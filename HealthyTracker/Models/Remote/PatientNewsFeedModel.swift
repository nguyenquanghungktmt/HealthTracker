//
//  PatientNewsFeedModel.swift
//  HealthyTracker
//
//  Created by pc_1359 on 29/06/2022.
//

import Foundation

class PatientNewsFeedModel: NSObject, JsonInitObject {
    var newsList : [NewsModel]?
    var promotionList : [PromotionModel]?
    var doctorList : [DoctorModel]?
    
    convenience init(newsList: [NewsModel]?,
                     doctorList: [DoctorModel]?,
                     promotionList: [PromotionModel]?) {
        
        self.init()
        
        self.newsList = newsList
        self.doctorList = doctorList
        self.promotionList = promotionList
    }
    
    required convenience init(json: [String: Any]) {
        self.init()
        
        if let wrapValue = json["articleList"] as? [[String: Any]]{
            let jsonValue = wrapValue.map({ NewsModel(json: $0)})
            self.newsList = jsonValue
        }
        if let wrapValue = json["doctorList"] as? [[String: Any]]{
            let jsonValue = wrapValue.map({ DoctorModel(json: $0)})
            self.doctorList = jsonValue
        }
        if let wrapValue = json["promotionList"] as? [[String: Any]]{
            let jsonValue = wrapValue.map({ PromotionModel(json: $0)})
            self.promotionList = jsonValue
        }
    }
}
