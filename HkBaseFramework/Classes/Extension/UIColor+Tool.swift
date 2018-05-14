//
//  UIColor+Tool.swift
//  SwiftBaseFrame
//
//  Created by Kun Huang on 2017/9/4.
//  Copyright © 2017年 Kun Huang. All rights reserved.
//

import UIKit

extension UIColor {
    /// 通过指定的不透明度和 RGB 分量值, 返回一个颜色对象
    ///
    /// - Parameters:
    ///   - red: 红色分量的值 (0 ~ 255)
    ///   - green: 绿色分量的值 (0 ~ 255)
    ///   - blue: 蓝色分量的值 (0 ~ 255)
    ///   - alpha: 不透明度的值 (0 ~ 1)
    /// - Returns: 颜色对象
    public static func RGBA(r: CGFloat, g: CGFloat, b: CGFloat, a: CGFloat) -> UIColor {
        return UIColor(red: r / 255.0, green: g / 255.0, blue: b / 255.0, alpha: a)
    }
    
    /// 通过指定的不透明度 和 一个用16进制数字表示 RGB 分量值的字符串, 返回一个颜色对象
    ///
    /// - Parameters:
    ///   - hexString: 以"#"或"0x"开头, 后面跟随6位(或3位)16进制数字 表示RGB分量值的字符串
    ///   - alpha: 不透明度 (0 ~ 1)
    /// - Returns: 颜色对象
    public static func color(hexString: String, alpha: CGFloat) -> UIColor {
        var red: CGFloat = 0.0, green: CGFloat = 0.0, blue:  CGFloat = 0.0
        var cString = hexString.trimmingCharacters(in: NSCharacterSet.whitespacesAndNewlines).uppercased()
        
        guard cString.hasPrefix("0X") || cString.hasPrefix("#") else {
            return UIColor(red: 1.0, green: 0.0, blue: 0.0, alpha: 1.0)
        }
        
        if cString.hasPrefix("0X") {
            cString = cString.substring(from: cString.index(cString.startIndex, offsetBy: 2))
        } else if cString.hasPrefix("#") {
            cString = cString.substring(from: cString.index(cString.startIndex, offsetBy: 1))
        }
        
        let scanner = Scanner(string: cString)
        var hexValue: CUnsignedLongLong = 0
        guard scanner.scanHexInt64(&hexValue) else {
            return UIColor(red: 0.0, green: 1.0, blue: 0.0, alpha: 1.0)
        }
        
        switch (cString.characters.count) {
        case 3:
            red   = CGFloat((hexValue & 0xF00) >> 8)       / 15.0
            green = CGFloat((hexValue & 0x0F0) >> 4)       / 15.0
            blue  = CGFloat(hexValue & 0x00F)              / 15.0
            
        case 6:
            red   = CGFloat((hexValue & 0xFF0000) >> 16)   / 255.0
            green = CGFloat((hexValue & 0x00FF00) >> 8)    / 255.0
            blue  = CGFloat(hexValue & 0x0000FF)           / 255.0
            
        default:
            red = 0.0; green = 0.0; blue = 1.0
        }
        return UIColor(red: red, green: green, blue: blue, alpha: alpha)
    }

}
