//
//  IntroCollectionViewCell.swift
//  HealthyTracker
//
//  Created by pc_1359 on 16/06/2022.
//

import UIKit

class IntroCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var imgIntro: UIImageView!
    @IBOutlet weak var lbIntro: UILabel!
    @IBOutlet weak var lbIntroDetail: UILabel!
    
    static let identifier = String(describing: IntroCollectionViewCell.self)
    
    public func setupIntroCell(){
//        self.lbIntro.text = "Bác sĩ sẵn lòng chăm sóc khi bạn cần"
//        self.lbIntroDetail.text = "Chọn chuyên khoa, bác sĩ phù hợp và được thăm khám trong không gian thoải mái tại nhà"
//        self.imgIntro.image = UIImage(named: "Intro1")
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
            print("123")
        }
        print("abc")
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        print("abcd")
    }
    
}
