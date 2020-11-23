//
//  StateDBAPI.swift
//  InstaCOVID
//
//  Created by Nicole Lyu on 11/20/20.
//  Copyright © 2020 team2. All rights reserved.
//

import SwiftUI
import Foundation

var stateDataList = [StateDataStruct]()

public func gerStateDataFromAPI() {
    stateDataList = [StateDataStruct]()
    
    var apiUrl = ""
    
    apiUrl = "https://corona.lmao.ninja/v2/states?sort&yesterday=true"
    
    var apiQueryUrlStruct: URL?
   
    if let urlStruct = URL(string: apiUrl) {
        apiQueryUrlStruct = urlStruct
    } else {
        // worldStatInfo will have the initial values set as above
        return
    }
    
    
    let request = NSMutableURLRequest(url: apiQueryUrlStruct!,
                                      cachePolicy: .useProtocolCachePolicy,
                                      timeoutInterval: 10.0)
 
    request.httpMethod = "GET"
    
    let semaphore = DispatchSemaphore(value: 0)
    
    URLSession.shared.dataTask(with: request as URLRequest, completionHandler: { (data, response, error) -> Void in
 
        // Process input parameter 'error'
        guard error == nil else {
            // countryFound will have the initial values set as above
            semaphore.signal()
            return
        }
       
        // Process input parameter 'response'. HTTP response status codes from 200 to 299 indicate success.
        guard let httpResponse = response as? HTTPURLResponse, (200...299).contains(httpResponse.statusCode) else {
            // countryFound will have the initial values set as above
            semaphore.signal()
            return
        }
 
        // Process input parameter 'data'. Unwrap Optional 'data' if it has a value.
        guard let jsonDataFromApi = data else {
            // countryFound will have the initial values set as above
            semaphore.signal()
            return
        }
 
        //------------------------------------------------
        // JSON data is obtained from the API. Process it.
        //------------------------------------------------
        do {
            /*
             Foundation framework’s JSONSerialization class is used to convert JSON data
             into Swift data types such as Dictionary, Array, String, Number, or Bool.
             */
            let jsonResponse = try JSONSerialization.jsonObject(with: jsonDataFromApi,
                               options: JSONSerialization.ReadingOptions.mutableContainers)

            if let array = jsonResponse as? [Any] {
                for object in array  {
                    var stateName = "", totalCases = 0, newCases = 0, totalDeaths = 0, newDeaths = 0
                    if let info = object as? [String : Any]{
                        if let name = info["state"] as? String {
                            stateName = name
                        }
                        
                        if let cases = info["cases"] as? Int {
                            totalCases = cases
                        }
                        
                        if let todayCases = info["todayCases"] as? Int {
                            newCases = todayCases
                        }
                        
                        if let deaths = info["deaths"] as? Int {
                            totalDeaths = deaths
                        }
                        
                        if let todayDeaths = info["todayDeaths"] as? Int {
                            newDeaths = todayDeaths
                        }
                        
                        
                    }
                    
                    let entry = StateDataStruct(id: UUID(), stateName: stateName, cases: totalCases, deaths: totalDeaths, newDeaths: newDeaths, newCases: newCases, lat: 0.0, long: 0.0)
                    stateDataList.append(entry)
                    
                }
                
                print(stateDataList.description)
            }
            
 
        } catch {
            // countryFound will have the initial values set as above
            semaphore.signal()
            return
        }
 
        semaphore.signal()
    }).resume()
 
    /*
     The URLSession task above is set up. It begins in a suspended state.
     The resume() method starts processing the task in an execution thread.
 
     The semaphore.wait blocks the execution thread and starts waiting.
     Upon completion of the task, the Completion Handler code is executed.
     The waiting ends when .signal() fires or timeout period of 10 seconds expires.
    */
 
    _ = semaphore.wait(timeout: .now() + 10)
}
