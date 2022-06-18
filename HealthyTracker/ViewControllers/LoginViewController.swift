//
//  LoginViewController.swift
//  HealthyTracker
//
//  Created by pc_1359 on 17/06/2022.
//

import UIKit

class LoginViewController: UIViewController {
    @IBOutlet weak var vEnterPhoneNumber: UIView!
    @IBOutlet weak var vHotline: UIView!
    @IBOutlet weak var txtEnterPhoneNumber: UITextField!
    @IBOutlet weak var txtHotlineNumber: UILabel!
    @IBOutlet weak var btnNext: UIButton!
    @IBOutlet weak var btnBack: UIButton!
    @IBOutlet weak var btnLanguage: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        print("Login")
        setupView()
    }
    
    func setupView(){
        btnBack.layer.cornerRadius = 16
        btnBack.backgroundColor = Constants.Color.grayLight
        btnLanguage.layer.cornerRadius = 16
        btnLanguage.backgroundColor = Constants.Color.grayLight
        
        vEnterPhoneNumber.layer.cornerRadius = 28
        vEnterPhoneNumber.layer.borderWidth = 1
        vEnterPhoneNumber.layer.borderColor = Constants.Color.greenBold.cgColor
        vEnterPhoneNumber.layer.shadowRadius = 8
        vEnterPhoneNumber.layer.shadowOpacity = 0.1
        
        btnNext.setTitleColor(.white, for: .normal)
        btnNext.layer.cornerRadius = 24
        btnNext.backgroundColor = Constants.Color.greenLight
        
        vHotline.layer.cornerRadius = 24
        vHotline.backgroundColor = Constants.Color.greenExtraLight
        txtHotlineNumber.textColor = Constants.Color.greenBold
        
        txtEnterPhoneNumber.addTarget(self, action: #selector(textFieldEditChanged(_:)), for: .editingChanged)
    }
    
    @IBAction func handleBtnBackAction(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func handleBtnLanguageAction(_ sender: UIButton) {
    }
    
    @IBAction func handleBtnNextAction(_ sender: UIButton) {
    }
    
    func isValidPhone(phone: String) -> Bool {
        let phone9NumberRegex = "^[1-9]{1}+[0-9]{8}$"
        let phone10NumberRegex = "^[0]+[0-9]{9}$"
        let phone9NumberTest = NSPredicate(format: "SELF MATCHES %@", phone9NumberRegex)
        let phone10NumberTest = NSPredicate(format: "SELF MATCHES %@", phone10NumberRegex)
        return phone9NumberTest.evaluate(with: phone) || phone10NumberTest.evaluate(with: phone)
    }
        
    @objc func textFieldEditChanged(_ textField: UITextField) {
        let phoneNumber = txtEnterPhoneNumber.text ?? ""
        updateBtnNext(isEnable: isValidPhone(phone: phoneNumber))
    }
    
    func updateBtnNext(isEnable: Bool) {
        self.btnNext.isEnabled = isEnable
        self.btnNext.backgroundColor = isEnable ? Constants.Color.greenBold : Constants.Color.greenLight
    }
}

extension LoginViewController: UITextFieldDelegate{
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        vEnterPhoneNumber.layer.borderColor = Constants.Color.greenBold.cgColor
        return true
    }
    
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        vEnterPhoneNumber.layer.borderColor = Constants.Color.greenExtraLight.cgColor
        return true
    }
}
