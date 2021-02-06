//
//  AxcDateEx.swift
//  AxcBadrock-Swift
//
//  Created by 赵新 on 2021/2/4.
//

import UIKit

// MARK: - 数据转换
public extension Date {
    /// 转换为String类型
    var axc_strValue: String {
        return axc_strValue()
    }
    /// 转换为String类型
    func axc_strValue(format: String = AxcTimeStamp.ymd_semicolon_Hm_colon) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        return dateFormatter.string(from: self)
    }
    /// 转换为系统格式的String类型
    func axc_strValue(dateStyle: DateFormatter.Style = .medium,
                      timeStyle: DateFormatter.Style = .medium) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.timeStyle = timeStyle
        dateFormatter.dateStyle = dateStyle
        return dateFormatter.string(from: self)
    }
    
    /// 转换为iso1861格式时间戳
    var axc_iso8601Str: String {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        dateFormatter.timeZone = TimeZone(abbreviation: "GMT")
        dateFormatter.dateFormat = AxcTimeStamp.iso8601
        return dateFormatter.string(from: self).appending("Z")
    }
    
    // MARK: 时间就近转换
    private var private_components: DateComponents {
        return axc_calendar.dateComponents( [.year, .month, .day, .hour, .minute, .second, .nanosecond], from: self)
    }
    /// 将分钟数转换为最近的5分钟
    ///
    ///     var date = Date() // "5:54 PM"
    ///     date.axc_minute = 32 // "5:32 PM"
    ///     date.axc_nearestFiveMinutes // "5:30 PM"
    ///
    var axc_nearestFiveMinutes: Date {
        var components = private_components
        let min = components.minute!
        components.minute! = min % 5 < 3 ? min - min % 5 : min + 5 - (min % 5)
        components.second = 0
        components.nanosecond = 0
        return axc_calendar.date(from: components)!
    }
    /// 将分钟数转换为最近的10分钟
    ///
    ///     var date = Date() // "5:54 PM"
    ///     date.axc_minute = 32 // "5:32 PM"
    ///     date.axc_nearestFiveMinutes // "5:30 PM"
    ///
    var axc_nearestTenMinutes: Date {
        var components = private_components
        let min = components.minute!
        components.minute? = min % 10 < 6 ? min - min % 10 : min + 10 - (min % 10)
        components.second = 0
        components.nanosecond = 0
        return axc_calendar.date(from: components)!
    }
    /// 将分钟数转换为最近的15分钟
    ///
    ///     var date = Date() // "5:54 PM"
    ///     date.axc_minute = 32 // "5:32 PM"
    ///     date.axc_nearestFiveMinutes // "5:30 PM"
    ///
    var axc_nearestQuarterHour: Date {
        var components = private_components
        let min = components.minute!
        components.minute! = min % 15 < 8 ? min - min % 15 : min + 15 - (min % 15)
        components.second = 0
        components.nanosecond = 0
        return axc_calendar.date(from: components)!
    }
    /// 将分钟数转换为最近的30分钟
    ///
    ///     var date = Date() // "5:54 PM"
    ///     date.axc_minute = 32 // "5:32 PM"
    ///     date.axc_nearestFiveMinutes // "5:30 PM"
    ///
    var axc_nearestHalfHour: Date {
        var components = private_components
        let min = components.minute!
        components.minute! = min % 30 < 15 ? min - min % 30 : min + 30 - (min % 30)
        components.second = 0
        components.nanosecond = 0
        return axc_calendar.date(from: components)!
    }
    /// 将分钟数转换为最近的1小时
    ///
    ///     var date = Date() // "5:54 PM"
    ///     date.axc_minute = 32 // "5:32 PM"
    ///     date.axc_nearestFiveMinutes // "5:00 PM"
    ///
    var axc_nearestHour: Date {
        let min = axc_calendar.component(.minute, from: self)
        let components: Set<Calendar.Component> = [.year, .month, .day, .hour]
        let date = axc_calendar.date(from: axc_calendar.dateComponents(components, from: self))!
        if min < 30 { return date }
        return axc_calendar.date(byAdding: .hour, value: 1, to: date)!
    }
}

// MARK: - 类方法/属性
public extension Date {
 // MARK: 协议
 // MARK: 扩展
}

// MARK: - 属性 & Api
public extension Date {
    /// 日历对象
    var axc_calendar: Calendar {
        return Calendar(identifier: Calendar.current.identifier)
    }
    
