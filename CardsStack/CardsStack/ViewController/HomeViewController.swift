//
//  HomeViewController.swift
//  CardsStack
//
//  Created by PinguMac on 2018/1/22.
//  Copyright © 2018年 PinguMac. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {

  @IBOutlet weak var collectionView: UICollectionView!
  
  let imageNames = ["01", "02", "03", "04", "05", "06","07",
                    "01", "02", "03", "04", "05", "06","07",
                    "01", "02", "03", "04", "05", "06","07"]
  
  lazy var cardLayout: CardCollectionViewLayout = {
    let layout = CardCollectionViewLayout()
//    layout.maximumVisibleItems = 4
    return layout
  }()
  
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    view.backgroundColor = UIColor.lightGray

    collectionView.dataSource = self
    collectionView.isPagingEnabled = true
    collectionView.showsHorizontalScrollIndicator = true
    collectionView.collectionViewLayout = cardLayout
    collectionView.backgroundColor = UIColor.clear
    
    let cellNib = UINib(nibName: "CardCell", bundle: nil)
    collectionView.register(cellNib, forCellWithReuseIdentifier: "cardCell")
  }

  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
}

extension HomeViewController: UICollectionViewDataSource {
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return imageNames.count
  }
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cardCell", for: indexPath) as! CardCell
    cell.imageName = imageNames[indexPath.row]
    cell.loadContent()
    return cell
  }
}

