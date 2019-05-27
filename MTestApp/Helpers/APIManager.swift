//
//  APIManager.swift
//  MTestApp
//
//  Created by John Raja on 25/05/19.
//  Copyright © 2019 John Raja. All rights reserved.
//

import Foundation
import UIKit
import Alamofire
import ObjectMapper
import RealmSwift

typealias responseHandler = (_ apiResponseHandler: DataResponse<String>) -> Void

class APIManager {

    static let sharedInstance = APIManager()
    
    private func getAuthorizationCode(path : URLConvertible) -> String {
        
        let auth = Constants.API.AUTHORIZATION
        
        return auth
    }
    
    enum Router: URLConvertible {
        
        case GetTopNews()
        case CheckUserStatus()
        case GetAvailableSubscriptions()
        
        var path: String {
            switch self {
            case .GetTopNews:
                return "/StubData/londonWeather.json"
            case .CheckUserStatus:
                return "/ThirdParty/LinkPoints/CheckUserStatus"
            case .GetAvailableSubscriptions:
                return "/Subscription/SG/GetAvailableSubscriptions"
            }
        }
        
        func asURL() throws -> URL {
            
            //http://friendservice.herokuapp.com/listFriends
            //let url = "http://perfectrdp.us/newspaper_webservice/get_top_news.php"
            
            //let url = "http://perfectrdp.us/newspaper_webservice"
            let url = try Constants.API.URL.asURL()
            return url.appendingPathComponent(path)
        }
        
    }
    
    // Common JSON Request
    func sendJSONRequest(method: HTTPMethod, path: URLConvertible, parameters: [String : Any]?, completed: @escaping responseHandler) {
        
           let headers = [
                    "Authorization": Constants.API.AUTHORIZATION,
                    "Content-Type" : "application/json"
           ]
        //application/x-www-form-urlencoded
        //application/json
        Alamofire.request(path, method: method, parameters: parameters, encoding: JSONEncoding.default, headers: headers)
            .responseString { (response) in
                
                print(response)
                completed(response)
        }
    }
}

