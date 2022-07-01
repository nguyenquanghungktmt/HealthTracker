//
//  FirstNewsListTableViewCell.swift
//  HealthyTracker
//
//  Created by pc_1359 on 01/07/2022.
//

import UIKit

class FirstNewsListTableViewCell: UITableViewCell {
    @IBOutlet weak var imgNews: UIImageView!
    @IBOutlet weak var lbTitle: UILabel!
    @IBOutlet weak var lbDate: UILabel!
    @IBOutlet weak var viewLine: UIView!
    
    var tapOnBtnShare: ((Bool) -> ())? = nil
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func configureCell(news: NewsModel?) {
        Utilities.loadImage(self.imgNews, strURL: news?.picture ?? "", placeHolder: UIImage.imageWithColor(color: .lightGray))
        self.lbTitle.text = news?.title
        self.lbDate.text = String.dateConvert(date: news?.created_at ?? "00/00/0000")
    }
}
