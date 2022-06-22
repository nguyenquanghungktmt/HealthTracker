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
        self.textColor = .black
    }
}
