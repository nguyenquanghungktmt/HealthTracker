//
//  OTPStackViiew.swift
//  HealthyTracker
//
//  Created by pc_1359 on 22/06/2022.
//

import UIKit

class OTPStackView: UIStackView {
    // MARK: UI Components
    private(set) var digitCodes = [OTPTextField]()
    
//    var isValidOTP: (() -> (Bool))? = nil
    var otpValueDidChanged: ((Bool) -> ())? = nil
    
    private lazy var tapGestureRecognizer: UITapGestureRecognizer = {
        let recognizer = UITapGestureRecognizer()
        recognizer.addTarget(self, action: #selector(becomeFirstResponder))
        return recognizer
    }()
    
    
    func configuretionOTPStackView(count: Int) {
        self.translatesAutoresizingMaskIntoConstraints = false
        self.backgroundColor = .clear
        
        for i in 0..<count{
            let textFieldOTP = OTPTextField()
            textFieldOTP.configureTextField()
            textFieldOTP.delegate = self
            textFieldOTP.addTarget(self, action: #selector(tapOnTextField), for: .editingDidBegin)
            self.addArrangedSubview(textFieldOTP)
            digitCodes.append(textFieldOTP)
            i != 0 ? (textFieldOTP.previousTextField = digitCodes[i-1]) : ()
            i != 0 ? (digitCodes[i-1].nextTextField = digitCodes[i]) : ()
        }
    }
    
    func getOTPString() -> String {
        return digitCodes.compactMap({ $0.text}).joined()
    }
    
    @objc
    func tapOnTextField(otpTextField: OTPTextField){
        if otpTextField.text?.isEmpty == true {return}
        let index = digitCodes.firstIndex(of: otpTextField) as Any
        for i in (index as! Int)..<digitCodes.count{ digitCodes[i].text = "" }
    }

    func isValidOTP(otp: String) -> Bool{
        let otpRegex = "^[0-9]{6}$"
        let otpTest = NSPredicate(format: "SELF MATCHES %@", otpRegex)
        return otpTest.evaluate(with: otp)
    }
}

extension OTPStackView: UITextFieldDelegate{
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        guard let otpTextField = textField as? OTPTextField else {
            return false
        }
        if string.isEmpty == false {
            otpTextField.text = string
            otpTextField.nextTextField?.becomeFirstResponder()
            return false
        }
        return true
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        textField.layer.borderColor = Constants.Color.greenBold.cgColor
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        textField.layer.borderColor = Constants.Color.greenExtraLight.cgColor
    }
    func textFieldDidChangeSelection(_ textField: UITextField) {
        otpValueDidChanged?(isValidOTP(otp: getOTPString()))
    }
}

class OTPTextField: UITextField{
    weak var previousTextField: UITextField?
    weak var nextTextField: UITextField?
    
    func configureTextField(){
        self.bounds = CGRect(x: 0, y: 0, width: 42, height: 36)
        self.setColorCornerRadius(color: .white, radius: 8)
        self.setBorder(color: Constants.Color.greenExtraLight.cgColor, width: 1)
        self.textAlignment = .center
        self.textColor = .black
        self.tintColor = Constants.Color.greenBold
        self.keyboardType = .numberPad
        self.textContentType = .oneTimeCode
    }
    
    override func deleteBackward() {
        self.text = ""
        self.previousTextField?.becomeFirstResponder()
    }
}
