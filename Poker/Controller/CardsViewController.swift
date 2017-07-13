//
//  CardsViewController.swift
//  Poker
//
//  Created by 朱坤 on 14/06/2017.
//  Copyright © 2017 Zkun. All rights reserved.
//

import UIKit

class CardsViewController: UIViewController {
  @IBOutlet weak var cardsCollectionView: UICollectionView!
  @IBOutlet weak var pageLabel: UILabel!
  @IBOutlet weak var timeLabel: UILabel!
  @IBOutlet weak var timeStartButton: UIButton!
  @IBOutlet weak var timeResetButton: UIButton!
  @IBOutlet weak var pageForwardButton: UIButton!
  @IBOutlet weak var pageBackButton: UIButton!
  
  var cards = [Card]()
  var timer: Timer?
  var currentIndex: Int = 1
  var time_record = 0 {
    didSet{
      self.timeLabel.text = convertToTimeString(second: time_record)
    }
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    cardsCollectionView.delegate = self
    cardsCollectionView.dataSource = self
  }

  func scrollViewDidScroll(_ scrollView: UIScrollView) {
    currentIndex = Int(cardsCollectionView.contentOffset.x / cardsCollectionView.frame.size.width) + 1
    if currentIndex == 52 {
      pageForwardButton.isEnabled = false
    } else if currentIndex == 1 {
      pageBackButton.isEnabled = false
    } else {
      pageForwardButton.isEnabled = true
      pageBackButton.isEnabled = true
    }
    pageLabel.text = "\(currentIndex)/\(cards.count)"
  }
  
  @IBAction func timeStartButton(_ sender: Any) {
    if let time = timer {
      timeStartButton.setTitle(">", for: .normal)
      timeResetButton.isEnabled = true
      time.invalidate()
      timer = nil
    } else {
      timeStartButton.setTitle("||", for: .normal)
      timeResetButton.isEnabled = false
      timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(startCount), userInfo: nil, repeats: true)
    }
  }
  
  @IBAction func timeResetButton(_ sender: Any) {
    self.time_record = 0
  }
  
  @IBAction func pageBackButton(_ sender: Any) {
    currentIndex = (currentIndex - 10) < 0 ? 1 : currentIndex - 10
    cardsCollectionView.scrollToItem(at: IndexPath(row: currentIndex - 1, section: 0), at: UICollectionViewScrollPosition.centeredHorizontally, animated: true)
  }
  
  @IBAction func pageForwardButton(_ sender: Any) {
    currentIndex = (currentIndex + 10) > 52 ? 52 : currentIndex + 10
    cardsCollectionView.scrollToItem(at: IndexPath(row: currentIndex - 1, section: 0), at: UICollectionViewScrollPosition.centeredHorizontally, animated: true)
  }
  
  @objc func startCount() {
    time_record += 1
  }
  
  private func convertToTimeString(second: Int) -> String {
    var time = ""
    let hours = second / 3600
    if (hours > 0) { time.append("\(hours)小时，") }
    let minutes = second / 60
    if (minutes > 0) { time.append("\(minutes)分钟，") }
    let seconds = second % 60
    time.append("\(seconds)秒")
    return time
  }
}

extension CardsViewController: UICollectionViewDataSource {
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return cards.count
  }
  
  func numberOfSections(in collectionView: UICollectionView) -> Int {
    return 1
  }
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CardCollectionViewCell", for: indexPath) as! CardCollectionViewCell
    cell.setData(card: cards[indexPath.row])
    return cell
  }
}

extension CardsViewController: UICollectionViewDelegateFlowLayout {
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
    return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
  }
  
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
    return 0
  }
  
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
    return 0
  }
}
