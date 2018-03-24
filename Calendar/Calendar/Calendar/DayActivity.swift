//
//  DayActivity.swift
//  Calendar
//
//  Created by savitha.rudramuni on 21/03/18.
//  Copyright © 2018 Savitha.Rudramuni. All rights reserved.
//

import Foundation
import EventKit

struct DayActivity {
  var time: String
  var status: String
  var eventTime: Date
  var actityDescription: String
  var location: String

}

struct DayEvent {
  var date: Date?
  var displayDate: String?
  var events: [EKEvent] =  [EKEvent]()
  
}
