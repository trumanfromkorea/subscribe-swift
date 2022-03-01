//
//  Formatter_model.swift
//  subscribe
//
//  Created by 장재훈 on 2022/02/13.
//

import Foundation


// 이 달의 첫번째 날짜
func firstDayOfMonth(_ date: Date) -> Date {
    var calendar: Calendar = Calendar(identifier: .gregorian)
    calendar.locale = Locale(identifier: "ko_KR")

    let components: DateComponents = calendar.dateComponents([.year, .month], from: date)

    return calendar.date(from: components)!
}

// 이 달의 마지막 날짜
func lastDayOfMonth(_ date: Date) -> Date {
    var calendar: Calendar = Calendar(identifier: .gregorian)
    calendar.locale = Locale(identifier: "ko_KR")

    let firstDate: Date = firstDayOfMonth(date)
    let nextMonth: Date? = calendar.date(byAdding: .month, value: 1, to: firstDate)
    let lastDate: Date? = calendar.date(byAdding: .day, value: -1, to: nextMonth!)

    return lastDate!
}

// 해당 요일 개수 구하기
func getWeekday(_ date: Date, _ weekday: Int) -> Int {
    // 요일 개수를 순서대로 담아줄 배열 (일~토)
    var weekDays: [Int] = []

    var calendar: Calendar = Calendar(identifier: .gregorian)
    calendar.locale = Locale(identifier: "ko_KR")

    // 해당 월의 시작 날짜와 마지막 날짜
    let firstDate: Date = firstDayOfMonth(date)
    let lastDate: Date = lastDayOfMonth(date)

    // 해당 월의 첫 요일
    let firstWeekday: Int = calendar.dateComponents([.weekday], from: firstDate).weekday!
    // 해당 월의 전체일수
    let lastDay: Int = calendar.dateComponents([.day], from: lastDate).day!

    for _ in 0 ..< 7 {
        weekDays.append(lastDay / 7)
    }

    // 남는 요일에 +1 씩
    for i in 0 ..< lastDay % 7 {
        let dayIndex: Int = firstWeekday + i
        weekDays[(dayIndex - 1) % 7] += 1
    }

    return weekDays[weekday - 1]
}

// 지금이랑 같은 달인지
func isSameMonth(_ date: Date) -> Bool {
    var calendar: Calendar = Calendar(identifier: .gregorian)
    calendar.locale = Locale(identifier: "ko_KR")

    let thisMonth: Int = calendar.dateComponents([.month], from: Date()).month!
    let compareMonth: Int = calendar.dateComponents([.month], from: date).month!

    return thisMonth == compareMonth
}

// MARK: - 다음 구독날짜 계산 메소드

// 다음 구독 날짜 계산 메소드
func nextDateCalculator(_ cycleType: Int, _ cycleValue: String) -> Date {
    
    print("다음 날짜 계산 시작")
    
    // 주간구독
    if cycleType == 0 {
        return weeklyDate(cycleValue)
    }
    // 월간구독
    else if cycleType == 1 {
        return monthlyDate(cycleValue)
    }
    // 연간구독
    else {
        return yearlyDate(cycleValue)
    }
}

// 주간구독 다음날짜
func weeklyDate(_ cycleValue: String) -> Date {
    var calendar: Calendar = Calendar(identifier: .gregorian)
    calendar.locale = Locale(identifier: "ko_KR")
    
    var nextDate: Date = Date()
    var weekday: Int = calendar.dateComponents([.weekday], from: nextDate).weekday!
    
    while weekday != Int(cycleValue)! {
        nextDate = calendar.date(byAdding: .day, value: 1,  to: nextDate)!
        weekday = calendar.dateComponents([.weekday], from: nextDate).weekday!
    }
    
    return nextDate
}

// 월간구독 다음날짜
func monthlyDate(_ cycleValue: String) -> Date{
    let calendar: Calendar = Calendar.current
    
    let format01: DateFormatter = DateFormatter()
    format01.locale = Locale(identifier: "ko_KR")
    format01.dateFormat = "yyyyMM"

    let format02: DateFormatter = DateFormatter()
    format02.locale = Locale(identifier: "ko_KR")
    format02.dateFormat = "dd"

    let date: String = format02.string(from: Date()) // 오늘 일자
    let nextDateString: String = format01.string(from: Date()) + cycleValue // 이번달 구독일

    format01.dateFormat = "yyyyMMdd"

    let nextDate: Date? = format01.date(from: nextDateString) // 날짜로 변환

    if Int(cycleValue)! > Int(date)! { // 아직 구독일자 전일때
        return nextDate!
    } else { // 구독일자 지났을때
        return calendar.date(byAdding: .month, value: 1, to: nextDate!)!
    }
}

// 연간구독 다음날짜
func yearlyDate(_ cycleValue: String) -> Date{
    let calendar: Calendar = Calendar.current
    
    let format01: DateFormatter = DateFormatter()
    format01.locale = Locale(identifier: "ko_KR")
    format01.dateFormat = "MMdd"
    
    let format02: DateFormatter = DateFormatter()
    format02.locale = Locale(identifier: "ko_KR")
    format02.dateFormat = "yyyyMMdd"

    let todayString: String = format01.string(from: Date())

    let year: Int = calendar.dateComponents([.year], from: Date()).year!
    let nextDate: Date? = format02.date(from: String(year) + cycleValue)
    
    print("다음 날짜 계산 끝 \(nextDate)")

    if cycleValue > todayString { // 구독날짜 전일때
        return nextDate!
    } else { // 지났을때
        return calendar.date(byAdding: .year, value: 1, to: nextDate!)!
    }
}
