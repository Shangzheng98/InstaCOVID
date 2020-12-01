//
//  Home.swift
//  InstaCOVID
//
//  Created by Nicole Lyu on 11/20/20.
//  Copyright © 2020 team2. All rights reserved.
//

import SwiftUI

struct Home: View {
    // Subscribe to changes in UserData
    @EnvironmentObject var userData: UserData
    
    var body: some View {
        ZStack {        // Background
            Color.gray.opacity(0.1).edgesIgnoringSafeArea(.all)
            
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
                        //                        Button(action: {    // Button 5
                        //                            self.userData.imageNumber = 4
                        //                        }) {
                        //                            self.imageForButton(buttonNumber: 4)
                        //                        }
                        //                        Button(action: {    // Button 6
                        //                            self.userData.imageNumber = 5
                        //                        }) {
                        //                            self.imageForButton(buttonNumber: 5)
                        //                        }
                        //                        Button(action: {    // Button 7
                        //                            self.userData.imageNumber = 6
                        //                        }) {
                        //                            self.imageForButton(buttonNumber: 6)
                        //                        }
                        //                        Button(action: {    // Button 8
                        //                            self.userData.imageNumber = 7
                        //                        }) {
                        //                            self.imageForButton(buttonNumber: 7)
                        //                        }
                        //                        Button(action: {    // Button 9
                        //                            self.userData.imageNumber = 8
                        //                        }) {
                        //                            self.imageForButton(buttonNumber: 8)
                        //                        }
                        
                    }   // End of HStack
                    .imageScale(.medium)
                    .font(Font.title.weight(.regular))
                    .padding(.bottom, 100)
                    
                    Text("Your Followed Country's Covid-19 Data")
                    FollowUp()
                    
                }   // End of VStack
                
            }   // End of ScrollView
            .onAppear() {
                self.userData.startTimer()
            }
            .onDisappear() {
                self.userData.stopTimer()
            }
        }   // End of ZStack
        

    }
    
    func imageForButton(buttonNumber: Int) -> Image {

        if self.userData.imageNumber == buttonNumber {
            return Image(systemName: "\(buttonNumber+1).circle.fill")
        } else {
            return Image(systemName: "\(buttonNumber+1).circle")
        }
    }
    
}

struct FollowUp: View{
    
    var wholeWorldData = WorldStatStruct(totalCases: worldStatInfo.totalCases, newCases: worldStatInfo.newCases, totalDeaths: worldStatInfo.totalDeaths, newDeaths: worldStatInfo.newDeaths, totalRecovered: worldStatInfo.totalRecovered)
    var body: some View{
        TabView {
            //followedUpDataList.append(testFollowUp)
                VStack(alignment: .leading) {
                    HStack {
                        Text("Whole World's Covid-19 Cases Status")
                    }
                    .font(.system(size: 13))
                    
                    HStack{
                        VStack(alignment: .leading) {
                            Text("Confirmed")
                                .font(.system(size: 12.5))
                                .foregroundColor(.red)
                            Text("\(worldStatInfo.totalCases)")
                            HStack {
                                Image(systemName: "arrow.up")
                                    .imageScale(.small)
                                    .foregroundColor(.gray)
                                
                                Text("\(worldStatInfo.newCases)")
                                    .foregroundColor(.gray)
                                    .font(.system(size: 11))
                            }
                        }
                        Divider()
                        
                        VStack(alignment: .leading) {
                            Text("Recovered ")
                                .font(.system(size: 12.5))
                                .foregroundColor(.green)
                                .multilineTextAlignment(.leading)
                            
                            HStack {
                                Text("\(worldStatInfo.totalRecovered)")
                            }
                            
                            Text("")
                        }
                        Divider()
                        VStack(alignment: .leading) {
                            Text("Deaths")
                                .font(.system(size: 12.5))
                            Text("\(worldStatInfo.totalDeaths)")
                            
                            HStack {
                                Image(systemName: "arrow.up")
                                    .imageScale(.small)
                                    .foregroundColor(.gray)
                                
                                Text("\(worldStatInfo.newDeaths)")
                                    .foregroundColor(.gray)
                                    .font(.system(size: 11))
                            }
                        }
                    }
                    .frame(width: 250.0)
                    .font(.system(size: 12))
                    
                }
            ForEach(followedUpDataList) { followedUp in
                HStack{
                    getImageFromUrl(url: followedUp.flagImgURL, defaultFilename: "ImageUnavailable")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width:80, height: 80)
                    VStack(alignment: .leading) {
                        HStack {
                            Text(followedUp.countryName)
                        }
                        .font(.system(size: 13))
                        
                        HStack{
                            VStack(alignment: .leading) {
                                Text("Confirmed")
                                    .font(.system(size: 12.5))
                                    .foregroundColor(.red)
                                Text("\(followedUp.cases)")
                                HStack {
                                    Image(systemName: "arrow.up")
                                        .imageScale(.small)
                                        .foregroundColor(.gray)
                                    
                                    Text("\(followedUp.newCases)")
                                        .foregroundColor(.gray)
                                        .font(.system(size: 11))
                                }
                            }
                            Divider()
                            
                            VStack(alignment: .leading) {
                                Text("Recovered ")
                                    .font(.system(size: 12.5))
                                    .foregroundColor(.green)
                                    .multilineTextAlignment(.leading)
                                
                                HStack {
                                    Text("\(followedUp.totalRecovered)")
                                }
                                
                                Text("")
                            }
                            Divider()
                            VStack(alignment: .leading) {
                                Text("Deaths")
                                    .font(.system(size: 12.5))
                                Text("\(followedUp.deaths)")
                                
                                HStack {
                                    Image(systemName: "arrow.up")
                                        .imageScale(.small)
                                        .foregroundColor(.gray)
                                    
                                    Text("\(followedUp.newDeaths)")
                                        .foregroundColor(.gray)
                                        .font(.system(size: 11))
                                }
                            }
                        }
                        .frame(width: 250.0)
                        .font(.system(size: 12))
                        
                    }
                }
            }
        }   // End of TabView
        .tabViewStyle(PageTabViewStyle())
    }
}
struct Home_Previews: PreviewProvider {
    static var previews: some View {
        Home()
    }
}
