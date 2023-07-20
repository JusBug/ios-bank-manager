//
//  BankManagerUIApp - ViewController.swift
//  Created by yagom. 
//  Copyright © yagom academy. All rights reserved.
// 

import UIKit

class ViewController: UIViewController {
    var timer: Timer?
    var startTime: Date?
    var labelArray: [UILabel] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.addSubview(addButton)
        self.view.addSubview(resetButton)
        self.view.addSubview(timerLabel)
        updateTimerLabel(time: 0)
        setUpStackView()
        
        self.addButton.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 60).isActive = true
        self.addButton.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 60).isActive = true
        
        self.resetButton.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 60).isActive = true
        self.resetButton.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant:280).isActive = true
        
        self.timerLabel.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 120).isActive = true
        self.timerLabel.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant:120).isActive = true
        
    }
    
    let addButton: UIButton = {
        let button1 = UIButton()
        
        button1.setTitle("고객 10명 추가", for: .normal)
        button1.setTitleColor(.systemBlue, for: .normal)
        //button1.addTarget(self, action: #selector(), for: .touchUpInside)
        button1.translatesAutoresizingMaskIntoConstraints = false
        
        return button1
    }()
    
    let resetButton: UIButton = {
        let button2 = UIButton()
        
        button2.setTitle("초기화", for: .normal)
        button2.setTitleColor(.systemRed, for: .normal)
        button2.addTarget(ViewController.self, action: #selector(stopTimer), for: .touchUpInside)
        button2.translatesAutoresizingMaskIntoConstraints = false
        
        return button2
    }()
    
    func startTimer() {
        if timer == nil {
            startTime = Date()
            timer = Timer.scheduledTimer(timeInterval: 0.001, target: self, selector: #selector(fireTimer), userInfo: nil, repeats: true)
        }
    }
    
    @objc func stopTimer() {
        timer?.invalidate()
        timer = nil
        timerLabel.text = "업무시간 - 00:00:000"
    }
    
    @objc func fireTimer() {
        guard let startTime = self.startTime else { return }
        
        let currentTime = Date().timeIntervalSince(startTime)
        updateTimerLabel(time: currentTime)
    }
    
    func updateTimerLabel(time: TimeInterval) {
        startTimer()
        let min = Int(time / 60)
        let sec = Int(time) % 60
        let milsec = Int((time.truncatingRemainder(dividingBy: 1)) * 1000)
        let formattedTimer = String(format: "%02d:%02d:%03d", min, sec, milsec)
        timerLabel.text = "업무시간 - \(formattedTimer)"
    }
    
    let timerLabel: UILabel = {
        let label = UILabel()
        
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    let waitingTitle: UILabel = {
        let label = UILabel()
        
        label.text = "대기중"
        label.textColor = .white
        label.backgroundColor = .systemGreen
        label.textAlignment = .left
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    let workingTitle: UILabel = {
        let label = UILabel())
        
        label.text = "업무중"
        label.textColor = .white
        label.backgroundColor = .systemBlue
        label.textAlignment = .left
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    var stackView: UIStackView {
        let stackView = UIStackView()
        
        stackView.axis = .horizontal
        stackView.alignment = .fill
        stackView.distribution = .fill
        stackView.spacing = 5
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }
    
    func setUpStackView() {
        self.stackView.addArrangedSubview(waitingTitle)
        self.stackView.addArrangedSubview(workingTitle)
        self.view.addSubview(stackView)
        
    }
}
