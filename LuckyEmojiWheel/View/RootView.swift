//
//  RootView.swift
//  LuckyEmojiWheel
//
//  Created by Елена Русских on 2023-09-03.
//

import UIKit
import SnapKit

class RootView : UIView {
    
  var emojies: [UILabel] = []
  let emojiArray: [String] = ["🌵", "🍀", "🍓", "🍌", "🍇", "🍉", "🍋"]
  
  struct LayoutConstants {
      static let emojiSize: CGFloat = 48
  }

  //MARK: - Views
  let stackView: UIStackView = {
      let stack = UIStackView()
      stack.translatesAutoresizingMaskIntoConstraints = false
      stack.axis = .horizontal
      stack.distribution = .equalSpacing
      stack.spacing = LayoutConstants.emojiSize
      return stack
  }()
  
  let stopButton: UIButton = {
      let btn = UIButton()
      btn.setTitle(Texts.ViewController.buttonStart, for: .normal)
      btn.setTitleColor(.appText, for: .normal)
      btn.titleLabel?.font = UIFont.systemFont(ofSize: UIFont.systemFontSize, weight: .bold)
      btn.backgroundColor = .appAccent
      btn.layer.cornerRadius = 10
      btn.clipsToBounds = true
      btn.translatesAutoresizingMaskIntoConstraints = false
      return btn
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
    
  
  override func layoutSubviews() {
      super.layoutSubviews()
      
      stackView.snp.remakeConstraints { make in
          make.width.equalTo(self.snp.width).multipliedBy(0.7)
          make.height.equalTo(LayoutConstants.emojiSize)
          make.top.equalTo(self.safeAreaLayoutGuide.snp.top).offset(self.bounds.height * 0.3)
          make.centerX.equalTo(self)
      }
    
      stopButton.snp.remakeConstraints { make in
          make.width.equalTo(self.snp.width).multipliedBy(0.7)
          make.height.equalTo(LayoutConstants.emojiSize)
          make.bottom.equalTo(self.safeAreaLayoutGuide.snp.bottom).offset(-40)
          make.centerX.equalTo(self)
      }
  }
  
  //MARK: - Private methods
  private func createCircles(count: Int) {
    for i in 0..<count {
      let emoji = createCircle()
      emoji.accessibilityIdentifier = "emoji\(i)"
      emojies.append(emoji)
      stackView.addArrangedSubview(emoji)
      emoji.snp.makeConstraints { make in
        make.width.height.equalTo(LayoutConstants.emojiSize)
      }
    }
  }
  
  private func createCircle() -> UILabel {
    let label = UILabel()
    label.text = emojiArray.randomElement() ?? "🍄"
    label.font = UIFont.systemFont(ofSize: 43)
    label.translatesAutoresizingMaskIntoConstraints = false
    return label
  }
  
  private func setupLayout() {
    addSubview(stackView)
    addSubview(stopButton)
  }
}


