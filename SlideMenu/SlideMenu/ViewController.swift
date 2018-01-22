//
//  ViewController.swift
//  SlideMenu
//
//  Created by PinguMac on 2018/1/19.
//  Copyright © 2018年 PinguMac. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {

  let ScreenSize = UIScreen.main.bounds.size
  
  lazy var backgroundImg: UIImageView = {
    let imgView = UIImageView()
    imgView.image = UIImage(named: "07.jpg")
    imgView.contentMode = .scaleAspectFill
    imgView.frame = CGRect(x: 0, y: 0,
                           width: self.ScreenSize.width,
                           height: self.ScreenSize.height)
    return imgView
  }()
  
  lazy var blurView: UIVisualEffectView = {
    let blurEffect = UIBlurEffect(style: .extraLight)
    let visualEffView = UIVisualEffectView(effect: blurEffect)
    visualEffView.frame = CGRect(x: 0, y: 0,
                                 width: self.ScreenSize.width / 2,
                                 height: self.ScreenSize.height)
    visualEffView.layer.cornerRadius = 15
    visualEffView.layer.masksToBounds = true
    visualEffView.clipsToBounds = true
    return visualEffView
  }()

  lazy var sideView: UIView = {
    let view = UIView()
    view.frame = CGRect(x: -(self.ScreenSize.width / 2),
                        y: 0,
                        width: self.ScreenSize.width / 2,
                        height: self.ScreenSize.height)
    view.layer.shadowColor = UIColor.black.cgColor
    view.layer.shadowOpacity = 0.8
    view.layer.shadowOffset = CGSize(width: 5, height: 0)
    view.layer.cornerRadius = 15
    view.layer.masksToBounds = true
    return view
  }()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    // Do any additional setup after loading the view, typically from a nib.
    
    settingNavigatorBar()
    
    self.view.addSubview(backgroundImg)
    
    UIApplication.shared.keyWindow?.addSubview(sideView)
    
    self.sideView.addSubview(blurView)
    
    let pan = UIPanGestureRecognizer(target: self,
                                     action: #selector(HomeViewController.panGesture))
    pan.minimumNumberOfTouches = 1
    pan.maximumNumberOfTouches = 1
    self.view.addGestureRecognizer(pan)
  }

  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
  
  func settingNavigatorBar() {
    let leftBtn = UIBarButtonItem(image: UIImage(named:"hamburger"),
                                  style: .plain,
                                  target: self,
                                  action: #selector(HomeViewController.leftBarBtnAct))
    self.navigationItem.leftBarButtonItem = leftBtn
  }
}

extension HomeViewController {
  @IBAction func leftBarBtnAct() {
    
  }
  
  @IBAction func panGesture(_ sender: UIPanGestureRecognizer) {
    if sender.state == .began || sender.state == .changed {
      let translation = sender.translation(in: self.view).x
      if translation > 0 {
        UIView.animate(withDuration: 1.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
//          UIApplication.shared.isStatusBarHidden = true
          self.sideView.frame = CGRect(x: 0,
                                       y: 0,
                                       width: self.ScreenSize.width / 2,
                                       height: self.ScreenSize.height)
        }, completion: nil)
      } else {
        UIView.animate(withDuration: 1.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
//          UIApplication.shared.isStatusBarHidden = false
          self.sideView.frame = CGRect(x: -(self.ScreenSize.width / 2),
                                       y: 0,
                                       width: self.ScreenSize.width / 2,
                                       height: self.ScreenSize.height)
        }, completion: nil)
      }
      
    } else if sender.state == .ended {
      
    }
  }
}

