//
//  SuitAddCollectionViewCell.swift
//  Poker
//
//  Created by 朱坤 on 20/06/2017.
//  Copyright © 2017 Zkun. All rights reserved.
//

import UIKit

class SuitAddCollectionViewCell: UICollectionViewCell {
  override func awakeFromNib() {
    super.awakeFromNib()
    
    //add border
    self.layer.borderColor = UIColor(red: 221/255, green: 221/255, blue: 221/255, alpha: 1).cgColor
    self.layer.borderWidth = 1
    self.layer.cornerRadius = 5
  }
}
