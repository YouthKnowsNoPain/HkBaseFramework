//
//  UIBarButtonItem+Extensions.swift
//  MeiTu
//
//  Created by Kun Huang on 2017/9/21.
//  Copyright © 2017年 Kun Huang. All rights reserved.
//

import UIKit

extension UIBarButtonItem {
    
    enum Alignment {
        case left
        case right
    }
    
    class func hk_creat(image:UIImage, target: Any?, alignment:Alignment, action: Selector) -> (item:UIBarButtonItem, btn:UIButton) {
        let btn = UIButton.init(type: .custom)
        btn.setImage(image, for: .normal)
        btn.addTarget(target, action: action, for: .touchUpInside)
        btn.bounds = CGRect.init(x: 0, y: 0, width: 60, height: 44)
        btn.contentHorizontalAlignment = alignment == .left ? .left : .right
//        btn.sizeToFit()
        return (item:self.init(customView: btn), btn:btn)
    }
    
    class func hk_creat(title:String, _ font:CGFloat = 15, _ color:UIColor = .white, target:Any?, action:Selector) -> (item:UIBarButtonItem, btn:UIButton) {
        let btn = UIButton.init(type: .custom)
        btn.setTitle(title, for: .normal)
        btn.titleLabel?.font = UIFont.systemFont(ofSize: font)
        btn.setTitleColor(color, for: .normal)
        btn.addTarget(target, action: action, for: .touchUpInside)
        btn.sizeToFit()
        return (item:self.init(customView: btn), btn:btn)
    }

    
}
