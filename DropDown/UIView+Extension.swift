//
//  UIView+Extension.swift
//  DropDown
//
//  Created by Jawad Ali on 27/11/2020.
//  Copyright © 2020 Jawad Ali. All rights reserved.
//

import UIKit
public protocol ReusableView: class {}

public extension ReusableView where Self: UIView {
    static var reuseIdentifier: String {
        return String(describing: self)
    }
}

extension UIView {
    func setConstraintsEqual(secondView: UIView, offset: UIEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)) {
        secondView.translatesAutoresizingMaskIntoConstraints = false
        
        let firstView: UIView = self
        let targetView = secondView
        
        targetView.leadingAnchor.constraint(equalTo: firstView.leadingAnchor, constant: offset.left).isActive = true
        targetView.trailingAnchor.constraint(equalTo: firstView.trailingAnchor, constant: offset.right).isActive = true
        targetView.topAnchor.constraint(equalTo: firstView.topAnchor, constant: offset.top).isActive = true
        targetView.bottomAnchor.constraint(equalTo: firstView.bottomAnchor, constant: offset.bottom).isActive = true
    }
}
