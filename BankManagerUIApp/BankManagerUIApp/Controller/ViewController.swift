//
//  BankManagerUIApp - ViewController.swift
//  Created by yagom. 
//  Copyright © yagom academy. All rights reserved.
// 

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    let waitingLineLabel = UILabel(text: "대기중", textColor: .white, backgroundColor: .green)
    let workingLineLabel = UILabel(text: "업무중", textColor: .white, backgroundColor: .systemBlue)
    let timerLabel = UILabel(text: "업무시간 - ", textColor: .black, backgroundColor: .systemBackground)

}

