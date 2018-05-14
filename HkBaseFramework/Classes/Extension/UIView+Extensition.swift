//
//  UIViewExtensition.swift
//  SwiftBaseFrame
//
//  Created by Kun Huang on 2017/9/4.
//  Copyright © 2017年 Kun Huang. All rights reserved.
//

import UIKit

public enum RGLineDirection {
    case horizontal
    case vertical
}

extension UIView {
    // MARK: Draw
    /// 在 view 的指定位置加指定长宽、颜色的线
    ///
    /// - Parameters:
    ///   - startPoint: 起始点坐标
    ///   - length: 长度
    ///   - width: 宽度
    ///   - color: 颜色
    ///   - direction: 方向
    /// - Returns: 按参数条件添加的线
    public func drawLine(
        from startPoint: CGPoint,
        length: CGFloat,
        width: CGFloat,
        color: UIColor,
        direction: RGLineDirection = .horizontal) -> UIView
    {
        let line = UIView()
        switch direction {
        case .horizontal:
            line.frame = CGRect(x: startPoint.x, y: startPoint.y, width: length, height: width)
            
        case .vertical:
            line.frame = CGRect(x: startPoint.x, y: startPoint.y, width: width, height: length)
        }
        line.backgroundColor = color
        self.addSubview(line)
        return line
    }
    
    /// 为视图添加边线
    ///
    /// - Parameters:
    ///   - width: 边线宽度
    ///   - cornerRadius: 边线圆角半径, 若无圆角则该值为0
    ///   - color: 边线颜色
    public func addBorder(width: CGFloat, cornerRadius: CGFloat, color: UIColor) {
        self.layer.masksToBounds = true
        self.layer.borderWidth = width
        self.layer.cornerRadius = cornerRadius
        self.layer.borderColor = color.cgColor
    }
        
    // MARK: Rect
    /// 视图尺寸
    var size: CGSize { return self.bounds.size }
    
    /// 视图横坐标最小值
    var minX: CGFloat { return self.frame.minX }
    /// 视图中心横坐标值
    var midX: CGFloat { return self.frame.midX }
    /// 视图横坐标最大值
    var maxX: CGFloat { return self.frame.maxX }
    
    /// 视图纵坐标最小值
    var minY: CGFloat { return self.frame.minY }
    /// 视图中心纵坐标值
    var midY: CGFloat { return self.frame.midY }
    /// 视图纵坐标最大值
    var maxY: CGFloat { return self.frame.maxY }
}

extension UIView {
    /// 视图左上角横坐标值
    var hk_x: CGFloat {
        get {
            return self.frame.origin.x
        }
        set {
            var frame = self.frame
            frame.origin.x = newValue
            self.frame = frame
        }
    }
    
    /// 视图左上角纵坐标值
    var hk_y: CGFloat {
        get {
            return self.frame.origin.y
        }
        set {
            var frame = self.frame
            frame.origin.y = newValue
            self.frame = frame
        }
    }
    
    /// 视图宽度
    var hk_width: CGFloat {
        get {
            return self.frame.size.width
        }
        set {
            var frame = self.frame
            frame.size.width = newValue
            self.frame = frame
        }
    }
    
    /// 视图高度
    var hk_height: CGFloat {
        get {
            return self.frame.size.height
        }
        set {
            var frame = self.frame
            frame.size.height = newValue
            self.frame = frame
        }
    }
    
    /// 视图中心横坐标
    var hk_centerX: CGFloat {
        get {
            return self.center.x
        }
        set {
            var center = self.center
            center.x = newValue
            self.center = center
        }
    }
}

// 可xib storyboard
extension UIView {
    // 边线的宽度
    @IBInspectable public var hk_borderWidth: CGFloat {
        get {
            return self.layer.borderWidth
        }
        set {
            self.layer.borderWidth = newValue
        }
    }
    
    // 边线的颜色
    @IBInspectable public var hk_borderColor: UIColor {
        get {
            guard let borderColor = self.layer.borderColor else {
                return UIColor.clear
            }
            return UIColor(cgColor: borderColor)
        }
        set {
            self.layer.borderColor = newValue.cgColor
        }
    }
    
    // 子图层超出部分是否裁剪
    @IBInspectable public var hk_maskToBounds: Bool {
        get {
            return self.layer.masksToBounds
        }
        set {
            self.layer.masksToBounds = newValue
        }
    }
    
    // 圆角
    @IBInspectable public var hk_cornerRadius: CGFloat {
        get {
            return self.layer.cornerRadius
        }
        set {
            self.layer.cornerRadius = newValue
        }
    }
    
    // 阴影颜色
    @IBInspectable public var hk_shadowColor: UIColor {
        get {
            guard let shadowColor = self.layer.shadowColor else {
                return UIColor.clear
            }
            return UIColor(cgColor: shadowColor)
        }
        set {
            self.layer.shadowColor = newValue.cgColor
        }
    }
    
    // 阴影透明度
    @IBInspectable public var hk_shadowOpacity: Float {
        get {
            return self.layer.shadowOpacity
        }
        set {
            self.layer.shadowOpacity = newValue
        }
    }
    
    // 阴影X轴偏移
    @IBInspectable public var hk_shadowOffsetX: CGFloat {
        get {
            return self.layer.shadowOffset.width
        }
        set {
            self.layer.shadowOffset = CGSize(width: newValue, height: self.layer.shadowOffset.height)
        }
    }
    
    //阴影Y轴偏移
    @IBInspectable public var hk_shadowOffsetY: CGFloat {
        get {
            return self.layer.shadowOffset.height
        }
        set {
            self.layer.shadowOffset = CGSize(width: self.layer.shadowOffset.width, height: newValue)
        }
    }
    
    // 阴影圆角
    @IBInspectable public var hk_shadowRadius: CGFloat {
        get {
            return self.layer.shadowRadius
        }
        set {
            self.layer.shadowRadius = newValue
        }
    }
}

