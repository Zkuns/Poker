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
    let alert = UIAlertController(title: "添加套牌", message: nil, preferredStyle: .alert)
    alert.addTextField(configurationHandler: { textField in
      textField.borderStyle = .none
      textField.text = "新套牌 \(Date().toFormatString(str: "H:mm"))"
    })
    let createAction = UIAlertAction(title: "确认", style: .default, handler: { action in
      let suitname = alert.textFields?[0].text ?? ""
      Suit.addSuit(suit: Suit(name: suitname))
      self.suits = Suit.suits ?? []
      collectionView.insertItems(at: [IndexPath(row: self.suits.count - 1, section: 0)])
      self.suitsCollectionView.reloadData()
    })
    let cancleAction = UIAlertAction(title: "取消", style: .cancel, handler: nil)
    alert.view.tintColor = UIColor.gray
    alert.addAction(createAction)
    alert.addAction(cancleAction)
    present(alert, animated: true, completion: nil)
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
    let alert = UIAlertController(title: "", message: "确认删除吗？", preferredStyle: .actionSheet)
    let sure = UIAlertAction(title: "确认", style: .default, handler: { action in
      guard let suit = suit else { return }
      Suit.deleteSuit(suit: suit)
      self.suits = Suit.suits ?? []
      self.suitsCollectionView.deleteItems(at: [self.suitsCollectionView.indexPath(for: cell)!])
    })
    let cancel = UIAlertAction(title: "取消", style: .cancel, handler: nil)
    alert.view.tintColor = UIColor.gray
    alert.addAction(sure)
    alert.addAction(cancel)
    present(alert, animated: true, completion: nil)
  }
  
  func animateOtherCell() {
    cleanCellAnimate()
  }
}
