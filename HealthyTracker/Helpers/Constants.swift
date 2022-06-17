//
//  Constants.swift
//  HealthyTracker
//
//  Created by pc_1359 on 17/06/2022.
//

import Foundation
import UIKit

struct Constants {
    
    static let introSlides = [IntroModel(image: UIImage(named: "img-intro1"),
                                         title: "Bác sĩ sẵn lòng chăm sóc khi bạn cần",
                                         subtitle: "Chọn chuyên khoa, bác sĩ phù hợp và được thăm khám trong không gian thoải mái tại nhà"),
                              IntroModel(image: UIImage(named: "img-intro2"),
                                        title: "Bác sĩ sẵn lòng chăm sóc khi bạn cần",
                                        subtitle: "Chọn chuyên khoa, bác sĩ phù hợp và được thăm khám trong không gian thoải mái tại nhà"),
                              IntroModel(image: UIImage(named: "img-intro3"),
                                        title: "Bác sĩ sẵn lòng chăm sóc khi bạn cần",
                                        subtitle: "Chọn chuyên khoa, bác sĩ phù hợp và được thăm khám trong không gian thoải mái tại nhà")]

    struct Color {
        static let background = UIColor(rgb: 0xF3F5FB)
        static let greenBold = UIColor(rgb: 0x2C8667)
        static let greenLight = UIColor(rgb: 0x2C8667, alpha: 0.3)
        static let startGradientIntro = UIColor(rgb: 0xA6F1F7)
        static let endGradientIntro = UIColor(rgb: 0xF3F5FB)
    }
    
    struct Font {
        static let regular = "NunitoSans-Regular"
        static let light = "NunitoSans-Light"
        static let semiBold = "NunitoSans-SemiBold"
        static let bold = "NunitoSans-Bold"
    }
}
