//
//  LoadAndSave.swift
//  InstaCOVID
//
//  Created by Shangzheng Ji on 12/2/20.
//  Copyright © 2020 team2. All rights reserved.
//

import Foundation
import SwiftUI

let casesFileName = "Cases.json"
let newCasesFileName = "NewCases.json"
let deathsFileName = "Deaths.json"
let newDeathsFileName = "NewDeaths.json"
let recoveredFileName = "Recovered.json"
let wordDataFileName = "WorldData.json"

let followingFileName = "followingData.json"

let diagnosisFileName = "diagnosis.json"
var diagnosisStructlist = [DiagnosisStruct]()


public func readAllDataFile() {
    var documentDirectoryHasFiles = false
    var urlOfJsonFileInDocumentDirectory = documentDirectory.appendingPathComponent(casesFileName)
    
    
    do {
        _ = try Data(contentsOf: urlOfJsonFileInDocumentDirectory)
        
        
        documentDirectoryHasFiles = true
        
        everyContriesDataListCases = decodeJsonFileIntoArrayOfStructs(fullFilename: casesFileName, fileLocation: "Document Directory")
        print("\(casesFileName) is loaded from document directory")
    } catch {
        documentDirectoryHasFiles = false
        print("everyContriesDataListCases gets from API")
        getEveryContriesDataFromAPISortByCases()
        
        
    }
    
    if documentDirectoryHasFiles {
        let urlOfFileInDocDir = documentDirectory.appendingPathComponent("orderedSearchableWorldDataListCases")
        
        let arrayFromFile: NSArray? = NSArray(contentsOf: urlOfFileInDocDir)
        if let arrayObtained = arrayFromFile {
            // Store the unique id of the created array into the global variable
            orderedSearchableWorldDataListCases = arrayObtained as! [String]
        } else {
            print("orderedSearchableWorldDataListCases file is not found in document directory on the user's device!")
        }
    }
    
    
    
    //========================================
    
    
    documentDirectoryHasFiles = false
    urlOfJsonFileInDocumentDirectory = documentDirectory.appendingPathComponent(newCasesFileName)
    
    do {
        _ = try Data(contentsOf: urlOfJsonFileInDocumentDirectory)
        
        
        documentDirectoryHasFiles = true
        
        everyContriesDataListNewCases = decodeJsonFileIntoArrayOfStructs(fullFilename: newCasesFileName, fileLocation: "Document Directory")
        print("\(newCasesFileName) is loaded from document directory")
    } catch {
        documentDirectoryHasFiles = false
        print("everyContriesDataListNewCases gets from API")
        getEveryContriesDataFromAPISortByNewCases()
    }
    
    
    if documentDirectoryHasFiles {
        let urlOfFileInDocDir = documentDirectory.appendingPathComponent("orderedSearchableWorldDataListNewCases")
        
        let arrayFromFile: NSArray? = NSArray(contentsOf: urlOfFileInDocDir)
        if let arrayObtained = arrayFromFile {
            // Store the unique id of the created array into the global variable
            orderedSearchableWorldDataListNewCases = arrayObtained as! [String]
        } else {
            print("orderedSearchableWorldDataListNewCases file is not found in document directory on the user's device!")
        }
    }
    
    //========================================
    
    
    documentDirectoryHasFiles = false
    urlOfJsonFileInDocumentDirectory = documentDirectory.appendingPathComponent(deathsFileName)
    
    do {
        _ = try Data(contentsOf: urlOfJsonFileInDocumentDirectory)
        
        
        documentDirectoryHasFiles = true
        
        everyContriesDataListDeaths = decodeJsonFileIntoArrayOfStructs(fullFilename: deathsFileName, fileLocation: "Document Directory")
        print("\(deathsFileName) is loaded from document directory")
    } catch {
        documentDirectoryHasFiles = false
        print("everyContriesDataListDeaths gets from API")
        getEveryContriesDataFromAPISortByDeaths()
    }
    
    
    if documentDirectoryHasFiles {
        let urlOfFileInDocDir = documentDirectory.appendingPathComponent("orderedSearchableWorldDataListDeaths")
        
        let arrayFromFile: NSArray? = NSArray(contentsOf: urlOfFileInDocDir)
        if let arrayObtained = arrayFromFile {
            // Store the unique id of the created array into the global variable
            orderedSearchableWorldDataListDeaths = arrayObtained as! [String]
        } else {
            print("orderedSearchableWorldDataListDeaths file is not found in document directory on the user's device!")
        }
    }
    
    
    
    //========================================
    
    
    documentDirectoryHasFiles = false
    urlOfJsonFileInDocumentDirectory = documentDirectory.appendingPathComponent(newDeathsFileName)
    
    do {
        _ = try Data(contentsOf: urlOfJsonFileInDocumentDirectory)
        
        
        documentDirectoryHasFiles = true
        
        everyContriesDataListNewDeaths = decodeJsonFileIntoArrayOfStructs(fullFilename: newDeathsFileName, fileLocation: "Document Directory")
        print("\(newDeathsFileName) is loaded from document directory")
    } catch {
        documentDirectoryHasFiles = false
        print("everyContriesDataListNewDeaths gets from API")
        getEveryContriesDataFromAPISortByNewDeaths()
    }
    
    
    if documentDirectoryHasFiles {
        let urlOfFileInDocDir = documentDirectory.appendingPathComponent("orderedSearchableWorldDataListNewDeaths")
        
        let arrayFromFile: NSArray? = NSArray(contentsOf: urlOfFileInDocDir)
        if let arrayObtained = arrayFromFile {
            // Store the unique id of the created array into the global variable
            orderedSearchableWorldDataListNewDeaths = arrayObtained as! [String]
        } else {
            print("orderedSearchableWorldDataListNewDeaths file is not found in document directory on the user's device!")
        }
    }
    
    //========================================
    
    
    documentDirectoryHasFiles = false
    urlOfJsonFileInDocumentDirectory = documentDirectory.appendingPathComponent(recoveredFileName)
    
    do {
        _ = try Data(contentsOf: urlOfJsonFileInDocumentDirectory)
        
        
        documentDirectoryHasFiles = true
        
        everyContriesDataListRecovered = decodeJsonFileIntoArrayOfStructs(fullFilename: recoveredFileName, fileLocation: "Document Directory")
        print("\(recoveredFileName) is loaded from document directory")
    } catch {
        documentDirectoryHasFiles = false
        print("everyContriesDataListRecovered gets from API")
        getEveryContriesDataFromAPISortByRecovered()
    }
    
    
    if documentDirectoryHasFiles {
        let urlOfFileInDocDir = documentDirectory.appendingPathComponent("orderedSearchableWorldDataListRecovered")
        
        let arrayFromFile: NSArray? = NSArray(contentsOf: urlOfFileInDocDir)
        if let arrayObtained = arrayFromFile {
            // Store the unique id of the created array into the global variable
            orderedSearchableWorldDataListRecovered = arrayObtained as! [String]
        } else {
            print("orderedSearchableWorldDataListRecovered file is not found in document directory on the user's device!")
        }
    }
    
    documentDirectoryHasFiles = false
    urlOfJsonFileInDocumentDirectory = documentDirectory.appendingPathComponent(followingFileName)
    
    do {
        _ = try Data(contentsOf: urlOfJsonFileInDocumentDirectory)
        
        
        documentDirectoryHasFiles = true
        
        followedUpDataList = decodeJsonFileIntoArrayOfStructs(fullFilename: followingFileName, fileLocation: "Document Directory")
        print("\(followingFileName) is loaded from document directory")
    } catch {
        print("error following list")
    }
    //================
    documentDirectoryHasFiles = false
    urlOfJsonFileInDocumentDirectory = documentDirectory.appendingPathComponent(diagnosisFileName)
    
    do {
        _ = try Data(contentsOf: urlOfJsonFileInDocumentDirectory)
        
        
        documentDirectoryHasFiles = true
        
        diagnosisStructlist = decodeJsonFileIntoArrayOfStructs(fullFilename: diagnosisFileName, fileLocation: "Document Directory")
        print("\(diagnosisFileName) is loaded from document directory")
    } catch {
        print("error diagnosis list")
    }
}


