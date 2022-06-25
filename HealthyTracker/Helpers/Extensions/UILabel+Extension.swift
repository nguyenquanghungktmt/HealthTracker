//
//  UILabel+Extension.swift
//  HealthyTracker
//
//  Created by pc_1359 on 20/06/2022.
//

import Foundation
import UIKit

extension UILabel {
    func setFontSizeColor(font: String, size: CGFloat, color: UIColor){
        self.font = UIFont(name: font, size: size)
        self.textColor = color
    }
    
    func addLeading(image: UIImage, text:String) {
        let attachment = NSTextAttachment()
        attachment.image = image

        let attachmentString = NSAttributedString(attachment: attachment)
        let mutableAttributedString = NSMutableAttributedString()
        mutableAttributedString.append(attachmentString)
        
        let string = NSMutableAttributedString(string: text, attributes: [:])
        mutableAttributedString.append(string)
        self.attributedText = mutableAttributedString
    }
}
