//
//  PromotionListViewController.swift
//  HealthyTracker
//
//  Created by pc_1359 on 30/06/2022.
//

import UIKit

class PromotionListViewController: UIViewController {
    @IBOutlet weak var tbvPromotion: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        print("Promotion list")
        register()
    }
    
    func register(){
        tbvPromotion.delegate = self
        tbvPromotion.dataSource = self
        self.tbvPromotion.register(UINib(nibName: "PromotionListTableViewCell", bundle: nil), forCellReuseIdentifier: "PromotionListTableViewCell")
    }
}
extension PromotionListViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 6
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "PromotionListTableViewCell", for: indexPath) as? PromotionListTableViewCell else {
            return UITableViewCell()
        }
        return cell
            
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 102
    }
}
