//
//  NewsDetailCollectionViewCell.swift
//  HealthyTracker
//
//  Created by pc_1359 on 25/06/2022.
//

import UIKit

class NewsDetailCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var viewNews: UIView!
    @IBOutlet weak var imgNews: UIImageView!
    @IBOutlet weak var lbNewsTitle: UILabel!
    @IBOutlet weak var lbNewsCategory: UILabel!
    @IBOutlet weak var lbNewsDate: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        setupView()
    }
    
    func setupView(){
        self.layer.shadowColor = UIColor.gray.cgColor
        self.layer.shadowOffset = CGSize(width: 0.0, height: 4.0)
        self.layer.shadowRadius = 5.0
        self.layer.shadowOpacity = 0.1
        self.layer.masksToBounds = false
    }
    
    func configureCell(news: ArticleModel) {
        Utilities.loadImage(self.imgNews, strURL: news.picture ?? "", placeHolder: UIImage(named: "img_news"))
        self.lbNewsTitle.text = news.title
        self.lbNewsCategory.text = news.category_name
        self.lbNewsDate.text = news.created_at
    }
    
    func configureCell(news: PromotionModel) {
        Utilities.loadImage(self.imgNews, strURL: news.picture ?? "", placeHolder: UIImage(named: "img_news"))
        self.lbNewsTitle.text = news.name
        self.lbNewsCategory.text = news.category_name
        self.lbNewsDate.text = news.created_at
    }
}
