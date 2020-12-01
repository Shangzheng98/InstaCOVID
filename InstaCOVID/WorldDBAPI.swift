//
//  WorldDBAPI.swift
//  InstaCOVID
//
//  Created by Nicole Lyu, Shangzheng Ji on 11/20/20.
//  Copyright © 2020 team2. All rights reserved.
//

import Foundation

var followedUpDataList = [WorldDataStruct]()
let testFollowUp = WorldDataStruct(id: UUID(), countryName: "Afghanistan", cases: 840, deaths: 30, totalRecovered: 54, newDeaths: 5, newCases: 56, lat: 33, long: 65, flagImgURL: "https://manta.cs.vt.edu/iOS/flags/af.png")

var worldStatInfo = WorldStatStruct(totalCases: "0", newCases: "0", totalDeaths: "0", newDeaths: "0",totalRecovered: "0")
var everyContriesDataListCases = [WorldDataStruct]()
var orderedSearchableWorldDataListCases = [String]()

var everyContriesDataListNewCases = [WorldDataStruct]()
var orderedSearchableWorldDataListNewCases = [String]()

var everyContriesDataListDeaths = [WorldDataStruct]()
var orderedSearchableWorldDataListDeaths = [String]()

var everyContriesDataListNewDeaths = [WorldDataStruct]()
var orderedSearchableWorldDataListNewDeaths = [String]()

var everyContriesDataListRecovered = [WorldDataStruct]()
var orderedSearchableWorldDataListRecovered = [String]()


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

/*
 https://documenter.getpostman.com/view/11144369/Szf6Z9B3?version=latest#ad1d0096-3390-462d-896c-5817101a7adf
 Data from Worldometers
 */

