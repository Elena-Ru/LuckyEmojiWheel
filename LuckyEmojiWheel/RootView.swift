//
//  RootView.swift
//  LuckyEmojiWheel
//
//  Created by Елена Русских on 2023-09-03.
//

import UIKit
import SnapKit

class RootView : UIView {
    
  var circles: [UILabel] = []
  
  struct LayoutConstants {
      static let circleSize: CGFloat = 20
  }

  //MARK: - Views
  let stackView: UIStackView = {
      let stack = UIStackView()
      stack.translatesAutoresizingMaskIntoConstraints = false
      stack.axis = .horizontal
      stack.distribution = .equalSpacing
      stack.spacing = LayoutConstants.circleSize
      return stack
  }()
  
  //MARK: - Inits
     init() {
        super.init(frame: CGRect())
        creatView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func creatView() {
        createCircles(count: 3)
        setupLayout()
    }
    
  
  //MARK: - Private methods
  private func createCircles(count: Int) {
    for i in 0..<count {
      let circle = createCircle()
      circle.accessibilityIdentifier = "circle\(i)"
      circles.append(circle)
      stackView.addArrangedSubview(circle)
      circle.snp.makeConstraints { make in
        make.width.height.equalTo(LayoutConstants.circleSize)
      }
    }
  }
  
  private func createCircle() -> UILabel {
    let label = UILabel()
    label.text = "🌵"
    label.font = UIFont.systemFont(ofSize: 18)
    label.translatesAutoresizingMaskIntoConstraints = false
    return label
  }
  
  private func setupLayout() {
    addSubview(stackView)
    
    stackView.snp.makeConstraints { make in
      make.width.equalTo(240)
      make.height.equalTo(LayoutConstants.circleSize)
      make.top.equalTo(self.safeAreaLayoutGuide.snp.top).offset(100)
      make.centerX.equalTo(self)
    }
  }
}


