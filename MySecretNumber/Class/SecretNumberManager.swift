//
//  SecretNumberManager.swift
//  MySecretNumber
//
//  Created by GUERNEVÉ Sébastien on 28/11/2020.
//

import Foundation

class SecretNumberManager {
    static let MIN_BOUNDARY = 0
    static let MAX_BOUNDARY = 1000
    private var _secretNumber: Int?
    private var _lowBoundary: Int?
    private var _highBoundary: Int?
    private var _lastUserProposal: Int?
    
    var lowBoundary: Int { _lowBoundary ?? SecretNumberManager.MIN_BOUNDARY }
    var highBoundary: Int { _highBoundary ?? SecretNumberManager.MAX_BOUNDARY}
    var secretNumber: Int? { _secretNumber }
    var lastUserProposal: Int? { _lastUserProposal }
    
    var IsInProgress: Bool {
        if _secretNumber == nil {
            return false
        }
        return true
    }
    
    private func userWin() {
        _secretNumber = nil
    }
    
    func starNewGame(withMyNumber numberFix: Int? = nil) {
        if numberFix == nil {
            _secretNumber = Int.random(in: SecretNumberManager.MIN_BOUNDARY...SecretNumberManager.MAX_BOUNDARY)
        } else {
            _secretNumber = numberFix
        }
        
        _lowBoundary = SecretNumberManager.MIN_BOUNDARY
        _highBoundary = SecretNumberManager.MAX_BOUNDARY
        _lastUserProposal = nil
    }
    
    func testUserProposal(_ userProposal:Int) {
        guard IsInProgress else { return }
        
        _lastUserProposal = userProposal
        
        if userProposal == _secretNumber {
            userWin()
        } else if userProposal < _secretNumber! {
            _lowBoundary = max(userProposal, _lowBoundary ?? SecretNumberManager.MIN_BOUNDARY)
        } else {
            _highBoundary = min(userProposal, _highBoundary ?? SecretNumberManager.MAX_BOUNDARY)
        }
    }
}
