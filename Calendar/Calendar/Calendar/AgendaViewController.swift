//
//  AgendaViewController.swift
//  Calendar
//
//  Created by savitha.rudramuni on 21/03/18.
//  Copyright © 2018 Savitha.Rudramuni. All rights reserved.
//

import Foundation
import UIKit

class AgendaViewController: UIViewController {
  private var tableView: UITableView?

  var events: [DayActivity] =  [DayActivity]()

  override func viewDidLoad() {
    super.viewDidLoad()
    createTableView()
  }

  func createTableView() {
    tableView =  UITableView(frame: view.frame, style: UITableViewStyle.plain)
    tableView?.dataSource =  self
    tableView?.delegate =  self
    view.addSubview(tableView!)

    tableView?.register(AgendaCell.self, forCellReuseIdentifier: "agendaCell")

    tableView?.reloadData()

    let list = CalendarEventStore().getEvents()
    events.append(contentsOf: list)
  }
}

@objc
extension AgendaViewController: UITableViewDataSource {

  func numberOfSections(in tableView: UITableView) -> Int {
    return 1
  }

  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return events.count
  }

  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell: UITableViewCell =  tableView.dequeueReusableCell(withIdentifier: "agendaCell", for: indexPath)

    if let agendaCell: AgendaCell = cell as? AgendaCell {
        agendaCell.activity = events[indexPath.row]
    }
    return cell
  }

}

@objc
extension AgendaViewController: UITableViewDelegate {

}

class CalendarEventStore {

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
