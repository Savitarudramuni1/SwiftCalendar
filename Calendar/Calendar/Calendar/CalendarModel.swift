//
//  CalendarModel.swift
//  Calendar
//
//  Created by savitha.rudramuni on 19/02/18.
//  Copyright © 2018 Savitha.Rudramuni. All rights reserved.
//

import Foundation

struct CalendarDay {
  var day: Int
  var dayName: String
  var weekDay: Int
  var currentDay: Bool = false
  var date:Date?
}

struct CalendarWeek {
  var week: Int
  var days: [CalendarDay]
  var weekName: String
}

struct CalendarMonth {
  var month: [CalendarWeek]
  var monthName: String
  var currentMonth: Bool = false
}

class CalendarModel {
  var months: [CalendarMonth]?
}
