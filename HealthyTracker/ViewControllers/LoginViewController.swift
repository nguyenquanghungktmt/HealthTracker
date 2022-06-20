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

        setupView()
    }
    
    func setupView(){
        txtEnterPhoneNumber.delegate = self
        
//        btnBack.backgroundColor = Constants.Color.grayLight
//        btnLanguage.backgroundColor = Constants.Color.grayLight
//
//        vEnterPhoneNumber.layer.borderColor = Constants.Color.borderGray.cgColor
//
//        btnNext.backgroundColor = Constants.Color.greenLight
//
//        vHotline.backgroundColor = Constants.Color.greenExtraLight
//        txtHotlineNumber.textColor = Constants.Color.greenBold
        
        txtEnterPhoneNumber.addTarget(self, action: #selector(textFieldEditChanged(_:)), for: .editingChanged)
    }
    
    @IBAction func handleBtnBackAction(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func handleBtnLanguageAction(_ sender: UIButton) {
    }
    
    @IBAction func handleBtnNextAction(_ sender: UIButton) {
        let verifyVC = self.storyboard?.instantiateViewController(withIdentifier: "OTPVerifyViewController") as! OTPVerifyViewController
        self.navigationController?.pushViewController(verifyVC, animated: true)
    }

    /// Check valid phone number using regex
    func isValidPhoneNumber(phone: String) -> Bool {
        let phoneRegex = "^(0?)[1-9]{1}+[0-9]{8}$"
        let phoneTest = NSPredicate(format: "SELF MATCHES %@", phoneRegex)
        return phoneTest.evaluate(with: phone)
    }
        
    @objc func textFieldEditChanged(_ textField: UITextField) {
        let phoneNumber = txtEnterPhoneNumber.text ?? ""
        updateBtnNext(isEnable: isValidPhoneNumber(phone: phoneNumber))
    }
    
    func updateBtnNext(isEnable: Bool) {
        self.btnNext.isEnabled = isEnable
        self.btnNext.backgroundColor = isEnable ? Constants.Color.greenBold : Constants.Color.greenLight
    }
}

extension LoginViewController: UITextFieldDelegate{
    func textFieldDidBeginEditing(_ textField: UITextField) {
        vEnterPhoneNumber.layer.borderColor = Constants.Color.greenBold.cgColor
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        vEnterPhoneNumber.layer.borderColor = Constants.Color.greenExtraLight.cgColor
    }
}
