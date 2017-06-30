//
//  CardsViewController.swift
//  Poker
//
//  Created by 朱坤 on 14/06/2017.
//  Copyright © 2017 Zkun. All rights reserved.
//

import UIKit

class CardsViewController: UIViewController {
  @IBOutlet weak var CardsCollectionView: UICollectionView!
  @IBOutlet weak var pageLabel: UILabel!
  
  var cards = [Card]()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    CardsCollectionView.delegate = self
    CardsCollectionView.dataSource = self
  }

  func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
    let currentIndex = Int(CardsCollectionView.contentOffset.x / CardsCollectionView.frame.size.width) + 1;
    pageLabel.text = "\(currentIndex)/\(cards.count)";
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
