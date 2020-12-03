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
        getTotalWorldStatFromAPI()
        
        let dateFormatter1 = DateFormatter()
         
        // Set the date format to yyyy-MM-dd at HH:mm
        dateFormatter1.dateFormat = "yyyy-MM-dd' at 'HH:mm"
         
        // Format dateAndTime under the dateFormatter and convert it to String
        let StringlastTime = dateFormatter1.string(from: Date())
        UserDefaults.standard.set(StringlastTime,forKey: "lastSaveTime")
        let currentTime = Date()
        let lastTime = UserDefaults.standard.string(forKey: "lastSaveTime")!
        let dateFormatter = DateFormatter()
        
        dateFormatter.dateFormat = "yyyy-MM-dd' at 'HH:mm"
        let lastDate = dateFormatter.date(from: lastTime)
        if currentTime <= (lastDate?.addingTimeInterval(60*60*24))! {
            readAllDataFile()
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
 
 

