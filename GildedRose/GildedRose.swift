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

public class GildedRose {

    public static func updateQuality(items: Array<Item>) -> [Item] {
        var items = items
        for i in 0 ..< items.count {
          switch items[i].name {
              case ITEM.AGED_BRIE.rawValue:  items[i] = updateAgedBrie(item: items[i])
              case ITEM.BACKSTAGE.rawValue:  items[i] = updateBackstage(item: items[i])
              case ITEM.CONJURED.rawValue:   items[i] = updateConjured(item: items[i])
              default:                      items[i] = updateNormalItems(item: items[i])
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
  
    public static func updateAgedBrie(item: Item) -> Item {
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
  
    public static func updateBackstage(item: Item) -> Item {
      var newItem: Item = item
      if newItem.quality < 50 {
        newItem.quality = newItem.quality + 1
      }
      if newItem.sellIn < 11 {
        if newItem.quality < 50 {
          newItem.quality = newItem.quality + 1
        }
      }
      
      if newItem.sellIn < 6 {
        if newItem.quality < 50 {
          newItem.quality = newItem.quality + 1
        }
      }
      newItem.sellIn =  newItem.sellIn - 1
      if newItem.sellIn < 0 {
        newItem.quality = newItem.quality - newItem.quality
      }
      return newItem
    }
  
    public static func updateConjured(item: Item) -> Item {
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
