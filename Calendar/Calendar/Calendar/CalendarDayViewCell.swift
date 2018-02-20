//
//  CalendarDayViewCell.swift
//  Calendar
//
//  Created by savitha.rudramuni on 20/02/18.
//  Copyright © 2018 Savitha.Rudramuni. All rights reserved.
//

import Foundation
import UIKit

class CalendarDayViewCell: UICollectionViewCell {

  var dayLabel: UILabel!

  private var _dayModel: CalendarDay?
  var dayModel: CalendarDay?
  {
    get{
      return _dayModel
    }
    set{
      _dayModel = newValue
      if _dayModel == nil
      {
          dayLabel.text = ""
      }
      else
      {
        dayLabel.text = _dayModel?.dayName
        if _dayModel?.currentDay == true {
           dayLabel.backgroundColor = UIColor.red
        }
        else
        {
          dayLabel.backgroundColor = UIColor.white
        }
      }
    }
  }


  override init(frame: CGRect) {
    super.init(frame: frame)

    dayLabel =  UILabel(frame: frame)
    dayLabel.text =  NSLocalizedString("1", comment: "")
    dayLabel.textColor = UIColor.black
    dayLabel.font =  UIFont.boldSystemFont(ofSize: 20)
    self.addSubview(dayLabel)
  }

  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  override func layoutSubviews() {
    super.layoutSubviews()
    dayLabel.frame =  CGRect(x: (frame.size.width - 30)/2, y: (frame.size.height - 30)/2, width: 30, height: 30)
  }

  override func prepareForReuse() {

  }
}
