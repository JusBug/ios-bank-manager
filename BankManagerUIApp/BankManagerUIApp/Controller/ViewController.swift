//
//  BankManagerUIApp - ViewController.swift
//  Created by yagom. 
//  Copyright © yagom academy. All rights reserved.
// 

import UIKit

class ViewController: UIViewController {
    var timer: Timer?
    var startTime: Date?

    override func viewDidLoad() {
        super.viewDidLoad()
        configureFullStackView()
        // Do any additional setup after loading the view.
    }

    let waitingLineLabel = UILabel(text: "대기중", textColor: .white, backgroundColor: .green)
    let workingLineLabel = UILabel(text: "업무중", textColor: .white, backgroundColor: .systemBlue)
    let timerLabel = UILabel(text: "업무시간 - 00:00:000", textColor: .black, backgroundColor: .systemBackground)
    let initializationButton = UIButton(title: "초기화", color: .red, action: #selector(stopTimer))
    let addCustomersButton = UIButton(title: "고객 10명 추가", color: .blue, action: #selector(addCustomer))
    let fullStackView = UIStackView(spacing: 5, alignment: .center, backgroundColor: .brown ,axis: .vertical)
    let subStackView = UIStackView(spacing: 5, alignment: .center, backgroundColor: .blue ,axis: .horizontal)

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
    
    @objc func addCustomer() {
        
    }
    
    func configureFullStackView() {
        view.addSubview(fullStackView)
        view.backgroundColor = .systemBackground
        
        NSLayoutConstraint.activate([
            fullStackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            fullStackView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            fullStackView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            fullStackView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
}

