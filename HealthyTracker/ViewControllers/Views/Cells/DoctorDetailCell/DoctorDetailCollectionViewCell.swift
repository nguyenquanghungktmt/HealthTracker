//
//  SuggestDoctorCollectionViewCell.swift
//  HealthyTracker
//
//  Created by pc_1359 on 28/06/2022.
//

import UIKit

class DoctorDetailCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var imgAvatarDoctor: UIImageView!
    @IBOutlet weak var lbDoctorName: UILabel!
    @IBOutlet weak var lbDoctorMajor: UILabel!
    @IBOutlet weak var lbRating: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func configureCell(doctor: DoctorModel?) {
        Utilities.loadImage(imgAvatarDoctor, strURL: doctor?.avatar ?? "", placeHolder: UIImage(named: "img_doctor_placehold"))
        self.lbDoctorName.text = doctor?.full_name
        self.lbDoctorMajor.text = doctor?.majors_name
        self.lbRating.attributedText = NSMutableAttributedString()
            .attrStr(text: "\(doctor?.ratio_star ?? 0) ")
            .attrStr(text: "(\(doctor?.number_of_reviews ?? 0))", textColor: UIColor.lightGray )
        
    }

}
