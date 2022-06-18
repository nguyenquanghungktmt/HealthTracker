//
//  SlideCollectionViewCell.swift
//  HealthyTracker
//
//  Created by pc_1359 on 16/06/2022.
//

import UIKit

class SlideCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var imgIntro: UIImageView!
    @IBOutlet weak var lbIntroTitle: UILabel!
    @IBOutlet weak var lbIntroDetail: UILabel!
    @IBOutlet weak var distanceImageVsTitle: NSLayoutConstraint!
    @IBOutlet weak var distanceTitleVsDetail: NSLayoutConstraint!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    public func setupIntroCell(intro: IntroModel){
        self.lbIntroTitle.text = intro.title
        self.lbIntroDetail.text = intro.subtitle
        self.imgIntro.image = intro.image
    }
}
