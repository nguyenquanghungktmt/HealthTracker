//
//  PromotionListViewController.swift
//  HealthyTracker
//
//  Created by pc_1359 on 30/06/2022.
//

import UIKit

class PromotionListViewController: UIViewController {
    @IBOutlet weak var tbvPromotion: UITableView!
    @IBOutlet weak var loading: UIActivityIndicatorView!
    
    lazy var refreshControl: UIRefreshControl = UIRefreshControl()
    
    var promotionList: [PromotionModel]?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupView()
        register()
        fetchDataPromotionList()
    }
    
    func setupView() {
        self.refreshControl.addTarget(self, action: #selector(fetchDataPromotionList), for: .valueChanged)
        tbvPromotion.refreshControl = refreshControl
    }
    
    func register(){
        tbvPromotion.delegate = self
        tbvPromotion.dataSource = self
        self.tbvPromotion.register(UINib(nibName: "NewsListTableViewCell", bundle: nil), forCellReuseIdentifier: "NewsListTableViewCell")
    }
    
    @objc
    func fetchDataPromotionList() {
        //load data here
        self.loading.startAnimating()
        APIUtilities.requestPromotionList2 { [weak self] result, error in
            guard let self = self else { return}
            self.loading.stopAnimating()
            self.refreshControl.endRefreshing()
            
            guard let result = result, error == nil else {
                self.showToast(message: "Couldn't load data")
                return
            }
            self.promotionList = result

            DispatchQueue.main.async { [weak self] in
                guard let self = self else { return}
                self.tbvPromotion.reloadData()
            }
        }
    }
    
    
    @IBAction func handleBtnBack(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
}
extension PromotionListViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.promotionList?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "NewsListTableViewCell", for: indexPath) as? NewsListTableViewCell else {
            return UITableViewCell()
        }
        
        let index = indexPath.item
        cell.selectionStyle = .none
        cell.configureCell(promotion: promotionList?[index],
                           tapOnBtnShare: {[weak self] (isShare) in
                            guard let self = self else { return}
                            if isShare {
                                /// copy news url to clipboard
                                UIPasteboard.general.string = self.promotionList?[index].link
                                self.showToast(message: "Copied url to clipboard")
                            }
                           },
                           isLastItem: (index == (self.promotionList?.count ?? 0) - 1))
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let promotion = self.promotionList?[indexPath.item] else { return }
        let detailsVC = self.storyboard?.instantiateViewController(withIdentifier: "DetailsViewController") as! DetailsViewController
        if let link = promotion.link {
            detailsVC.configVC(title: "Chi tiết khuyến mại", url: URL(string: link))
        }
        self.navigationController?.pushViewController(detailsVC, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return Constants.NewsListVC.newsTableCellHeight
    }
}
