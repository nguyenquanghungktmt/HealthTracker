//
//  DoctorListModel.swift
//  HealthyTracker
//
//  Created by pc_1359 on 29/06/2022.
//

import Foundation

class DoctorModel {
    var avatar     : String?
    var contact_email     : String?
    var full_name     : String?
    var id     : Int?
    var last_name     : String?
    var majors_name     : String?
    var name     : String?
    var number_of_reviews     : Int?
    var number_of_stars     : Int?
    var phone     : String?
    var ratio_star     : Double?
    
    convenience init(avatar: String?,
                     contact_email: String?,
                     full_name: String?,
                     id: Int?,
                     last_name: String?,
                     majors_name: String?,
                     name: String?,
                     number_of_reviews: Int?,
                     number_of_stars: Int?,
                     phone: String?,
                     ratio_star: Double?) {
        self.init()
        
        self.avatar = avatar
        self.contact_email = contact_email
        self.full_name = full_name
        self.id = id
        self.last_name = last_name
        self.majors_name = majors_name
        self.name = name
        self.number_of_reviews = number_of_reviews
        self.number_of_stars = number_of_stars
        self.phone = phone
        self.ratio_star = ratio_star
    }
    
    
    convenience init(json: [String: Any]) {
        self.init()
        
        if let wrapValue = json["avatar"] as? String {
            self.avatar = wrapValue
        }
        if let wrapValue = json["contact_email"] as? String {
            self.contact_email = wrapValue
        }
        if let wrapValue = json["full_name"] as? String {
            self.full_name = wrapValue
        }
        if let wrapValue = json["id"] as? Int {
            self.id = wrapValue
        }
        if let wrapValue = json["last_name"] as? String {
            self.last_name = wrapValue
        }
        if let wrapValue = json["majors_name"] as? String {
            self.majors_name = wrapValue
        }
        if let wrapValue = json["name"] as? String {
            self.name = wrapValue
        }
        if let wrapValue = json["number_of_reviews"] as? Int {
            self.number_of_reviews = wrapValue
        }
        if let wrapValue = json["number_of_stars"] as? Int {
            self.number_of_stars = wrapValue
        }
        if let wrapValue = json["phone"] as? String {
            self.phone = wrapValue
        }
        if let wrapValue = json["ratio_star"] as? Double {
            self.ratio_star = wrapValue
        }
    }
}
