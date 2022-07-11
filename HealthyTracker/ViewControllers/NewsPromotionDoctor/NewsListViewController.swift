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
    
    lazy var refreshControl: UIRefreshControl = UIRefreshControl()
    
    var newsList: [NewsModel]?

    override func viewDidLoad() {
        super.viewDidLoad()

        setupView()
        register()
        fetchDataNewsList()
    }
    
    func setupView() {
        self.refreshControl.addTarget(self, action: #selector(fetchDataNewsList), for: .valueChanged)
        tbvNews.refreshControl = refreshControl
    }
    
    func register(){
        tbvNews.delegate = self
        tbvNews.dataSource = self
        self.tbvNews.register(UINib(nibName: "NewsListTableViewCell", bundle: nil), forCellReuseIdentifier: "NewsListTableViewCell")
        self.tbvNews.register(UINib(nibName: "FirstNewsListTableViewCell", bundle: nil), forCellReuseIdentifier: "FirstNewsListTableViewCell")
    }
    
    @objc
    func fetchDataNewsList() {
        //load data here
        self.loading.startAnimating()
        APIUtilities.requestNewsList2 { [weak self] result, error in
            guard let self = self else { return}
            self.loading.stopAnimating()
            self.refreshControl.endRefreshing()
            
            guard let result = result, error == nil else {
                self.showToast(message: "Couldn't load data")
                return
            }
            self.newsList = result

            DispatchQueue.main.async { [weak self] in
                guard let self = self else { return}
                self.tbvNews.reloadData()
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
            cell.configureCell(news: newsList?[indexPath.item])
            cell.selectionStyle = .none
            return cell
        }
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "NewsListTableViewCell", for: indexPath) as? NewsListTableViewCell else {
            return UITableViewCell()
        }
        let index = indexPath.item
        cell.selectionStyle = .none
        cell.configureCell(news: newsList?[index],
                           tapOnBtnShare: {[weak self] (isShare) in
                                guard let self = self else { return}
                                if isShare {
                                    /// copy news url to clipboard
                                    UIPasteboard.general.string = self.newsList?[index].link
                                    self.showToast(message: "Copied url to clipboard")
                                }
                           },
                           isLastItem: (index == (self.newsList?.count ?? 0) - 1) )
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let news = self.newsList?[indexPath.item] else { return }
        let detailsVC = self.storyboard?.instantiateViewController(withIdentifier: "DetailsViewController") as! DetailsViewController
        
        if let link = news.link {
            detailsVC.configVC(title: "Chi tiết tin tức", url: URL(string: link))
        }
        self.navigationController?.pushViewController(detailsVC, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return indexPath.item == 0 ? Constants.NewsListVC.firstNewsTableCellHeight : Constants.NewsListVC.newsTableCellHeight
    }
}
