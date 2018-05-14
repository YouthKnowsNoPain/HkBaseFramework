//
//  HKTextField.swift
//  SwiftBaseFrame
//
//  Created by Kun Huang on 2017/9/4.
//  Copyright © 2017年 Kun Huang. All rights reserved.
//

import UIKit

public enum HKTextFieldType:Int {
    case none // 不限制
    case count // 数量 可以0在首位
    case countNonZeroFront // 数量类 非0开头(可以单0)
    case money // 金额类 默认小数点后保留2位
}

class HKTextField: UITextField,UITextFieldDelegate {
    // 类型
    var type:HKTextFieldType = HKTextFieldType.none
    
    // 最大长度
    @IBInspectable var textMaxLength = 0 {
        didSet {
            if textMaxLength != 0 {
                self.addTarget(nil, action: #selector(textFieldMaxLenthDidChange(textField:)), for: .editingChanged)
            }
        }
    }
    
    // 小数点后保留2位
    @IBInspectable var moneyMaxDecimal:Int = 2
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.delegate = self
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.delegate = self
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    @objc func textFieldMaxLenthDidChange(textField:UITextField) {
        guard let toBeString = textField.text else {
            return
        }
        
        let lang = UIApplication.shared.textInputMode?.primaryLanguage
        
        if lang == "zh-Hans" { // 中文
            
            // 获取高亮部分
            if let selectedRange = textField.markedTextRange {
                let position = textField.position(from: selectedRange.start, offset: 0)
                // 没有高亮选择的字，则对已输入的文字进行字数统计和限制
                if (position == nil) && toBeString.count > textMaxLength {
                    textField.text = (toBeString as NSString).substring(to: textMaxLength)
                } else {//有高亮选择的字符串，则暂不对文字进行统计和限制
                    
                }
            } else {
                
                if toBeString.count != 0 && toBeString.length > textMaxLength {
                    textField.text = (toBeString as NSString).substring(to: textMaxLength)
                }
            
            }
            
        } else {
            //中文输入法以外的直接对其统计限制即可，不考虑其他语种情况
            if toBeString.count > textMaxLength {
                textField.text = (toBeString as NSString).substring(to: textMaxLength)
            }
        }
        
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        guard let text = textField.text else {
            return true
        }
        
        switch type {
        case .none:
            return true
        case .count:
            let scanner = Scanner.init(string: string)
            let numbers = CharacterSet.init(charactersIn: "0123456789")
            var buffer:NSString?
            if !scanner.scanCharacters(from: numbers, into: &buffer) && string.count != 0 {
                return false
            }
            return true
        case .countNonZeroFront:
            let scanner = Scanner.init(string: string)
            let numbers = CharacterSet.init(charactersIn: "0123456789")
            let zeroRange = (text as NSString).range(of: "0")
            if zeroRange.length == 1 && zeroRange.location == 0 {
                if string != "0" && string != "." && text.count == 1 {
                    textField.text = string
                }
                return false
            }
            var buffer:NSString?
            if !scanner.scanCharacters(from: numbers, into: &buffer) && string.count != 0 {
                return false
            }
            return true
            
        case .money:
            let scanner = Scanner.init(string: string)
            var numbers:CharacterSet!
            let pointRange = (text as NSString).range(of: ".")
            if pointRange.length > 0 && (pointRange.location < range.location || pointRange.location > range.location + range.length) {
                numbers = CharacterSet.init(charactersIn: "0123456789")
            } else {
                numbers = CharacterSet.init(charactersIn: "0123456789.")
            }
            if text == "" && string == "." {
                return false
            }
            
            let tempStr = text + string
            let strlen = tempStr.count
            if pointRange.length > 0 && pointRange.location > 0 {
                if string == "." {
                    return false
                }
                
                if strlen > 0 && (strlen - pointRange.location) > moneyMaxDecimal + 1 {
                    return false
                }
            }
            
            let zeroRange = (text as NSString).range(of: "0")
            if zeroRange.length == 1 && zeroRange.location == 0 {
                if string != "0" && string != "." && text.count == 1 {
                    textField.text = string
                    return false
                } else {
                    if pointRange.length == 0 && pointRange.location > 0 && string == "0" {
                        return false
                    }
                }
            }
            var buffer:NSString?
            if  !scanner.scanCharacters(from: numbers, into: &buffer) && string.count != 0 {
                return false
            }
            return true
        }
        
    }
    

}
