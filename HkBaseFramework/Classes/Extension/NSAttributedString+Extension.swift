//
//  NSAttributedStringExtension.swift
//  SwiftBaseFramework
//
//  Created by Kun Huang on 2017/9/7.
//  Copyright © 2017年 Kun Huang. All rights reserved.
//

import UIKit

public extension String {
    public var attributed:NSAttributedString {
        return NSAttributedString.init(string: self)
    }
}

public extension NSAttributedString {
    
    // 返回所有的字体属性
    public func attributes() -> [String: Any] {
        return self.attributes(at: 0, longestEffectiveRange: nil, in: self.attributedStringRange(nil))
    }
    
    // 修改字体
    public func font(_ font: UIFont, range: NSRange? = nil) -> NSAttributedString {
        let mutableAttributedString = NSMutableAttributedString(string: self.string, attributes: self.attributes())
        mutableAttributedString.addAttribute(NSFontAttributeName, value: font, range: attributedStringRange(range))
        return mutableAttributedString as NSAttributedString
    }
    
    // 修改字体颜色
    public func foregroundColor(_ foregroundColor: UIColor, range: NSRange? = nil) -> NSAttributedString {
        let mutableAttributedString = NSMutableAttributedString(string: self.string, attributes: self.attributes())
        mutableAttributedString.addAttribute(NSForegroundColorAttributeName, value: foregroundColor, range: attributedStringRange(range))
        return mutableAttributedString as NSAttributedString
    }
    
    // 修改文本背景颜色
    public func backgroundColor(_ backgroundColor: UIColor, range: NSRange? = nil) -> NSAttributedString {
        let mutableAttributedString = NSMutableAttributedString(string: self.string, attributes: self.attributes())
        mutableAttributedString.addAttribute(NSBackgroundColorAttributeName, value: backgroundColor, range: attributedStringRange(range))
        return mutableAttributedString as NSAttributedString
    }
    
    // 字距调整
    public func kern(_ kern: Float, range: NSRange? = nil) -> NSAttributedString {
        let mutableAttributedString = NSMutableAttributedString(string: self.string, attributes: self.attributes())
        mutableAttributedString.addAttribute(NSKernAttributeName, value: kern, range: attributedStringRange(range))
        return mutableAttributedString as NSAttributedString
    }

    // 添加删除线
    public func strikethroughStyle(_ strikethroughStyle: Int, range: NSRange? = nil) -> NSAttributedString {
        let mutableAttributedString = NSMutableAttributedString(string: self.string, attributes: self.attributes())
        mutableAttributedString.addAttribute(NSStrikethroughStyleAttributeName, value: strikethroughStyle, range: attributedStringRange(range))
        return mutableAttributedString as NSAttributedString
    }
    
    // 设置下划线
    public func underlineStyle(_ underlineStyle: NSUnderlineStyle, range: NSRange? = nil) -> NSAttributedString {
        let mutableAttributedString = NSMutableAttributedString(string: self.string, attributes: self.attributes())
        mutableAttributedString.addAttribute(NSUnderlineStyleAttributeName, value: underlineStyle, range: attributedStringRange(range))
        return mutableAttributedString as NSAttributedString
    }
    
    //
    private func attributedStringRange(_ range: NSRange?) -> NSRange {
        return range ?? NSRange(location: 0, length: self.string.count)
    }

}
