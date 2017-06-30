//
//  Suit.swift
//  Poker
//
//  Created by 朱坤 on 20/06/2017.
//  Copyright © 2017 Zkun. All rights reserved.
//

import Foundation

class Suit: NSObject, NSCoding {
  var name = ""
  var store_key = ""
  var cards = [Card]()
  
  static var suits: [Suit]? {
    get{
      if let suit_data = UserDefaults.standard.object(forKey: "suits") as? Data {
        if let local_cards = NSKeyedUnarchiver.unarchiveObject(with: suit_data) as? [Suit] {
          return local_cards
        }
      }
      return nil
    }
  }
  
  init(name: String?) {
    super.init()
    self.name = name ?? "new suit \(Date().toFormatString(str: "yy-MM-d H:m"))"
    self.store_key = self.generateRandomKey()
    self.cards = self.generateCards().shuffled()
  }
  
  required init?(coder aDecoder: NSCoder) {
    self.name = aDecoder.decodeObject(forKey: "name") as! String
    self.store_key = aDecoder.decodeObject(forKey: "store_key") as! String
    let card_data = UserDefaults.standard.object(forKey: self.store_key) as! Data
    let local_cards = NSKeyedUnarchiver.unarchiveObject(with: card_data) as! [Card]
    self.cards = local_cards
  }
  
  func encode(with aCoder: NSCoder) {
    aCoder.encode(self.name, forKey: "name")
    aCoder.encode(self.store_key, forKey: "store_key")
    let data = NSKeyedArchiver.archivedData(withRootObject: self.cards)
    UserDefaults.standard.setValue(data, forKey: self.store_key)
  }
  
  override var description: String {
    return "\(name):\(store_key)"
  }
  
  static func storeToLocal(suits: [Suit]) {
    let data = NSKeyedArchiver.archivedData(withRootObject: suits)
    UserDefaults.standard.setValue(data, forKey: "suits")
  }
  
  static func addSuit(suit: Suit) {
    guard var suits = Suit.suits else { return }
    suits.append(suit)
    storeToLocal(suits: suits)
  }
  
  static func deleteSuit(suit: Suit) {
    guard var suits = Suit.suits else { return }
    guard let index = suits.index(where: { return $0.store_key == suit.store_key }) else { return }
    suits.remove(at: index)
    storeToLocal(suits: suits)
  }
  
  private
  
  func generateCards() -> [Card] {
    return ["A", "2", "3", "4", "5", "6", "7", "8", "9", "10", "J", "K", "Q"].reduce([], { result, number in
      let cards = ["spade", "heart", "diamond", "club"].map { color in
        return Card(number: number, color: color)
      }
      return result + cards
    })
  }
  
  func generateRandomKey() -> String {
    return "\(NSDate().timeIntervalSince1970 * 1000)"
  }
}

func == (lhs: Suit, rhs: Suit) -> Bool {
  return lhs.store_key == rhs.store_key
}
