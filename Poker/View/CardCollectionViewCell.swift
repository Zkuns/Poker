//
//  CardCollectionViewCell.swift
//  Poker
//
//  Created by 朱坤 on 15/06/2017.
//  Copyright © 2017 Zkun. All rights reserved.
//

import UIKit

class CardCollectionViewCell: UICollectionViewCell {
  @IBOutlet weak var topText: UILabel!
  @IBOutlet weak var topImage: UIImageView!
  @IBOutlet weak var bottomText: UILabel!
  @IBOutlet weak var bottomImage: UIImageView!
  @IBOutlet weak var colorImage: UIImageView!
  @IBOutlet weak var cardView: UIView!
  
  var card: Card?{
    didSet{
      updateUI()
    }
  }
  
  func setData(card: Card) {
    self.card = card
  }
  
  func updateUI(){
    topText.text = card?.number
    bottomText.text = card?.number
    colorImage.image = UIImage(named: card?.color ?? "")
    topImage.image = UIImage(named: card?.color ?? "")
    bottomImage.image = UIImage(named: card?.color ?? "")
  }
  
  override func awakeFromNib() {
    super.awakeFromNib()
    cardView.layer.borderColor = UIColor.gray.cgColor
    cardView.layer.borderWidth = 1
    cardView.layer.cornerRadius = 5
    bottomText.transform = CGAffineTransform.identity.rotated(by: CGFloat(Double.pi))
    bottomImage.transform = CGAffineTransform.identity.rotated(by: CGFloat(Double.pi))
  }
}
