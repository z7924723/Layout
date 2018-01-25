//
//  CardCell.swift
//  CardsLine
//
//  Created by PinguMac on 2018/1/24.
//  Copyright © 2018年 PinguMac. All rights reserved.
//

import UIKit

class CardCell: UICollectionViewCell {

  @IBOutlet weak var imageView: UIImageView!
  var imageName: String?
  
  override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

  func loadContent() {
    if imageName == nil { return }
    if let image = UIImage(named: imageName!) {
      imageView.image = image
    }
    
    self.layer.cornerRadius = 20
    self.layer.borderColor = UIColor.white.cgColor
    self.layer.borderWidth = 2
  }
}
