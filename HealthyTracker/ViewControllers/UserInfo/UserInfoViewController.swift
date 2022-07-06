//
//  UserInfoViewController.swift
//  HealthyTracker
//
//  Created by pc_1359 on 06/07/2022.
//

import UIKit

class UserInfoViewController: UIViewController {
    
    var userInfo : UserModel?
    var userLocation : LocationModel?

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        loadDataUser()
    }
    
    func loadDataUser(){
        let queue = DispatchQueue(label: "queue")
        queue.async {
            self.fetchDataUserInfo()
        }
        queue.async {
            self.fetchDataUserLocation()
        }
    }
    
    func fetchDataUserInfo() {
        APIUtilities.requestUserInfo { [weak self] result, error in
            guard let self = self else { return}
            
            guard let result = result, error == nil else {
//                self.loading.stopAnimating()
                self.showToast(message: "Couldn't load user information")
                return
            }
            self.userInfo = result
            print(result as Any)
        }
    }
    
    func fetchDataUserLocation() {
        /// Load data user location
        if let province_code = self.userInfo?.province_code,
           let district_code = self.userInfo?.district_code,
           let ward_code = self.userInfo?.ward_code {
            APIUtilities.requestLocation(province_code: province_code, district_code: district_code, ward_code: ward_code, completionHandler: { [weak self] result, error in
                guard let self = self else { return}
                
                guard let result = result, error == nil else {
//                    self.loading.stopAnimating()
                    self.showToast(message: "Couldn't load user location")
                    return
                }
                self.userLocation = result
                print(result as Any)
            })
        }
        else {
            self.showToast(message: "Couldn't load user location (have nill parameter)")
        }
    }

    @IBAction func handleBtnBack(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
}
