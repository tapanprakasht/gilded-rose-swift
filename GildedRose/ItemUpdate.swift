//
//  ItemUpdate.swift
//  GildedRose
//
//  Created by Prakash T, Tapan on 26/04/18.
//  Copyright © 2018 Tom Heinan. All rights reserved.
//

import Foundation

public protocol ItemProtocol {
  func updateItem(item: Item) -> Item
}

public class AgedBrie: ItemProtocol {
  public func updateItem(item: Item) -> Item {
    var newItem: Item = item
    if newItem.quality < 50 {
      newItem.quality = newItem.quality + 1
    }
    newItem.sellIn =  newItem.sellIn - 1
    if newItem.sellIn < 0 {
      if newItem.quality < 50 {
        newItem.quality = newItem.quality + 1
      }
    }
    return newItem
  }
}

public class BackStage: ItemProtocol {
  public func updateItem(item: Item) -> Item {
    var newItem: Item = item
    if newItem.quality < 50 {
      newItem.quality = newItem.quality + 1
      if newItem.sellIn < 11 {
        newItem.quality = newItem.quality + 1
      }
      if newItem.sellIn < 6 {
        newItem.quality = newItem.quality + 1
      }
    }
    newItem.sellIn =  newItem.sellIn - 1
    if newItem.sellIn < 0 {
      newItem.quality = newItem.quality - newItem.quality
    }
    return newItem
  }
}

public class Conjured: ItemProtocol {
  public func updateItem(item: Item) -> Item {
    var newItem: Item = item
    if newItem.sellIn > 0 {
      newItem.quality = newItem.quality - 2
    } else {
      newItem.quality = newItem.quality - 4
    }
    if newItem.quality < 0 {
      newItem.quality = 0
    }
    newItem.sellIn =  newItem.sellIn - 1
    
    return newItem
  }
}
