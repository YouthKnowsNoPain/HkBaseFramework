//
//  UILabel+Space.swift
//  SwiftBaseFrame
//
//  Created by Kun Huang on 2017/9/4.
//  Copyright © 2017年 Kun Huang. All rights reserved.
//

import UIKit

extension UILabel {
    /**  改变行间距  */
    func changeLineSpace(space:CGFloat) {
        if self.text == nil || self.text == "" {
            return
        }
        let text = self.text
        let attributedString = NSMutableAttributedString.init(string: text!)
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = space
        attributedString.addAttribute(NSParagraphStyleAttributeName, value: paragraphStyle, range: .init(location: 0, length: (text?.characters.count)!))
        attributedString.addAttribute(NSForegroundColorAttributeName, value: self.textColor, range: .init(location: 0, length: (text?.characters.count)!))
        attributedString.addAttribute(NSFontAttributeName, value: self.font, range: .init(location: 0, length: (text?.characters.count)!))
        
        self.attributedText = attributedString
        //        self.sizeToFit()
    }
    
    /**  改变字间距  */
    func changeWordSpace(space:CGFloat) {
        if self.text == nil || self.text == "" {
            return
        }
        let text = self.text
        let attributedString = NSMutableAttributedString.init(string: text!, attributes: [NSKernAttributeName:space])
        let paragraphStyle = NSMutableParagraphStyle()
        attributedString.addAttribute(NSParagraphStyleAttributeName, value: paragraphStyle, range: .init(location: 0, length: (text?.characters.count)!))
        attributedString.addAttribute(NSForegroundColorAttributeName, value: self.textColor, range: .init(location: 0, length: (text?.characters.count)!))
        attributedString.addAttribute(NSFontAttributeName, value: self.font, range: .init(location: 0, length: (text?.characters.count)!))
        self.attributedText = attributedString
        //        self.sizeToFit()
    }
    
    /**  改变字间距和行间距  */
    func changeSpace(lineSpace:CGFloat, wordSpace:CGFloat) {
        if self.text == nil || self.text == "" {
            return
        }
        let text = self.text
        let attributedString = NSMutableAttributedString.init(string: text!, attributes: [NSKernAttributeName:wordSpace])
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = lineSpace
        attributedString.addAttribute(NSParagraphStyleAttributeName, value: paragraphStyle, range: .init(location: 0, length: (text?.characters.count)!))
        attributedString.addAttribute(NSForegroundColorAttributeName, value: self.textColor, range: .init(location: 0, length: (text?.characters.count)!))
        attributedString.addAttribute(NSFontAttributeName, value: self.font, range: .init(location: 0, length: (text?.characters.count)!))
        self.attributedText = attributedString
        //        self.sizeToFit()
        
    }
}
