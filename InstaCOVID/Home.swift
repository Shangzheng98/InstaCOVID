//
//  Home.swift
//  InstaCOVID
//
//  Created by Nicole Lyu on 11/20/20.
//  Copyright © 2020 team2. All rights reserved.
//

import SwiftUI

struct Home: View {
    var followedUpDataList = [WorldDataStruct]()
    //    wholeWorldData = WorldDataStruct()
    //    WorldDataStruct(id: UUID(), countryName: "Afghanistan", cases: 840, deaths: 30, totalRecovered: 54, newDeaths: 5, newCases: 56, lat: 33, long: 65, flagImgURL: "https://manta.cs.vt.edu/iOS/flags/af.png"))
    // Subscribe to changes in UserData
    @EnvironmentObject var userData: UserData
    
    var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
            VStack {    // Foreground
                Image("Welcome")
                    .padding(.top, 50)
                // Show IEX Cloud API provider's website in default web browser
                
                Link(destination: URL(string: "https://www.cdc.gov/coronavirus/2019-ncov/")!) {
                    Text("CDC's Covid-19 News")
                }
                
                Image("photo\(userData.imageNumber + 1)")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(minWidth: 300, maxWidth: 500, alignment: .center)
                    .padding(.top, 30)
                    .padding(.bottom, 5)
                    .padding(.horizontal)
                
                HStack {
                    Button(action: {    // Button 1
                        self.userData.imageNumber = 0
                    }) {
                        self.imageForButton(buttonNumber: 0)
                    }
                    Button(action: {    // Button 2
                        self.userData.imageNumber = 1
                    }) {
                        self.imageForButton(buttonNumber: 1)
                    }
                    Button(action: {    // Button 3
                        self.userData.imageNumber = 2
                    }) {
                        self.imageForButton(buttonNumber: 2)
                    }
                    Button(action: {    // Button 4
                        self.userData.imageNumber = 3
                    }) {
                        self.imageForButton(buttonNumber: 3)
                    }
                    
                }   // End of HStack
                .imageScale(.medium)
                .font(Font.title.weight(.regular))
                .padding(.bottom, 100)
                
            }   // End of VStack
            Text("Your Followed Country's Covid-19 Data")
        }   // End of ScrollView
        .onAppear() {
            self.userData.startTimer()
        }
        .onDisappear() {
            self.userData.stopTimer()
        }
//        TabView {
//            ForEach(followedUpDataList) { followedUp in
//                {
//                    getImageFromUrl(url: followedUp.flagImgURL, defaultFilename: "ImageUnavailable")
//                        .resizable()
//                        .aspectRatio(contentMode: .fit)
//                        .frame(width:80, height: 80)
//                    VStack(alignment: .leading) {
//                        HStack {
//                            Text(followedUp.countryName)
//                        }
//                        .font(.system(size: 13))
//                        
//                        HStack{
//                            VStack(alignment: .leading) {
//                                Text("Confirmed")
//                                    .font(.system(size: 12.5))
//                                    .foregroundColor(.red)
//                                Text("\(followedUp.cases)")
//                                HStack {
//                                    Image(systemName: "arrow.up")
//                                        .imageScale(.small)
//                                        .foregroundColor(.gray)
//                                    
//                                    Text("\(followedUp.newCases)")
//                                        .foregroundColor(.gray)
//                                        .font(.system(size: 11))
//                                }
//                            }
//                            Divider()
//                            
//                            VStack(alignment: .leading) {
//                                Text("Recovered ")
//                                    .font(.system(size: 12.5))
//                                    .foregroundColor(.green)
//                                    .multilineTextAlignment(.leading)
//                                
//                                HStack {
//                                    Text("\(followedUp.totalRecovered)")
//                                }
//                                
//                                Text("")
//                            }
//                            Divider()
//                            VStack(alignment: .leading) {
//                                Text("Deaths")
//                                    .font(.system(size: 12.5))
//                                Text("\(followedUp.deaths)")
//                                
//                                HStack {
//                                    Image(systemName: "arrow.up")
//                                        .imageScale(.small)
//                                        .foregroundColor(.gray)
//                                    
//                                    Text("\(followedUp.newDeaths)")
//                                        .foregroundColor(.gray)
//                                        .font(.system(size: 11))
//                                }
//                            }
//                        }
//                        .frame(width: 250.0)
//                        .font(.system(size: 12))
//                        
//                    }
//                    
//                }
//            }
//        }   // End of TabView
//        .tabViewStyle(PageTabViewStyle())
    
    

        }   // End of body
        
        func imageForButton(buttonNumber: Int) -> Image {

            if self.userData.imageNumber == buttonNumber {
                return Image(systemName: "\(buttonNumber+1).circle.fill")
            } else {
                return Image(systemName: "\(buttonNumber+1).circle")
            }
        }
}


struct Home_Previews: PreviewProvider {
    static var previews: some View {
        Home()
    }
}
