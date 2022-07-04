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
    @IBOutlet weak var tbvNewsFeed: UITableView!
    @IBOutlet weak var loading: UIActivityIndicatorView!
    
    var newsFeed : PatientNewsFeedModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
        register()
        fetchDataNewsFeed()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        viewContent.roundCorners([.topLeft, .topRight], radius: 20)
    }
    
    func setupView(){
        lbUsername.text = "Quỳnh Ken"
        lbStatus.text = "Đang hoạt động"
    }
    
    func register(){
        tbvNewsFeed.delegate = self
        tbvNewsFeed.dataSource = self
        self.tbvNewsFeed.register(UINib(nibName: "NewsFeedTableViewCell", bundle: nil), forCellReuseIdentifier: "NewsFeedTableViewCell")
        self.tbvNewsFeed.register(UINib(nibName: "SuggestDoctorTableViewCell", bundle: nil), forCellReuseIdentifier: "SuggestDoctorTableViewCell")
    }
    
    func fetchDataNewsFeed() {
        //load data here
        self.loading.startAnimating()
        APIUtilities.requestHomePatientNewsFeed { [weak self] newsFeedResult, error in
            guard let self = self else { return}
            
            guard let newsFeedResult = newsFeedResult, error == nil else {
                self.loading.stopAnimating()
                self.showToast(message: "Couldn't load data")
                return
            }
            self.newsFeed = newsFeedResult

            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) { [weak self] in
                guard let self = self else { return}
                self.tbvNewsFeed.reloadData()
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
            newsCell.selectionStyle = .none
            newsCell.configureViews(articleList: self.newsFeed?.articleList,
                                    pushNextVC: {[weak self] (result) in
                                                guard let self = self else { return}
                                                if result {
                                                    let vc = self.storyboard?.instantiateViewController(withIdentifier: "NewsListViewController") as! NewsListViewController
                                                    self.navigationController?.pushViewController(vc, animated: true)
                                                }
                                    },
                                    tapOnNewsFeedCell: {[weak self] (result) in
                                                        guard let self = self else { return}
                    
                                                        let detailsVC = self.storyboard?.instantiateViewController(withIdentifier: "DetailsViewController") as! DetailsViewController
                                                        detailsVC.titles = "Chi tiết tin tức"
                                                        if let link = self.newsFeed?.articleList?[result].link {
                                                            detailsVC.url = URL(string: link)
                                                        }
                                                        self.navigationController?.pushViewController(detailsVC, animated: true)
                                        
                                    })
            return newsCell
            
        case 1:
            guard let promotionCell = tableView.dequeueReusableCell(withIdentifier: "NewsFeedTableViewCell", for: indexPath) as? NewsFeedTableViewCell else {
                return UITableViewCell()
            }
            promotionCell.selectionStyle = .none
            promotionCell.configureViews(promotionList: self.newsFeed?.promotionList,
                                         pushNextVC: {[weak self] (result) in
                                            guard let self = self else { return}
                                            if result {
                                                let vc = self.storyboard?.instantiateViewController(withIdentifier: "PromotionListViewController") as! PromotionListViewController
                                                self.navigationController?.pushViewController(vc, animated: true)
                                            }
                                            
                                         },
                                         tapOnNewsFeedCell: {[weak self] (result) in
                                            guard let self = self else { return}

                                            let detailsVC = self.storyboard?.instantiateViewController(withIdentifier: "DetailsViewController") as! DetailsViewController
                                            detailsVC.titles = "Chi tiết khuyến mại"
                                            if let link = self.newsFeed?.promotionList?[result].link {
                                                detailsVC.url = URL(string: link)
                                            }
                                            self.navigationController?.pushViewController(detailsVC, animated: true)
            
                                        })
            return promotionCell
            
        case 2:
            guard let doctorCell = tableView.dequeueReusableCell(withIdentifier: "SuggestDoctorTableViewCell", for: indexPath) as? SuggestDoctorTableViewCell else { return UITableViewCell() }
            doctorCell.selectionStyle = .none
            doctorCell.configureViews(listDoctor: self.newsFeed?.doctorList, pushNextVC: {[weak self] (result) in
                guard let self = self else { return}
                if result {
                    let vc = self.storyboard?.instantiateViewController(withIdentifier: "DoctorListViewController") as! DoctorListViewController
                    self.navigationController?.pushViewController(vc, animated: true)
                }
            })
            return doctorCell
        default:
            return UITableViewCell()
        }
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return indexPath.item==2 ? Constants.HomeVC.tableDoctorCellHeight : Constants.HomeVC.tableNewsCellHeight
    }
}
extension HomeViewController {
    func moveDetailsNews(news: NewsModel?){
        let detailsVC = self.storyboard?.instantiateViewController(withIdentifier: "DetailsViewController") as! DetailsViewController
        detailsVC.titles = "Chi tiết tin tức"
        if let link = news?.link {
            detailsVC.url = URL(string: link)
        }
        self.navigationController?.pushViewController(detailsVC, animated: true)
    }
}
