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
    
    var listDoctor : [DoctorModel]?
    
    var pushNextVC: ((Bool) -> ())? = nil

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        clvNewsDetail.delegate = self
        clvNewsDetail.dataSource = self
        self.clvNewsDetail.register(UINib(nibName: "DoctorDetailCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "DoctorDetailCollectionViewCell")
    }
    
    func configureViews(listDoctor: [DoctorModel]?, pushNextVC: ((Bool) -> ())?){
        self.pushNextVC = pushNextVC
        self.lbTitle.text = "Giới thiệu bác sĩ"
        self.listDoctor = listDoctor
        self.clvNewsDetail.reloadData()
    }
    
    @IBAction func handleBtnViewAll(_ sender: UIButton) {
        self.pushNextVC?(true)
    }
}
extension SuggestDoctorTableViewCell: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.listDoctor?.count ?? 0
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "DoctorDetailCollectionViewCell", for: indexPath) as? DoctorDetailCollectionViewCell else {
            return UICollectionViewCell()
        }
        cell.configureCell(doctor: self.listDoctor?[indexPath.item] ?? DoctorModel())
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: Constants.HomeVC.cltDoctorCellWidth, height: collectionView.bounds.height)
    }

}
