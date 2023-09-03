//
//  EmojiViewModel.swift
//  LuckyEmojiWheel
//
//  Created by Елена Русских on 2023-09-03.
//

import Foundation

class EmojiViewModel {
    private var model: EmojiModel

    var emojiArray: [String] {
        return model.emojiArray
    }

    init(model: EmojiModel) {
        self.model = model
    }

    func randomEmoji() -> String {
        return emojiArray.randomElement() ?? "🍄"
    }
}
