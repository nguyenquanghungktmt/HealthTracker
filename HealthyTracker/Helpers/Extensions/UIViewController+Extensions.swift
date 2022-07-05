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
    
    func showToast(message : String) {
        let toastLabel = UILabel(frame: CGRect(x: self.view.frame.size.width/2 - 100, y: self.view.frame.size.height - 80, width: 200, height: 40))
        toastLabel.backgroundColor = UIColor.black.withAlphaComponent(0.4)
        toastLabel.textColor = UIColor.white
        toastLabel.font = UIFont(name: Constants.Font.regular, size: 15)
        toastLabel.textAlignment = .center;
        toastLabel.text = message
        toastLabel.alpha = 1.0
        toastLabel.layer.cornerRadius = 14;
        toastLabel.clipsToBounds  =  true
        self.view.addSubview(toastLabel)
        UIView.animate(withDuration: 0.3, delay: 2.0, options: .curveEaseOut, animations: {
             toastLabel.alpha = 0.0
        }, completion: {(isCompleted) in
            toastLabel.removeFromSuperview()
        })
    }
}
