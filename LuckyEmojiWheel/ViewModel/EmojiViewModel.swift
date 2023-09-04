//
//  EmojiViewModel.swift
//  LuckyEmojiWheel
//
//  Created by Елена Русских on 2023-09-03.
//

import Foundation
import Combine

class EmojiViewModel {
  
  // MARK: - Properties
  private var model: EmojiModel
  private var cancellables: Set<AnyCancellable> = []
  private var sharedTimer: AnyPublisher<Date, Never>!
  @Published var isSpinning: Bool = false
  @Published var currentEmojis: [String] = []
  
  var emojiArray: [String] {
    return model.emojiArray
  }
  // MARK: - Init
  init(model: EmojiModel) {
    self.model = model
  }
  
  // MARK: - Public Methods
  func toggleSpinning() {
    isSpinning.toggle()
    if isSpinning {
      startSpinning()
    } else {
      cleanup()
    }
  }
  
  func gameResult() -> (title: String, message: String)? {
    let matchedEmojis = Set(currentEmojis)
    if matchedEmojis.count == 1 {
      return (title: Texts.AlertWinner.title, message: Texts.AlertWinner.message)
    } else if matchedEmojis.count == 2 {
      return (title: Texts.AlertHalfWinner.title, message: Texts.AlertHalfWinner.message)
    }
    return nil
  }
  
  // MARK: - Private Methods
  private func startSpinning() {
    sharedTimer = Timer.publish(every: 0.1, on: .main, in: .common)
      .autoconnect()
      .share()
      .eraseToAnyPublisher()
    
    sharedTimer
      .sink { [weak self] _ in
        self?.updateEmojis()
      }
      .store(in: &cancellables)
  }
  
  private func randomEmoji() -> String {
    return emojiArray.randomElement() ?? "🍄"
  }
  
  private func updateEmojis() {
    var newEmojis: [String] = []
    for _ in 1...3 {
      newEmojis.append(randomEmoji())
    }
    currentEmojis = newEmojis
  }
  
  private func cleanup() {
    cancellables.forEach { $0.cancel() }
  }
}
