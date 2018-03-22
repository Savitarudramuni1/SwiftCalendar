//
//  CalendarWeekViewCell.swift
//  Calendar
//
//  Created by savitha.rudramuni on 20/02/18.
//  Copyright © 2018 Savitha.Rudramuni. All rights reserved.
//

import Foundation
import  UIKit

protocol CalendarWeekViewCellProtocol: class {
  func didSelectDay(day: CalendarDay)
}

@objcMembers
class CalendarWeekViewCell: UICollectionViewCell, UICollectionViewDataSource,UICollectionViewDelegate {

  var weekCollectionView: UICollectionView!
  weak var cellDelegate:CalendarWeekViewCellProtocol?

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
    weekCollectionView.delegate =  self
    weekCollectionView.backgroundColor =  UIColor.white
    weekCollectionView.register(CalendarDayViewCell.self, forCellWithReuseIdentifier: "dayView")
    self.addSubview(weekCollectionView)

let flow = UICollectionViewFlowLayout()
flow.itemSize = CGSize(width: weekCollectionView.frame.size.width / 7, height: 40)
flow.scrollDirection = .horizontal
flow.minimumInteritemSpacing = 0
flow.minimumLineSpacing = 0
    weekCollectionView.collectionViewLayout = flow;
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
    return 7
  }

  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cell: UICollectionViewCell =  collectionView.dequeueReusableCell(withReuseIdentifier: "dayView", for: indexPath)
    if let dayCell: CalendarDayViewCell =  cell as? CalendarDayViewCell {
      let dayModel: CalendarDay? =  weekModel?.days.filter({ (d:CalendarDay) -> Bool in
        return d.weekDay == indexPath.row+1
      }).first

      if dayModel != nil {
        dayCell.dayModel =  dayModel
        dayCell.backgroundColor =  UIColor.white
      }
      else {
        dayCell.dayLabel.text =  ""
      }

    }
    return cell
  }

  func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    let dayModel: CalendarDay? =  weekModel?.days.filter({ (d:CalendarDay) -> Bool in
      return d.weekDay == indexPath.row+1
    }).first

    if dayModel != nil {
      cellDelegate?.didSelectDay(day: dayModel!)
    }

  }

  @objc func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    return CGSize(width: collectionView.frame.size.width / 7, height: 40)
  }

}
