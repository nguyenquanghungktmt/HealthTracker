//
//  OTPVerifyViewController.swift
//  HealthyTracker
//
//  Created by pc_1359 on 20/06/2022.
//

import UIKit

class OTPVerifyViewController: UIViewController {
    @IBOutlet weak var btnBack: UIButton!
    @IBOutlet weak var btnNext: UIButton!
    @IBOutlet weak var btnResendOTP: UIButton!
    
    @IBOutlet weak var lbTitleBar: UILabel!
    @IBOutlet weak var lbTypeOTPCode: UILabel!
    @IBOutlet weak var lbTypeWrongOTP: UILabel!
    @IBOutlet weak var viewResendOTP: UIView!
    
    @IBOutlet weak var stackOTPCode: OTPStackView!
    
    // MARK: UI Components
    private(set) var digitCodes = [UITextField]()
    
    var phoneNumber: String?
    let OTPCount = 6
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(_:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(_:)), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    func setupView(){
        btnNext.setTitle("Tiếp Tục", for: .normal)
        btnResendOTP.setTitle("Gửi lại mã sau 60s", for: .normal)
        updateBtnNext(isEnable: false)
        
        lbTitleBar.text = "Xác minh số điện thoại"
        
        let attributedString = NSMutableAttributedString(string: "Vui lòng nhập mã gồm \(OTPCount) chữ số đã được gửi đến bạn vào số điện thoại ")
        let boldString = NSMutableAttributedString(string: phoneNumber ?? "",
                                                   attributes:[ .font: UIFont(name: Constants.Font.bold, size: 14) as Any] )
        attributedString.append(boldString)
        lbTypeOTPCode.attributedText = attributedString
        
        lbTypeWrongOTP.isHidden = true		
        
        // add text box OTP to stack
        stackOTPCode.configuretionOTPStackView(count: 6)
        stackOTPCode.otpValueDidChanged = {[weak self] (result) in
            self?.updateBtnNext(isEnable: result)
        }
        
    }

    @IBAction func handleBtnBackAction(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func handleBtnNextAction(_ sender: UIButton) {
        if self.stackOTPCode.getOTPString() == "111111" {
            /// Enter right OTP Code
            /// Move to Home VC
        }
        else {
            /// Display error notice
            lbTypeWrongOTP.text = "Nhập sai mã xác thực"
            lbTypeWrongOTP.isHidden = false
        }
    }

    @IBAction func handleBtnResendOTP(_ sender: UIButton) {
        print("Touch on Button")
    }
    
    @objc func keyboardWillShow(_ notification: Notification) {
        guard let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue else { return }
        let duration = (notification.userInfo?[UIResponder.keyboardAnimationDurationUserInfoKey] as? Double) ?? 0

        UIView.animate(withDuration: duration) {[weak self] in
            guard let self = self else { return}
            self.btnNext.transform = CGAffineTransform(translationX: 0, y: -keyboardSize.height + self.safeAreaInsets.bottom)
        }
    }
    
    @objc func keyboardWillHide(_ notification: Notification) {
        let duration = (notification.userInfo?[UIResponder.keyboardAnimationDurationUserInfoKey] as? Double) ?? 0
        UIView.animate(withDuration: duration) {[weak self] in
            guard let self = self else { return}
            self.btnNext.transform = .identity
        }
    }
    
    func updateBtnNext(isEnable: Bool) {
        self.btnNext.isEnabled = isEnable
        self.btnNext.backgroundColor = isEnable ? Constants.Color.greenBold : Constants.Color.greenLight
    }
}
