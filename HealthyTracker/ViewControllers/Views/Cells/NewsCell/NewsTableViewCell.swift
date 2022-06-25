//
//  NewsTableViewCell.swift
//  HealthyTracker
//
//  Created by pc_1359 on 25/06/2022.
//

import UIKit

class NewsTableViewCell: UITableViewCell {
    @IBOutlet weak var lbTitle: UILabel!
    @IBOutlet weak var btnViewAll: UIButton!
    @IBOutlet weak var clvNewsDetail: UICollectionView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        clvNewsDetail.delegate = self
        clvNewsDetail.dataSource = self
        self.clvNewsDetail.register(UINib(nibName: "NewsDetailCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "NewsDetailCollectionViewCell")
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
extension NewsTableViewCell: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 6
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let introCell = collectionView.dequeueReusableCell(withReuseIdentifier: "NewsDetailCollectionViewCell", for: indexPath) as? NewsDetailCollectionViewCell else {
            return UICollectionViewCell()
        }
//        introCell.setupIntroCell(intro: introSlides[indexPath.item])
        return introCell
    }

}
