//
//  StateHistDBAPI.swift
//  InstaCOVID
//
//  Created by Ruichang Chen on 2020/12/3.
//  Copyright © 2020 team2. All rights reserved.
//

import SwiftUI
import Foundation

var stateHistDataList = [StateHistDataStruct]()
let stateList = ["AL", "AK", "AZ", "AR", "CA", "CO", "CT", "DE", "DC", "FL", "GA", "HI", "ID", "IL", "IN", "IA", "KS", "KY", "LA", "ME", "MD", "MA", "MI", "MN", "MS", "MO", "MT", "NE", "NV", "NH", "NJ", "NM", "NY", "NC", "ND", "OH", "OK", "OR", "PA", "RI", "SC", "SD", "TN", "TX", "UT", "VT", "VA", "WA", "WV", "WI", "WY"]

public func gerStateHistDataFromAPI() {
    stateHistDataList = [StateHistDataStruct]()
    
    var apiUrl = ""
    
    apiUrl = "https://api.covidtracking.com/v1/states/daily.json"
    
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
                for state in stateList {
                    var caseList = [Int]()
                    var deathList = [Int]()
                    for object in array  {
                        if let info = object as? [String : Any]{
                            var totalCases = 0, totalDeaths = 0
                            if let name = info["state"] as? String {
                                if name == state {
                                    if let cases = info["positive"] as? Int {
                                        totalCases = cases
                                    }
                                    if let deaths = info["death"] as? Int {
                                        totalDeaths = deaths
                                    }
                                    caseList.append(totalCases)
                                    deathList.append(totalDeaths)
                                }
                            }
                        }
                    }
                    let histData = StateHistDataStruct(id: UUID(), stateName: state, cases: caseList, deaths: deathList)
                    stateHistDataList.append(histData)
                }
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
