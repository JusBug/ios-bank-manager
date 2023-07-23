//
//  WorkTimer.swift
//  BankManagerUIApp
//
//  Created by 박종화 on 2023/07/23.
//

import Foundation

extension ViewController {
    func startTimer() {
        if timer == nil {
            startTime = Date()
            timer = Timer.scheduledTimer(timeInterval: 0.001, target: self, selector: #selector(updateAccumulatedTime), userInfo: nil, repeats: true)
        }
    }
    
    func resume() {
        if timer == nil {
            startTime = Date().addingTimeInterval(-accumualtedTime)
            timer = Timer.scheduledTimer(timeInterval: 0.001, target: self, selector: #selector(updateAccumulatedTime), userInfo: nil, repeats: true)
        }
    }
    
    @objc func pause() {
        timer?.invalidate()
        timer = nil
    }
    
    @objc func stop() {
        removeWaitingLineCustomer()
        pause()
        accumualtedTime = 0.0
        timerLabel.text = "업무시간 - 00:00:000"
        updateTimerLabel(time: accumualtedTime)
    }
    
    @objc func updateAccumulatedTime() {
        guard let startTime = self.startTime else { return }
        
        let currentTime = Date().timeIntervalSince(startTime)
        accumualtedTime = currentTime
        updateTimerLabel(time: currentTime)
    }
    
    func updateTimerLabel(time: TimeInterval) {
        let min = Int(time / 60)
        let sec = Int(time) % 60
        let milsec = Int((time.truncatingRemainder(dividingBy: 1)) * 1000)
        let formattedTimer = String(format: "%02d:%02d:%03d", min, sec, milsec)
        timerLabel.text = "업무시간 - \(formattedTimer)"
    }
}
