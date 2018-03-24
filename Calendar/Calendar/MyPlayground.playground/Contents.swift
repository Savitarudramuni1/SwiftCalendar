//: Playground - noun: a place where people can play

import UIKit
import Foundation
import PlaygroundSupport

var str = "Hello, playground"

struct CalendarDay {
  var day: Int
  var dayName: String
  var weekDay: Int
  var currentDay: Bool = false
}

struct CalendarWeek {
  var week: Int
  var days: [CalendarDay]
  var weekName: String
}

class CalendarOperation {


let calendar: Calendar = Calendar.current
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
    var dateComponent: DateComponents =  calendar.dateComponents([.weekday,.month,.year], from: Date())
    let currentMonth  =  dateComponent.month
    let currentYear =  dateComponent.year
   // let weekday = dateComponent.weekday

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
      let dayObj: CalendarDay = CalendarDay(day: i, dayName: "\(comm.weekOfMonth!)", weekDay: comm.weekday ?? 0, currentDay: false)
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

let caleOps =  CalendarOperation ()
let m = caleOps.getCurrentMonthData(month: Int(4), year: Int(2018))

struct DayActivity {
  var time: String
  var status: String
  var eventTime: Date
  var actityDescription: String
  var location: String

}



class NetworkOperation {

  let session = URLSession(configuration: .default)

  init() {
  }

  func fetchAPIData(api: String,apiClosure:@escaping (_ response: Any?,_ error: Error?) -> ()) -> Void{
    if let apiURL: URL =  URL(string: api) {
      self.getDataFromURL(url: apiURL) {(aResponse: Any?, anError: Error?) in
        apiClosure(aResponse,anError)
      }
    }
  }

  func getDataFromURL(url: URL,closure:@escaping (_ response:Any?,_ error: Error?) -> ()) {
    session.dataTask(with: url) { (data: Data?, response: URLResponse?, serviceError: Error?) in
      let jsonResponse: Any? = self.paserJSONData(data)
      closure(jsonResponse,serviceError)
      }.resume()
  }

  func paserJSONData(_ data: Data?) -> Any? {
    if data != nil {
      var parsingResult: Any?
      do {

        parsingResult = try JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions())
      } catch {
        print(error)
      }
      return parsingResult
    } else {
      return nil
    }
  }
}

struct ForeCastModel {

  var placeName: String
  var temparature: String
  var iconUrl: String
}

class WeatherForCast: NetworkOperation {

  let key: String =  "47aa219fedbaae7d"
  var url: String = "http://api.wunderground.com/api/47aa219fedbaae7d/conditions/q/IN/Mumbai.json"

  override init() {
    super.init()
  }

  func getforeCast() {
    self.fetchAPIData(api: url) { (response: Any?, error: Error?) in
      if let foreCastResponse: [String: Any] =  response as? [String: Any] {
        if let current: [String: Any] = foreCastResponse["current_observation"] as? [String: Any] {
          var todayFC:ForeCastModel =  ForeCastModel(placeName: "", temparature: "", iconUrl: "")
          todayFC.placeName =  (current["display_location"] as! [String: Any])["city"] as! String
          todayFC.temparature = "\(current["temp_c"] ?? "") c"
          todayFC.iconUrl = current["icon_url"] as! String
        print("Status",todayFC.placeName)
        }
      }
      }
    }
}

let o = WeatherForCast()
o.getforeCast()


class CalendarEventStore {

 

  func getEvents(){
    var events: [DayActivity] =  [DayActivity]()

    for _ in 0...3 {

      var dActivity: DayActivity = DayActivity (time: "9:00 AM", status: "away", eventTime: Date(), actityDescription: "Meeting", location: "Some Location")
      dActivity.time = "9:00 AM"
      dActivity.status = "away"
      dActivity.eventTime = Date()
      dActivity.actityDescription = "Meeting"
      dActivity.location = "Some Location"
      events.append(dActivity)
    }

    print(events)
  }


}

let ec =  CalendarEventStore()
ec.getEvents()


PlaygroundPage.current.needsIndefiniteExecution = true




