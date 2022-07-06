//
//  UserModel.swift
//  HealthyTracker
//
//  Created by pc_1359 on 06/07/2022.
//

import Foundation

class UserModel: NSObject, JsonInitObject  {
    
    var id                          : Int?
    var name                        : String?
    var last_name                   : String?
    var username                    : String?
    var contact_email               : String?
    var phone                       : String?
    var card_id                     : String?
    var address                     : String?
    var province_code               : String?
    var district_code               : String?
    var ward_code                   : String?
    var latitude                    : Int?
    var longitude                   : Int?
    var birth_date                  : String?
    var avatar                      : String?
    var degree                      : String?
    var training_place              : String?
    var academic_rank               : String?
    var majors_id                   : Int?
    var hospital_name               : String?
    var sex                         : Int?
    var blood                       : Int?
    var description_self            : String?
    var verified_at                 : String?
    var current_step                : Int?
    var user_type                   : Int?
    var refer_code                  : String?
    var working_hour_type           : Int?
    var balance                     : Int?
    var ratio_star                  : Double?
    var number_of_reviews           : Int?
    var number_of_stars             : Int?
    var status                      : Int?
    var is_first_login              : Int?
    var created_at                  : String?
    var updated_at                  : String?
    var full_address                : String?
    var full_name                   : String?
    var order_cancel_total          : Int?
    var referral_total              : Int?
    var blood_name                  : String?
    var total_appointment           : Int?
    
    
    convenience init(id: Int? = nil, name: String? = nil, last_name: String? = nil, username: String? = nil, contact_email: String? = nil, phone: String? = nil, card_id: String? = nil, address: String? = nil, province_code: String? = nil, district_code: String? = nil, ward_code: String? = nil, latitude: Int? = nil, longitude: Int? = nil, birth_date: String? = nil, avatar: String? = nil, degree: String? = nil, training_place: String? = nil, academic_rank: String? = nil, majors_id: Int? = nil, hospital_name: String? = nil, sex: Int? = nil, blood: Int? = nil, description_self: String? = nil, verified_at: String? = nil, current_step: Int? = nil, user_type: Int? = nil, refer_code: String? = nil, working_hour_type: Int? = nil, balance: Int? = nil, ratio_star: Double? = nil, number_of_reviews: Int? = nil, number_of_stars: Int? = nil, status: Int? = nil, is_first_login: Int? = nil, created_at: String? = nil, updated_at: String? = nil, full_address: String? = nil, full_name: String? = nil, order_cancel_total: Int? = nil, referral_total: Int? = nil, blood_name: String? = nil, total_appointment: Int? = nil) {
        
        self.init()
        
        self.id = id
        self.name = name
        self.last_name = last_name
        self.username = username
        self.contact_email = contact_email
        self.phone = phone
        self.card_id = card_id
        self.address = address
        self.province_code = province_code
        self.district_code = district_code
        self.ward_code = ward_code
        self.latitude = latitude
        self.longitude = longitude
        self.birth_date = birth_date
        self.avatar = avatar
        self.degree = degree
        self.training_place = training_place
        self.academic_rank = academic_rank
        self.majors_id = majors_id
        self.hospital_name = hospital_name
        self.sex = sex
        self.blood = blood
        self.description_self = description_self
        self.verified_at = verified_at
        self.current_step = current_step
        self.user_type = user_type
        self.refer_code = refer_code
        self.working_hour_type = working_hour_type
        self.balance = balance
        self.ratio_star = ratio_star
        self.number_of_reviews = number_of_reviews
        self.number_of_stars = number_of_stars
        self.status = status
        self.is_first_login = is_first_login
        self.created_at = created_at
        self.updated_at = updated_at
        self.full_address = full_address
        self.full_name = full_name
        self.order_cancel_total = order_cancel_total
        self.referral_total = referral_total
        self.blood_name = blood_name
        self.total_appointment = total_appointment
    }
    
