//
//  ViewController.swift
//  LuckyEmojiWheel
//
//  Created by Елена Русских on 2023-09-03.
//

import UIKit

class ViewController: UIViewController {
  
  var rootView = RootView()

  
  override func loadView() {
      super.loadView()
      view = rootView
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    view.backgroundColor = .appBackground
  }


}

