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
    
    var promotionList: [PromotionModel]?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        register()
        fetchDataPromotionList()
    }
    func register(){
        tbvPromotion.delegate = self
        tbvPromotion.dataSource = self
        self.tbvPromotion.register(UINib(nibName: "NewsListTableViewCell", bundle: nil), forCellReuseIdentifier: "NewsListTableViewCell")
    }
    func fetchDataPromotionList() {
        //load data here
        self.loading.startAnimating()
        self.loading.hidesWhenStopped = true
        APIUtilities.requestPromotionList { [weak self] result, error in
            guard let self = self else { return}

            
            guard let result = result, error == nil else { return }
            self.promotionList = result.promotionList

            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) { [weak self] in
                guard let self = self else { return}
                self.tbvPromotion.reloadData()
                self.loading.stopAnimating()
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
        cell.configureCell(promotion: promotionList?[index])
        cell.viewLine.isHidden = (index == (self.promotionList?.count ?? 0) - 1)
        cell.tapOnBtnShare = {[weak self] (isShare) in
            guard let self = self else { return}
            if isShare {
                /// copy news url to clipboard
                UIPasteboard.general.string = self.promotionList?[index].link
                self.showToast(message: "Copied url to clipboard")
            }
        }
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let promotion = self.promotionList?[indexPath.item] else { return }
        let detailsVC = self.storyboard?.instantiateViewController(withIdentifier: "DetailsViewController") as! DetailsViewController
        if let link = promotion.link {
            detailsVC.url = URL(string: link)
        }
        self.navigationController?.pushViewController(detailsVC, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return Constants.NewsListVC.newsTableCellHeight
    }
}
