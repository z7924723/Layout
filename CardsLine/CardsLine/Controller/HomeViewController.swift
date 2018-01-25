//
//  HomeViewController.swift
//  CardsLine
//
//  Created by PinguMac on 2018/1/24.
//  Copyright © 2018年 PinguMac. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {

  @IBOutlet weak var collectionView: UICollectionView!
  
  let imageNames = ["01", "02", "03", "04", "05", "06","07",
                    "01", "02", "03", "04", "05", "06","07",
                    "01", "02", "03", "04", "05", "06","07"]
  
  lazy var cardLayout: CardsLayout = {
    let layout = CardsLayout()
    return layout
  }()
  
  override func viewDidLoad() {
    super.viewDidLoad()

    // Do any additional setup after loading the view.
    view.backgroundColor = UIColor.lightGray

    collectionView.dataSource = self
    collectionView.backgroundColor = UIColor.clear
    collectionView.collectionViewLayout = cardLayout

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
