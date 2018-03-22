//
//  WeatherForeCast.swift
//  Calendar
//
//  Created by savitha.rudramuni on 22/03/18.
//  Copyright © 2018 Savitha.Rudramuni. All rights reserved.
//

import Foundation

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

  func getResponseData(url: URL,closure:@escaping (_ response:Data?,_ error: Error?) -> ()){
    session.dataTask(with: url) { (data: Data?, response: URLResponse?, serviceError: Error?) in
      closure(data,serviceError)
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
  var iconUrl: String?
  var prediction: String?
  var iconStatus: String?
}

class WeatherForCast {

  public static let sharedInstrance = WeatherForCast()

  fileprivate let key: String =  "47aa219fedbaae7d"
  fileprivate var url: String = "http://api.wunderground.com/api/47aa219fedbaae7d/forecast/geolookup/conditions/q/IN/bangalore.json"

  fileprivate let networkHandler  = NetworkOperation()

  public var todayForeCast:ForeCastModel = ForeCastModel(placeName: "", temparature: "", iconUrl: "", prediction: "", iconStatus: "")

  init() {
    getforeCast()
  }

  func getforeCast() {
    networkHandler.fetchAPIData(api: url) { (response: Any?, error: Error?) in
      if let foreCastResponse: [String: Any] =  response as? [String: Any] {
        if let current: [String: Any] = foreCastResponse["current_observation"] as? [String: Any] {
          self.todayForeCast.placeName =  (current["display_location"] as! [String: Any])["city"] as! String
          self.todayForeCast.temparature = "\(current["temp_c"] ?? "")"
          self.todayForeCast.iconUrl = current["icon_url"] as? String
          print("Status",self.todayForeCast.placeName)

        }

        if let fc:[String: Any] = foreCastResponse["forecast"] as? [String: Any]{
          if let tctFc:[String: Any]  = fc["txt_forecast"] as? [String: Any] {
          if let list:[[String: Any]] = tctFc["forecastday"] as? [[String: Any]]  {
        if let p : [String: Any] = list.first {
          self.todayForeCast.prediction = p["fcttext"] as? String
          self.todayForeCast.iconStatus = p["icon"] as? String
          }
          }
          }


      }
    }

      NotificationCenter.default.post(name: NSNotification.Name(rawValue: "forecast"), object: nil)
  }
}
}
