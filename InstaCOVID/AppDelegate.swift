//
//  AppDelegate.swift
//  InstaCOVID
//
//  Created by Shangzheng Ji on 11/20/20.
//

import UIKit
import Foundation

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
 
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        createAudioPlayers()
        getTotalWorldStatFromAPI()
        gerStateHistDataFromAPI()
        profileImgae = UserDefaults.standard.data(forKey: "Photo")
        let dateFormatter = DateFormatter()
         
        // Set the date format to yyyy-MM-dd at HH:mm
        dateFormatter.dateFormat = "yyyy-MM-dd"
         
        let currentTime = Date()
        if let lastTime = UserDefaults.standard.string(forKey: "lastSaveTime") {
            let lastSaveDate = dateFormatter.date(from: lastTime)
            if currentTime <= (lastSaveDate?.addingTimeInterval(60*60*24))! {
                readAllDataFile()
            }else {
                print("update the data from API")
                getEveryContriesDataFromAPISortByCases()
                getEveryContriesDataFromAPISortByDeaths()
                getEveryContriesDataFromAPISortByRecovered()
                getEveryContriesDataFromAPISortByNewCases()
                getEveryContriesDataFromAPISortByNewDeaths()
            }
        }
        else {
            print("first install the app, get data from API")
            getEveryContriesDataFromAPISortByCases()
            getEveryContriesDataFromAPISortByDeaths()
            getEveryContriesDataFromAPISortByRecovered()
            getEveryContriesDataFromAPISortByNewCases()
            getEveryContriesDataFromAPISortByNewDeaths()
            
        }
//        let lastRecordSavedDate = UserDefaults.standard.string(forKey: "lastRecordDate") ?? "2020-12-07"
//
//
//
//
//
//        let date = dateFormatter.date(from: lastRecordSavedDate)
//
//        lastRecord = date!
        
        if let lastRecordSavedDate = UserDefaults.standard.string(forKey: "lastRecordDate") {
            let date = dateFormatter.date(from: lastRecordSavedDate)
            if currentTime > (date?.addingTimeInterval(26*60*60))! {
                numberOfStampe = 0
                print("reset the card record")
            } else {
                let stampeNumber = UserDefaults.standard.integer(forKey: "stampeNumber")
                numberOfStampe = stampeNumber
            }
        } else {
            print("There is no record card info")
        }
        
        return true
    }
 
    // MARK: UISceneSession Lifecycle
 
    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }
 
    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }
 
}
 
 

