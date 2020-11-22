//
//  WorldDBAPI.swift
//  InstaCOVID
//
//  Created by Nicole Lyu, Shangzheng Ji on 11/20/20.
//  Copyright © 2020 team2. All rights reserved.
//

import Foundation



var worldStatInfo = WorldStatStruct(totalCases: "0", newCases: "0", totalDeaths: "0", newDeaths: "0",totalRecovered: "0")
var everyContriesDataList = [WorldDataStruct]()
var orderedSearchableWorldDataList = [String]()

let APIKey = "889af3ca3fmshd882371958ac448p100118jsn58444a268212"

/*
  This data is from Coronavirus monitor v2 in the Rapid APi, the information you can find in the https://rapidapi.com/astsiatsko/api/coronavirus-monitor-v2?endpoint=apiendpoint_16b9117c-2a8c-4588-834a-6758fa464f06
 */
public func getTotalWorldStatFromAPI () {
    // reinit the worldStatInfo
    worldStatInfo = WorldStatStruct(totalCases: "0", newCases: "0", totalDeaths: "0", newDeaths: "0",totalRecovered: "0")
    
    var apiUrl = ""
    
    apiUrl = "https://coronavirus-monitor-v2.p.rapidapi.com/coronavirus/worldstat.php"
    
    var apiQueryUrlStruct: URL?
   
    if let urlStruct = URL(string: apiUrl) {
        apiQueryUrlStruct = urlStruct
    } else {
        // worldStatInfo will have the initial values set as above
        return
    }
    
    let headers = [
        "x-rapidapi-key": APIKey,
        "x-rapidapi-host": "coronavirus-monitor-v2.p.rapidapi.com"
    ]
    
    let request = NSMutableURLRequest(url: apiQueryUrlStruct!,
                                      cachePolicy: .useProtocolCachePolicy,
                                      timeoutInterval: 10.0)
 
    request.httpMethod = "GET"
    request.allHTTPHeaderFields = headers
    
    let semaphore = DispatchSemaphore(value: 0)
    
    URLSession.shared.dataTask(with: request as URLRequest, completionHandler: { (data, response, error) -> Void in
        /*
        URLSession is established and the JSON file from the API is set to be fetched
        in an asynchronous manner. After the file is fetched, data, response, error
        are returned as the input parameter values of this Completion Handler Closure.
        */
 
        // Process input parameter 'error'
        guard error == nil else {
            // countryFound will have the initial values set as above
            semaphore.signal()
            return
        }
       
        /*
         ---------------------------------------------------------
         🔴 Any 'return' used within the completionHandler Closure
            exits the Closure; not the public function it is in.
         ---------------------------------------------------------
         */
 
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
 
            var totalCases = "", newCases = "", totalDeaths = "", newDeaths = "", totalRecovered = ""
            
            if let jsonObject = jsonResponse as? [String: Any] {
                if let cases = jsonObject["total_cases"] as? String {
                    totalCases = cases
                }
                
                if let newCasesGeted = jsonObject["new_cases"] as? String {
                    newCases = newCasesGeted
                }
                
                if let totalDeathGeted = jsonObject["total_deaths"] as? String {
                    totalDeaths = totalDeathGeted
                }
                
                if let newDeathsGeted = jsonObject["new_deaths"] as? String {
                    newDeaths = newDeathsGeted
                }
                
                if let recovered = jsonObject["total_recovered"] as? String {
                    totalRecovered = recovered
                }
            }
            
            worldStatInfo.newCases = newCases
            worldStatInfo.totalCases = totalCases
            worldStatInfo.totalDeaths = totalDeaths
            worldStatInfo.totalRecovered = totalRecovered
            worldStatInfo.newDeaths = newDeaths
            print(worldStatInfo)
 
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


public func getEveryContriesDataFromAPI(){
    
    orderedSearchableWorldDataList = [String]()
    everyContriesDataList = [WorldDataStruct]()
    
    var apiUrl = ""
    
    apiUrl = "https://coronavirus-monitor-v2.p.rapidapi.com/coronavirus/cases_by_country.php"
    
    var apiQueryUrlStruct: URL?
   
    if let urlStruct = URL(string: apiUrl) {
        apiQueryUrlStruct = urlStruct
    } else {
        // worldStatInfo will have the initial values set as above
        return
    }
    
    let headers = [
        "x-rapidapi-key": APIKey,
        "x-rapidapi-host": "coronavirus-monitor-v2.p.rapidapi.com"
    ]
    
    let request = NSMutableURLRequest(url: apiQueryUrlStruct!,
                                      cachePolicy: .useProtocolCachePolicy,
                                      timeoutInterval: 10.0)
 
    request.httpMethod = "GET"
    request.allHTTPHeaderFields = headers
    
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