public func writeFile() {
    // Obtain URL of the JSON file into which data will be written
    var urlOfJsonFileInDocumentDirectory = documentDirectory.appendingPathComponent(casesFileName)
 
    // Encode CocktailStructList into JSON and write it into the JSON file
    var encoder = JSONEncoder()
    if let encoded = try? encoder.encode(everyContriesDataListCases) {
        do {
            try encoded.write(to: urlOfJsonFileInDocumentDirectory)
        } catch {
            fatalError("Unable to write everyContriesDataListCases list data to document directory!")
        }
    } else {
        fatalError("Unable to encode everyContriesDataListCases list data!")
    }
   
 
    // Obtain URL of the file in document directory on the user's device
    var urlOfFileInDocDirectory = documentDirectory.appendingPathComponent("orderedSearchableWorldDataListCases")
 
    /*
    Swift Array does not yet provide the 'write' function, but NSArray does.
    Therefore, typecast the Swift array as NSArray so that we can write it.
    */
   
    (orderedSearchableWorldDataListCases as NSArray).write(to: urlOfFileInDocDirectory, atomically: true)
    
    
    
    //===========================
    
    urlOfJsonFileInDocumentDirectory = documentDirectory.appendingPathComponent(newCasesFileName)
 
    // Encode CocktailStructList into JSON and write it into the JSON file
    encoder = JSONEncoder()
    if let encoded = try? encoder.encode(everyContriesDataListNewCases) {
        do {
            try encoded.write(to: urlOfJsonFileInDocumentDirectory)
        } catch {
            fatalError("Unable to write everyContriesDataListNewCases list data to document directory!")
        }
    } else {
        fatalError("Unable to encode everyContriesDataListNewCases list data!")
    }
   
 
    // Obtain URL of the file in document directory on the user's device
    urlOfFileInDocDirectory = documentDirectory.appendingPathComponent("orderedSearchableWorldDataListNewCases")
 
    /*
    Swift Array does not yet provide the 'write' function, but NSArray does.
    Therefore, typecast the Swift array as NSArray so that we can write it.
    */
   
    (orderedSearchableWorldDataListNewCases as NSArray).write(to: urlOfFileInDocDirectory, atomically: true)
    
    
    //===========================
    
    urlOfJsonFileInDocumentDirectory = documentDirectory.appendingPathComponent(deathsFileName)
 
    // Encode CocktailStructList into JSON and write it into the JSON file
    encoder = JSONEncoder()
    if let encoded = try? encoder.encode(everyContriesDataListDeaths) {
        do {
            try encoded.write(to: urlOfJsonFileInDocumentDirectory)
        } catch {
            fatalError("Unable to write everyContriesDataListDeaths list data to document directory!")
        }
    } else {
        fatalError("Unable to encode everyContriesDataListDeaths list data!")
    }
   
 
    // Obtain URL of the file in document directory on the user's device
    urlOfFileInDocDirectory = documentDirectory.appendingPathComponent("orderedSearchableWorldDataListDeaths")
 
    /*
    Swift Array does not yet provide the 'write' function, but NSArray does.
    Therefore, typecast the Swift array as NSArray so that we can write it.
    */
   
    (orderedSearchableWorldDataListDeaths as NSArray).write(to: urlOfFileInDocDirectory, atomically: true)
    
    
    
    //===============
    
    urlOfJsonFileInDocumentDirectory = documentDirectory.appendingPathComponent(newDeathsFileName)
 
    // Encode CocktailStructList into JSON and write it into the JSON file
    encoder = JSONEncoder()
    if let encoded = try? encoder.encode(everyContriesDataListNewDeaths) {
        do {
            try encoded.write(to: urlOfJsonFileInDocumentDirectory)
        } catch {
            fatalError("Unable to write everyContriesDataListNewDeaths list data to document directory!")
        }
    } else {
        fatalError("Unable to encode everyContriesDataListNewDeaths list data!")
    }
   
 
    // Obtain URL of the file in document directory on the user's device
    urlOfFileInDocDirectory = documentDirectory.appendingPathComponent("orderedSearchableWorldDataListNewDeaths")
 
    /*
    Swift Array does not yet provide the 'write' function, but NSArray does.
    Therefore, typecast the Swift array as NSArray so that we can write it.
    */
   
    (orderedSearchableWorldDataListNewDeaths as NSArray).write(to: urlOfFileInDocDirectory, atomically: true)
    
    
    //===============
    
    urlOfJsonFileInDocumentDirectory = documentDirectory.appendingPathComponent(recoveredFileName)
 
    // Encode CocktailStructList into JSON and write it into the JSON file
    encoder = JSONEncoder()
    if let encoded = try? encoder.encode(everyContriesDataListRecovered) {
        do {
            try encoded.write(to: urlOfJsonFileInDocumentDirectory)
        } catch {
            fatalError("Unable to write everyContriesDataListRecovered list data to document directory!")
        }
    } else {
        fatalError("Unable to encode everyContriesDataListRecovered list data!")
    }
   
 
    // Obtain URL of the file in document directory on the user's device
    urlOfFileInDocDirectory = documentDirectory.appendingPathComponent("orderedSearchableWorldDataListRecovered")
 
    /*
    Swift Array does not yet provide the 'write' function, but NSArray does.
    Therefore, typecast the Swift array as NSArray so that we can write it.
    */
   
    (orderedSearchableWorldDataListRecovered as NSArray).write(to: urlOfFileInDocDirectory, atomically: true)
    
    //===============
    
    urlOfJsonFileInDocumentDirectory = documentDirectory.appendingPathComponent(followingFileName)
 
    // Encode CocktailStructList into JSON and write it into the JSON file
    encoder = JSONEncoder()
    if let encoded = try? encoder.encode(followedUpDataList) {
        do {
            try encoded.write(to: urlOfJsonFileInDocumentDirectory)
        } catch {
            fatalError("Unable to write followedUpDataList list data to document directory!")
        }
    } else {
        fatalError("Unable to encode followedUpDataList list data!")
    }
    
    
    //===============
    
    urlOfJsonFileInDocumentDirectory = documentDirectory.appendingPathComponent(diagnosisFileName)
 
    // Encode CocktailStructList into JSON and write it into the JSON file
    encoder = JSONEncoder()
    if let encoded = try? encoder.encode(diagnosisStructlist) {
        do {
            try encoded.write(to: urlOfJsonFileInDocumentDirectory)
        } catch {
            fatalError("Unable to write diagnosisStructlist list data to document directory!")
        }
    } else {
        fatalError("Unable to encode diagnosisStructlist list data!")
    }
    
    let saveTime = Date()
    let dateFormatter = DateFormatter()
     
    // Set the date format to yyyy-MM-dd at HH:mm
    dateFormatter.dateFormat = "yyyy-MM-dd"
     
    // Format dateAndTime under the dateFormatter and convert it to String
    let lastTime = dateFormatter.string(from: saveTime)
    UserDefaults.standard.set(lastTime,forKey: "lastSaveTime")
}
