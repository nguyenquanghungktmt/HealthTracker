//
//  DoctorListModel.swift
//  HealthyTracker
//
//  Created by pc_1359 on 02/07/2022.
//

import Foundation

class DoctorListModel: NSObject, JsonInitObject {
    var doctorList : [DoctorModel]?
    
    convenience init(doctorList: [DoctorModel]?) {
        self.init()

        self.doctorList = doctorList
    }
    
    required convenience init(json: [String: Any]) {
        self.init()
        
        if let wrapValue = json["items"] as? [[String: Any]]{
            let jsonValue = wrapValue.map({ DoctorModel(json: $0)})
            self.doctorList = jsonValue
        }
    }
}
