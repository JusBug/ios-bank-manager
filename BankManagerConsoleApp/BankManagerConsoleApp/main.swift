//
//  BankManagerConsoleApp - main.swift
//  Created by yagom. 
//  Copyright © yagom academy. All rights reserved.
// 

import Foundation


let kukminBank = Bank(name: "국민은행", tellers: (1,2))

var programManager = ProgramManager(program: kukminBank)
programManager.selectMenu()
