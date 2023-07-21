//
//  UIStackView+.swift
//  BankManagerUIApp
//
//  Created by 박종화 on 2023/07/20.
//

import UIKit

extension UIStackView {
    convenience init(spacing: CGFloat, alignment: Alignment, backgroundColor: UIColor, axis: NSLayoutConstraint.Axis, constraint: Bool = false, distribution: Distribution = .equalSpacing) {
        self.init(frame: .zero)
        self.spacing = spacing
        self.alignment = alignment
        self.axis = axis
        self.backgroundColor = backgroundColor
        self.translatesAutoresizingMaskIntoConstraints = constraint
        self.distribution = distribution
    }
}
