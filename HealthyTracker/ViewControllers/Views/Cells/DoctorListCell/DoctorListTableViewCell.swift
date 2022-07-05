//
//  DoctorListTableViewCell.swift
//  HealthyTracker
//
//  Created by pc_1359 on 02/07/2022.
//

import UIKit

class DoctorListTableViewCell: UITableViewCell {
    @IBOutlet weak var imgAvatar: UIImageView!
    @IBOutlet weak var lbFullname: UILabel!
    @IBOutlet weak var lbMajor: UILabel!
    @IBOutlet weak var lbRating: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func configureCell(doctor: DoctorModel?) {
        Utilities.loadImage(imgAvatar, strURL: doctor?.avatar ?? "", placeHolder: UIImage(named: "img_doctor_placehold"))
        self.lbFullname.text = doctor?.full_name ?? " "
        self.lbMajor.text = "Chuyên ngành: \(doctor?.majors_name ?? "")"
        self.lbRating.attributedText = NSMutableAttributedString()
            .attrStr(text: "\(doctor?.ratio_star ?? 0) ")
            .attrStr(text: "(\(doctor?.number_of_reviews ?? 0) Đánh giá)", textColor: UIColor.lightGray )
    }
}
