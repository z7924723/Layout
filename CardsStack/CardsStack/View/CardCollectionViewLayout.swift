//
//  CardCollectionViewLayout.swift
//  CardsStack
//
//  Created by PinguMac on 2018/1/22.
//  Copyright © 2018年 PinguMac. All rights reserved.
//

import UIKit

class CardCollectionViewLayout: UICollectionViewLayout {
  var itemSize: CGSize!
  var spacing: CGFloat!
  var maximumVisibleItems: Int!
  var itemsCount: Int!
  
  override open func prepare() {
    super.prepare()
    assert(collectionView?.numberOfSections == 1, "Multiple sections aren't supported!")
    
    self.itemSize = CGSize(width: 250, height: 400)
    self.spacing  = 16.0
    self.maximumVisibleItems = 4
    self.itemsCount = collectionView!.numberOfItems(inSection: 0)
  }
  
  // Returns the width and height of the collection view’s contents.
  override var collectionViewContentSize: CGSize {
    if collectionView == nil { return CGSize.zero }
    
    return CGSize(width: collectionView!.bounds.width * CGFloat(itemsCount),
                  height: collectionView!.bounds.height)
  }
  
  // Returns the layout attributes for all of the cells and views in the specified rectangle.
  // rect: 736*736
  override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
    if collectionView == nil { return nil }
  
    let minVisibleIndex = Int(collectionView!.contentOffset.x) / Int(collectionView!.bounds.width)
    let maxVisibleIndex = min(itemsCount, minVisibleIndex + maximumVisibleItems)
//    print("collectionView!.contentOffset.y", collectionView!.contentOffset.y)
//    print("collectionView!.bounds", collectionView!.bounds)
    
    let contentCenterX = collectionView!.contentOffset.x + (collectionView!.bounds.width / 2)
    let contentCenterY = collectionView!.contentOffset.y + (collectionView!.bounds.height / 2)
    let deltaOffset = Int(collectionView!.contentOffset.x) % Int(collectionView!.bounds.width)
    let percentageDeltaOffset = CGFloat(deltaOffset) / collectionView!.bounds.width
//    print("contentCenterX:", contentCenterX)
//    print("deltaOffset:", deltaOffset)
//    print("percentageDeltaOffset:", percentageDeltaOffset)

    var attributes = [UICollectionViewLayoutAttributes]()
    for i in minVisibleIndex ..< maxVisibleIndex {
      let attribute = computeLayoutAttributesForItem(indexPath: IndexPath(item: i, section: 0),
                                                     minVisibleIndex: minVisibleIndex,
                                                     contentCenterX: contentCenterX,
                                                     contentCenterY: contentCenterY,
                                                     deltaOffset: CGFloat(deltaOffset),
                                                     percentageDeltaOffset: percentageDeltaOffset)
      attributes.append(attribute)
    }
    
    return attributes
  }
  
  // Asks the layout object if the new bounds require a layout update.
  override func shouldInvalidateLayout(forBoundsChange newBounds: CGRect) -> Bool {
    return true
  }
  
  func computeLayoutAttributesForItem(indexPath: IndexPath,
                                      minVisibleIndex: Int,
                                      contentCenterX: CGFloat,
                                      contentCenterY: CGFloat,
                                      deltaOffset: CGFloat,
                                      percentageDeltaOffset: CGFloat) -> UICollectionViewLayoutAttributes {
    if collectionView == nil {
      return UICollectionViewLayoutAttributes(forCellWith: indexPath)
    }
    
    let attributes = UICollectionViewLayoutAttributes(forCellWith: indexPath)
    let cardIndex = indexPath.row - minVisibleIndex

    attributes.size = itemSize
    attributes.center = CGPoint(x: contentCenterX + spacing * CGFloat(cardIndex),
                                y: contentCenterY + spacing * CGFloat(cardIndex))
    attributes.zIndex = maximumVisibleItems - cardIndex
//    print("attributes.center:", attributes.center)
//    print("attributes.zIndex", attributes.zIndex)
    
    switch cardIndex {
    case 0:
      attributes.center.x -= deltaOffset

    case 0 ..< maximumVisibleItems:
      attributes.center.x -= spacing * percentageDeltaOffset
      attributes.center.y -= spacing * percentageDeltaOffset
      
      // Make last card transparent
      if cardIndex == maximumVisibleItems - 1 {
        attributes.alpha = percentageDeltaOffset
      }
      
    default:
      break
    }
    return attributes
  }
}
