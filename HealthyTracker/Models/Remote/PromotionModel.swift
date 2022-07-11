//
//  PromotionListModel.swift
//  HealthyTracker
//
//  Created by pc_1359 on 29/06/2022.
//

import Foundation

class PromotionModel: NSObject, JsonInitObject {
    var id     : Int?
    var category_id     : Int?
    var code     : String?
    var amount     : Int?
    var amount_text     : String?
    var category_name     : String?
    var content     : String?
    var created_at     : String?
    var from_date     : String?
    var to_date     : String?
    var is_bookmark     : Bool?
    var kind     : Int?
    var link     : String?
    var name     : String?
    var picture     : String?
    var slug     : String?
    var type     : Int?

    convenience init(amount: Int?,
                            amount_text: String?,
                            category_id: Int?,
                            category_name: String?,
                            code: String?,
                            content: String?,
                            created_at: String?,
                            from_date: String?,
                            id: Int?,
                            is_bookmark: Bool?,
                            kind: Int?,
                            link: String?,
                            name: String?,
                            picture: String?,
                            slug: String?,
                            to_date: String?,
                            type: Int?) {
        self.init()
        
        self.amount = amount
        self.amount_text = amount_text
        self.category_id = category_id
        self.category_name = category_name
        self.code = code
        self.content = content
        self.created_at = created_at
        self.from_date = from_date
        self.id = id
        self.is_bookmark = is_bookmark
        self.kind = kind
        self.link = link
        self.name = name
        self.picture = picture
        self.slug = slug
        self.to_date = to_date
        self.type = type
    }


    required convenience init(json: [String: Any]) {
        self.init()
        
        if let wrapValue = json["amount"] as? Int {
            self.amount = wrapValue
        }
        if let wrapValue = json["amount_text"] as? String {
            self.amount_text = wrapValue
        }
        if let wrapValue = json["category_id"] as? Int {
            self.category_id = wrapValue
        }
        if let wrapValue = json["category_name"] as? String {
            self.category_name = wrapValue
        }
        if let wrapValue = json["code"] as? String {
            self.code = wrapValue
        }
        if let wrapValue = json["content"] as? String {
            self.content = wrapValue
        }
        if let wrapValue = json["created_at"] as? String {
            self.created_at = wrapValue
        }
        if let wrapValue = json["from_date"] as? String {
            self.from_date = wrapValue
        }
        if let wrapValue = json["id"] as? Int {
            self.id = wrapValue
        }
        if let wrapValue = json["is_bookmark"] as? Bool {
            self.is_bookmark = wrapValue
        }
        if let wrapValue = json["kind"] as? Int {
            self.kind = wrapValue
        }
        if let wrapValue = json["link"] as? String {
            self.link = wrapValue
        }
        if let wrapValue = json["name"] as? String {
            self.name = wrapValue
        }
        if let wrapValue = json["picture"] as? String {
            self.picture = wrapValue
        }
        if let wrapValue = json["slug"] as? String {
            self.slug = wrapValue
        }
        if let wrapValue = json["to_date"] as? String {
            self.to_date = wrapValue
        }
        if let wrapValue = json["type"] as? Int {
            self.type = wrapValue
        }
    }
}
