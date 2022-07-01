//
//  PromotionListModel.swift
//  HealthyTracker
//
//  Created by pc_1359 on 01/07/2022.
//

import Foundation

class PromotionListModel: NSObject, JsonInitObject {
    var promotionList : [PromotionModel]?
    
    convenience init(promotionList: [PromotionModel]?) {
        
        self.init()
        
        self.promotionList = promotionList
    }
    
    required convenience init(json: [String: Any]) {
        self.init()
        
        if let wrapValue = json["items"] as? [[String: Any]]{
            let jsonValue = wrapValue.map({ PromotionModel(json: $0)})
            self.promotionList = jsonValue
        }
    }
}
