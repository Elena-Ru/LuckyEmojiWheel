//
//  ViewController.swift
//  LuckyEmojiWheel
//
//  Created by Елена Русских on 2023-09-03.
//

import UIKit
import Combine


class ViewController: UIViewController {
  
  // MARK: - Constants
  private enum Constants {
    static let startTitle = "START"
    static let stopTitle = "STOP"
    static let defaultEmoji = "🍄"
  }
  
  // MARK: - Properties
  var rootView = RootView()
  var viewModel: EmojiViewModel!
  var timer: AnyCancellable?
  var cancellables = Set<AnyCancellable>()
  
  override func loadView() {
    super.loadView()
    view = rootView
  }
  // MARK: - Lifecycle Methods
  override func viewDidLoad() {
    super.viewDidLoad()
    view.backgroundColor = .appBackground
    rootView.stopButton.addTarget(self, action: #selector(handleStopButtonTap), for: .touchUpInside)
  }
  
  deinit {
    cancellables.forEach { $0.cancel() }
  }
  // MARK: - Objc Methods
  @objc func updateEmoji() {
    for emojiLabel in rootView.emojies {
      emojiLabel.text = viewModel.randomEmoji()
    }
  }
  
  @objc func handleStopButtonTap() {
    if timer == nil {
      startSpinning()
    } else {
      stopSpinning()
    }
  }
  
  // MARK: - Private Methods
  private func startSpinning() {
    timer = Timer.publish(every: 0.1, on: .main, in: .common)
      .autoconnect()
      .sink(receiveValue: { [weak self] _ in
        self?.updateEmoji()
      })
    
    rootView.stopButton.setTitle(Constants.stopTitle, for: .normal)
  }
  
  private func stopSpinning() {
    timer?.cancel()
    timer = nil
    rootView.stopButton.setTitle(Constants.startTitle, for: .normal)
    
    let matchedEmojis = Set(rootView.emojies.map { $0.text })
    
    if matchedEmojis.count == 1 {
      showAlert(title: "Поздравляем!", message: "Вы выиграли!")
    } else if matchedEmojis.count == 2 {
      showAlert(title: "Почти!", message: "Два эмодзи совпали!")
    }
  }
  
  private func showAlert(title: String, message: String) {
    let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
    alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
    present(alert, animated: true, completion: nil)
  }
  
}

