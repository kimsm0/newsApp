//
//  File.swift
//  
//
//  Created by kimsoomin_mac2022 on 4/27/24.
//

import UIKit

public struct AttributeTextStyle {
    let font: UIFont
    let hasUnderline: Bool
    let targetText: String
    
    public init(font: UIFont, 
                hasUnderline: Bool,
                targetText: String
    ) {
        self.font = font
        self.hasUnderline = hasUnderline
        self.targetText = targetText
    }
}

public extension UILabel {
    func setAttributeText(style: AttributeTextStyle){
        let fullText = self.text ?? ""
        let range = (fullText as NSString).range(of: style.targetText)
        let attributedString = NSMutableAttributedString(string: fullText)
        attributedString.addAttribute(.font, value: style.font, range: range)
        
        if style.hasUnderline {
            attributedString.addAttribute(.underlineStyle, value: NSUnderlineStyle.single.rawValue , range: range)
        }
        
        self.attributedText = attributedString
    }
}
