//
//  UIStackView+.swift
//  BankManagerUIApp
//
//  Created by 박종화 on 2023/07/20.
//

import UIKit

extension UIStackView {
    convenience init(backgroundColor: UIColor = .systemBackground, spacing: CGFloat = 0, alignment: Alignment = .center, axis: NSLayoutConstraint.Axis = .vertical, constraint: Bool = false, distribution: UIStackView.Distribution = .equalSpacing) {
        self.init(frame: .zero)
        self.spacing = spacing
        self.alignment = alignment
        self.axis = axis
        self.backgroundColor = backgroundColor
        self.translatesAutoresizingMaskIntoConstraints = constraint
        self.distribution = distribution
    }
}
