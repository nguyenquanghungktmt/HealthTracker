//
//  PromotionListTableViewCell.swift
//  HealthyTracker
//
//  Created by pc_1359 on 30/06/2022.
//

import UIKit

class NewsListTableViewCell: UITableViewCell {
    @IBOutlet weak var imgNews: UIImageView!
    @IBOutlet weak var lbTitle: UILabel!
    @IBOutlet weak var lbDate: UILabel!
    @IBOutlet weak var imgBookmark: UIImageView!
    @IBOutlet weak var viewLine: UIView!
    
    var tapOnBtnShare: ((Bool) -> ())? = nil
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(imageTapped(tapGestureRecognizer:)))
        imgBookmark.isUserInteractionEnabled = true
        imgBookmark.addGestureRecognizer(tapGestureRecognizer)
    }
    
    func configureCell(news: NewsModel?, tapOnBtnShare: ((Bool) -> ())?, isLastItem: Bool?) {
        self.tapOnBtnShare = tapOnBtnShare
        self.imgBookmark.image = UIImage(named: "ic_share_unselected")
        Utilities.loadImage(self.imgNews, strURL: news?.picture ?? "", placeHolder: UIImage.imageWithColor(color: .lightGray))
        self.lbTitle.text = news?.title ?? " "
        self.lbDate.text = String.dateConvert(date: news?.created_at ?? "00/00/0000")
        self.viewLine.isHidden = isLastItem ?? false
    }
    
    func configureCell(promotion: PromotionModel?, tapOnBtnShare: ((Bool) -> ())?, isLastItem: Bool?) {
        self.tapOnBtnShare = tapOnBtnShare
        self.imgBookmark.image = UIImage(named: "ic_share_unselected")
        Utilities.loadImage(self.imgNews, strURL: promotion?.picture ?? "", placeHolder: UIImage.imageWithColor(color: .lightGray))
        self.lbTitle.text = promotion?.name ?? " "
        self.lbDate.text = String.dateConvert(date: promotion?.created_at ?? "00/00/0000")
        self.viewLine.isHidden = isLastItem ?? false
    }
    
    @objc func imageTapped(tapGestureRecognizer: UITapGestureRecognizer) {
        /// handle event tapped on btn share
        let tappedImage = tapGestureRecognizer.view as! UIImageView
        
        let imgSelectedShare = UIImage(named: "ic_share_selected")
        
        if tappedImage.image == imgSelectedShare {
            /// unselect share news
            tappedImage.image = UIImage(named: "ic_share_unselected")
            self.tapOnBtnShare?(false)
        }
        else {
            /// select share news
            tappedImage.image = imgSelectedShare
            self.tapOnBtnShare?(true)
        }
    }
}
