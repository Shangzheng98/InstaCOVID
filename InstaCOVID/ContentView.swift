//
//  ContentView.swift
//  InstaCOVID
//
//  Created by Shangzheng Ji on 11/20/20.
//

import SwiftUI
import Combine

struct ContentView: View {
    @EnvironmentObject var userData: UserData
    var body: some View {
        TabView {
            Home()
                .tabItem {
                    Image(systemName: "house.fill")
                    Text("Home")
                }
            DataView()
                .tabItem {
                    Image(systemName: "chart.bar.xaxis")
                    Text("Data")
                }
            if userData.userAuthenticated {
                DiagnosisAvailable().tabItem {
                    Image(systemName: "cross.circle.fill")
                    Text("Diagnosis")
                }
            }
            else{
                DiagnosisNotAvailable().tabItem {
                    Image(systemName: "cross.circle.fill")
                    Text("Diagnosis")
                }
            }
            
            if userData.userAuthenticated {
                DisplayPersonalInfo().tabItem {
                    Image(systemName: "gear")
                    Text("Settings")
                }
            }
            else{
                SettingMain().tabItem {
                    Image(systemName: "gear")
                    Text("Settings")
                }
            }
        }   // End of TabView
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
