//
//  BankTask.swift
//  BankManagerUIApp
//
//  Created by minsong kim on 2023/07/19.
//

import UIKit

enum BankTask: CaseIterable {
    case loan
    case deposit
    
    var type: String {
        switch self {
        case .deposit:
            return "예금"
        case .loan:
            return "대출"
        }
    }
    
    var time: Double {
        switch self {
        case .deposit:
            return 1.1
        case .loan:
            return 0.7
        }
    }
    
    var color: UIColor {
        switch self {
        case .deposit:
            return .black
        case .loan:
            return .purple
        }
    }
}
