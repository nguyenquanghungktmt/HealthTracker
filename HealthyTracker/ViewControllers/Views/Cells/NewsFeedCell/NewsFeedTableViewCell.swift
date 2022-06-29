//
//  NewsTableViewCell.swift
//  HealthyTracker
//
//  Created by pc_1359 on 25/06/2022.
//

import UIKit

class NewsFeedTableViewCell: UITableViewCell {
    @IBOutlet weak var lbTitle: UILabel!
    @IBOutlet weak var btnViewAll: UIButton!
    @IBOutlet weak var clvNewsDetail: UICollectionView!
    
    var articleList     : [ArticleModel]?
    var promotionList     : [PromotionModel]?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        clvNewsDetail.delegate = self
        clvNewsDetail.dataSource = self
        self.clvNewsDetail.register(UINib(nibName: "NewsDetailCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "NewsDetailCollectionViewCell")
    }

    func configureViews(articleList: [ArticleModel]?){
        self.lbTitle.text = "Tin tức"
        self.articleList = articleList		
        self.promotionList = nil
        self.clvNewsDetail.reloadData()
    }
    
    func configureViews(promotionList: [PromotionModel]?){
        self.lbTitle.text = "Khuyến mãi"
        self.articleList = nil
        self.promotionList = promotionList
        self.clvNewsDetail.reloadData()
    }
    
}
extension NewsFeedTableViewCell: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if let articleList = self.articleList {
            return articleList.count
        }
        
        return self.promotionList?.count ?? 0
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "NewsDetailCollectionViewCell", for: indexPath) as? NewsDetailCollectionViewCell else {
            return UICollectionViewCell()
        }

        if let articleList = self.articleList {
            
            let news = articleList[indexPath.item]
            cell.configureCell(news: news)
            
            return cell
        }
        
        let promotion = self.promotionList?[indexPath.item]
        cell.configureCell(news: promotion ?? PromotionModel())
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: Constants.HomeVC.cltNewsCellWidth, height: collectionView.bounds.height)
    }

}