    // MARK: 允许get&set属性
    /// 年份
    var axc_year: Int {
        get { return axc_calendar.component(.year, from: self) }
        set { guard newValue > 0 else { return }
            let currentYear = axc_calendar.component(.year, from: self)
            let yearsToAdd = newValue - currentYear
            if let date = axc_calendar.date(byAdding: .year, value: yearsToAdd, to: self) {
                self = date
            }
        }
    }
    /// 月份
    var axc_month: Int {
        get {  return axc_calendar.component(.month, from: self) }
        set { let allowedRange = axc_calendar.range(of: .month, in: .year, for: self)!
            guard allowedRange.contains(newValue) else { return }
            let currentMonth = axc_calendar.component(.month, from: self)
            let monthsToAdd = newValue - currentMonth
            if let date = axc_calendar.date(byAdding: .month, value: monthsToAdd, to: self) {
                self = date
            }
        }
    }
    /// 天
    var axc_day: Int {
        get { return axc_calendar.component(.day, from: self) }
        set { let allowedRange = axc_calendar.range(of: .day, in: .month, for: self)!
            guard allowedRange.contains(newValue) else { return }
            let currentDay = axc_calendar.component(.day, from: self)
            let daysToAdd = newValue - currentDay
            if let date = axc_calendar.date(byAdding: .day, value: daysToAdd, to: self) {
                self = date
            }
        }
    }
    /// 小时
    var axc_hour: Int {
        get { return axc_calendar.component(.hour, from: self) }
        set { let allowedRange = axc_calendar.range(of: .hour, in: .day, for: self)!
            guard allowedRange.contains(newValue) else { return }
            let currentHour = axc_calendar.component(.hour, from: self)
            let hoursToAdd = newValue - currentHour
            if let date = axc_calendar.date(byAdding: .hour, value: hoursToAdd, to: self) {
                self = date
            }
        }
    }
    /// 分钟
    var axc_minute: Int {
        get { return axc_calendar.component(.minute, from: self) }
        set { let allowedRange = axc_calendar.range(of: .minute, in: .hour, for: self)!
            guard allowedRange.contains(newValue) else { return }
            let currentMinutes = axc_calendar.component(.minute, from: self)
            let minutesToAdd = newValue - currentMinutes
            if let date = axc_calendar.date(byAdding: .minute, value: minutesToAdd, to: self) {
                self = date
            }
        }
    }
    /// 秒
    var axc_second: Int {
        get { return axc_calendar.component(.second, from: self) }
        set { let allowedRange = axc_calendar.range(of: .second, in: .minute, for: self)!
            guard allowedRange.contains(newValue) else { return }
            let currentSeconds = axc_calendar.component(.second, from: self)
            let secondsToAdd = newValue - currentSeconds
            if let date = axc_calendar.date(byAdding: .second, value: secondsToAdd, to: self) {
                self = date
            }
        }
    }
    /// 毫秒
    var axc_millisecond: Int {
        get { return axc_calendar.component(.nanosecond, from: self) / 1_000_000 }
        set { let nanoSeconds = newValue * 1_000_000
            #if targetEnvironment(macCatalyst)
            let allowedRange = 0..<1_000_000_000
            #else
            let allowedRange = axc_calendar.range(of: .nanosecond, in: .second, for: self)!
            #endif
            guard allowedRange.contains(nanoSeconds) else { return }
            if let date = axc_calendar.date(bySetting: .nanosecond, value: nanoSeconds, of: self) {
                self = date
            }
        }
    }
    /// 纳秒
    var axc_nanosecond: Int {
        get { return axc_calendar.component(.nanosecond, from: self) }
        set {
            #if targetEnvironment(macCatalyst)
            let allowedRange = 0..<1_000_000_000
            #else
            let allowedRange = axc_calendar.range(of: .nanosecond, in: .second, for: self)!
            #endif
            guard allowedRange.contains(newValue) else { return }
            let currentNanoseconds = axc_calendar.component(.nanosecond, from: self)
            let nanosecondsToAdd = newValue - currentNanoseconds
            if let date = axc_calendar.date(byAdding: .nanosecond, value: nanosecondsToAdd, to: self) {
                self = date
            }
        }
    }
}

// MARK: - 获取换算
public extension Date {
    // MARK: 名称获取
    /// 时间名字样式
    enum AxcTimeNameStyle {
        /// 只显示一个单词
        case oneLetter
        /// 显示三个单词
        case threeLetters
        /// 全部显示
        case full
    }
    /// 获取天的名称
    ///
    ///     Date().dayName(ofStyle: .oneLetter) -> "T"
    ///     Date().dayName(ofStyle: .threeLetters) -> "Thu"
    ///     Date().dayName(ofStyle: .full) -> "Thursday"
    ///
    func axc_dayName(style: AxcTimeNameStyle = .full) -> String {
        let dateFormatter = DateFormatter()
        var format: String {
            switch style {
            case .oneLetter:    return "EEEEE"
            case .threeLetters: return "EEE"
            case .full:         return "EEEE"
            }
        }
        dateFormatter.setLocalizedDateFormatFromTemplate(format)
        return dateFormatter.string(from: self)
    }
    
