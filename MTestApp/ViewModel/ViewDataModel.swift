//
//  ViewDataModel.swift
//  MTestApp
//
//  Created by John Raja on 25/05/19.
//  Copyright © 2019 John Raja. All rights reserved.
//

import Foundation
import SwiftyJSON
import ObjectMapper

class ViewDataModel {
    
    static let sharedInstance = ViewDataModel()
    
    func getList(completionHandler: @escaping (_ msg: String?, _ response: CurrentWeather?) -> Void) {
        
        //let stubDataURL = "https://raw.githubusercontent.com/cjbatin/Swift4-Decoding-JSON-Using-Codable/master/WeatherForecast/StubData/londonWeather.json"
        
        APIManager.sharedInstance.sendJSONRequest(method: .get, path: APIManager.Router.GetTopNews(), parameters: nil) { (responseHandler) -> Void in
            
            print("Response:\(responseHandler)")
            
            if responseHandler.result.isSuccess {
                do {
                    /*
                    let APIResponse = try JSONDecoder().decode([CurrentWeather].self, from: responseHandler.data!)
                    
                    print(APIResponse)
                    completionHandler(nil, APIResponse)
                     */
                    self.createWeatherObjectWith(json: responseHandler.data!, completion: { (weather, error) in
                        if let error = error {
                            print("Failed to convert data")
                            //return completion(nil, error)
                            completionHandler("Failed to convert data", nil)
                        }
                        //return completion(weather, nil)
                        completionHandler(nil, weather)
                    })
                } catch {
                    print("Error in decoder \(error)",responseHandler.result.value!)
                    completionHandler("Error in decoder: \(error)", nil) 
                }
            } else {
                completionHandler("Something went wrong", nil)
            }
        }
    }
    
    func CheckUserStatus(_ data:GetUserStatusRequest, completionHandler: @escaping (_ msg: String?, _ response: SampleStructData02?) -> Void) {
        
        APIManager.sharedInstance.sendJSONRequest(method: .post, path: APIManager.Router.GetAvailableSubscriptions(), parameters: data.toJSON()) { (responseHandler) -> Void in
            print("data.toJSON():\(data.toJSON())")
            print("Response:\(responseHandler)")
            
            if responseHandler.result.isSuccess {
                do {
                    
                    let jsonStr = self.nsdataToJSON(data: responseHandler.data!)
                    print(jsonStr as Any)
                    
                    if let response = Mapper<CheckUserStatusResponse>().map(JSONObject: jsonStr) {
                        
                        print(response.IsPaidPremiumUser)
                        print(response.NotSubscriberNtucMessage)
                    }
                    
                    let APIResponse = try JSONDecoder().decode(SampleStructData02.self, from: responseHandler.data!)
                    
                    print(APIResponse)
                    
                    completionHandler(nil, APIResponse)
                } catch {
                    print("Error in decoder \(error)",responseHandler.result.value!)
                    completionHandler("Error in decoder: \(error)", nil)
                }
            } else {
                completionHandler("Something went wrong", nil)
            }
        }
    }
    
    // Convert from NSData to json object
    func nsdataToJSON(data: Data) -> AnyObject? {
        do {
            return try JSONSerialization.jsonObject(with: data as Data, options: .mutableContainers) as AnyObject
        } catch let myJSONError {
            print(myJSONError)
        }
        return nil
    }
    
    // Convert from JSON to nsdata
    func jsonToNSData(json: AnyObject) -> Data?{
        do {
            return try JSONSerialization.data(withJSONObject: json, options: JSONSerialization.WritingOptions.prettyPrinted) as Data
        } catch let myJSONError {
            print(myJSONError)
        }
        return nil;
    }
    
    private func createWeatherObjectWith(json: Data, completion: @escaping (_ data: CurrentWeather?, _ error: Error?) -> Void) {
        do {
            let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = .convertFromSnakeCase
            let weather = try decoder.decode(CurrentWeather.self, from: json)
            return completion(weather, nil)
        } catch let error {
            print("Error creating current weather from JSON because: \(error.localizedDescription)")
            return completion(nil, error)
        }
    }
}
