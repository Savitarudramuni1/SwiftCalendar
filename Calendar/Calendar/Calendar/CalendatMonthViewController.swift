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
class CalendatMonthViewController: UIViewController {
  var collectionView: UICollectionView!
  var foreCastView: ForeCastView!
  var month: [CalendarMonth] =  [CalendarMonth]()

  var currentDisplayMonth: Int =  CalendarOperator.shared.currentMonth

  override func viewDidLoad() {
    super.viewDidLoad()
    self.navigationController?.isNavigationBarHidden =  false
    let dateFormatter: DateFormatter =  DateFormatter()
    dateFormatter.dateFormat =  "MMMM YYYY"

    self.title = dateFormatter.string(from: Date())
   self.createUI()
    NotificationCenter.default.addObserver(self, selector: #selector(CalendatMonthViewController.loadForecast), name: NSNotification.Name(rawValue: "forecast"), object: nil)
  }

  override func viewDidLayoutSubviews() {
    super.viewDidLayoutSubviews()
  }

  func createUI() {

    let weekNameView: UIView =  UIView(frame: CGRect(x: 0, y: 0, width: self.view.bounds.width, height: 40))
    weekNameView.backgroundColor =  UIColor.white
    view.addSubview(weekNameView)


    let layout: UICollectionViewFlowLayout =  UICollectionViewFlowLayout()
    layout.scrollDirection =  .vertical
    let collectionViewHeight: CGFloat = 40 * 8
    collectionView =  UICollectionView(frame: CGRect(x: 0, y: 40, width: self.view.bounds.width, height: collectionViewHeight), collectionViewLayout: layout)
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
    flow.minimumInteritemSpacing = 1
    flow.minimumLineSpacing = 1
    generateMonth(currentDisplayMonth)
    currentDisplayMonth =  currentDisplayMonth + 1
    generateMonth(currentDisplayMonth)
    self.collectionView.reloadData()

    foreCastView =  ForeCastView(frame: CGRect(x: 0, y: collectionViewHeight + 40, width: self.view.bounds.width, height: self.view.bounds.height - (collectionViewHeight + 40)))
    foreCastView.isHidden =  true
    view.addSubview(foreCastView)

  }

  func loadForecast() {
    DispatchQueue.main.async {
      self.collectionView.reloadData()
      self.foreCastView.isHidden =  false
      self.foreCastView.foreCastImage.backgroundColor =  UIColor.clear
      let fc = WeatherForCast.sharedInstrance.todayForeCast
      self.foreCastView.dayLabel.text = "\(fc.placeName)"
      self.foreCastView.predictionLabel.text =  fc.prediction
      self.foreCastView.tempLabel.text =  " \(fc.temparature) "
      self.foreCastView.foreCastImage.updateView()
    }

  }

  func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
      currentDisplayMonth =  currentDisplayMonth + 1
    generateMonth(currentDisplayMonth)
    if let indexPath: Int =  collectionView.indexPathsForVisibleItems.first?.row {
    let monthName: String =  self.month[indexPath].monthName
      self.title =  monthName
    }
      self.collectionView.reloadData()
  }

}


extension CalendatMonthViewController: UICollectionViewDataSource {

  func numberOfSections(in collectionView: UICollectionView) -> Int {
    return month.count
  }

  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return month[section].month.count
  }

  @objc func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cell: UICollectionViewCell =  collectionView.dequeueReusableCell(withReuseIdentifier: "weeKView", for: indexPath)
    cell.backgroundColor = UIColor.red
    if let weekCell: CalendarWeekViewCell =  cell as? CalendarWeekViewCell {
        weekCell.backgroundColor = UIColor.red
        weekCell.cellDelegate =  self
        weekCell.weekModel =  month[indexPath.section].month[indexPath.row]
    }
    return cell
  }

}

extension CalendatMonthViewController: UICollectionViewDelegateFlowLayout,CalendarWeekViewCellProtocol {
  @objc func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    return CGSize(width: collectionView.frame.size.width, height: 40)
  }

  func generateMonth(_ monthIndex: Int) {
    let dMonth =  CalendarOperator.shared.getMonthData(month: monthIndex)
    month.append(dMonth)
    collectionView.reloadData()
  }

  func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {

    let agendaViewController: AgendaViewController = AgendaViewController()
    agendaViewController.currentDisplayDate =  Date()
    self.navigationController?.pushViewController(agendaViewController, animated: true)

  }

  func didSelectDay(day: CalendarDay){
    let agendaViewController: AgendaViewController = AgendaViewController()
    agendaViewController.currentDisplayDate =  day.date!
    self.navigationController?.pushViewController(agendaViewController, animated: true)
  }



}
