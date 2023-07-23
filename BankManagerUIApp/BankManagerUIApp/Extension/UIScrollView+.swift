//
//  UIScrollView+.swift
//  BankManagerUIApp
//
//  Created by 박종화 on 2023/07/21.
//

import UIKit

extension UIScrollView {
    convenience init(backgroundColor: UIColor = .systemBackground, constant: Bool = false) {
        self.init(frame: .zero)
        self.backgroundColor = backgroundColor
        self.translatesAutoresizingMaskIntoConstraints = constant
    }
}
