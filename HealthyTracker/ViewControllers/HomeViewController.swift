//
//  HomeViewController.swift
//  HealthyTracker
//
//  Created by pc_1359 on 23/06/2022.
//

import UIKit

class HomeViewController: UIViewController {
    @IBOutlet weak var lbNews: UILabel!
    @IBOutlet weak var btnViewAll: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
    }
    
    func setupView(){
        lbNews.text = "Tin Tức"

        btnViewAll.setTitle("Xem tất cả", for: .normal)
        btnViewAll.imageToRight()
        btnViewAll.contentEdgeInsets = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10)
        btnViewAll.imageEdgeInsets = UIEdgeInsets(top: 5, left: -10, bottom: 5, right: 0)
    }

    @IBAction func hadleBtnViewAll(_ sender: UIButton) {
        print("Touch BTN View All")
    }
}
