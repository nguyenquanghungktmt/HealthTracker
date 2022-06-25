//
//  HomeViewController.swift
//  HealthyTracker
//
//  Created by pc_1359 on 23/06/2022.
//

import UIKit

class HomeViewController: UIViewController {
    @IBOutlet weak var lbUsername: UILabel!
    @IBOutlet weak var lbStatus: UILabel!
    
    @IBOutlet weak var tbvNews: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
        
        tbvNews.delegate = self
        tbvNews.dataSource = self
        self.tbvNews.register(UINib(nibName: "NewsTableViewCell", bundle: nil), forCellReuseIdentifier: "NewsTableViewCell")
    }
    
    func setupView(){
        lbUsername.text = "Quỳnh Ken"
        lbStatus.text = "Đang hoạt động"
        
        tbvNews.roundCorners([.topLeft, .topRight], radius: 20)
    }

    @IBAction func hadleBtnViewAll(_ sender: UIButton) {
        print("Touch BTN View All")
    }
}
extension HomeViewController: UITableViewDelegate, UITableViewDataSource, UICollectionViewDelegateFlowLayout{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let newsCell = tableView.dequeueReusableCell(withIdentifier: "NewsTableViewCell", for: indexPath) as? NewsTableViewCell else {
            return UITableViewCell()
        }
        
        return newsCell
    }
    
    
}
