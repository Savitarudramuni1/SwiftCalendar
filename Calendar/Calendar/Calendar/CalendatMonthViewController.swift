//
//  CalendatMonthViewController.swift
//  Calendar
//
//  Created by savitha.rudramuni on 20/02/18.
//  Copyright © 2018 Savitha.Rudramuni. All rights reserved.
//

import Foundation
import UIKit

@objcMembers
class CalendatMonthViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {
  var collectionView: UICollectionView!
  var month: CalendarMonth?

  override func viewDidLoad() {
    super.viewDidLoad()

    let layout: UICollectionViewFlowLayout =  UICollectionViewFlowLayout()
    layout.scrollDirection =  .vertical
    collectionView =  UICollectionView(frame: self.view.bounds, collectionViewLayout: layout)
    collectionView.dataSource =  self
    collectionView.delegate =  self
    collectionView.backgroundColor = UIColor.white
    collectionView.register(CalendarWeekViewCell.self, forCellWithReuseIdentifier: "weeKView")
    self.view.addSubview(collectionView)
    collectionView.reloadData()
    generateMonth()
  }

  override func viewDidLayoutSubviews() {
    super.viewDidLayoutSubviews()
    collectionView.frame = self.view.bounds
  }

//}
//
//extension CalendatMonthViewController: UICollectionViewDataSource {

  func numberOfSections(in collectionView: UICollectionView) -> Int {
    return 1
  }

  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return month!.month.count
  }

  @objc func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cell: UICollectionViewCell =  collectionView.dequeueReusableCell(withReuseIdentifier: "weeKView", for: indexPath)
    cell.backgroundColor = UIColor.red
    if let weekCell: CalendarWeekViewCell =  cell as? CalendarWeekViewCell {
        weekCell.backgroundColor = UIColor.red
        weekCell.weekModel =  month?.month[indexPath.row]
    }
    return cell
  }
//}
//
//extension CalendatMonthViewController: UICollectionViewDelegateFlowLayout {
  @objc func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    return CGSize(width: collectionView.frame.size.width, height: 100)
  }

  func generateMonth()
  {
    var weeks: [CalendarWeek] =  [CalendarWeek] ()
    var days: [CalendarDay] =  [CalendarDay] ()

    var nextDay: Int = 0

    for i in 0...4 {
      days.removeAll()
      for j in nextDay...nextDay+6 {
        let day: CalendarDay = CalendarDay (day: j+1, dayName: "\(j+1)",currentDay: false)
        days.append(day)
        nextDay =  j+1
      }
      let week: CalendarWeek = CalendarWeek (week: i, days: days, weekName: "\(i)")
      weeks.append(week)
    }
      month =  CalendarMonth(month: weeks, monthName: "AAA", currentMonth: true)

    collectionView.reloadData()
  }


}
