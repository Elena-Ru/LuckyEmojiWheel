//
//  Timer.swift
//  LuckyEmojiWheel
//
//  Created by Елена Русских on 2023-09-04.
//

import Foundation
import Combine

protocol TimerProtocol {
  func publish(every interval: TimeInterval, on runLoop: RunLoop, in mode: RunLoop.Mode) -> AnyPublisher<Date, Never>
}


struct TimerService: TimerProtocol {
  func publish(every interval: TimeInterval,
               on runLoop: RunLoop,
               in mode: RunLoop.Mode
  ) -> AnyPublisher<Date, Never> {
    return Timer.publish(every: interval, on: runLoop, in: mode)
      .autoconnect()
      .eraseToAnyPublisher()
  }
}
