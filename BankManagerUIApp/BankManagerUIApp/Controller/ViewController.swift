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
        configureButtonStackView()
        configureLineTitleStackView()
        configureLineScrollView()
        // Do any additional setup after loading the view.
    }
    
    let waitingLineLabel = UILabel(text: "대기중", textColor: .white, backgroundColor: .systemGreen, font: .preferredFont(forTextStyle: .title1))
    let workingLineLabel = UILabel(text: "업무중", textColor: .white, backgroundColor: .systemBlue, font: .preferredFont(forTextStyle: .title1))
    let timerLabel = UILabel(text: "업무시간 - 00:00:000", textColor: .black, backgroundColor: .systemBackground, font: .preferredFont(forTextStyle: .title2))
    
    let initializationButton = UIButton(title: "초기화", color: .red, action: #selector(stopTimer))
    let addCustomersButton = UIButton(title: "고객 10명 추가", color: .blue, action: #selector(addCustomer))
    
    let fullStackView = UIStackView(spacing: 0, alignment: .center, backgroundColor: .brown ,axis: .vertical, distribution: .equalSpacing)
    let buttonStackView = UIStackView(spacing: 100, alignment: .center, backgroundColor: .blue ,axis: .horizontal, distribution: .equalSpacing)
    let lineStackView = UIStackView(spacing: 0, alignment: .fill , backgroundColor: .purple, axis: .horizontal, distribution: .fillEqually)
    
    let scrollView = UIScrollView(constant: false)
    let lineScrollStackView = UIStackView(spacing: 0, alignment: .fill, backgroundColor: .black, axis: .horizontal, distribution: .equalSpacing)
    let waitingLineStackView = UIStackView(spacing: 0, alignment: .center, backgroundColor: .red, axis: .vertical, distribution: .equalSpacing)
    let workingLineStackView = UIStackView(spacing: 0, alignment: .center, backgroundColor: .orange, axis: .vertical, distribution: .equalSpacing)
    
    let waitingLineScrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.backgroundColor = .blue
        
        return scrollView
    }()
    
    let workingLineScrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.backgroundColor = .magenta
        
        return scrollView
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
    
    func configureButtonStackView() {
        buttonStackView.addArrangedSubview(addCustomersButton)
        buttonStackView.addArrangedSubview(initializationButton)
        fullStackView.addArrangedSubview(buttonStackView)
        fullStackView.addArrangedSubview(timerLabel)
        
        NSLayoutConstraint.activate([
            buttonStackView.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    
    func configureLineTitleStackView() {
        lineStackView.addArrangedSubview(waitingLineLabel)
        lineStackView.addArrangedSubview(workingLineLabel)
        fullStackView.addArrangedSubview(lineStackView)
        
        NSLayoutConstraint.activate([
            lineStackView.heightAnchor.constraint(equalToConstant: 50),
            lineStackView.leadingAnchor.constraint(equalTo: fullStackView.leadingAnchor),
            lineStackView.trailingAnchor.constraint(equalTo: fullStackView.trailingAnchor)
        ])
    }
    
    func configureLineScrollView() {
        waitingLineScrollView.addSubview(waitingLineStackView)
        workingLineScrollView.addSubview(workingLineStackView)
        lineScrollStackView.addArrangedSubview(waitingLineScrollView)
        lineScrollStackView.addArrangedSubview(workingLineScrollView)
        fullStackView.addArrangedSubview(lineScrollStackView)
        
        NSLayoutConstraint.activate([
            lineScrollStackView.topAnchor.constraint(equalTo: lineStackView.bottomAnchor),
            lineScrollStackView.bottomAnchor.constraint(equalTo: fullStackView.bottomAnchor),
            lineScrollStackView.widthAnchor.constraint(equalTo: fullStackView.widthAnchor)
        ])
        
        NSLayoutConstraint.activate([
            waitingLineScrollView.leadingAnchor.constraint(equalTo: waitingLineLabel.leadingAnchor),
            waitingLineScrollView.trailingAnchor.constraint(equalTo: waitingLineLabel.trailingAnchor),
            workingLineScrollView.leadingAnchor.constraint(equalTo: workingLineLabel.leadingAnchor),
            workingLineScrollView.trailingAnchor.constraint(equalTo: workingLineLabel.trailingAnchor)
        ])
    }
    
}
