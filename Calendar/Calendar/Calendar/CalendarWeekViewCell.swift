//
//  CalendarWeekViewCell.swift
//  Calendar
//
//  Created by savitha.rudramuni on 20/02/18.
//  Copyright © 2018 Savitha.Rudramuni. All rights reserved.
//

import Foundation
import  UIKit

@objcMembers
class CalendarWeekViewCell: UICollectionViewCell, UICollectionViewDataSource {

  var weekCollectionView: UICollectionView!

  private var _weekModel: CalendarWeek?
  var weekModel: CalendarWeek?
  {
    get{
      return _weekModel
    }
    set{
      _weekModel = newValue
      weekCollectionView.reloadData()
    }
  }

  override init(frame: CGRect) {
    super.init(frame: frame)

     let layout: UICollectionViewFlowLayout =  UICollectionViewFlowLayout()
    layout.scrollDirection =  .horizontal
    weekCollectionView =  UICollectionView(frame: self.bounds, collectionViewLayout: layout)
    weekCollectionView.dataSource =  self
    weekCollectionView.register(CalendarDayViewCell.self, forCellWithReuseIdentifier: "dayView")
    self.addSubview(weekCollectionView)
  }

  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

//}
//
//extension CalendarWeekViewCell: UICollectionViewDataSource {

  func numberOfSections(in collectionView: UICollectionView) -> Int {
    return 1
  }

  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return weekModel?.days != nil ? weekModel!.days.count : 0
  }

  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cell: UICollectionViewCell =  collectionView.dequeueReusableCell(withReuseIdentifier: "dayView", for: indexPath)
    if let dayCell: CalendarDayViewCell =  cell as? CalendarDayViewCell {
        dayCell.dayModel =  weekModel?.days[indexPath.row]
        dayCell.backgroundColor =  UIColor.white
    }
    return cell
  }

  @objc func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    return CGSize(width: collectionView.frame.size.width / 7, height: 100)
  }
}