    required convenience init(json: [String : Any]) {
        self.init()
        
        if let wrapValue = json["id"] as? Int {
            self.id = wrapValue
        }

        if let wrapValue = json["latitude"] as? Int {
            self.latitude = wrapValue
        }

        if let wrapValue = json["longitude"] as? Int {
            self.longitude = wrapValue
        }

        if let wrapValue = json["majors_id"] as? Int {
            self.majors_id = wrapValue
        }

        if let wrapValue = json["sex"] as? Int {
            self.sex = wrapValue
        }

        if let wrapValue = json["blood"] as? Int {
            self.blood = wrapValue
        }

        if let wrapValue = json["current_step"] as? Int {
            self.current_step = wrapValue
        }

        if let wrapValue = json["user_type"] as? Int {
            self.user_type = wrapValue
        }

        if let wrapValue = json["working_hour_type"] as? Int {
            self.working_hour_type = wrapValue
        }

        if let wrapValue = json["balance"] as? Int {
            self.balance = wrapValue
        }

        if let wrapValue = json["number_of_reviews"] as? Int {
            self.number_of_reviews = wrapValue
        }

        if let wrapValue = json["number_of_stars"] as? Int {
            self.number_of_stars = wrapValue
        }

        if let wrapValue = json["status"] as? Int {
            self.status = wrapValue
        }

        if let wrapValue = json["is_first_login"] as? Int {
            self.is_first_login = wrapValue
        }

        if let wrapValue = json["order_cancel_total"] as? Int {
            self.order_cancel_total = wrapValue
        }

        if let wrapValue = json["referral_total"] as? Int {
            self.referral_total = wrapValue
        }

        if let wrapValue = json["total_appointment"] as? Int {
            self.total_appointment = wrapValue
        }

        if let wrapValue = json["name"] as? String {
            self.name = wrapValue
        }

        if let wrapValue = json["last_name"] as? String {
            self.last_name = wrapValue
        }

        if let wrapValue = json["username"] as? String {
            self.username = wrapValue
        }

        if let wrapValue = json["contact_email"] as? String {
            self.contact_email = wrapValue
        }

        if let wrapValue = json["phone"] as? String {
            self.phone = wrapValue
        }

        if let wrapValue = json["card_id"] as? String {
            self.card_id = wrapValue
        }

        if let wrapValue = json["address"] as? String {
            self.address = wrapValue
        }

        if let wrapValue = json["province_code"] as? String {
            self.province_code = wrapValue
        }

        if let wrapValue = json["district_code"] as? String {
            self.district_code = wrapValue
        }

        if let wrapValue = json["ward_code"] as? String {
            self.ward_code = wrapValue
        }

        if let wrapValue = json["birth_date"] as? String {
            self.birth_date = wrapValue
        }

        if let wrapValue = json["avatar"] as? String {
            self.avatar = wrapValue
        }

        if let wrapValue = json["degree"] as? String {
            self.degree = wrapValue
        }

        if let wrapValue = json["training_place"] as? String {
            self.training_place = wrapValue
        }

        if let wrapValue = json["academic_rank"] as? String {
            self.academic_rank = wrapValue
        }

        if let wrapValue = json["hospital_name"] as? String {
            self.hospital_name = wrapValue
        }

        if let wrapValue = json["description_self"] as? String {
            self.description_self = wrapValue
        }

        if let wrapValue = json["verified_at"] as? String {
            self.verified_at = wrapValue
        }

        if let wrapValue = json["refer_code"] as? String {
            self.refer_code = wrapValue
        }

        if let wrapValue = json["created_at"] as? String {
            self.created_at = wrapValue
        }

        if let wrapValue = json["updated_at"] as? String {
            self.updated_at = wrapValue
        }

        if let wrapValue = json["full_address"] as? String {
            self.full_address = wrapValue
        }

        if let wrapValue = json["full_name"] as? String {
            self.full_name = wrapValue
        }

        if let wrapValue = json["blood_name"] as? String {
            self.blood_name = wrapValue
        }
    }
}
