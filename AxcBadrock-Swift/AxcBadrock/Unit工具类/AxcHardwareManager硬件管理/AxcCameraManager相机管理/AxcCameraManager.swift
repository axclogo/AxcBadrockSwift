//
//  AxcCameraManager.swift
//  AxcBadrock-Swift
//
//  Created by 赵新 on 2021/3/12.
//

import UIKit
import AVFoundation
import CoreImage
import CoreLocation
import CoreMotion
import ImageIO
import MobileCoreServices
import Photos
import PhotosUI

public extension AxcCameraManager {
    
}

public class AxcCameraManager: NSObject,
                               AVCaptureFileOutputRecordingDelegate,
                               UIGestureRecognizerDelegate {
    // MARK: - Api
    // MARK: 属性
    /// 自定义图像相册名称
    var axc_imageAlbumName: String?
    
    /// 自定义视频相册名称
    var axc_videoAlbumName: String?
    
    /// 自定义相机会话
    var axc_captureSession: AVCaptureSession?
    
    /// 管理器显示错误
    /// 如果你想自己显示错误，设置为false
    /// 如果你想添加自定义错误UI设置showErrorBlock属性。
    /// 默认 false
    var axc_showErrorsToUsers = false
   
    /// 是否应该在需要时立即弹出显示相机权限，控制是否手动显示它。默认 true
    /// 因为使用相机需要许可，如果你设置这个值为false，不手动询问，你将不能使用相机。
    var axc_showAccessPermissionPopupAutomatically = true
    
    /// 一个创建UI以向用户显示错误消息的Block
    /// 这可以被定制为在窗口根视图控制器上显示，或者传入viewController，它将显示UIAlertController
    /// 默认示例
    var axc_showErrorBlock: (_ errorTitle: String, _ errorMessage: String) -> Void
        = { (title, msg) -> Void in
            var alertVC = UIAlertController(title: title, msg: msg, actionTitles: [AxcBadrockLanguage("确定")])
            alertVC.axc_show()
        }
    
    /// 是否应将资源写入媒体库 默认 true
    var axc_writeFilesToPhoneLibrary = true
    
    /// 是否应该适配设备方向 默认 true
    var axc_autoOrientation = true {
        didSet { axc_autoOrientation ? startFollowingDeviceOrientation() : stopFollowingDeviceOrientation() }
    }
    /// 是否水平翻转前置摄像头拍摄的图像  默认 false
    var axc_flipFrontCameraImage = false
    /// 当方向改变时，是否应该保持视图的相同边界 默认 false
    var shouldKeepViewAtOrientationChanges = false
    
    /// 是否启用点击手势聚焦相机预览 默认 true
    var axc_enableTapToFocus = true { didSet { focusGesture.isEnabled = axc_enableTapToFocus } }
    /// 是否启用手势缩放功能 默认 true
    var axc_enablePinchToZoom = true { didSet { zoomGesture.isEnabled = axc_enablePinchToZoom } }
    /// 是否启用上下滑动手势改变曝光/亮度 默认 true
    var axc_enableExposure = true { didSet { exposureGesture.isEnabled = axc_enableExposure } }
    
    /// 相机是否可以使用
    var axc_isCameraReady: Bool { return cameraIsSetup }
    
    /// 是否具有前置摄像头
    var axc_isHasFrontCamera: Bool { return AVCaptureDevice.axc_isHasCamera(type: .front) }
    /// 是否具有后置摄像头
    var axc_isHasBackCamera: Bool { return AVCaptureDevice.axc_isHasCamera(type: .back) }
    /// 是否具有闪光灯
    var axc_isHasFlash: Bool { return AVCaptureDevice.axc_isHasFlash }
    
    /// 是否启用前后摄像头切换时的翻转动画 默认 true
    var axc_switchCameraAnimation: Bool = true
    /// 是否启用快门动画 默认 true
    open var axc_shutterAnimation: Bool = true
    
    /// 是否启用位置服务
    /// 相机中的位置服务用于EXIF数据
    var axc_useLocationServices: Bool = false {
       didSet {
           if axc_useLocationServices {
               self.locationManager = CameraLocationManager()
           }
       }
   }
    
    /// 前置和后置之间更改的相机设备
    var axc_cameraDevice: DeviceType = .back {
        didSet {
            if cameraIsSetup, axc_cameraDevice != oldValue {
                if animateCameraDeviceChange {
                    _doFlipAnimation()
                }
                _updateCameraDevice(axc_cameraDevice)
                _updateIlluminationMode(flashMode)
                _setupMaxZoomScale()
                _zoom(0)
                _orientationChanged()
            }
        }
    }
    /// 闪光灯模式
    var axc_flashMode: FlashMode = .off {
        didSet {
            if cameraIsSetup && axc_flashMode != oldValue {
                _updateIlluminationMode(axc_flashMode)
            }
        }
    }
    /// 相机输出质量
    var axc_cameraOutputQuality: AVCaptureSession.Preset = .high {
        didSet {
            if cameraIsSetup && axc_cameraOutputQuality != oldValue {
                _updateCameraQualityMode(axc_cameraOutputQuality)
            }
        }
    }
    
    
    // MARK: 方法
    /// 是否已经设置过
    func canSetPreset(preset: AVCaptureSession.Preset) -> Bool? {
        if let validCaptureSession = axc_captureSession {
            return validCaptureSession.canSetSessionPreset(preset)
        }
        return nil
    }
    
    // MARK: 私有
    /// 开启设备方向获取
    private func startFollowingDeviceOrientation() {
        if shouldRespondToOrientationChanges, !cameraIsObservingDeviceOrientation {
            coreMotionManager = CMMotionManager()
            coreMotionManager.deviceMotionUpdateInterval = 1 / 30.0
            if coreMotionManager.isDeviceMotionAvailable {
                coreMotionManager.startDeviceMotionUpdates(to: OperationQueue()) { motion, _ in
                    guard let motion = motion else { return }
                    let x = motion.gravity.x
                    let y = motion.gravity.y
                    let previousOrientation = self.deviceOrientation
                    if fabs(y) >= fabs(x) {
                        if y >= 0 {
                            self.deviceOrientation = .portraitUpsideDown
                        } else {
                            self.deviceOrientation = .portrait
                        }
                    } else {
                        if x >= 0 {
                            self.deviceOrientation = .landscapeRight
                        } else {
                            self.deviceOrientation = .landscapeLeft
                        }
                    }
                    if previousOrientation != self.deviceOrientation {
                        self._orientationChanged()
                    }
                }
                
                cameraIsObservingDeviceOrientation = true
            } else {
                cameraIsObservingDeviceOrientation = false
            }
        }
    }
    /// 关闭设备方向
    private func stopFollowingDeviceOrientation() {
        if cameraIsObservingDeviceOrientation {
            coreMotionManager.stopDeviceMotionUpdates()
            cameraIsObservingDeviceOrientation = false
        }
    }
}
