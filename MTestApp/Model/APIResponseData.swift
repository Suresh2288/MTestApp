//
//  APIResponseData.swift
//  MTestApp
//
//  Created by John Raja on 25/05/19.
//  Copyright © 2019 John Raja. All rights reserved.
//

import Foundation
import ObjectMapper

struct SampleResponseData : Decodable {
    let firstname: String?
    let lastname: String?
    let phonenumber: String?
    
    enum CodingKeys: String, CodingKey
    {
        case firstname
        case lastname
        case phonenumber
    }
}


struct SampleResponseData01 : Codable {
    let Data: ResponseData
    let ErrorCode: String
    let Message: String
    
    enum CodingKeys: String, CodingKey
    {
        case Data
        case ErrorCode
        case Message
    }
}


struct ResponseData: Codable
{
    let IsPaidPremiumUser: AnyCodable
    let NotSubscriberNtucMessage: String
}

struct SampleStructData02: Codable {
    let ErrorCode: String
    let Data: SampleStructData02SubData
    
}

struct SampleStructData02SubData: Codable {
    //let NotSubscriberNtucMessage : String
    //let IsPaidPremiumUser : AnyCodable
    
    let AvailablePlans: [SampleStructData03SubData]
    
    
}

struct SampleStructData03SubData: Codable {
    let PlanoPremiumCode : String
    let TitleKey : AnyCodable
}

class CheckUserStatusResponse: NSObject, Mappable {
    
    @objc dynamic var IsPaidPremiumUser:Int = 0
    var NotSubscriberNtucMessage = ""
    
    required init?(map: Map){
        
    }
    
    func mapping(map: Map) {
        IsPaidPremiumUser <- map["Data.IsPaidPremiumUser"]
        NotSubscriberNtucMessage <- map["Data.NotSubscriberNtucMessage"]
    }
    
}

struct CurrentWeather: Codable {
    //let coord: Coord
    let weather: [WeatherDetails]
    let base: String
    //let main: Main
    let visibility: Int
    //let wind: Wind
    //let clouds: Clouds
    let dt: Int
    //let sys: Sys
    let id: Int
    let name: String
}

struct WeatherDetails: Codable
{
    let id: Int
    let main: String
    let description: String
    let icon: String
}
