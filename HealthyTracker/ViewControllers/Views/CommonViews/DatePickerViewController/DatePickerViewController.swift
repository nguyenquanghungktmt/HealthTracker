//
//  DatePickerViewController.swift
//  HealthyTracker
//
//  Created by pc_1359 on 09/07/2022.
//

import UIKit

final class DatePickerViewController: UIViewController {
    @IBOutlet weak var vPicker: UIView!
    @IBOutlet weak var datePicker: UIDatePicker!
    @IBOutlet weak var btnCancel: UIButton!
    @IBOutlet weak var btnSelect: UIButton!
    
    @IBOutlet weak var lbTitle: UILabel!
    
    var maxDate: Date? = nil
    var minDate: Date? = nil
    
    var toolBarTitle: String? = nil
    var selectDateCallBack : ((_ date: Date) -> (Void))? = nil
    var dismissCallBack : (() -> (Void))? = nil
    
    var tapGesture: UITapGestureRecognizer?
    
    override func viewWillAppear(_ animated: Bool) {
        self.view.transform = CGAffineTransform(translationX: 0, y: -safeAreaInsets.bottom)
    }
    
    @objc func viewTapped() {
        handleDismiss()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        tapGesture = UITapGestureRecognizer(target: self, action: #selector(viewTapped))
        self.view.addGestureRecognizer(tapGesture!)
        self.lbTitle.text = toolBarTitle ?? lbTitle.text
        
        datePicker.maximumDate = maxDate
        datePicker.minimumDate = minDate
    }
    
    func onDateSelect(_ callback: @escaping ((_ date: Date) -> (Void))){
        self.selectDateCallBack = callback
    }
    
    func onDismiss(_ callback: @escaping (() -> (Void))){
        self.dismissCallBack = callback
    }
    
    @IBAction func cancelAction(_ sender: Any) {
        handleDismiss()
    }
    
    @IBAction func selectAction(_ sender: Any) {
        if let selectDateCallBack = self.selectDateCallBack {
            selectDateCallBack(self.datePicker.date)
        }
        handleDismiss()
    }
    
    func handleDismiss() {
        dismiss(animated: true, completion: nil)
        self.dismissCallBack?()
    }
}
