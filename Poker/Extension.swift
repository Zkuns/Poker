//
//  Extension.swift
//  Poker
//
//  Created by 朱坤 on 15/06/2017.
//  Copyright © 2017 Zkun. All rights reserved.
//

import Foundation

extension MutableCollection where Indices.Iterator.Element == Index {
  mutating func shuffle() {
    let c = count
    guard c > 1 else { return }
    
    for (firstUnshuffled , unshuffledCount) in zip(indices, stride(from: c, to: 1, by: -1)) {
      let d: IndexDistance = numericCast(arc4random_uniform(numericCast(unshuffledCount)))
      guard d != 0 else { continue }
      let i = index(firstUnshuffled, offsetBy: d)
      swap(&self[firstUnshuffled], &self[i])
    }
  }
}

extension Sequence {
  func shuffled() -> [Iterator.Element] {
    var result = Array(self)
    result.shuffle()
    return result
  }
}
