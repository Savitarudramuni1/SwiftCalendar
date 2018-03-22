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
class CalendatMonthViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource,UICollectionViewDelegateFlowLayout,CalendarWeekViewCellProtocol {
  var collectionView: UICollectionView!
  var foreCastView: ForeCastView!
  var month: CalendarMonth?

  let calendarOpeartor: CalendarOperator =  CalendarOperator()

  override func viewDidLoad() {
    super.viewDidLoad()

    let layout: UICollectionViewFlowLayout =  UICollectionViewFlowLayout()
    layout.scrollDirection =  .vertical
    let collectionViewHeight: CGFloat = 40 * 5
    collectionView =  UICollectionView(frame: CGRect(x: 0, y: 0, width: self.view.bounds.width, height: collectionViewHeight), collectionViewLayout: layout)
    collectionView.dataSource =  self
    collectionView.delegate =  self
    collectionView.backgroundColor = .white
    collectionView.backgroundColor = UIColor.white
    collectionView.register(CalendarWeekViewCell.self, forCellWithReuseIdentifier: "weeKView")
    self.view.addSubview(collectionView)
    collectionView.reloadData()

    let flow = UICollectionViewFlowLayout()
    flow.itemSize = CGSize(width: collectionView.frame.size.width, height: 40)
    flow.scrollDirection = .vertical
    flow.minimumInteritemSpacing = 0
    flow.minimumLineSpacing = 0
    generateMonth()

    foreCastView =  ForeCastView(frame: CGRect(x: 0, y: collectionViewHeight + 100, width: self.view.bounds.width, height: self.view.bounds.height - collectionViewHeight))
    foreCastView.isHidden =  true
    view.addSubview(foreCastView)

    NotificationCenter.default.addObserver(self, selector: #selector(CalendatMonthViewController.loadForecast), name: NSNotification.Name(rawValue: "forecast"), object: nil)
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
        weekCell.cellDelegate =  self
        weekCell.weekModel =  month?.month[indexPath.row]
    }
    return cell
  }
//}
//
//extension CalendatMonthViewController: UICollectionViewDelegateFlowLayout {
  @objc func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    return CGSize(width: collectionView.frame.size.width, height: 40)
  }

  func generateMonth() {
    month =  CalendarMonth(month: calendarOpeartor.currentMonthData, monthName: "AAA", currentMonth: true)
    collectionView.reloadData()
  }

  func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {

    let agendaViewController: AgendaViewController = AgendaViewController()
    self.navigationController?.pushViewController(agendaViewController, animated: true)

  }

  func didSelectDay(day: CalendarDay){
    let agendaViewController: AgendaViewController = AgendaViewController()
    self.navigationController?.pushViewController(agendaViewController, animated: true)
  }

  func loadForecast() {
    DispatchQueue.main.async {
      self.collectionView.reloadData()
      self.foreCastView.isHidden =  false
      let fc = WeatherForCast.sharedInstrance.todayForeCast
      if let imageUrl: String =  fc.iconUrl, imageUrl != ""{
        self.foreCastView.addForecastBackground(url: imageUrl)
      }
      self.foreCastView.dayLabel.text = "\(fc.placeName) - \(fc.temparature) c"
      self.foreCastView.predictionLabel.text =  fc.prediction
      self.foreCastView.iconStatusLabel.text =  fc.iconStatus
    }

  }

}
