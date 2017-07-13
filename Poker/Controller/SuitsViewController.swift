//
//  ViewController.swift
//  Poker
//
//  Created by 朱坤 on 12/06/2017.
//  Copyright © 2017 Zkun. All rights reserved.
//

import UIKit

class SuitsViewController: UIViewController {
  @IBOutlet weak var suitsCollectionView: UICollectionView!
  
  var suits = [Suit]()

  override func viewDidLoad() {
    super.viewDidLoad()
    title = "卡牌列表"
    suits = Suit.suits ?? []
    suitsCollectionView.delegate = self
    suitsCollectionView.dataSource = self
  }
  
  func reloadSuitData() {
    self.suits = Suit.suits ?? []
    self.suitsCollectionView.reloadData()
  }
  
  func cleanCellAnimate() {
    for index in 0..<(suits.count) {
      let cell = suitsCollectionView.cellForItem(at: IndexPath(item: index, section: 0)) as! SuitCollectionViewCell
      cell.show_button = false
    }
  }
}

extension SuitsViewController: UICollectionViewDataSource {
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return suits.count + 1
  }
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    if indexPath.row == suits.count {
      return collectionView.dequeueReusableCell(withReuseIdentifier: "SuitAddCollectionViewCell", for: indexPath) as! SuitAddCollectionViewCell
    } else {
      let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SuitCollectionViewCell", for: indexPath) as! SuitCollectionViewCell
      cell.index = indexPath.row
      cell.delegate = self
      cell.setData(suit: suits[indexPath.row])
      return cell
    }
  }
  
  func numberOfSections(in collectionView: UICollectionView) -> Int {
    return 1
  }
  
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    let width = (UIScreen.main.bounds.width - 10) / 3 - 10
    let height = width * 6.8 / 5.5
    return CGSize(width: width, height: height)
  }
}

extension SuitsViewController: UICollectionViewDelegate {
  func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    guard indexPath.row == suits.count else { return }
    Suit.addSuit(suit: Suit(name: nil))
    suits = Suit.suits ?? []
    collectionView.insertItems(at: [IndexPath(row: suits.count - 1, section: 0)])
    suitsCollectionView.reloadData()
  }
}

extension SuitsViewController: UICollectionViewDelegateFlowLayout {
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
    return 10
  }
  
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
    return 10
  }
}

extension SuitsViewController: SuitCollectionViewCellDelegate {
  func start(cards: [Card]?) {
    guard let cards = cards else { return }
    let controller = storyboard?.instantiateViewController(withIdentifier: "CardsViewController") as! CardsViewController
    controller.cards = cards
    navigationController?.pushViewController(controller, animated: true)
  }
 
  func delete(suit: Suit?, cell: SuitCollectionViewCell) {
    guard let suit = suit else { return }
    Suit.deleteSuit(suit: suit)
    suits = Suit.suits ?? []
    suitsCollectionView.deleteItems(at: [suitsCollectionView.indexPath(for: cell)!])
  }
  
  func animateOtherCell() {
    cleanCellAnimate()
  }
}
