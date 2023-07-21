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
        addViews()
        configureViews()
    }
    
    //Labels
    let waitingLineLabel = UILabel(text: "대기중", textColor: .white, backgroundColor: .systemGreen, font: .preferredFont(forTextStyle: .title1))
    let workingLineLabel = UILabel(text: "업무중", textColor: .white, backgroundColor: .systemBlue, font: .preferredFont(forTextStyle: .title1))
    let timerLabel = UILabel(text: "업무시간 - 00:00:000", textColor: .black, backgroundColor: .systemBackground, font: .preferredFont(forTextStyle: .title2))
    
    //Buttons
    let initializationButton = UIButton(title: "초기화", color: .red, action: #selector(stopTimer))
    let addCustomersButton = UIButton(title: "고객 10명 추가", color: .blue, action: #selector(addCustomer))
    
    //StackViews
    let fullStackView = UIStackView(backgroundColor: .brown)
    let buttonStackView = UIStackView(backgroundColor: .blue, spacing: 100, axis: .horizontal)
    let lineStackView = UIStackView(backgroundColor: .purple, alignment: .fill , axis: .horizontal, distribution: .fillEqually)
    let lineScrollStackView = UIStackView(backgroundColor: .black, alignment: .fill, axis: .horizontal)
    let waitingLineStackView = UIStackView(backgroundColor: .red)
    let workingLineStackView = UIStackView(backgroundColor: .orange)
    
    //ScrollViews
    let waitingLineScrollView = UIScrollView(backgroundColor: .blue)
    let workingLineScrollView = UIScrollView(backgroundColor: .magenta)
    
    
    //testLabel
    let test1 = UILabel(text: "test1", textColor: .blue, backgroundColor: .white)
    let test2 = UILabel(text: "test2", textColor: .magenta, backgroundColor: .white)
    
    @objc func addCustomer() {
        
    }
    
    func addViews() {
        view.addSubview(fullStackView)
        view.backgroundColor = .systemBackground
        
        buttonStackView.addArrangedSubview(addCustomersButton)
        buttonStackView.addArrangedSubview(initializationButton)
        
        lineStackView.addArrangedSubview(waitingLineLabel)
        lineStackView.addArrangedSubview(workingLineLabel)
        
        waitingLineScrollView.addSubview(waitingLineStackView)
        workingLineScrollView.addSubview(workingLineStackView)
        lineScrollStackView.addArrangedSubview(waitingLineScrollView)
        lineScrollStackView.addArrangedSubview(workingLineScrollView)
        
        waitingLineStackView.addArrangedSubview(test1)
        workingLineStackView.addArrangedSubview(test2)
        
        fullStackView.addArrangedSubview(buttonStackView)
        fullStackView.addArrangedSubview(timerLabel)
        fullStackView.addArrangedSubview(lineStackView)
        fullStackView.addArrangedSubview(lineScrollStackView)
    }
    
    func configureViews() {
        configureFullStackView()
        configureLineTitleStackView()
        configureLineScrollView()
    }
    
    func configureFullStackView() {
        
        NSLayoutConstraint.activate([
            fullStackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            fullStackView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            fullStackView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            fullStackView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
    

    func configureLineTitleStackView() {
        NSLayoutConstraint.activate([
            lineStackView.heightAnchor.constraint(equalToConstant: 50),
            lineStackView.leadingAnchor.constraint(equalTo: fullStackView.leadingAnchor),
            lineStackView.trailingAnchor.constraint(equalTo: fullStackView.trailingAnchor)
        ])
    }

    func configureLineScrollView() {
        NSLayoutConstraint.activate([
            lineScrollStackView.topAnchor.constraint(equalTo: lineStackView.bottomAnchor),
            lineScrollStackView.bottomAnchor.constraint(equalTo: fullStackView.bottomAnchor),
            lineScrollStackView.widthAnchor.constraint(equalTo: fullStackView.widthAnchor)
        ])

        NSLayoutConstraint.activate([
            waitingLineScrollView.leadingAnchor.constraint(equalTo: waitingLineLabel.leadingAnchor),
            waitingLineScrollView.trailingAnchor.constraint(equalTo: waitingLineLabel.trailingAnchor),
            waitingLineScrollView.topAnchor.constraint(equalTo: lineScrollStackView.topAnchor),
            waitingLineScrollView.bottomAnchor.constraint(equalTo: lineScrollStackView.bottomAnchor)
        ])
        NSLayoutConstraint.activate([
            workingLineScrollView.leadingAnchor.constraint(equalTo: workingLineLabel.leadingAnchor),
            workingLineScrollView.trailingAnchor.constraint(equalTo: workingLineLabel.trailingAnchor),
            workingLineScrollView.topAnchor.constraint(equalTo: lineScrollStackView.topAnchor),
            workingLineScrollView.bottomAnchor.constraint(equalTo: lineScrollStackView.bottomAnchor)
        ])
        
        NSLayoutConstraint.activate([
            waitingLineStackView.leadingAnchor.constraint(equalTo: waitingLineScrollView.leadingAnchor),
            waitingLineStackView.topAnchor.constraint(equalTo: waitingLineScrollView.topAnchor),
            waitingLineStackView.trailingAnchor.constraint(equalTo: waitingLineScrollView.trailingAnchor),
            waitingLineStackView.bottomAnchor.constraint(equalTo: waitingLineScrollView.bottomAnchor)
        ])

        NSLayoutConstraint.activate([
            workingLineStackView.leadingAnchor.constraint(equalTo: workingLineScrollView.leadingAnchor),
            workingLineStackView.topAnchor.constraint(equalTo: workingLineScrollView.topAnchor),
            workingLineStackView.trailingAnchor.constraint(equalTo: workingLineScrollView.trailingAnchor),
            workingLineStackView.bottomAnchor.constraint(equalTo: workingLineScrollView.bottomAnchor)
        ])
    }
//
}

extension ViewController {
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
    
}
