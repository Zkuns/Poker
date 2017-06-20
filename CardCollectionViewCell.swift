//
//  CardCollectionViewCell.swift
//  Poker
//
//  Created by 朱坤 on 15/06/2017.
//  Copyright © 2017 Zkun. All rights reserved.
//

import UIKit

class CardCollectionViewCell: UICollectionViewCell {
  @IBOutlet weak var detail: UILabel!
  var card: Card?{
    didSet{
      updateUI()
    }
  }
  
  func setData(card: Card) {
    self.card = card
  }
  
  func updateUI(){
    detail.text = card?.description
  }
}
