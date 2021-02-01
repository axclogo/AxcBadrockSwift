//
//  AxcBadrock_SwiftTests.swift
//  AxcBadrock-SwiftTests
//
//  Created by 赵新 on 2021/1/30.
//

import XCTest
@testable import AxcBadrock_Swift

class AxcBadrock_SwiftTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        
        print("=============Start")

        print(CGFloat.leastNormalMagnitude)
        print(CGFloat.leastNonzeroMagnitude)
        print(CGFloat.greatestFiniteMagnitude)
        
        let aa = "123".axc_qrCode
        print(aa)
        
        let color = "0099FF".axc_color(0.5)
        print(color)
        
      
        print(FLT_MIN)
        print(0x000000001)
        print("=============End")
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
        
    }

}
