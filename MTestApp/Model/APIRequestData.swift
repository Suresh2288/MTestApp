//
//  APIRequestData.swift
//  MTestApp
//
//  Created by John Raja on 25/05/19.
//  Copyright © 2019 John Raja. All rights reserved.
//

import Foundation
import RealmSwift
import ObjectMapper


class GetUserStatusRequest: NSObject, Mappable {
    
    var email = ""
    var accessToken = ""
    var languageID = "4"
    var countryCode = "IN"
    
    required init?(map: Map){
        
    }
    
    init(email: String, accessToken: String) {
        
        self.email = email
        self.accessToken = accessToken
    }
    
    func mapping(map: Map) {
        email <- map["Email"]
        accessToken <- map["Access_Token"]
        languageID <- map["LanguageID"]
        countryCode <- map["Country"]
    }
}
