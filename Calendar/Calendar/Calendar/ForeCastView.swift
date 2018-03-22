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
  var foreCastImage: UIImageView!
  var predictionLabel: UILabel!
  var iconStatusLabel: UILabel!


  override init(frame: CGRect) {
    super.init(frame: frame)

    backgroundColor =  UIColor.blue

    foreCastImage =  UIImageView(frame: CGRect(x:(self.frame.size.width -  50) - 10 , y: 10, width: 50, height: 50))
    foreCastImage.image = UIImage(named: "background")
    foreCastImage.contentMode = .scaleAspectFill
     addSubview(foreCastImage!)
    foreCastImage.isUserInteractionEnabled =  true

    iconStatusLabel =  UILabel(frame:CGRect(x:self.frame.size.width -  70 , y: 50, width: 70 , height: 50) )
    iconStatusLabel.text =  NSLocalizedString("1", comment: "")
    iconStatusLabel.textColor = UIColor.white
    iconStatusLabel.numberOfLines = 0
    iconStatusLabel.font =  UIFont.boldSystemFont(ofSize: 10)
    self.addSubview(iconStatusLabel)


    dayLabel =  UILabel(frame:CGRect(x:10 , y: 10, width: self.frame.size.width -  50 , height: 50) )
    dayLabel.text =  NSLocalizedString("1", comment: "")
    dayLabel.textColor = UIColor.white
    dayLabel.numberOfLines = 0
    dayLabel.font =  UIFont.boldSystemFont(ofSize: 20)
    self.addSubview(dayLabel)

    predictionLabel =  UILabel(frame:CGRect(x:10 , y: 90, width: self.frame.size.width, height: 50) )
    predictionLabel.text =  NSLocalizedString("1", comment: "")
    predictionLabel.textColor = UIColor.white
    predictionLabel.numberOfLines = 0
    predictionLabel.font =  UIFont.boldSystemFont(ofSize: 20)
    self.addSubview(predictionLabel)
  }

  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }


  func addForecastBackground(url: String) {
    foreCastImage?.isHidden =  false
    if url != "" {
      DispatchQueue.global().async {
        if let imageUrl : URL =  URL(string: url) {
          NetworkOperation().getResponseData(url: imageUrl, closure: { (data: Data?, error: Error?) in
            if data != nil {
              guard let source:CGImageSource = CGImageSourceCreateWithData(data! as CFData, nil) else {
                print("image doesn't exist")
                return
              }
              if let image: UIImage = UIImage.animatedImageWithSource(source: source) {
                DispatchQueue.main.async {
                  self.foreCastImage?.image = image
                }
              }
            }
          })
        }
      }
    }
  }


}
