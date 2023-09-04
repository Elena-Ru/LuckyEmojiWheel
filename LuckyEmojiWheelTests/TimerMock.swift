//
//  TimerMock.swift
//  LuckyEmojiWheelTests
//
//  Created by Елена Русских on 2023-09-04.
//

import Foundation
import Combine
@testable import LuckyEmojiWheel

class TimerMock: TimerProtocol {
    
    private let subject = PassthroughSubject<Date, Never>()
    var isActive: Bool = true
    
    func publish(every interval: TimeInterval, on runLoop: RunLoop, in mode: RunLoop.Mode) -> AnyPublisher<Date, Never> {
        return subject.eraseToAnyPublisher()
    }
    
    func tick() {
        if isActive {
            subject.send(Date())
        }
    }

    func deactivate() {
        isActive = false
    }
}
