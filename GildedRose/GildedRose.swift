//
//  GildedRose.swift
//  GildedRose
//
//  Created by Tom Heinan on 8/31/15.
//  Copyright © 2015 Tom Heinan. All rights reserved.
//
enum ITEM:String {
  case AGED_BRIE = "Aged Brie"
  case SULFURAS  = "Sulfuras, Hand of Ragnaros"
  case BACKSTAGE = "Backstage passes to a TAFKAL80ETC concert"
  case CONJURED  = "Conjured Mana Cake"
}

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

public class GildedRose {

   public static let itemMap = ["Aged Brie":AgedBrie(),"Backstage passes to a TAFKAL80ETC concert": BackStage(),"Conjured Mana Cake": Conjured()] as [String: ItemProtocol]
  
    public static func updateQuality(items: Array<Item>) -> [Item] {
        var items = items
        for i in 0 ..< items.count {
          let itemDelegate = itemMap[items[i].name]
          if itemDelegate != nil {
            items[i] = (itemDelegate?.updateItem(item: items[i]))!
          } else {
            items[i] = updateNormalItems(item: items[i])
          }
        }
        return items
    }
    public static func updateNormalItems(item: Item) -> Item {
      var newItem: Item = item
      if newItem.quality > 0 && newItem.name != ITEM.SULFURAS.rawValue{
        newItem.quality = newItem.quality - 1
      }
      if newItem.name != ITEM.SULFURAS.rawValue  {
        newItem.sellIn =  newItem.sellIn - 1
      }
      if newItem.sellIn < 0 && newItem.quality > 0 && newItem.name != ITEM.SULFURAS.rawValue {
        newItem.quality = newItem.quality - 1
      }
      return newItem
    }
}
