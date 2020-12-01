//
//  ContentView.swift
//  InstaCOVID
//
//  Created by Shangzheng Ji on 11/20/20.
//

import SwiftUI
 
struct ContentView: View {
    
    var body: some View {
        TabView {
//            Home()
//                .tabItem {
//                    Image(systemName: "house.fill")
//                    Text("Home")
//                }
            DataView()
                .tabItem {
                    Image(systemName: "chart.bar.xaxis")
                    Text("Data")
                }
        }   // End of TabView
            
    }
}
 
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
