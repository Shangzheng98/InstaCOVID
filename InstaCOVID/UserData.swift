//
//  UserData.swift
//  InstaCovid
//
//  Created by Nicole Lyu on 11/20/20.
//

import Combine
import SwiftUI
import UIKit
import LocalAuthentication
 

var profileImgae: Data? = nil
final class UserData: ObservableObject {
    // Publish if the user is authenticated or not
    @Published var userAuthenticated = false
    /*
     -------------------------------
     MARK: - Slide Show Declarations
     -------------------------------
     */
    let numberOfImagesInSlideShow = 4
    var counter = 0
    /*
     Create a Timer using initializer () and store its object reference into slideShowTimer.
     A Timer() object invokes a method after a certain time interval has elapsed.
     */
    var slideShowTimer = Timer()
 
    /*
     ===============================================================================
     MARK: -               Publisher-Subscriber Design Pattern
     ===============================================================================
     | Publisher:   @Published var under class conforming to ObservableObject      |
     | Subscriber:  Any View declaring '@EnvironmentObject var userData: UserData' |
     ===============================================================================
    
     By modifying the first View to be shown, ContentView(), with '.environmentObject(UserData())' in
     SceneDelegate, we inject an instance of this UserData() class into the environment and make it
     available to every View subscribing to it by declaring '@EnvironmentObject var userData: UserData'.
    
     When a change occurs in userData (e.g., deleting a country from the list, reordering countries list,
     adding a new country to the list), every View subscribed to it is notified to re-render its View.
     ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
     NOTE:  Only Views can subscribe to it. You cannot subscribe to it within
            a non-View Swift file such as our CountriesData.swift file.
     ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
     */
   
    // Publish countriesList with initial value of countryStructList obtained in CountriesData.swift
    @Published var countriesDataListCases = everyContriesDataListCases
    @Published var countriesDataListNewCases = everyContriesDataListNewCases
    @Published var countriesDataListDeaths = everyContriesDataListDeaths
    @Published var countriesDataListNewDeaths = everyContriesDataListNewDeaths
    @Published var countriesDataListRecovered = everyContriesDataListRecovered
    
    @Published var diagnosisHistoryList = diagnosisStructlist
    
    @Published var profilePhoto: Data? = profileImgae
    
    @Published var followedCountriesList = followedUpDataList
    @Published var searchableOrderedWorldDataList = orderedSearchableWorldDataListCases
    
    @Published var stateInfoList = stateDataList
   
    
    @Published var recordDay = numberOfStampe
    @Published var lastRecordDate = lastRecord
    
    
    // Publish imageNumber to refresh the View body in Home.swift when it is changed in the slide show
    @Published var imageNumber = 0
    
    
    @Published var flipped = false
    /*
     --------------------------
     MARK: - Scheduling a Timer
     --------------------------
     */
    public func startTimer() {
        // Stop timer if running
        stopTimer()
 
        /*
         Schedule a timer to invoke the fireTimer() method given below
         after 3 seconds in a loop that repeats itself until it is stopped.
         */
        slideShowTimer = Timer.scheduledTimer(timeInterval: 3,
                             target: self,
                             selector: (#selector(fireTimer)),
                             userInfo: nil,
                             repeats: true)
    }
 
    public func stopTimer() {
        counter = 0
        slideShowTimer.invalidate()
    }
   
    @objc func fireTimer() {
        counter += 1
        if counter == numberOfImagesInSlideShow {
            counter = 0
        }
        /*
         Each time imageNumber is changed here, the View body in Home.swift will be re-rendered to
         reflect the change since it subscribes to changes in imageNumber as specified above.
         */
        imageNumber = counter
    }
    
    @IBAction func logging() {
        
        let context = LAContext()
        
        context.localizedCancelTitle = "Cancel"
        var error: NSError?
        
        if context.canEvaluatePolicy(.deviceOwnerAuthentication, error: &error) {
            let reason = "Log in to your account"
            
            context.evaluatePolicy(.deviceOwnerAuthentication, localizedReason: reason) { (success, error) in
                if success {
                    DispatchQueue.main.async { [unowned self] in
                        userAuthenticated = true
                    }
                } else {
                    DispatchQueue.main.async { [unowned self] in
                        userAuthenticated = false
                    }
                }
            }
        }
    }
 
}
