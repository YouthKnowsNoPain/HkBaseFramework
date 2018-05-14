//
//  UIImageExtension.swift
//  SwiftBaseFramework
//
//  Created by Kun Huang on 2017/9/8.
//  Copyright © 2017年 Kun Huang. All rights reserved.
//

import UIKit

public extension UIImage {
    
    // 渐变方式
    enum GradientType {
        case topToBottom // 上到下
        case leftToRight // 左到右
        case upleftTolowRight // 左上到右下
        case uprightTolowLeft // 右上到左下
    }
    
    enum ComposeType {
        case center
        case top // 上
        case bottom // 下
    }
    
    //
    public static func screenScale() -> CGFloat {
        return UIScreen.main.scale
    }

    // 初始化一个有颜色的
    public convenience init?(color: UIColor) {
        let rect: CGRect = CGRect(x: 0, y: 0, width: 1 * UIImage.screenScale(), height: 1 * UIImage.screenScale())
        UIGraphicsBeginImageContext(rect.size)
        
        color.setFill()
        UIRectFill(rect)
        
        guard let image: UIImage = UIGraphicsGetImageFromCurrentImageContext() else {
            UIGraphicsEndImageContext()
            return nil
        }
        UIGraphicsEndImageContext()
        
        self.init(cgImage: image.cgImage!, scale: UIImage.screenScale(), orientation: .up)
    }
    
    // 图片旋转 radians
    public func rotate(radians: Float) -> UIImage {
        let degrees = Float(Double(radians) * 180 / Double.pi)
        let rotatedViewBox: UIView = UIView(frame: CGRect(x: 0, y: 0, width: self.size.width, height: self.size.height))
        let rotationAngle = CGFloat(Double(degrees) * Double.pi / 180)
        let transformation: CGAffineTransform = CGAffineTransform(rotationAngle: rotationAngle)
        rotatedViewBox.transform = transformation
        let rotatedSize: CGSize = CGSize(width: Int(rotatedViewBox.frame.size.width), height: Int(rotatedViewBox.frame.size.height))
        
        UIGraphicsBeginImageContextWithOptions(rotatedSize, false, UIImage.screenScale())
        guard let context: CGContext = UIGraphicsGetCurrentContext() else {
            UIGraphicsEndImageContext()
            return self
        }
        
        context.translateBy(x: rotatedSize.width / 2, y: rotatedSize.height / 2)
        
        context.rotate(by: rotationAngle)
        
        context.scaleBy(x: 1.0, y: -1.0)
        context.draw(self.cgImage!, in: CGRect(x: -self.size.width / 2, y: -self.size.height / 2, width: self.size.width, height: self.size.height))
        
        guard let newImage: UIImage = UIGraphicsGetImageFromCurrentImageContext() else {
            UIGraphicsEndImageContext()
            return self
        }
        UIGraphicsEndImageContext()
        
        return newImage
    }
    
    // 创建一个渐变的图片
    class func hk_creat(size:CGSize, colors:[UIColor]?, gradientType:GradientType) -> UIImage? {
        
        guard let aColors = colors else {
            return nil
        }
        
        UIGraphicsBeginImageContextWithOptions(size, true, screenScale())
        let context = UIGraphicsGetCurrentContext()
        context?.saveGState()
        let colorSpace = CGColorSpaceCreateDeviceRGB()
        let otherColors = aColors.map { $0.cgColor } as CFArray
        let gradient = CGGradient.init(colorsSpace: colorSpace, colors: otherColors, locations: [0,1])
        
        var start = CGPoint(x: 0.0, y: 0.0)
        var end = CGPoint(x: 0.0, y: 0.0)
        
        switch gradientType {
        case .leftToRight:
            start = CGPoint(x: 0.0, y: 0.0)
            end = CGPoint(x: size.width, y: 0.0)
            break
        case .topToBottom:
            start = CGPoint(x: 0.0, y: 0.0)
            end = CGPoint(x: 0.0, y: size.height)
            break
        case .upleftTolowRight:
            start = CGPoint(x: 0.0, y: 0.0)
            end = CGPoint(x: size.width, y: size.height)
            break
        case .uprightTolowLeft:
            start = CGPoint(x: size.width, y: 0.0)
            end = CGPoint(x: 0.0, y: size.height)
            break
        }
        
