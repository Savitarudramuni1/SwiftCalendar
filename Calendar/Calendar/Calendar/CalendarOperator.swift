//
//  CalendarOperator.swift
//  Calendar
//
//  Created by savitha.rudramuni on 23/02/18.
//  Copyright © 2018 Savitha.Rudramuni. All rights reserved.
//

import Foundation

class CalendarOperator {


  let calendar: Calendar = Calendar.current
  var currentMonth  = 0
  var currentYear =  0
  var currentDay  =  0

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

  func getCurrentMonthData(month: Int, year: Int) -> [CalendarWeek] {
    var customDateComponent: DateComponents = DateComponents()
    var months: [CalendarWeek] =  [CalendarWeek] ()

    if let firstDayOfMonth: Date = getFirstDayOfMonth(month: month, year: year) {

      if let range =  getRangeOfMonth(date: firstDayOfMonth) {
        var weeekIndex: Int  =  1
        var weeks: CalendarWeek =  CalendarWeek(week: weeekIndex, days: [CalendarDay](), weekName: "")
        for i in range.lowerBound...range.upperBound-1 {
          customDateComponent.day =  i
          customDateComponent.month = month
          customDateComponent.year =  year
          customDateComponent.calendar = calendar
          if let formDate = customDateComponent.date {
            let comm = calendar.dateComponents([.weekday,.month,.year,.weekdayOrdinal,.weekOfMonth], from: formDate)
            var dayObj: CalendarDay = CalendarDay(day: i, dayName: "\(comm.weekOfMonth!)", weekDay: comm.weekday ?? 0, currentDay: false)
            if currentDay ==  i && currentMonth == comm.month && currentYear == comm.year {
            dayObj.currentDay = true
            } else {
              dayObj.currentDay = false
            }
            if comm.weekOfMonth == weeekIndex {
              print("Day",i,"weekDay",comm.weekday ?? 0)
              weeks.days.append(dayObj)
            }
            else {
              weeekIndex =  weeekIndex + 1
              months.append(weeks)
              weeks =  CalendarWeek(week: weeekIndex, days: [CalendarDay](), weekName: "")
              weeks.days.append(dayObj)
            }

          }
          else {
            print("no date")
          }

        }
        if weeks.days.count > 0 {
          months.append(weeks)
        }
      }
    }
    return months
  }

}
