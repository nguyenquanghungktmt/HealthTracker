//
//  LocationModel.swift
//  HealthyTracker
//
//  Created by pc_1359 on 06/07/2022.
//

import Foundation

class LocationModel: NSObject, JsonInitObject  {
    var province_name   : String?
    var district_name   : String?
    var ward_name       : String?
    
    convenience init(province_name  : String?,
                     district_name  : String?,
                     ward_name      : String?) {
        self.init()

        self.province_name = province_name
        self.district_name = district_name
        self.ward_name = ward_name
    }
    
    required convenience init(json: [String: Any]) {
        self.init()
        
        if let wrapValue = json["province_name"] as? String {
            self.province_name = wrapValue
        }

        if let wrapValue = json["district_name"] as? String {
            self.district_name = wrapValue
        }

        if let wrapValue = json["ward_name"] as? String {
            self.ward_name = wrapValue
        }
    }
}
