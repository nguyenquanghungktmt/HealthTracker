//
//  NewsListModel.swift
//  HealthyTracker
//
//  Created by pc_1359 on 01/07/2022.
//

import Foundation

class NewsListModel: NSObject, JsonInitObject {
    var newsList : [NewsModel]?
    
    convenience init(newsList: [NewsModel]?) {
        
        self.init()
        
        self.newsList = newsList
    }
    
    required convenience init(json: [String: Any]) {
        self.init()
        
        if let wrapValue = json["items"] as? [[String: Any]]{
            let jsonValue = wrapValue.map({ NewsModel(json: $0)})
            self.newsList = jsonValue
        }
    }
}
