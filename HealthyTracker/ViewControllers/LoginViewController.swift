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
    @IBOutlet weak var btnNationPhoneCode: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupView()
    }
    
    func setupView(){
        txtEnterPhoneNumber.delegate = self
        txtEnterPhoneNumber.addTarget(self, action: #selector(textFieldEditChanged(_:)), for: .editingChanged)
    }
    
    @IBAction func handleBtnBackAction(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func handleBtnLanguageAction(_ sender: UIButton) {
    }
    
    @IBAction func handleBtnNextAction(_ sender: UIButton) {
        let nationCode = self.btnNationPhoneCode.currentTitle ?? ""
        let phoneNumber = self.txtEnterPhoneNumber.text ?? ""
        let numberEditted = "\(nationCode) \(splitPhoneNumber(number: phoneNumber))"
        
        let verifyVC = self.storyboard?.instantiateViewController(withIdentifier: "OTPVerifyViewController") as! OTPVerifyViewController
        verifyVC.phoneNumber = numberEditted
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
    
    func splitPhoneNumber(number:String) -> String {
        var numberString = number.trimmingCharacters(in: .whitespacesAndNewlines)
        if numberString.first == "0", numberString.count > 9 {
            numberString.removeFirst()
        }
        
        let numberArray = numberString.components(withMaxLength: 3)
        return numberArray.joined(separator:" ")
    }
}

extension LoginViewController: UITextFieldDelegate{
    func textFieldDidBeginEditing(_ textField: UITextField) {
        vEnterPhoneNumber.layer.borderColor = Constants.Color.greenBold.cgColor
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        vEnterPhoneNumber.layer.borderColor = Constants.Color.grayLight.cgColor
    }
}
extension String {
    func components(withMaxLength length: Int) -> [String] {
        return stride(from: 0, to: self.count, by: length).map {
            let start = self.index(self.startIndex, offsetBy: $0)
            let end = self.index(start, offsetBy: length, limitedBy: self.endIndex) ?? self.endIndex
            return String(self[start..<end])
        }
    }
}
