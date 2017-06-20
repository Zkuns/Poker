//
//  Card.swift
//  Poker
//
//  Created by 朱坤 on 13/06/2017.
//  Copyright © 2017 Zkun. All rights reserved.
//

import Foundation

class Card: NSObject, NSCoding {
  var number: String
  var color: String
  
  init(number: String, color: String) {
    self.number = number
    self.color = color
  }
  
  override var description: String {
    return "\(color):\(number)"
  }
  
  required init?(coder aDecoder: NSCoder) {
    self.number = aDecoder.decodeObject(forKey: "number") as! String
    self.color = aDecoder.decodeObject(forKey: "color") as! String
  }
  
  func encode(with aCoder: NSCoder) {
    aCoder.encode(number, forKey: "number")
    aCoder.encode(color, forKey: "color")
  }
  
  static func generateCard() -> [Card]{
    return ["A", "2", "3", "4", "5", "6", "7", "8", "9", "10", "J", "K", "Q"].reduce([], { result, number in
      let cards = ["spade", "heart", "diamond", "club"].map { color in
        return Card(number: number, color: color)
      }
      return result + cards
    })
  }
}
