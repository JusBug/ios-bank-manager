//
//  UIButton+.swift
//  BankManagerUIApp
//
//  Created by minsong kim on 2023/07/19.
//

import UIKit

extension UIButton {
    convenience init(title: String, color: UIColor, target: Any?, action: Selector) {
        self.init(frame: .zero)
        self.setTitle(title, for: .normal)
        self.backgroundColor = .systemBackground
        self.setTitleColor(color, for: .normal)
        self.addTarget(target, action: action, for: .touchUpInside)
    }
}
