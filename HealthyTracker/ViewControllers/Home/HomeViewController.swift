//
//  HomeViewController.swift
//  HealthyTracker
//
//  Created by pc_1359 on 23/06/2022.
//

import UIKit

class HomeViewController: UIViewController {
    @IBOutlet weak var viewContent: UIView!
    @IBOutlet weak var lbUsername: UILabel!
    @IBOutlet weak var lbStatus: UILabel!
    @IBOutlet weak var tbvNews: UITableView!
    @IBOutlet weak var loading: UIActivityIndicatorView!
    
    var newsFeed : PatientNewsFeedModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
        register()
        fetchDataNewsFeed()
    }
    
    override func viewDidLayoutSubviews() {
        viewContent.roundCorners([.topLeft, .topRight], radius: 20)
    }
    
    func setupView(){
        lbUsername.text = "Quỳnh Ken"
        lbStatus.text = "Đang hoạt động"
        
        
        self.loading.hidesWhenStopped = true
    }
    
    func register(){
        tbvNews.delegate = self
        tbvNews.dataSource = self
        self.tbvNews.register(UINib(nibName: "NewsFeedTableViewCell", bundle: nil), forCellReuseIdentifier: "NewsFeedTableViewCell")
        self.tbvNews.register(UINib(nibName: "SuggestDoctorTableViewCell", bundle: nil), forCellReuseIdentifier: "SuggestDoctorTableViewCell")
    }
    
    func fetchDataNewsFeed() {
        //load data here
        self.loading.startAnimating()
        APIUtilities.requestHomePatientNewsFeed { [weak self] newsFeedResult, error in
            guard let self = self else { return}

            
            guard let newsFeedResult = newsFeedResult, error == nil else { return }
            self.newsFeed = newsFeedResult

            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) { [weak self] in
                guard let self = self else { return}
                self.tbvNews.reloadData()
                self.loading.stopAnimating()
            }
        }
    }
}
extension HomeViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.item {
        case 0:
            guard let newsCell = tableView.dequeueReusableCell(withIdentifier: "NewsFeedTableViewCell", for: indexPath) as? NewsFeedTableViewCell else {
                return UITableViewCell()
            }
            newsCell.configureViews(articleList: self.newsFeed?.articleList)
            newsCell.pushNextVC = {[weak self] (result) in
                guard let self = self else { return}
                if result {
                    let vc = self.storyboard?.instantiateViewController(withIdentifier: "NewsListViewController") as! NewsListViewController
                    self.navigationController?.pushViewController(vc, animated: true)
                }
            }
            return newsCell
            
        case 1:
            guard let promotionCell = tableView.dequeueReusableCell(withIdentifier: "NewsFeedTableViewCell", for: indexPath) as? NewsFeedTableViewCell else {
                return UITableViewCell()
            }
            promotionCell.configureViews(promotionList: self.newsFeed?.promotionList)
            promotionCell.pushNextVC = {[weak self] (result) in
                guard let self = self else { return}
                if result {
                    let vc = self.storyboard?.instantiateViewController(withIdentifier: "PromotionListViewController") as! PromotionListViewController
                    self.navigationController?.pushViewController(vc, animated: true)
                }
            }
            return promotionCell
            
        case 2:
            guard let doctorCell = tableView.dequeueReusableCell(withIdentifier: "SuggestDoctorTableViewCell", for: indexPath) as? SuggestDoctorTableViewCell else { return UITableViewCell() }
            doctorCell.configureViews(listDoctor: self.newsFeed?.doctorList)
            doctorCell.pushNextVC = {[weak self] (result) in
                guard let self = self else { return}
                if result {
                    let vc = self.storyboard?.instantiateViewController(withIdentifier: "DoctorListViewController") as! DoctorListViewController
                    self.navigationController?.pushViewController(vc, animated: true)
                }
            }
            return doctorCell
        default:
            return UITableViewCell()
        }
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return indexPath.item==2 ? Constants.HomeVC.tableDoctorCellHeight : Constants.HomeVC.tableNewsCellHeight
    }
}
