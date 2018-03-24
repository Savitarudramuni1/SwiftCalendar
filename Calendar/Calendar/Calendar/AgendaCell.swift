//
//  AgendaCell.swift
//  Calendar
//
//  Created by savitha.rudramuni on 21/03/18.
//  Copyright © 2018 Savitha.Rudramuni. All rights reserved.
//

import Foundation
import UIKit
import EventKit

class AgendaCell: UITableViewCell {

  let cellIdentifier: String =  "agendaCell"

  let dateFormatter: DateFormatter =  CalendarOperator.shared.dateFormatter

  private var timeLabel: UILabel?
  private var activityView: UIView?
  private var activiytMainTitle: UILabel?
  private var peopleView: UIView?
  private var locationView: UIView?

  private var _event: EKEvent?
  var event:EKEvent? {
    get {return _event}
    set {
      _event =  newValue
      timeLabel?.text = dateFormatter.string(from: _event!.occurrenceDate)
      activiytMainTitle?.text = _event?.title

    }
  }

  override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
    super.init(style: style, reuseIdentifier: "agendaCell")

    dateFormatter.dateFormat =  "hh:ss a"
    createUI()
  }

  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  func createUI() {

    timeLabel =  UILabel(frame: CGRect(x: 10, y: 10, width: 100, height: self.frame.size.height))
    timeLabel?.text = "8:30 AM"
    timeLabel?.textColor  =  UIColor.black
    addSubview(timeLabel!)

    activityView =  UIView(frame: CGRect(x: 120, y: (self.frame.size.height - 10)/2, width: 10, height: 10))
    activityView?.backgroundColor =  UIColor.blue
    addSubview(activityView!)

    activiytMainTitle =  UILabel(frame: CGRect(x: 150, y: 10, width: self.frame.size.width - 150, height: self.frame.size.height))
    activiytMainTitle?.text = "This main event"
    activiytMainTitle?.textColor  =  UIColor.black
    addSubview(activiytMainTitle!)

  }
}
