//
//  AgendaViewController.swift
//  Calendar
//
//  Created by savitha.rudramuni on 21/03/18.
//  Copyright © 2018 Savitha.Rudramuni. All rights reserved.
//

import Foundation
import UIKit
import EventKit

class AgendaViewController: UIViewController,UITableViewDataSource,UITableViewDelegate {
  private var tableView: UITableView?
  var calendars: [EKCalendar]?
  let dateFormatter: DateFormatter =  CalendarOperator.shared.dateFormatter
  var eventInfoList:[DayEvent] =  [DayEvent]()

  let eventStore: EKEventStore =  CalendarOperator.shared.eventStore

  var currentDisplayDate:Date  = Date()
  var currentPaginationIndex: Int = 0

  override func viewDidLoad() {
    super.viewDidLoad()
    dateFormatter.dateFormat =  "dd MMMM YYYY"
    requestAccessToCalendar()
    createTableView()

  }

  func createTableView() {
    tableView =  UITableView(frame: view.frame, style: UITableViewStyle.plain)
    tableView?.dataSource =  self
    tableView?.delegate =  self
    view.addSubview(tableView!)

    tableView?.register(AgendaCell.self, forCellReuseIdentifier: "agendaCell")
    tableView?.register(EmptyEventCell.self, forCellReuseIdentifier: "emptyEventCell")

    tableView?.reloadData()

  tableView?.tableFooterView = UIView(frame: CGRect.zero)

    getEvents(pageIndex: currentPaginationIndex)

  }

  func requestAccessToCalendar() {
    eventStore.requestAccess(to: EKEntityType.event, completion: {
      (accessGranted: Bool, error: Error?) in

      if accessGranted == true {
        DispatchQueue.main.async(execute: {
          self.tableView?.reloadData()
        })
      } else {
        DispatchQueue.main.async(execute: {
        })
      }
    })
  }

  func getEvents(pageIndex: Int){

    let startIndex: Int  =  pageIndex * 10
    let endIndex: Int = startIndex + 10

    for i in startIndex...endIndex {
        var dateComponent: DateComponents = DateComponents()
        dateComponent.day = i
      if let displayDate =  Calendar.current.date(byAdding: dateComponent, to: currentDisplayDate, wrappingComponents: false) {
        let eventsPredicate = self.eventStore.predicateForEvents(withStart: displayDate, end: displayDate, calendars: self.calendars)
        let eList = self.eventStore.events(matching: eventsPredicate)
        let key = dateFormatter.string(from: displayDate)
        let dayEvent: DayEvent =  DayEvent(date: displayDate, displayDate: key, events: eList)
        self.eventInfoList.append(dayEvent)
      }
    }

    self.tableView?.reloadData()
  }
//}

//@objc
//extension AgendaViewController: UITableViewDataSource {

  func numberOfSections(in tableView: UITableView) -> Int {
    return self.eventInfoList.count
  }

  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    let eventCount: Int  =  self.eventInfoList[section].events.count
    return eventCount > 0 ? eventCount :  1
  }

  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

    let cellIdentifier: String =   self.eventInfoList[indexPath.section].events.count > 0 ?  "agendaCell" : "emptyEventCell"

    let cell: UITableViewCell =  tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath)

    if let agendaCell: AgendaCell = cell as? AgendaCell {
        agendaCell.event = self.eventInfoList[indexPath.section].events[indexPath.row]
    }
    else if let emptyCell: EmptyEventCell =  cell as? EmptyEventCell {
       emptyCell.descLabel.text =  "No Events"
    }
    return cell
  }

  func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {

    let headerView: UIView =  UIView(frame: CGRect(x: 0, y: 0, width: tableView.frame.size.width, height: 45))

    let headerLabel =  UILabel(frame: CGRect(x: 0, y: 0, width: tableView.frame.size.width, height: 45))
    if let eventCount: String  =  self.eventInfoList[section].displayDate {
     headerLabel.text = eventCount
    }
    else {
headerLabel.text = dateFormatter.string(from: Date())
    }
    headerView.backgroundColor =  UIColor.white
    headerView.addSubview(headerLabel)

    return headerView

  }
  func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    return 45
  }

  func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
    currentPaginationIndex = currentPaginationIndex + 1
    getEvents(pageIndex: currentPaginationIndex)
  }

//}

//@objc
//extension AgendaViewController: UITableViewDelegate {
//
//}
}

class CalendarEventStore {

   let eventStore: EKEventStore = EKEventStore()


  func getEvents()->[DayActivity]{
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

    return events
  }


}
