//
//  CalendarOperator.swift
//  Calendar
//
//  Created by savitha.rudramuni on 23/02/18.
//  Copyright © 2018 Savitha.Rudramuni. All rights reserved.
//

import Foundation
import EventKit

class CalendarOperator {

 static let shared: CalendarOperator =  CalendarOperator()

  let calendar: Calendar = Calendar.current
  var currentMonth  = 0
  var currentYear =  0
  var currentDay  =  0

  let eventStore: EKEventStore =  EKEventStore()
  let dateFormatter: DateFormatter =  DateFormatter()

  var currentMonthData: [CalendarWeek] =  [CalendarWeek]()

  init() {
    let currentDate: (month: Int?,year: Int?) = self.getCurrentMonthAndYear()
    if currentDate.month != nil && currentDate.year !=  nil {
      self.currentMonthData  = self.getCurrentMonthData(month: currentDate.month!, year: currentDate.year!)
    }
  }

  func getRangeOfMonth(date: Date) -> Range<Int>?{
    return  calendar.range(of: Calendar.Component.day, in: Calendar.Component.month, for: date)

  }

  func getCurrentMonthAndYear()->(month: Int?,year: Int?) {
    var dateComponent: DateComponents =  calendar.dateComponents([.weekday,.month,.year,.day], from: Date())
    currentMonth  =  dateComponent.month ?? 0
    currentYear =  dateComponent.year ?? 0
    currentDay =  dateComponent.day ?? 0
    return (currentMonth,currentYear)
  }

  func getFirstDayOfMonth(month: Int, year: Int)-> Date? {
    var dateComponent: DateComponents =  DateComponents()
    dateComponent.month = month
    dateComponent.year = year
    dateComponent.day =  1
    dateComponent.calendar = calendar
    print("Date",dateComponent.date ?? "")
    return dateComponent.date
  }

  func getMonthData(month: Int) -> CalendarMonth {
    var dateComponent: DateComponents = DateComponents()
    dateComponent.month = 0
    if let displayDate =  Calendar.current.date(byAdding: dateComponent, to: Date(), wrappingComponents: false) {
    dateFormatter.dateFormat =  "MMMM"
    let info = getFullMonth(date: displayDate,month: month)
    let weeks: [CalendarWeek] = info.0
    let month: CalendarMonth =  CalendarMonth(month: weeks, monthName: info.1, currentMonth: month ==  currentMonth)
      return month
    } else {
      return CalendarMonth(month: [], monthName: "", currentMonth: month ==  currentMonth)
    }

  }

  func getCurrentMonthData(month: Int, year: Int) -> [CalendarWeek] {

    var months: [CalendarWeek] =  [CalendarWeek] ()

    if let firstDayOfMonth: Date = getFirstDayOfMonth(month: month, year: year) {

      months =  getFullMonth(date: firstDayOfMonth,month: month).0
    }
    return months
  }

  func getFullMonth(date: Date,month: Int) -> ([CalendarWeek] , String) {
     var customDateComponent: DateComponents = DateComponents()
    var monthName: String = ""
      var months: [CalendarWeek] =  [CalendarWeek] ()
      if let range =  getRangeOfMonth(date: date) {
        var weeekIndex: Int  =  1
        var weeks: CalendarWeek =  CalendarWeek(week: weeekIndex, days: [CalendarDay](), weekName: "")
        for i in range.lowerBound...range.upperBound-1 {
          customDateComponent.day =  i
          customDateComponent.month = month
       //   customDateComponent.year =  year
          customDateComponent.calendar = calendar
          if let formDate = customDateComponent.date {
            monthName = dateFormatter.string(from: formDate)
            let comm = calendar.dateComponents([.weekday,.month,.year,.weekdayOrdinal,.weekOfMonth], from: formDate)
            let dayObj: CalendarDay = CalendarDay(day: i, dayName: "\(comm.weekOfMonth!)", weekDay: comm.weekday ?? 0, currentDay: (currentDay ==  i && currentMonth == comm.month && currentYear == comm.year), date: formDate)
            if comm.weekOfMonth == weeekIndex {
              weeks.days.append(dayObj)
            }
            else {
              weeekIndex =  weeekIndex + 1
              months.append(weeks)
              weeks =  CalendarWeek(week: weeekIndex, days: [CalendarDay](), weekName: "")
              weeks.days.append(dayObj)
            }

          }
        }
        if weeks.days.count > 0 {
          months.append(weeks)
        }
      }
      return (months,monthName)
    }

}
