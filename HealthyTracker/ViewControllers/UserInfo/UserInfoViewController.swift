//
//  UserInfoViewController.swift
//  HealthyTracker
//
//  Created by pc_1359 on 06/07/2022.
//

import UIKit

class UserInfoViewController: UIViewController {
    @IBOutlet weak var titleNews: UILabel!
    @IBOutlet weak var txtName: UITextField!
    @IBOutlet weak var txtLastName: UITextField!
    @IBOutlet weak var txtBirthDate: UITextField!
    @IBOutlet weak var txtPhoneNumber: UITextField!
    @IBOutlet weak var txtEmail: UITextField!
    @IBOutlet weak var txtProvince: UITextField!
    @IBOutlet weak var txtDistrict: UITextField!
    @IBOutlet weak var txtWard: UITextField!
    @IBOutlet weak var txtAddress: UITextField!
    @IBOutlet weak var txtBloodType: UITextField!
    
    @IBOutlet weak var btnNext: UIButton!
    
    var userInfo : UserModel?
    var userLocation : LocationModel?

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        txtName.delegate = self
        txtLastName.delegate = self
        txtBirthDate.delegate = self
        txtPhoneNumber.delegate = self
        txtEmail.delegate = self
        loadDataUser()
    }
    
    func loadDataUser(){
        DispatchQueue.main.async {[weak self] in
            guard let self = self else { return}
            self.fetchDataUserInfo()
        }

        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {[weak self] in
            guard let self = self else { return}
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
            
            DispatchQueue.main.async { [weak self] in
                guard let self = self else { return}
                // update ui
                self.txtName.text = self.userInfo?.name
                self.txtLastName.text = self.userInfo?.last_name
                self.txtBirthDate.text = self.userInfo?.birth_date
                self.txtEmail.text = self.userInfo?.contact_email
                self.txtPhoneNumber.text = self.userInfo?.phone
                self.txtAddress.text = self.userInfo?.full_address
                self.txtBloodType.text = self.userInfo?.blood_name
            }
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
                    return
                }
                self.userLocation = result
                DispatchQueue.main.async { [weak self] in
                    guard let self = self else { return}
                    // update ui
                    self.txtProvince.text = self.userLocation?.province_name
                    self.txtDistrict.text = self.userLocation?.district_name
                    self.txtWard.text = self.userLocation?.ward_name
                }
            })
        }

    }

    @IBAction func handleBtnBack(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
}
extension UserInfoViewController: UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        guard let listView = textField.superview?.subviews else { return }
        for view in listView {
            (view.viewWithTag(1) as? UILabel)?.textColor = Constants.Color.greenBold
            view.viewWithTag(3)?.backgroundColor = Constants.Color.greenBold
        }
        
    }
    func textFieldDidEndEditing(_ textField: UITextField) {
        guard let listView = textField.superview?.subviews else { return }
        for view in listView {
            (view.viewWithTag(1) as? UILabel)?.textColor = Constants.Color.grayBold
            view.viewWithTag(3)?.backgroundColor = Constants.Color.grayBold
        }
    }
}
