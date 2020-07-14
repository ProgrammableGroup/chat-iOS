//
//  UITextField+border.swift
//  chat-iOS
//
//  Created by 倉谷　明希 on 2020/07/14.
//

import UIKit

public extension UITextField {
    func addBorderBottom(borderWidth: CGFloat, color: UIColor) {
        let border = CALayer()
        border.frame = CGRect(x: 0, y: self.frame.height - borderWidth, width: self.frame.width, height: borderWidth)
        border.backgroundColor = color.cgColor
        self.layer.addSublayer(border)
    }
}
