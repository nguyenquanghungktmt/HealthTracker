//
//  SlideCollectionViewCell.swift
//  HealthyTracker
//
//  Created by pc_1359 on 16/06/2022.
//

import UIKit

class SlideCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var imgIntro: UIImageView!
    @IBOutlet weak var lbIntro: UILabel!
    @IBOutlet weak var lbIntroDetail: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    public func setupIntroCell(){
        self.lbIntro.text = "Bác sĩ sẵn lòng chăm sóc khi bạn cần"
        self.lbIntroDetail.text = "Chọn chuyên khoa, bác sĩ phù hợp và được thăm khám trong không gian thoải mái tại nhà"
        self.imgIntro.image = UIImage(named: "Intro2")
    }
}
