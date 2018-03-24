//
//  EmptyEventCell.swift
//  Calendar
//
//  Created by savitha.rudramuni on 24/03/18.
//  Copyright © 2018 Savitha.Rudramuni. All rights reserved.
//

import Foundation
import UIKit


class EmptyEventCell: UITableViewCell {

  let cellIdentifier: String =  "emptyEventCell"
  var descLabel: UILabel!

  override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
    super.init(style: style, reuseIdentifier: reuseIdentifier)

    descLabel =  UILabel(frame: self.frame)
    descLabel.text = "No Events"
    descLabel.textColor  =  UIColor.black
    addSubview(descLabel)
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
}
