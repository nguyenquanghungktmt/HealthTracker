//
//  SuggestDoctorTableViewCell.swift
//  HealthyTracker
//
//  Created by pc_1359 on 28/06/2022.
//

import UIKit

class SuggestDoctorTableViewCell: UITableViewCell {
    @IBOutlet weak var lbTitle: UILabel!
    @IBOutlet weak var btnViewAll: UIButton!
    @IBOutlet weak var clvNewsDetail: UICollectionView!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        clvNewsDetail.delegate = self
        clvNewsDetail.dataSource = self
        self.clvNewsDetail.register(UINib(nibName: "DoctorDetailCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "DoctorDetailCollectionViewCell")
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
extension SuggestDoctorTableViewCell: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 6
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "DoctorDetailCollectionViewCell", for: indexPath) as? DoctorDetailCollectionViewCell else {
            return UICollectionViewCell()
        }
        cell.configureCell()
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 137, height: collectionView.bounds.height)
    }

}
