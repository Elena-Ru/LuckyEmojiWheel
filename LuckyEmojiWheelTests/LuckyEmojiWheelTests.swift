//
//  EmojiViewModelTests.swift
//  LuckyEmojiWheelUnitTests
//
//  Created by Елена Русских on 2023-09-04.
//

import XCTest
import Combine
@testable import LuckyEmojiWheel

final class EmojiViewModelTests: XCTestCase {

    var sut: EmojiViewModel!
    var timerMock: TimerMock!
    var cancellables: Set<AnyCancellable> = []
    
    override func setUp() {
        super.setUp()
      
        var mockModel = EmojiModel()
        mockModel.emojiArray = ["🍄", "😀", "🙂"]
        timerMock = TimerMock()
        sut = EmojiViewModel(model: mockModel, timerService: timerMock)
    }
    
    override func tearDown() {
        sut.stopTimer()
        sut = nil
        timerMock = nil
        cancellables.removeAll()
        super.tearDown()
    }
  
    func testCurrentEmojis_ToggleSpinningAndTimerTick_ContainsThreeEmojis() {
        // Given
        sut.toggleSpinning()
        // When
        timerMock.tick()
        // Then
        XCTAssertEqual(sut.currentEmojis.count, 3, "After a timer tick, there should be 3 emojis")
    }
    
    func testIsSpinning_InitialState_IsFalse() {
        // Then
        XCTAssertFalse(sut.isSpinning, "isSpinning should be false initially")
    }

    func testIsSpinning_AfterFirstToggle_IsTrue() {
        // When
        sut.toggleSpinning()
        // Then
        XCTAssertTrue(sut.isSpinning, "isSpinning should be true after first toggle")
    }
  
    func testIsSpinning_AfterSecondToggle_IsFalse() {
        // Given
        sut.toggleSpinning()
        timerMock.deactivate()
        // When
        sut.toggleSpinning()
        // Then
        XCTAssertFalse(sut.isSpinning, "isSpinning should be false after toggling twice")
    }
  
    func testGameResult_AllEmojisSame_ReturnsWinner() {
        // Given
        sut.currentEmojis = ["🍄", "🍄", "🍄"]
        // When
        let result = sut.gameResult()
        // Then
        XCTAssertEqual(result?.title, Texts.AlertWinner.title, "Should return winner title for all same emojis")
        XCTAssertEqual(result?.message, Texts.AlertWinner.message, "Should return winner message for all same emojis")
    }
  
    func testGameResult_TwoEmojisSame_ReturnsHalfWinner() {
        // Given
        sut.currentEmojis = ["🍄", "😀", "😀"]
        // When
        let result = sut.gameResult()
        // Then
        XCTAssertEqual(result?.title, Texts.AlertHalfWinner.title, "Should return half winner title for two same     emojis")
        XCTAssertEqual(result?.message, Texts.AlertHalfWinner.message, "Should return half winner message for two   same   emojis")
    }
  
    func testGameResult_AllEmojisDifferent_ReturnsNil() {
        // Given
        sut.currentEmojis = ["🍄", "😀", "🙂"]
        // When
        let result = sut.gameResult()
        // Then
        XCTAssertNil(result, "Should return nil for all different emojis")
    }
}

