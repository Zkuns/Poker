//
//  SuitCollectionViewCell.swift
//  Poker
//
//  Created by 朱坤 on 20/06/2017.
//  Copyright © 2017 Zkun. All rights reserved.
//

import UIKit

// need to implement by SuitsViewController
protocol SuitCollectionViewCellDelegate: NSObjectProtocol {
  func start(cards: [Card]?) -> ()
  func delete(suit: Suit?, cell: SuitCollectionViewCell) -> ()
  func animateOtherCell() -> ()
}

class SuitCollectionViewCell: UICollectionViewCell {
  @IBOutlet weak var name: UILabel!
  @IBOutlet weak var start_button: UIButton!
  @IBOutlet weak var delete_button: UIButton!
  @IBOutlet weak var container_view: UIView!
  
  var suit: Suit?
  var index = 0
  var show_button = false {
    didSet{
      guard oldValue != show_button else { return }
      animateView()
    }
  }
  weak var delegate: SuitCollectionViewCellDelegate?
  
  @IBAction func clickStartButton(_ sender: Any) {
    show_button = !show_button
    delegate?.start(cards: suit?.cards)
  }
  
  @IBAction func clickDeleteButton(_ sender: Any) {
    show_button = !show_button
    delegate?.delete(suit: suit, cell: self)
  }
  
  func setData(suit: Suit) {
    self.suit = suit
    updateView()
  }
  
  func updateView(){
    self.name.text = self.suit?.name ?? ""
  }
  
  override func awakeFromNib() {
    super.awakeFromNib()
    //add click
    let gesture = UITapGestureRecognizer(target: self, action: #selector(toggleView(sender:)))
    container_view.addGestureRecognizer(gesture)
    
    //add border
    self.layer.borderColor = UIColor(red: 221/255, green: 221/255, blue: 221/255, alpha: 1).cgColor
    self.layer.borderWidth = 1
    self.layer.cornerRadius = 5
    
    //change button image size
    start_button.imageEdgeInsets = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
    delete_button.imageEdgeInsets = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
  }
  
  func toggleView(sender: UITapGestureRecognizer) {
    if show_button == false { delegate?.animateOtherCell() }
    show_button = !show_button
  }
  
  func animateView() {
    let moveDistance = self.container_view.frame.width / 2 * (show_button ? 1 : -1)
    UIView.animate(withDuration: 0.5, animations: {
      self.container_view.frame.origin.x = self.container_view.frame.origin.x - moveDistance
    })
  }
}
