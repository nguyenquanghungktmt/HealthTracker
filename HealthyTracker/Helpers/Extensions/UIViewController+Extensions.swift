//
//  UIViewController+Extensions.swift
//  HealthyTracker
//
//  Created by pc_1359 on 22/06/2022.
//

import Foundation
import UIKit

extension UIViewController{
    var safeAreaInsets: UIEdgeInsets {
        if #available(iOS 11.0, *) {
            let window = UIApplication.shared.windows[0]
            return window.safeAreaInsets 
        }
        
        if #available(iOS 13.0, *) {
            let window = UIApplication.shared.windows[0]
            return window.safeAreaInsets
        }
        
        return .zero
    }
}
