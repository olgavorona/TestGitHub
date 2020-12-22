//
//  UIView+Constraints.swift
//  TestGitHub
//
//  Created by Olga Vorona on 22.12.2020.
//

import Foundation
import UIKit

@objc public extension UIView {
    
    @objc static func deactivate(constraints: [NSLayoutConstraint]) {
        NSLayoutConstraint.deactivate(constraints)
    }

    @objc static func activate(constraints: [NSLayoutConstraint]) {
        constraints.forEach { ($0.firstItem as? UIView)?.translatesAutoresizingMaskIntoConstraints = false }
        NSLayoutConstraint.activate(constraints)
    }

    @discardableResult
    @objc func pin(to view: UIView, insets: UIEdgeInsets = .zero) -> [NSLayoutConstraint] {
        let anchors = [
            topAnchor.constraint(equalTo: view.topAnchor, constant: insets.top),
            leftAnchor.constraint(equalTo: view.leftAnchor, constant: insets.left),
            rightAnchor.constraint(equalTo: view.rightAnchor, constant: -insets.right),
            bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -insets.bottom)
        ]
        UIView.activate(constraints: anchors)
        return anchors
    }

    
}
