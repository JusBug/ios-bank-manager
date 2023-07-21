//
//  UILabel+.swift
//  BankManagerUIApp
//
//  Created by minsong kim on 2023/07/19.
//
alignment
import UIKit

extension UILabel {
    convenience init(text: String, textColor: UIColor, backgroundColor: UIColor, alignment: NSTextAlignment) {
        self.init(frame: .zero)
        self.text = text
        self.textColor = textColor
        self.backgroundColor = backgroundColor
        self.textAlignment = alignment
    }
}
