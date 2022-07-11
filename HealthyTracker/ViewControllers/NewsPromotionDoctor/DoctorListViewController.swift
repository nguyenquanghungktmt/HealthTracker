//
//  DoctorListViewController.swift
//  HealthyTracker
//
//  Created by pc_1359 on 30/06/2022.
//

import UIKit

class DoctorListViewController: UIViewController {
    @IBOutlet weak var tbvDoctor: UITableView!
    @IBOutlet weak var loading: UIActivityIndicatorView!
    
    lazy var refreshControl: UIRefreshControl =  UIRefreshControl()
    
    var doctorList: [DoctorModel]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
        register()
        fetchDataDoctorList()
    }
    
    func setupView(){
        tbvDoctor.rowHeight = UITableView.automaticDimension
        tbvDoctor.estimatedRowHeight = Constants.DoctorListVC.estimateDoctorTableCellHeight
        
        self.refreshControl.addTarget(self, action: #selector(fetchDataDoctorList), for: .valueChanged)
        tbvDoctor.refreshControl = refreshControl
    }
    
    func register(){
        tbvDoctor.delegate = self
        tbvDoctor.dataSource = self
        self.tbvDoctor.register(UINib(nibName: "DoctorListTableViewCell", bundle: nil), forCellReuseIdentifier: "DoctorListTableViewCell")
    }
    
    @objc
    func fetchDataDoctorList() {
        //load data here
        self.loading.startAnimating()
        APIUtilities.requestDoctorList2 { [weak self] result, error in
            guard let self = self else { return}
            self.loading.stopAnimating()
            self.refreshControl.endRefreshing()
            
            guard let result = result, error == nil else {
                self.showToast(message: "Couldn't load data")
                return
            }
            self.doctorList = result

            DispatchQueue.main.async { [weak self] in
                guard let self = self else { return}
                self.tbvDoctor.reloadData()
            }
        }
    }
    
    @IBAction func handleBtnBack(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
}
extension DoctorListViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.doctorList?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "DoctorListTableViewCell", for: indexPath) as? DoctorListTableViewCell else {
            return UITableViewCell()
        }
        let index = indexPath.item
        cell.configureCell(doctor: doctorList?[index])
        return cell
    }

}
