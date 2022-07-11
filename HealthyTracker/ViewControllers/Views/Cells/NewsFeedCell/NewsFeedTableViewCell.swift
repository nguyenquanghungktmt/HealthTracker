//
//  NewsTableViewCell.swift
//  HealthyTracker
//
//  Created by pc_1359 on 25/06/2022.
//

import UIKit

enum NewFeedTableViewCellType {
    case news
    case promotion
}

class NewsFeedTableViewCell: UITableViewCell {
    @IBOutlet weak var lbTitle: UILabel!
    @IBOutlet weak var btnViewAll: UIButton!
    @IBOutlet weak var clvNewsDetail: UICollectionView!
    
    var newsList     : [NewsModel]?
    var promotionList     : [PromotionModel]?
    var typeCell : NewFeedTableViewCellType?
    
    var pushNextVC: ((Bool) -> ())? = nil
    var tapOnNewsFeedCell: ((Int) -> ())? = nil
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        self.typeCell = .news
        clvNewsDetail.delegate = self
        clvNewsDetail.dataSource = self
        clvNewsDetail.register(UINib(nibName: "NewsDetailCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "NewsDetailCollectionViewCell")
    }

    func configureViews(newsList: [NewsModel]?, pushNextVC: ((Bool) -> ())?, tapOnNewsFeedCell: ((Int) -> ())?){
        self.typeCell = .news
        self.pushNextVC = pushNextVC
        self.tapOnNewsFeedCell = tapOnNewsFeedCell
        self.lbTitle.text = "Tin tức"
        self.newsList = newsList
        self.promotionList = nil
        self.clvNewsDetail.reloadData()
    }
    
    func configureViews(promotionList: [PromotionModel]?, pushNextVC: ((Bool) -> ())?, tapOnNewsFeedCell: ((Int) -> ())?){
        self.typeCell = .promotion
        self.pushNextVC = pushNextVC
        self.tapOnNewsFeedCell = tapOnNewsFeedCell
        self.lbTitle.text = "Khuyến mãi"
        self.newsList = nil
        self.promotionList = promotionList
        self.clvNewsDetail.reloadData()
    }
    
    @IBAction func handleBtnViewAll(_ sender: UIButton) {
        self.pushNextVC?(true)
    }
}
extension NewsFeedTableViewCell: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch self.typeCell {
        case .news:
            return newsList?.count ?? 0
            
        case .promotion:
            return promotionList?.count ?? 0
            
        default:
            return 0
        }
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "NewsDetailCollectionViewCell", for: indexPath) as? NewsDetailCollectionViewCell else {
            return UICollectionViewCell()
        }
        
        switch self.typeCell {
        case .news:
            let news = newsList?[indexPath.item]
            cell.configureCell(news: news)
            return cell
            
        case .promotion:
            let promotion = self.promotionList?[indexPath.item]
            cell.configureCell(promotion: promotion)
            return cell
            
        default:
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.tapOnNewsFeedCell?(indexPath.item)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: Constants.HomeVC.cltNewsCellWidth, height: collectionView.bounds.height)
    }

}
