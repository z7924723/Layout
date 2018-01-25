//
//  CardCollectionViewLayout.swift
//  CardsLine
//
//  Created by PinguMac on 2018/1/24.
//  Copyright © 2018年 PinguMac. All rights reserved.
//

import UIKit

class CardsLayout: UICollectionViewFlowLayout {
  
  var contentOffsetBeginX: CGFloat = 0.0
  var inset: CGFloat!
  var itemsCount: Int!
  
  override func prepare() {
    super.prepare()
    
    self.itemSize = CGSize(width: 250, height: 400)
    self.scrollDirection = .horizontal
    self.minimumLineSpacing = 10
    self.itemsCount = collectionView!.numberOfItems(inSection: 0)
    
    inset = (collectionView!.frame.size.width - itemSize.width) * 0.5
    self.sectionInset = UIEdgeInsets.init(top: 0, left: inset, bottom: 0, right: inset)
  }
  
  override var collectionViewContentSize: CGSize {
    if collectionView == nil { return CGSize.zero }

    let spaceWidth = (2 * inset) + (self.minimumInteritemSpacing) * CGFloat(itemsCount - 1)
    let totalWidth = (self.itemSize.width * CGFloat(itemsCount)) + spaceWidth

    return CGSize(width: totalWidth, height: collectionView!.bounds.height)
  }
  
  override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
    if collectionView == nil { return nil }

    let attributes = super.layoutAttributesForElements(in: rect)
    let centerX = collectionView!.contentOffset.x + collectionView!.bounds.width / 2.0
    print(collectionView!.contentOffset.x)
    print(collectionView!.bounds.width)
    
    for attribute in attributes! {
      let delta = abs(attribute.center.x - centerX)
      let scale = 1.3 - delta / collectionView!.frame.size.width

      attribute.transform = CGAffineTransform(scaleX: scale, y: scale);
    }
    return attributes
  }
  
  override func shouldInvalidateLayout(forBoundsChange newBounds: CGRect) -> Bool {
    return true
  }
}
