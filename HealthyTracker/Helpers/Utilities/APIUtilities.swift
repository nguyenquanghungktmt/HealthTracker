//
//  APIUltilities.swift
//  HealthyTracker
//
//  Created by pc_1359 on 28/06/2022.
//

import Foundation
import Alamofire

protocol JsonInitObject: NSObject {
    init(json: [String: Any])
}


final class APIUtilities {
    static let domain = "https://gist.githubusercontent.com"
    static let responseDataKey = "data"
    static let responseDataItems = "items"
    static let responseCodeKey = "code"
    static let responseMessageKey = "message"
    
    static func requestHomePatientNewsFeed(completionHandler: ((PatientNewsFeedModel?, APIError?) -> Void)?) {
        
        let tailStrURL = "/hdhuy179/f967ffb777610529b678f0d5c823352a/raw"
        
        jsonResponseObject(tailStrURL: tailStrURL, method: .get, headers: [:], completionHandler: completionHandler)
    }
    
    static func requestPromotionList(completionHandler: ((PromotionListModel?, APIError?) -> Void)?) {
        
        let tailStrURL = "/hdhuy179/ef03ed850ad56f0136fe3c5916b3280b/raw/Training_Intern_BasicApp_Promotion"
        
        jsonResponseObject(tailStrURL: tailStrURL, method: .get, headers: [:], completionHandler: completionHandler)
    }
    
    static func requestNewsList(completionHandler: ((NewsListModel?, APIError?) -> Void)?) {
        
        let tailStrURL = "/hdhuy179/84d1dfe96f2c0ab1ddea701df352a7a6/raw"
        
        jsonResponseObject(tailStrURL: tailStrURL, method: .get, headers: [:], completionHandler: completionHandler)
    }
    
    static func requestDoctorList(completionHandler: ((DoctorListModel?, APIError?) -> Void)?) {
        
        let tailStrURL = "/hdhuy179/9ac0a89969b46fb67bc7d1a8b94d180e/raw"
        
        jsonResponseObject(tailStrURL: tailStrURL, method: .get, headers: [:], completionHandler: completionHandler)
    }
    
    static func requestUserInfo(completionHandler: ((UserModel?, APIError?) -> Void)?) {
        
        let tailStrURL = "/hdhuy179/7883b8f11ea4b25cf6d3822c67049606/raw/Training_Intern_BasicApp_UserInfo"
        
        jsonResponseObject(tailStrURL: tailStrURL, method: .get, headers: [:], completionHandler: completionHandler)
    }
    
    static func requestLocation(province_code: String,
                                district_code: String,
                                ward_code: String,
                                completionHandler: ((LocationModel?, APIError?) -> Void)?) {
    
        let tailStrURL = "/hdhuy179/7883b8f11ea4b25cf6d3822c67049606/raw/province_code=\(province_code)&district_code=\(district_code)&ward_code=\(ward_code)"
        jsonResponseObject(tailStrURL: tailStrURL, method: .get, headers: [:], completionHandler: completionHandler)
    }
    
    
    
    // Here are some api that return a list of object
    static func requestPromotionList2(completionHandler: (([PromotionModel]?, APIError?) -> Void)?) {
        
        let tailStrURL = "/hdhuy179/ef03ed850ad56f0136fe3c5916b3280b/raw/Training_Intern_BasicApp_Promotion"
        
        jsonResponseListObject(tailStrURL: tailStrURL, method: .get, headers: [:], completionHandler: completionHandler)
    }
    
    static func requestNewsList2(completionHandler: (([NewsModel]?, APIError?) -> Void)?) {
        
        let tailStrURL = "/hdhuy179/84d1dfe96f2c0ab1ddea701df352a7a6/raw"
        
        jsonResponseListObject(tailStrURL: tailStrURL, method: .get, headers: [:], completionHandler: completionHandler)
    }
    
    static func requestDoctorList2(completionHandler: (([DoctorModel]?, APIError?) -> Void)?) {
        
        let tailStrURL = "/hdhuy179/9ac0a89969b46fb67bc7d1a8b94d180e/raw"
        
        jsonResponseListObject(tailStrURL: tailStrURL, method: .get, headers: [:], completionHandler: completionHandler)
    }
    
    static private func jsonResponseObject<T: JsonInitObject>(tailStrURL: String, method: HTTPMethod, headers: HTTPHeaders, completionHandler: ((T?, APIError?) -> Void)?) {
        
        jsonResponse(tailStrURL: tailStrURL, isPublicAPI: false, method: method, headers: headers) { response, serverCode, serverMessage in
            
            switch response.result {
            case .success(let value):
                guard serverCode == 200 else {
                    completionHandler?(nil, .serverError(serverCode, serverMessage))
                    return
                }
                
                guard let responseDict = value as? [String: Any],
                      let dataDict = responseDict[responseDataKey] as? [String: Any] else {
                          completionHandler?(nil, .resposeFormatError)
                          return
                      }
                
                let obj = T(json: dataDict)
                
                completionHandler?(obj, nil)
                
            case .failure(let error):
                completionHandler?(nil, .unowned(error))
            }
        }
    }
    
    static private func jsonResponse(tailStrURL: String,
                                     isPublicAPI: Bool,
                                     method: HTTPMethod,
                                     parameters: Parameters? = nil,
                                     encoding: ParameterEncoding = JSONEncoding.default,
                                     headers: HTTPHeaders = [:],
                                     completionHandler: ((AFDataResponse<Any>, Int?, String?) -> Void)?) {
        
        guard let url = URL(string: domain + tailStrURL) else { return }
        AF.request(url, method: method, parameters: parameters, encoding: encoding, headers: headers)
            .responseJSON { response in
                
                var serverCode: Int? = nil
                var serverMessage: String? = nil
                
                switch response.result {
                case .success(let value):
                    serverCode = (value as? [String: Any])?[responseCodeKey] as? Int
                    serverMessage = (value as? [String: Any])?[responseMessageKey] as? String
                case .failure(_):
                    break
                }
                
                completionHandler?(response, serverCode, serverMessage)
            }
    }
    
    
    
    static private func jsonResponseListObject<T: JsonInitObject>(tailStrURL: String, method: HTTPMethod, headers: HTTPHeaders, completionHandler: (([T]?, APIError?) -> Void)?) {
        
        jsonResponse(tailStrURL: tailStrURL, isPublicAPI: false, method: method, headers: headers) { response, serverCode, serverMessage in
            
            switch response.result {
            case .success(let value):
                guard serverCode == 200 else {
                    completionHandler?(nil, .serverError(serverCode, serverMessage))
                    return
                }
                
                guard let responseDict = value as? [String: Any],
                      let dataDict = responseDict[responseDataKey] as? [String: Any],
                      let dataListItems = dataDict[responseDataItems] as? [[String: Any]]else {
                          completionHandler?(nil, .resposeFormatError)
                          return
                      }
                
                /// parse list json data to list object
                var objList = [T]()
                for item in dataListItems {
                    let obj = T(json: item)
                    objList.append(obj)
                }
                
                completionHandler?(objList, nil)
                
            case .failure(let error):
                completionHandler?(nil, .unowned(error))
            }
        }
    }
    
}

extension APIUtilities {
    enum APIError: Error {
        case resposeFormatError
        case serverError(Int?, String?)
        case unowned(Error)
    }
}
