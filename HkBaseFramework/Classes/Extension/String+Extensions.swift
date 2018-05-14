//  StringExtensions.swift
//  SwiftBaseFrame
//
//  Created by Kun Huang on 2017/9/4.
//  Copyright © 2017年 Kun Huang. All rights reserved.
//

import Foundation
import UIKit

// MARK: - String类型的拓展
public extension String{
    
    /// 手机号正则
    ///
    /// - Returns: true or false
    public func isPhoneNum()->Bool{
        
        // 中国移动
        let isCM = isValidateByRegex("^1(34[0-8]|(3[5-9]|5[017-9]|8[2478])\\d)\\d{7}$")
        // 中国联通
        let isCU = isValidateByRegex("^1(3[0-2]|5[256]|8[356]|45|76)\\d{8}$")
        // 中国电信
        let isCT = isValidateByRegex("^1((33|53|77|8[09])[0-9]|349)\\d{7}$")
        
       return (isCM || isCU || isCT)
    }

    /// 身份证正则
    ///
    /// - Returns: true or false
    public func isIDCardNum()->Bool{
        return isValidateByRegex("^(\\d{14}|\\d{17})(\\d|[xX])$")
    }
    
    
    fileprivate func isValidateByRegex(_ regex:String) -> Bool {
        return NSPredicate(format: "SELF MATCHES %@", regex).evaluate(with: self)
    }
    
    /// 银行卡号正则
    ///
    /// - Returns: true or false
    public func isBankCarNum()->Bool{
        
        for char in self{
            if char == "_"{
                return false
            }
        }
        
        var result = ""
        // - 1、创建规则
        let pattern1 = "[0-9]{15,18}"
        //        let pattern1 = "^[a-zA-Z\\u4e00-\\u9fa5][a-zA-Z0-9\\u4e00-\\u9fa5]$"
        // - 2、创建正则表达式对象
        let regex1 = try! NSRegularExpression(pattern: pattern1, options: NSRegularExpression.Options.caseInsensitive)
        // - 3、开始匹配
        let res = regex1.matches(in: self, options: NSRegularExpression.MatchingOptions(rawValue: 0), range: NSMakeRange(0, self.count))
        // 输出结果
        for checkingRes in res {
            result = result + (self as NSString).substring(with: checkingRes.range)
        }
        if result == self{
            return true
        }else{
            return false
        }
        
    }
    
    /*
     是否包含字母和数字之外的字符
     */
    public func containSpecialCharacters() -> Bool{
        let nameCharacters = CharacterSet(charactersIn: "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789").inverted
        let userNameRange = (self as NSString).rangeOfCharacter(from: nameCharacters)
        if userNameRange.location != NSNotFound{
            return true
        }else{
            return false
        }
    }
    

}

public extension String {
    
    /** 获取字符串长度 */
    public var length: Int {return self.count}
    
    // 获取某个下标的字符
    public func character(at index: Int) -> Character {
        return self[self.index(self.startIndex, offsetBy: index)]
    }
    
    // 从某个下标开始截取字符串
    public func substring(from index: Int) -> String {
        return self.substring(from: self.index(self.startIndex, offsetBy: index))
    }
    
    // 从开始截取到某个下标
    public func substring(to index: Int) -> String {
        guard index <= self.count else {
            return ""
        }
        return self.substring(to: self.index(self.startIndex, offsetBy: index))
    }
    
    // 截取一个区域内的字符串
    public func substring(with range: Range<Int>) -> String {
        let start = self.index(self.startIndex, offsetBy: range.lowerBound)
        let end = self.index(self.startIndex, offsetBy: range.upperBound)
        
        return self.substring(with: start..<end)
    }
    
    // 转Int
    public func hk_toInt() -> Int {
        return (self as NSString).integerValue
    }

    // 转Double
    public func hk_toDouble() -> Double {
        return (self as NSString).doubleValue
    }
    
    // 固定高计算文字的宽度
    public func width(_ font:CGFloat,height:CGFloat) -> CGFloat {
        return (self as NSString).boundingRect(with: CGSize(width: UIScreen.main.bounds.width, height: height), options: NSStringDrawingOptions.usesLineFragmentOrigin, attributes: [NSFontAttributeName:UIFont.systemFont(ofSize: font)], context: nil).size.width
    }
    
    // 固定宽度计算文字的高度
    public func height(_ font:CGFloat,wight:CGFloat) -> CGFloat {
        return (self as NSString).boundingRect(with: CGSize(width: wight, height: 2200), options: NSStringDrawingOptions.usesLineFragmentOrigin, attributes: [NSFontAttributeName:UIFont.systemFont(ofSize: font)], context: nil).size.height
    }
    
    // 汉字转拼音
    public func toPinYin() -> String {
        let mutableString = NSMutableString(string: self)
        CFStringTransform(mutableString, nil, kCFStringTransformToLatin, false)
        CFStringTransform(mutableString, nil, kCFStringTransformStripDiacritics, false)
        let string = String(mutableString)
        return string.replacingOccurrences(of: " ", with: "")
    }
    
    // 返回大写拼音首字母, 如果不是拼音，返回#
    public func pinyinInitial(_ isHandelPolyphone:Bool = false) -> String {
        if self.count == 0 {return "#"}
        // 注意,这里一定要转换成可变字符串
        let mutableString = NSMutableString.init(string: self)
        // 将中文转换成带声调的拼音
        CFStringTransform(mutableString as CFMutableString, nil, kCFStringTransformToLatin, false)
        // 去掉声调
        let pinyinString = mutableString.folding(options: String.CompareOptions.diacriticInsensitive, locale: NSLocale.current)
        // 将拼音首字母装换成大写
        let strPinYin = isHandelPolyphone ? polyphoneStringHandle(nameString: self, pinyinString: pinyinString).uppercased() : pinyinString.uppercased()
    
        // 截取大写首字母
        let firstString = strPinYin.substring(to: strPinYin.index(strPinYin.startIndex, offsetBy:1))
        // 判断姓名首位是否为大写字母
        let regexA = "^[A-Z]$"
        let predA = NSPredicate.init(format: "SELF MATCHES %@", regexA)
        return predA.evaluate(with: firstString) ? firstString : "#"
    }
    
    /// 多音字处理
    private func polyphoneStringHandle(nameString:String, pinyinString:String) -> String {
        if nameString.hasPrefix("长") {return "chang"}
        if nameString.hasPrefix("沈") {return "shen"}
        if nameString.hasPrefix("厦") {return "xia"}
        if nameString.hasPrefix("地") {return "di"}
        if nameString.hasPrefix("重") {return "chong"}
        
        return pinyinString;
    }

}