    /// 获取月的名称
    ///
    ///     Date().monthName(ofStyle: .oneLetter) -> "J"
    ///     Date().monthName(ofStyle: .threeLetters) -> "Jan"
    ///     Date().monthName(ofStyle: .full) -> "January"
    ///
    func monthName(ofStyle style: AxcTimeNameStyle = .full) -> String {
        let dateFormatter = DateFormatter()
        var format: String {
            switch style {
            case .oneLetter:    return "MMMMM"
            case .threeLetters: return "MMM"
            case .full:         return "MMMM"
            }
        }
        dateFormatter.setLocalizedDateFormatFromTemplate(format)
        return dateFormatter.string(from: self)
    }
    
    // MARK: 与年相关的跨度
    /// 世纪
    var axc_era: Int { return axc_calendar.component(.era, from: self) }
    
    /// 第几季度
    var axc_quarter: Int {
        let month = Double(axc_calendar.component(.month, from: self))
        let numberOfMonths = Double(axc_calendar.monthSymbols.count)
        let numberOfMonthsInQuarter = numberOfMonths / 4
        return Int(ceil(month / numberOfMonthsInQuarter))
    }
    
    /// 本年的第几周
    var axc_weekOfYear: Int { return axc_calendar.component(.weekOfYear, from: self) }
    
    /// 本年的第几月
    var axc_weekOfMonth: Int { return axc_calendar.component(.weekOfMonth, from: self) }
    
    /// 这是本周的第几天
    var axc_dayOfWeek: Int { return axc_calendar.component(.weekday, from: self) }
    
    // MARK: 日期计算
    /// 获取昨天的时间，当前时间减一天
    var axc_yesterday: Date {
        return axc_add(.day, value: -1)
    }

    /// 获取明天的时间，当前时间加一天
    var axc_tomorrow: Date {
        return axc_add(.day, value: 1)
    }
    
    /// 日期增减
    func axc_add(_ component: Calendar.Component, value: Int) -> Date {
        return axc_calendar.date(byAdding: component, value: value, to: self)!
    }
    
    /// 日期修改
    func axc_changing(_ component: Calendar.Component, value: Int) -> Date? {
        var date = self
        switch component {
        case .nanosecond:   date.axc_nanosecond = value
        case .second:       date.axc_second = value
        case .minute:       date.axc_minute = value
        case .hour:         date.axc_hour = value
        case .day:          date.axc_day = value
        case .month:        date.axc_month = value
        case .year:         date.axc_year = value
        default: return axc_calendar.date(bySetting: component, value: value, of: self)
        }
        return date
    }
    
    /// 计算相差天数
    func axc_intervalDays(_ date: Date) -> Double {
        return axc_intervalHours(date) / 24
    }
    /// 计算相差小时
    func axc_intervalHours(_ date: Date) -> Double {
        return axc_intervalMinutes(date) / 60
    }
    /// 计算相差分钟
    func axc_intervalMinutes(_ date: Date) -> Double {
        return axc_intervalSeconds(date) / 60
    }
    /// 计算相差秒数
    func axc_intervalSeconds(_ date: Date) -> Double {
        return timeIntervalSince(date)
    }
}

// MARK: - 决策判断
public extension Date {
    /// 是否大于当前时间？也就是是否是在未来
    var axc_isFuture: Bool { return self > Date() }
    
    /// 是否小于当前时间？也就是是否是在过去
    var axc_isPast: Bool { return self < Date() }
    
    /// 是否是今天
    var axc_isToday: Bool { return axc_calendar.isDateInToday(self) }
    
    /// 是否是昨天
    var axc_isYesterday: Bool { return axc_calendar.isDateInYesterday(self) }
    
    /// 是否是明天
    var axc_isTomorrow: Bool { return axc_calendar.isDateInTomorrow(self) }
    
    /// 是否是周末
    var axc_isWeekend: Bool { return axc_calendar.isDateInWeekend(self) }
    
    /// 是否是工作日
    var axc_isWorkday: Bool { return !axc_calendar.isDateInWeekend(self) }
    
    /// 是否是本周
    var axc_isCurrentWeek: Bool { return axc_calendar.isDate(self, equalTo: Date(), toGranularity: .weekOfYear) }

    /// 是否是本月
    var axc_isCurrentMonth: Bool { return axc_calendar.isDate(self, equalTo: Date(), toGranularity: .month) }

    /// 是否是今年
    var axc_isCurrentYear: Bool {  return axc_calendar.isDate(self, equalTo: Date(), toGranularity: .year) }
    
    /// 校验一个日期是否在两个日期之间
    /// - Parameters:
    ///   - startDate: 起始日期
    ///   - endDate: 结束日期
    ///   - includeBounds: 是否包含
    func axc_isBetween(_ startDate: Date, _ endDate: Date, includeBounds: Bool = false) -> Bool {
        if includeBounds {
            return startDate.compare(self).rawValue * compare(endDate).rawValue >= 0
        }
        return startDate.compare(self).rawValue * compare(endDate).rawValue > 0
    }
    
}

// MARK: - 操作符
public extension Date {
}

// MARK: - 运算符
public extension Date {
}
