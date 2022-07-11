//
//  UserInfoViewController.swift
//  HealthyTracker
//
//  Created by pc_1359 on 06/07/2022.
//

import UIKit
import IQKeyboardManagerSwift

class UserInfoViewController: UIViewController {
    @IBOutlet weak var scrollViewUser: UIScrollView!
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
    @IBOutlet weak var loading: UIActivityIndicatorView!
    
    
    @IBOutlet weak var lbMale: UILabel!
    @IBOutlet weak var lbFemale: UILabel!
    @IBOutlet weak var imgFemale: UIImageView!
    @IBOutlet weak var imgMale: UIImageView!
    
    @IBOutlet weak var scGender: UISegmentedControl!
    
    @IBOutlet weak var btnNext: UIButton!
    
    var userInfo : UserModel?
    var userLocation : LocationModel?
    
    lazy var refreshControl: UIRefreshControl = UIRefreshControl()

    override func viewDidLoad() {
        super.viewDidLoad()

        register()
        setupView()
        loadDataUser()
    }
    
    func register() {
        /// set delegate for text fields
        txtName.delegate = self
        txtLastName.delegate = self
        txtBirthDate.delegate = self
        txtPhoneNumber.delegate = self
        txtEmail.delegate = self
    }
    
    func setupView(){
        self.refreshControl.addTarget(self, action: #selector(loadDataUser), for: .valueChanged)
        self.scrollViewUser.refreshControl = refreshControl
        
        self.setFocusSegmentControl(isSelected: true, label: self.lbMale, image: self.imgMale)
        self.setFocusSegmentControl(isSelected: false, label: self.lbFemale, image: self.imgFemale)
        
        IQKeyboardManager.shared.previousNextDisplayMode = .alwaysShow
    }
    
    @objc
    func loadDataUser(){
        self.loading.startAnimating()
        DispatchQueue.main.async {[weak self] in
            guard let self = self else { return}
            self.fetchDataUserInfo()
        }
    }
    
    func fetchDataUserInfo() {
        /// Load data user Information
        APIUtilities.requestUserInfo { [weak self] result, error in
            guard let self = self else { return}
            
            guard let result = result, error == nil else {
                self.loading.stopAnimating()
                self.refreshControl.endRefreshing()
                self.showToast(message: "Couldn't load user information")
                return
            }
            self.userInfo = result
            
            /// Continue to load data user location
            self.fetchDataUserLocation()
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
                    self.loading.stopAnimating()
                    self.refreshControl.endRefreshing()
                    self.showToast(message: "Couldn't load user location")
                    return
                }
                self.userLocation = result
                
                /// Update data to UI
                self.updateUIData()
            })
        }

    }
    
    func updateUIData() {
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return}
            self.loading.stopAnimating()
            self.refreshControl.endRefreshing()
            
            // update ui
            self.txtName.text = self.userInfo?.name
            self.txtLastName.text = self.userInfo?.last_name
            self.txtBirthDate.text = self.userInfo?.birth_date
            self.txtEmail.text = self.userInfo?.contact_email
            self.txtPhoneNumber.text = self.userInfo?.phone
            self.txtAddress.text = self.userInfo?.address
            self.txtBloodType.text = self.userInfo?.blood_name
            
            if let gender = self.userInfo?.sex {
                self.scGender.selectedSegmentIndex = (gender == 1 ? 0 : 1)
                self.setFocusGender(isMale: gender == 1)
            }
            
            // update ui for user location
            self.txtProvince.text = self.userLocation?.province_name
            self.txtDistrict.text = self.userLocation?.district_name
            self.txtWard.text = self.userLocation?.ward_name
            
            // update BtnNext
            self.updateBtnNext(isEnable: self.isFullFields())
        }
    }
    
    @IBAction func genderDidChange(_ sender: UISegmentedControl) {
        self.setFocusGender(isMale: sender.selectedSegmentIndex == 0)
    }
    

    @IBAction func handleBtnBack(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func handleBtnNext(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
}
extension UserInfoViewController: UITextFieldDelegate {
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        // highlight title and line
        guard let listView = textField.superview?.subviews else { return false}
        for view in listView {
            (view.viewWithTag(1) as? UILabel)?.textColor = Constants.Color.greenBold
            view.viewWithTag(3)?.backgroundColor = Constants.Color.greenBold
        }
        
        // date picker for Date textfield
        if textField.tag == 4{
            
            self.view.endEditing(true)
            let datePicker = DatePickerViewController()
            datePicker.modalPresentationStyle = .overFullScreen
            self.present(datePicker, animated: true, completion: nil)
            datePicker.selectDateCallBack = { date in
                let dateFormatter = DateFormatter()
                dateFormatter.dateFormat = "dd/MM/YYYY"
                // set date to text field
                textField.text = dateFormatter.string(from: date)
            }
            return false
        }
        
        return true
    }
    
//    func textFieldDidBeginEditing(_ textField: UITextField) {
//        guard let listView = textField.superview?.subviews else { return }
//        for view in listView {
//            (view.viewWithTag(1) as? UILabel)?.textColor = Constants.Color.greenBold
//            view.viewWithTag(3)?.backgroundColor = Constants.Color.greenBold
//        }
//
//    }
    func textFieldDidEndEditing(_ textField: UITextField) {
        guard let listView = textField.superview?.subviews else { return }
        for view in listView {
            (view.viewWithTag(1) as? UILabel)?.textColor = Constants.Color.grayBold
            view.viewWithTag(3)?.backgroundColor = Constants.Color.grayBold
        }
        updateBtnNext(isEnable: self.isFullFields())
    }
}
extension UserInfoViewController {
    func setFocusSegmentControl(isSelected: Bool?, label: UILabel?, image: UIImageView?){
        if let isSelected = isSelected {
            label?.textColor = isSelected ? Constants.Color.greenBold : .black
            image?.tintColor = isSelected ? Constants.Color.greenBold : .black
        }
    }
    
    func setFocusGender(isMale: Bool) {
        self.setFocusSegmentControl(isSelected: isMale, label: self.lbMale, image: self.imgMale)
        self.setFocusSegmentControl(isSelected: !isMale, label: self.lbFemale, image: self.imgFemale)
    }
    
    func isFullFields() -> Bool{
        return !(self.txtName.text == "" || self.txtLastName.text == "" || self.txtBirthDate.text == "")
    }
    
    func updateBtnNext(isEnable: Bool) {
        self.btnNext.isEnabled = isEnable
        self.btnNext.backgroundColor = isEnable ? Constants.Color.greenBold : Constants.Color.greenLight
    }
}