        guard let aGradient = gradient  else {
            return nil
        }
        context?.drawLinearGradient(aGradient, start: start, end: end, options: [.drawsBeforeStartLocation,.drawsAfterEndLocation])
        let image = UIGraphicsGetImageFromCurrentImageContext()
        context?.restoreGState()
        UIGraphicsEndImageContext()
        return image
    }

    // 合成图片
    static func hk_composeImage(bottomImage:UIImage, upImage:UIImage, type:ComposeType = ComposeType.center) -> UIImage? {
        
        guard let imgRef = upImage.cgImage else {
            return nil
        }
        
        let w = CGFloat(imgRef.width)
        let h = CGFloat(imgRef.height)
        
        guard let imgRef1 = bottomImage.cgImage else {
            return nil
        }
        
        let w1 = CGFloat(imgRef1.width)
        let h1 = CGFloat(imgRef1.height)
        
        UIGraphicsBeginImageContext(CGSize.init(width: w1, height: h1))
        bottomImage.draw(in: CGRect.init(x: 0, y: 0, width: w1, height: h1))
        if type == .center {
            upImage.draw(in: CGRect.init(x: (w1-w)/2.0, y: (h1-h)/2.0, width: w, height: h))
        } else if type == .top {
            upImage.draw(in: CGRect.init(x: 0.0, y: 0.0, width: w, height: h))
        } else {
            upImage.draw(in: CGRect.init(x: 0.0, y: h1-h, width: w, height: h))
        }
        
        
        guard let resultImg = UIGraphicsGetImageFromCurrentImageContext() else {
            UIGraphicsEndImageContext()
            return nil
        }
        UIGraphicsEndImageContext()
        return resultImg
        
    }
    
    // 把视图转成图片
    class func getImageFromView(view:UIView) ->UIImage? {
        
//        UIGraphicsBeginImageContext(view.bounds.size)
        UIGraphicsBeginImageContextWithOptions(view.bounds.size, false, UIScreen.main.scale)
        guard let context = UIGraphicsGetCurrentContext() else {
            return nil
        }
        view.layer.render(in: context)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image
    }
    
    // 图片重绘
    
    class func hk_image(image:UIImage,size:CGSize) -> UIImage? {
        
        UIGraphicsBeginImageContextWithOptions(size, false, UIScreen.main.scale)
        image.draw(in: CGRect.init(x: 0, y: 0, width: size.width, height: size.height))
        
        guard let newImage = UIGraphicsGetImageFromCurrentImageContext() else {
            return nil
        }
        
        UIGraphicsEndImageContext()
        
        return newImage
    }

    func image(_ text:String,size:(CGFloat,CGFloat),backColor:UIColor=UIColor.orange,textColor:UIColor=UIColor.white,isCircle:Bool=true) -> UIImage?{
        // 过滤空""
        if text.isEmpty { return nil }
        // 取第一个字符(测试了,太长了的话,效果并不好)
        let letter = (text as NSString).substring(to: 1)
        let sise = CGSize(width: size.0, height: size.1)
        let rect = CGRect(origin: CGPoint.zero, size: sise)
        // 开启上下文
        UIGraphicsBeginImageContext(sise)
        // 拿到上下文
        guard let ctx = UIGraphicsGetCurrentContext() else { return nil }
        // 取较小的边
        let minSide = min(size.0, size.1)
        // 是否圆角裁剪
        if isCircle {
            UIBezierPath(roundedRect: rect, cornerRadius: minSide*0.5).addClip()
        }
        // 设置填充颜色
        ctx.setFillColor(backColor.cgColor)
        // 填充绘制
        ctx.fill(rect)
        let attr = [ NSForegroundColorAttributeName : textColor, NSFontAttributeName : UIFont.systemFont(ofSize: minSide*0.5)]
        // 写入文字
        (letter as NSString).draw(at: CGPoint(x: minSide*0.25, y: minSide*0.25), withAttributes: attr)
        // 得到图片
        let image = UIGraphicsGetImageFromCurrentImageContext()
        // 关闭上下文
        UIGraphicsEndImageContext()
        return image
    }
    

}
