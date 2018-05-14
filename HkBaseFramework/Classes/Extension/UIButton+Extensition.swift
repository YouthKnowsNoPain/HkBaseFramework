//
//  UIButtonExtensition.swift
//  UIButtonImageTitlePositionDemo
//
//  Created by JiongXing on 2017/2/22.
//  Copyright © 2017年 JiongXing. All rights reserved.
//

import Foundation
import UIKit

private var key: Void?

extension UIButton {
    
    // 图片文字
    enum ImagePosition {
        case left
        case right
        case top
        case bottom
    }
    
    // 渐变方式
    enum GradientType {
        case topToBottom // 上到下
        case leftToRight // 左到右
        case upleftTolowRight // 左上到右下
        case uprightTolowLeft // 右上到左下
    }
    
    /// 利用 runtime 添加一个 indexPath 属性
    var indexPath: IndexPath? {
        get {
            return objc_getAssociatedObject(self, &key) as? IndexPath
        }
        set(newValue) {
            objc_setAssociatedObject(self, &key, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
    
    /// 调整图片位置，返回调整后所需要的size
    /// 调用本方法前，请先确保imageView和titleLabel有值。
    @discardableResult
    func adjustImage(position: ImagePosition, spacing: CGFloat) -> CGSize {
        guard imageView != nil && titleLabel != nil else {
            return CGSize.zero
        }
        let imageSize = self.imageView!.intrinsicContentSize
        let titleSize = self.titleLabel!.intrinsicContentSize
        
        // 布局
        switch (position) {
        case .left:
            imageEdgeInsets = UIEdgeInsets(top: 0, left: -spacing / 2, bottom: 0, right: spacing / 2)
            titleEdgeInsets = UIEdgeInsets(top: 0, left: spacing / 2, bottom: 0, right: -spacing / 2)
            contentEdgeInsets = UIEdgeInsets(top: 0, left: spacing / 2, bottom: 0, right: spacing / 2)
        case .right:
            imageEdgeInsets = UIEdgeInsets(top: 0, left: (titleSize.width + spacing / 2), bottom: 0, right: -(titleSize.width + spacing / 2))
            titleEdgeInsets = UIEdgeInsets(top: 0, left: -(imageSize.width + spacing / 2), bottom: 0, right: (imageSize.width + spacing / 2))
            contentEdgeInsets = UIEdgeInsetsMake(0, spacing / 2, 0, spacing / 2);
        case .top, .bottom:
            let imageOffsetX = (imageSize.width + titleSize.width) / 2 - imageSize.width / 2
            let imageOffsetY = imageSize.height / 2 + spacing / 2
            let titleOffsetX = (imageSize.width + titleSize.width / 2) - (imageSize.width + titleSize.width) / 2
            let titleOffsetY = titleSize.height / 2 + spacing / 2
            let changedWidth = titleSize.width + imageSize.width - max(titleSize.width, imageSize.width)
            let changedHeight = titleSize.height + imageSize.height + spacing - max(imageSize.height, imageSize.height)
            
            if position == .top {
                imageEdgeInsets = UIEdgeInsets(top: -imageOffsetY, left: imageOffsetX, bottom: imageOffsetY, right: -imageOffsetX)
                titleEdgeInsets = UIEdgeInsets(top: titleOffsetY, left: -titleOffsetX, bottom: -titleOffsetY, right: titleOffsetX)
                self.contentEdgeInsets = UIEdgeInsetsMake(imageOffsetY, -changedWidth / 2, changedHeight - imageOffsetY, -changedWidth / 2);
            } else {
                imageEdgeInsets = UIEdgeInsets(top: imageOffsetY, left: imageOffsetX, bottom: -imageOffsetY, right: -imageOffsetX)
                titleEdgeInsets = UIEdgeInsets(top: -titleOffsetY, left: -titleOffsetX, bottom: titleOffsetY, right: titleOffsetX)
                self.contentEdgeInsets = UIEdgeInsetsMake(changedHeight - imageOffsetY, -changedWidth / 2, imageOffsetY, -changedWidth / 2);
            }
        }
        
        return self.intrinsicContentSize
    }
    
    //创建一个mormal btn
    class func hk_creatNormal(title:String, fontSize:CGFloat, textColor:UIColor) -> UIButton {
        return hk_creat(normalTitle: title, selectedTitle: nil, normalTextColor: textColor, selectedTextColor: nil, fontSize: fontSize)
    }
    
    class func hk_creat(normalTitle:String, selectedTitle:String?, normalTextColor:UIColor, selectedTextColor:UIColor?, fontSize:CGFloat) -> UIButton {
        let btn = UIButton.init(type: .custom)
        btn.setTitle(normalTitle, for: .normal)
        btn.setTitleColor(normalTextColor, for: .normal)
        btn.titleLabel?.font = UIFont.systemFont(ofSize: fontSize)
        
        if (selectedTitle != nil) {
            btn.setTitle(selectedTitle, for: .selected)
            if (selectedTextColor != nil) {
                btn.setTitleColor(selectedTextColor, for: .selected)
            } else {
                btn.setTitleColor(normalTextColor, for: .selected)
            }
        }
        
        return btn
    }
    
    // 添加一个渐变背景
    func hk_addGradient(colors:[UIColor],gradientType:GradientType) {
        var otherGradient = UIImage.GradientType.topToBottom
        switch gradientType {
        case .leftToRight:
            otherGradient = UIImage.GradientType.leftToRight
             break
        case .topToBottom:
            otherGradient = UIImage.GradientType.topToBottom
            break
        case .uprightTolowLeft:
            otherGradient = UIImage.GradientType.uprightTolowLeft
            break
        case .upleftTolowRight:
            otherGradient = UIImage.GradientType.upleftTolowRight
            break
        }
        let image = UIImage.hk_creat(size: self.bounds.size, colors: colors, gradientType: otherGradient)
        self.setBackgroundImage(image, for: .normal)
    }
    
}