public func getEveryContriesDataFromAPISortByCases(){
    
    orderedSearchableWorldDataListCases = [String]()
    everyContriesDataListCases = [WorldDataStruct]()
    
    var apiUrl = ""
    
    apiUrl = "https://corona.lmao.ninja/v2/countries?yesterday=true&sort=cases"
    
    
    let jsonDataFromApi = getJsonDataFromApi(apiUrl: apiUrl)
    
    
    //------------------------------------------------
    // JSON data is obtained from the API. Process it.
    //------------------------------------------------
    do {
        /*
         Foundation framework’s JSONSerialization class is used to convert JSON data
         into Swift data types such as Dictionary, Array, String, Number, or Bool.
         */
        let jsonResponse = try JSONSerialization.jsonObject(with: jsonDataFromApi!,
                           options: JSONSerialization.ReadingOptions.mutableContainers)

        if let array = jsonResponse as? [Any] {
            for object in array  {
                var countryName = "", totalCases = 0, newCases = 0, totalDeaths = 0, newDeaths = 0, totalrecovered = 0, lat = 0.0, long = 0.0, flagURL = "",flagName = ""
                if let info = object as? [String : Any]{
                    if let name = info["country"] as? String {
                        countryName = name
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
                    
                    if let recovered = info["recovered"] as? Int {
                        totalrecovered = recovered
                    }
                    
                    if let countryInfo = info["countryInfo"] as? [String: Any] {
                        if let la = countryInfo["lat"] as? Double {
                            lat = la
                        }
                        
                        if let lo = countryInfo["long"] as? Double {
                            long = lo
                        }
                        
                        if let flag = countryInfo["flag"] as? String {
                            flagURL = flag
                            flagURL = flagURL.replacingOccurrences(of: "https://raw.githubusercontent.com/NovelCOVID/API/master/assets/flags", with: "https://manta.cs.vt.edu/iOS/flags")
                            flagName = String(flagURL.dropFirst(flagURL.count - 6).dropLast(4))
                        }
                    }
                }
                let id = UUID()
                let entry = WorldDataStruct(id: id, countryName: countryName, cases: totalCases, deaths: totalDeaths, totalRecovered: totalrecovered, newDeaths: newDeaths, newCases: newCases, lat: lat, long: long, flagImgURL: flagURL,flagImageName:flagName)
                everyContriesDataListCases.append(entry)
                
                let searchableListEntry = "\(id)|\(countryName)|\(totalCases)|\(totalDeaths)|\(totalrecovered)|\(newCases)|\(newDeaths)"
                orderedSearchableWorldDataListCases.append(searchableListEntry)
            }
            
            print(everyContriesDataListCases.description)
        }
        

    } catch {

        
        return
    }

    
}
 
 
public func getEveryContriesDataFromAPISortByNewCases(){
    
    orderedSearchableWorldDataListNewCases = [String]()
    everyContriesDataListNewCases = [WorldDataStruct]()
    
    var apiUrl = ""
    
    apiUrl = "https://corona.lmao.ninja/v2/countries?yesterday=true&sort=todayCases"
    
    
    let jsonDataFromApi = getJsonDataFromApi(apiUrl: apiUrl)
    
    
    //------------------------------------------------
    // JSON data is obtained from the API. Process it.
    //------------------------------------------------
    do {
        /*
         Foundation framework’s JSONSerialization class is used to convert JSON data
         into Swift data types such as Dictionary, Array, String, Number, or Bool.
         */
        let jsonResponse = try JSONSerialization.jsonObject(with: jsonDataFromApi!,
                           options: JSONSerialization.ReadingOptions.mutableContainers)

        if let array = jsonResponse as? [Any] {
            for object in array  {
                var countryName = "", totalCases = 0, newCases = 0, totalDeaths = 0, newDeaths = 0, totalrecovered = 0, lat = 0.0, long = 0.0, flagURL = "",flagName = ""
                if let info = object as? [String : Any]{
                    if let name = info["country"] as? String {
                        countryName = name
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
                    
                    if let recovered = info["recovered"] as? Int {
                        totalrecovered = recovered
                    }
                    
                    if let countryInfo = info["countryInfo"] as? [String: Any] {
                        if let la = countryInfo["lat"] as? Double {
                            lat = la
                        }
                        
                        if let lo = countryInfo["long"] as? Double {
                            long = lo
                        }
                        
                        if let flag = countryInfo["flag"] as? String {
                            flagURL = flag
                            flagURL = flagURL.replacingOccurrences(of: "https://raw.githubusercontent.com/NovelCOVID/API/master/assets/flags", with: "https://manta.cs.vt.edu/iOS/flags")
                            flagName = String(flagURL.dropFirst(flagURL.count - 6).dropLast(4))
                        }
                    }
                }
                let id = UUID()
                let entry = WorldDataStruct(id: id, countryName: countryName, cases: totalCases, deaths: totalDeaths, totalRecovered: totalrecovered, newDeaths: newDeaths, newCases: newCases, lat: lat, long: long, flagImgURL: flagURL,flagImageName: flagName)
                everyContriesDataListNewCases.append(entry)
                
                let searchableListEntry = "\(id)|\(countryName)|\(totalCases)|\(totalDeaths)|\(totalrecovered)|\(newCases)|\(newDeaths)"
                orderedSearchableWorldDataListNewCases.append(searchableListEntry)
            }
            
        }
    } catch {

        return
    }
}

public func getEveryContriesDataFromAPISortByDeaths(){
    
    orderedSearchableWorldDataListDeaths = [String]()
    everyContriesDataListDeaths = [WorldDataStruct]()
    
    var apiUrl = ""
    
    apiUrl = "https://corona.lmao.ninja/v2/countries?yesterday=true&sort=deaths"
    
    
    let jsonDataFromApi = getJsonDataFromApi(apiUrl: apiUrl)
    
    
    //------------------------------------------------
    // JSON data is obtained from the API. Process it.
    //------------------------------------------------
    do {
        /*
         Foundation framework’s JSONSerialization class is used to convert JSON data
         into Swift data types such as Dictionary, Array, String, Number, or Bool.
         */
        let jsonResponse = try JSONSerialization.jsonObject(with: jsonDataFromApi!,
                           options: JSONSerialization.ReadingOptions.mutableContainers)

        if let array = jsonResponse as? [Any] {
            for object in array  {
                var countryName = "", totalCases = 0, newCases = 0, totalDeaths = 0, newDeaths = 0, totalrecovered = 0, lat = 0.0, long = 0.0, flagURL = "",flagName = ""
                if let info = object as? [String : Any]{
                    if let name = info["country"] as? String {
                        countryName = name
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
                    
                    if let recovered = info["recovered"] as? Int {
                        totalrecovered = recovered
                    }
                    
                    if let countryInfo = info["countryInfo"] as? [String: Any] {
                        if let la = countryInfo["lat"] as? Double {
                            lat = la
                        }
                        
                        if let lo = countryInfo["long"] as? Double {
                            long = lo
                        }
                        
                        if let flag = countryInfo["flag"] as? String {
                            flagURL = flag
                            flagURL = flagURL.replacingOccurrences(of: "https://raw.githubusercontent.com/NovelCOVID/API/master/assets/flags", with: "https://manta.cs.vt.edu/iOS/flags")
                            flagName = String(flagURL.dropFirst(flagURL.count - 6).dropLast(4))
                        }
                    }
                }
                let id = UUID()
                let entry = WorldDataStruct(id: id, countryName: countryName, cases: totalCases, deaths: totalDeaths, totalRecovered: totalrecovered, newDeaths: newDeaths, newCases: newCases, lat: lat, long: long, flagImgURL: flagURL,flagImageName: flagName)
                everyContriesDataListDeaths.append(entry)
                
                let searchableListEntry = "\(id)|\(countryName)|\(totalCases)|\(totalDeaths)|\(totalrecovered)|\(newCases)|\(newDeaths)"
                orderedSearchableWorldDataListDeaths.append(searchableListEntry)
            }
            
        }
    } catch {

        return
    }
}


public func getEveryContriesDataFromAPISortByNewDeaths(){
    
    orderedSearchableWorldDataListNewDeaths = [String]()
    everyContriesDataListNewDeaths = [WorldDataStruct]()
    
    var apiUrl = ""
    
    apiUrl = "https://corona.lmao.ninja/v2/countries?yesterday=true&sort=todayDeaths"
    
    
    let jsonDataFromApi = getJsonDataFromApi(apiUrl: apiUrl)
    
    
    //------------------------------------------------
    // JSON data is obtained from the API. Process it.
    //------------------------------------------------
    do {
        /*
         Foundation framework’s JSONSerialization class is used to convert JSON data
         into Swift data types such as Dictionary, Array, String, Number, or Bool.
         */
        let jsonResponse = try JSONSerialization.jsonObject(with: jsonDataFromApi!,
                           options: JSONSerialization.ReadingOptions.mutableContainers)

        if let array = jsonResponse as? [Any] {
            for object in array  {
                var countryName = "", totalCases = 0, newCases = 0, totalDeaths = 0, newDeaths = 0, totalrecovered = 0, lat = 0.0, long = 0.0, flagURL = "",flagName = ""
                if let info = object as? [String : Any]{
                    if let name = info["country"] as? String {
                        countryName = name
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
                    
                    if let recovered = info["recovered"] as? Int {
                        totalrecovered = recovered
                    }
                    
                    if let countryInfo = info["countryInfo"] as? [String: Any] {
                        if let la = countryInfo["lat"] as? Double {
                            lat = la
                        }
                        
                        if let lo = countryInfo["long"] as? Double {
                            long = lo
                        }
                        
                        if let flag = countryInfo["flag"] as? String {
                            flagURL = flag
                            flagURL = flagURL.replacingOccurrences(of: "https://raw.githubusercontent.com/NovelCOVID/API/master/assets/flags", with: "https://manta.cs.vt.edu/iOS/flags")
                            flagName = String(flagURL.dropFirst(flagURL.count - 6).dropLast(4))
                        }
                    }
                }
                let id = UUID()
                let entry = WorldDataStruct(id: id, countryName: countryName, cases: totalCases, deaths: totalDeaths, totalRecovered: totalrecovered, newDeaths: newDeaths, newCases: newCases, lat: lat, long: long, flagImgURL: flagURL, flagImageName: flagName)
                everyContriesDataListNewDeaths.append(entry)
                
                let searchableListEntry = "\(id)|\(countryName)|\(totalCases)|\(totalDeaths)|\(totalrecovered)|\(newCases)|\(newDeaths)"
                orderedSearchableWorldDataListNewDeaths.append(searchableListEntry)
            }
            
        }
    } catch {

        return
    }
}

public func getEveryContriesDataFromAPISortByRecovered(){
    
    orderedSearchableWorldDataListRecovered = [String]()
    everyContriesDataListRecovered = [WorldDataStruct]()
    
    var apiUrl = ""
    
    apiUrl = "https://corona.lmao.ninja/v2/countries?yesterday=true&sort=recovered"
    
    
    let jsonDataFromApi = getJsonDataFromApi(apiUrl: apiUrl)
    
    
    //------------------------------------------------
    // JSON data is obtained from the API. Process it.
    //------------------------------------------------
    do {
        /*
         Foundation framework’s JSONSerialization class is used to convert JSON data
         into Swift data types such as Dictionary, Array, String, Number, or Bool.
         */
        let jsonResponse = try JSONSerialization.jsonObject(with: jsonDataFromApi!,
                           options: JSONSerialization.ReadingOptions.mutableContainers)

        if let array = jsonResponse as? [Any] {
            for object in array  {
                var countryName = "", totalCases = 0, newCases = 0, totalDeaths = 0, newDeaths = 0, totalrecovered = 0, lat = 0.0, long = 0.0, flagURL = "", flagName = ""
                if let info = object as? [String : Any]{
                    if let name = info["country"] as? String {
                        countryName = name
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
                    
                    if let recovered = info["recovered"] as? Int {
                        totalrecovered = recovered
                    }
                    
                    if let countryInfo = info["countryInfo"] as? [String: Any] {
                        if let la = countryInfo["lat"] as? Double {
                            lat = la
                        }
                        
                        if let lo = countryInfo["long"] as? Double {
                            long = lo
                        }
                        
                        if let flag = countryInfo["flag"] as? String {
                            flagURL = flag
                            flagURL = flagURL.replacingOccurrences(of: "https://raw.githubusercontent.com/NovelCOVID/API/master/assets/flags", with: "https://manta.cs.vt.edu/iOS/flags")
                            flagName = String(flagURL.dropFirst(flagURL.count - 6).dropLast(4))
                            print(flagName)
                        }
                    }
                }
                let id = UUID()
                let entry = WorldDataStruct(id: id, countryName: countryName, cases: totalCases, deaths: totalDeaths, totalRecovered: totalrecovered, newDeaths: newDeaths, newCases: newCases, lat: lat, long: long, flagImgURL: flagURL,flagImageName: flagName)
                everyContriesDataListRecovered.append(entry)
                
                let searchableListEntry = "\(id)|\(countryName)|\(totalCases)|\(totalDeaths)|\(totalrecovered)|\(newCases)|\(newDeaths)"
                orderedSearchableWorldDataListRecovered.append(searchableListEntry)
            }
            
        }
    } catch {

        return
    }
}
