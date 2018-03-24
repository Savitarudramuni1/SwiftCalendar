//
//  ForeCastStatusView.swift
//  Calendar
//
//  Created by savitha.rudramuni on 23/03/18.
//  Copyright © 2018 Savitha.Rudramuni. All rights reserved.
//

import Foundation
import UIKit


class ForeCastStatusView : UIView {


var statusLabel: UILabel!
var statusIconImageView: UIImageView!

  fileprivate var _statusIconURL: String?
  var statusIconURL: String?{
    get {return _statusIconURL}
    set {
      _statusIconURL = newValue
      if _statusIconURL !=  nil {
        self.addForecastBackground(url: _statusIconURL!)
        
      }
    }
  }

  override init(frame: CGRect) {
    super.init(frame: frame)

    backgroundColor =  UIColor(named: "skyColor")


    statusIconImageView =  UIImageView(frame: CGRect(x:frame.size.width -  20 , y: 0, width:20 , height: 20))
    statusIconImageView.image = UIImage(named: "background")
    statusIconImageView.contentMode = .scaleAspectFill
    addSubview(statusIconImageView)



    statusLabel = UILabel(frame: CGRect(x:0 , y: frame.size.height -  20, width:frame.size.width , height: 20))
    statusLabel.textColor =  UIColor.black
    statusLabel.text = "Cloudly"
    statusLabel.adjustsFontSizeToFitWidth =  true
    addSubview(statusLabel)
  }

  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  func addForecastBackground(url: String) {
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
                  self.statusIconImageView?.image = image
                }
              }
            }
          })
        }
      }
    }
  }

  func updateView(){
    let fc = WeatherForCast.sharedInstrance.todayForeCast
    if let imageUrl: String =  fc.iconUrl, imageUrl != ""{
      self.addForecastBackground(url: imageUrl)
    }
    self.statusLabel.text =  fc.iconStatus
  }

}
