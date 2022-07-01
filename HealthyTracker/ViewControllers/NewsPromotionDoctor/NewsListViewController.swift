//
//  NewsListViewController.swift
//  HealthyTracker
//
//  Created by pc_1359 on 30/06/2022.
//

import UIKit

class NewsListViewController: UIViewController {
    @IBOutlet weak var tbvNews: UITableView!
    @IBOutlet weak var loading: UIActivityIndicatorView!
    
    var newsList: [NewsModel]?

    override func viewDidLoad() {
        super.viewDidLoad()

        register()
        fetchDataPromotionList()
    }
    
    func register(){
        tbvNews.delegate = self
        tbvNews.dataSource = self
        self.tbvNews.register(UINib(nibName: "NewsListTableViewCell", bundle: nil), forCellReuseIdentifier: "NewsListTableViewCell")
        self.tbvNews.register(UINib(nibName: "FirstNewsListTableViewCell", bundle: nil), forCellReuseIdentifier: "FirstNewsListTableViewCell")
    }
    func fetchDataPromotionList() {
        //load data here
        self.loading.startAnimating()
        self.loading.hidesWhenStopped = true
        APIUtilities.requestNewsList { [weak self] result, error in
            guard let self = self else { return}

            
            guard let result = result, error == nil else { return }
            self.newsList = result.newsList

            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) { [weak self] in
                guard let self = self else { return}
                self.tbvNews.reloadData()
                self.loading.stopAnimating()
            }
        }
    }
    
    
    @IBAction func handleBtnBack(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
}
extension NewsListViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.newsList?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.item == 0 {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "FirstNewsListTableViewCell", for: indexPath) as? FirstNewsListTableViewCell else {
                return UITableViewCell()
            }
            let index = indexPath.item
            cell.configureCell(news: newsList?[index])
            return cell
        }
        
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "NewsListTableViewCell", for: indexPath) as? NewsListTableViewCell else {
            return UITableViewCell()
        }
        
        let index = indexPath.item
        cell.configureCell(news: newsList?[index])
        cell.viewLine.isHidden = (index == (self.newsList?.count ?? 0) - 1)
        cell.tapOnBtnShare = {[weak self] (isShare) in
            guard let self = self else { return}
            if isShare {
                /// copy news url to clipboard
                UIPasteboard.general.string = self.newsList?[index].link
                self.showToast(message: "Copied url to clipboard")
            }
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return indexPath.item == 0 ? 300 : Constants.NewsListVC.tableNewsCellHeight
    }
}
