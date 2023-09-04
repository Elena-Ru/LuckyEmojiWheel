//
//  Texts.swift
//  LuckyEmojiWheel
//
//  Created by Елена Русских on 2023-09-04.
//

import Foundation

enum Texts {
    
    enum ViewController {
        static var buttonStart: String { NSLocalizedString("start", comment: "") }
        static var buttonStop: String { NSLocalizedString("stop", comment: "") }
    }
    
    enum AlertWinner {
        static var title: String { NSLocalizedString("alert_winning_title", comment: "") }
        static var message: String { NSLocalizedString("alert_winning_message", comment: "") }
    }
  
    enum AlertHalfWinner {
        static var title: String {   NSLocalizedString("alert_halfWining_title",   comment: "") }
        static var message: String {   NSLocalizedString("alert_halfWining_message",   comment: "") }
    }
  
    enum Common {
        static var ok: String {   NSLocalizedString("ok", comment: "") }
    }
}
