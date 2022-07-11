//
//  NewsModel.swift
//  HealthyTracker
//
//  Created by pc_1359 on 01/07/2022.
//

import Foundation

class NewsModel: NSObject, JsonInitObject{
    var id: Int?
    var category_id: Int?
    var title : String?
    var summary : String?
    var content : String?
    var slug : String?
    var picture : String?
    var picture_caption : String?
    var created_at : String?
    var category_name : String?
    var link : String?
    
    
    convenience init(id: Int?,
                     category_id: Int?,
                     category_name: String?,
                     summary : String?,
                     content : String?,
                     created_at: String?,
                     link: String?,
                     picture: String?,
                     picture_caption: String?,
                     slug: String?,
                     title: String?) {
        self.init()
        
        self.id = id
        self.category_id = category_id
        self.category_name = category_name
        self.created_at = created_at
        self.link = link
        self.picture = picture
        self.picture_caption = picture_caption
        self.slug = slug
        self.title = title
        self.content = content
        self.summary = summary
    }
    
    required convenience init(json: [String: Any]) {
        self.init()
        
        if let wrapValue = json["category_id"] as? Int {
            self.category_id = wrapValue
        }
        if let wrapValue = json["category_name"] as? String {
            self.category_name = wrapValue
        }
        if let wrapValue = json["created_at"] as? String {
            self.created_at = wrapValue
        }
        if let wrapValue = json["id"] as? Int {
            self.id = wrapValue
        }
        if let wrapValue = json["link"] as? String {
            self.link = wrapValue
        }
        if let wrapValue = json["picture"] as? String {
            self.picture = wrapValue
        }
        if let wrapValue = json["picture_caption"] as? String {
            self.picture_caption = wrapValue
        }
        if let wrapValue = json["slug"] as? String {
            self.slug = wrapValue
        }
        if let wrapValue = json["title"] as? String {
            self.title = wrapValue
        }
        if let wrapValue = json["content"] as? String {
            self.content = wrapValue
        }
        if let wrapValue = json["summary"] as? String {
            self.summary = wrapValue
        }
    }
}
