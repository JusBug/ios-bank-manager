//
//  UIStackView+.swift
//  BankManagerUIApp
//
//  Created by 박종화 on 2023/07/20.
//

import UIKit

extension UIStackView {
    convenience init(spacing: CGFloat, alignment: Alignment, axis: NSLayoutConstraint.Axis, constraint: Bool = false, distribution: Distribution = .fill) {
        self.init(frame: .zero)
        self.spacing = spacing
        self.alignment = alignment
        self.axis = axis
        self.translatesAutoresizingMaskIntoConstraints = constraint
        self.distribution = distribution
    }
}
