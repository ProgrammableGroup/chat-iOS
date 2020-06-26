//
//  String+estimateFlame.swift
//  chat-iOS
//
//  Created by jun on 2020/06/22.
//

import UIKit

extension String {
    func estimatedFrame() -> CGRect {
        let size = CGSize(width: 250, height: 10000)
        let options = NSStringDrawingOptions.usesFontLeading.union(.usesLineFragmentOrigin)
        let attributes = [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 18)]
        return NSString(string: self).boundingRect(with: size, options: options, attributes: attributes, context: nil)
    }
}
