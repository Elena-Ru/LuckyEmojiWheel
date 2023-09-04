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
    static let startTitle = Texts.ViewController.buttonStart
    static let stopTitle = Texts.ViewController.buttonStop
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
    setupBindings()
  }
  
  deinit {
    cancellables.forEach { $0.cancel() }
  }
  
  @objc func handleStopButtonTap() {
    viewModel.toggleSpinning()
  }
  
  // MARK: - Private Methods
  private func setupBindings() {
    viewModel.$currentEmojis
      .sink { [weak self] emojies in
        guard let self = self else { return }
        for (index, emojiLabel) in self.rootView.emojies.enumerated() {
          if index < emojies.count {
            emojiLabel.text = emojies[index]
          }
        }
      }
      .store(in: &cancellables)
    
    viewModel.$isSpinning
      .sink { [weak self] spinning in
        if spinning {
          self?.rootView.stopButton.setTitle(Constants.stopTitle, for: .normal)
        } else {
          self?.rootView.stopButton.setTitle(Constants.startTitle, for: .normal)
          if let result = self?.viewModel.gameResult() {
            self?.showAlert(title: result.title, message: result.message)
          }
        }
      }
      .store(in: &cancellables)
  }
  
  private func showAlert(title: String, message: String) {
    let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
    alert.addAction(UIAlertAction(title: Texts.Common.ok, style: .default, handler: nil))
    present(alert, animated: true, completion: nil)
  }
  
}

