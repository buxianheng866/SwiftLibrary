//
//  SwiftDateHelper.swift
//  SwiftLib
//
//  Created by nb616 on 2017/10/27.
//  Copyright © 2017年 nb616. All rights reserved.
//

import Foundation
import SwiftDate
struct SwiftDateHelper {
    
    func setDefaultRegion() -> Void {
        let resionRome = Region(tz: TimeZoneName.asiaShanghai, cal: CalendarName.chinese, loc: LocaleName.chinese)
        Date.setDefaultRegion(resionRome)
    }
    
    
    func test0() -> Void {
        //今天
        let now = DateInRegion()
        let _ = now.year
        
        //四舍五入取最近的时间, 8:15 ---> 8点
        let _ = now.nearestHour
        
        let _ = now.weekOfYear // 当年第几周
        
        let _ = now.weekday  //周几 1 2 3 4 5 6 0
        
        let _ = now.weekOfMonth // 当月第几周
        
        let _ = now.isToday // 是否今天  isYesterday
        
        let _ = now.nextMonth //下个月 prevMonth
        
        let _ = now.monthDays // 当月天数
        
        let _ = now.next(day: WeekDay(rawValue: 1)!)
        
        //字符串转时间
        let _ = DateInRegion(string: "2017-10-27 18:30:00", format: .custom("yyyy-MM-dd HH:mm:ss"))!
        
        //时间转字符串
        let _ = now.string(format: .custom("yyyy-MM-dd HH:mm:ss"))
        
    }
    
}
