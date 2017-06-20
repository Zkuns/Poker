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
    getCards()
    CardsCollectionView.delegate = self
    CardsCollectionView.dataSource = self
  }

  func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
    let currentIndex = Int(CardsCollectionView.contentOffset.x / CardsCollectionView.frame.size.width) + 1;
    pageLabel.text = "\(currentIndex)/\(cards.count)";
  }
  
  private
  
  func getCards() {
    if let card_data = UserDefaults.standard.object(forKey: "cards") as? Data {
      if let local_cards = NSKeyedUnarchiver.unarchiveObject(with: card_data) as? [Card] {
        self.cards = local_cards
      }
    } else {
      self.cards = generateCards()
    }
  }
  
  func generateCards() -> [Card] {
    let new_cards = Card.generateCard().shuffled()
    let data = NSKeyedArchiver.archivedData(withRootObject: new_cards)
    UserDefaults.standard.setValue(data, forKey: "cards")
    return new_cards
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
  
  func collectionView(_ collectionView: UICollectionView, didEndDisplaying cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
    pageLabel.text = "\(indexPath.row)/\(cards.count)"
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
