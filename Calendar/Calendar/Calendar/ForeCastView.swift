//
//  ForeCastView.swift
//  Calendar
//
//  Created by savitha.rudramuni on 22/03/18.
//  Copyright © 2018 Savitha.Rudramuni. All rights reserved.
//

import Foundation
import UIKit

class ForeCastView: UIView {

  var dayLabel: UILabel!
  var foreCastImage: ForeCastStatusView!
  var predictionLabel: UILabel!
  var iconStatusLabel: UILabel!
  var tempLabel: TemparatureView!


  override init(frame: CGRect) {
    super.init(frame: frame)

    backgroundColor =   UIColor(named: "skyColor")

    foreCastImage =  ForeCastStatusView(frame: CGRect(x:(self.frame.size.width -  100) - 10 , y: 10, width: 100, height: 100))
    addSubview(foreCastImage)


    dayLabel =  UILabel(frame:CGRect(x:10 , y: 10, width: self.frame.size.width -  50 , height: 50) )
    dayLabel.text =  NSLocalizedString("1", comment: "")
    dayLabel.textColor = UIColor.black
    dayLabel.numberOfLines = 0
    dayLabel.font =  UIFont.boldSystemFont(ofSize: 20)
    self.addSubview(dayLabel)

    tempLabel =  TemparatureView(frame:CGRect(x: 20 , y: 60, width:self.frame.size.width -  150 , height:  70) )
    tempLabel.text =  NSLocalizedString("1", comment: "")
    tempLabel.textColor = UIColor.black
    tempLabel.numberOfLines = 0
    tempLabel.textAlignment = .center
    tempLabel.font =  UIFont.boldSystemFont(ofSize: 30)
    self.addSubview(tempLabel)
    tempLabel.layer.borderWidth =  2
    tempLabel.layer.borderColor =  UIColor.black.cgColor

    predictionLabel =  UILabel(frame:CGRect(x:10 , y: 150, width: self.frame.size.width, height: 50) )
    predictionLabel.text =  NSLocalizedString("1", comment: "")
    predictionLabel.textColor = UIColor.black
    predictionLabel.numberOfLines = 0
    predictionLabel.font =  UIFont.boldSystemFont(ofSize: 20)
    self.addSubview(predictionLabel)

   foreCastImage.statusIconImageView.frame = CGRect(x:0 , y: 10, width: 50, height: 50)
  }

  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }


}
