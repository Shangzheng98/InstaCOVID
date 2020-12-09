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
    let imageSliderPhotoCaptions = ["Covid-19 Protection", "Wash Your Hands", "We can Overcome Together", "Take Care", "Protect Your Grandparents"]
    
    var body: some View {
        ZStack {        // Background
            Color.white.opacity(0.1).edgesIgnoringSafeArea(.all)
            VStack {
                VStack {
                    Image("start")
                        .resizable()
                        .frame(height: 200, alignment: .center)
                        .edgesIgnoringSafeArea(.horizontal)
                        .padding(.top, 20)
                    Image("photo\(userData.imageNumber + 1)")
                        .resizable()
                        //.aspectRatio(contentMode: .fill)
                        .frame(width: 400, height: 250, alignment: .center)
                        //.padding(.top, 30)
                        //.padding(.bottom, 5)
                        .padding(.horizontal)
                    Link(destination: URL(string: "https://www.cdc.gov/coronavirus/2019-ncov/")!) {
                        HStack{
                        Text("\(imageSliderPhotoCaptions[userData.imageNumber])")
                            .font(homeFont)
                            //.padding(.bottom, 5)
                            Image(systemName: "arrow.turn.up.right")
                                .imageScale(.small)
                                .font(Font.title.weight(.light))
                        }
                    }
                    
                    
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
                        Button(action: {    // Button 5
                            self.userData.imageNumber = 4
                        }) {
                            self.imageForButton(buttonNumber: 4)
                        }

                    }   // End of HStack
                    .imageScale(.small)
                    .font(Font.title.weight(.light))
                    .padding(.bottom, 90)
                    .foregroundColor(.black)

                }   // End of VStack
                .onAppear() {
                    self.userData.startTimer()
                }
                .onDisappear() {
                    self.userData.stopTimer()
                }
                
                Text("Your Followed Country's Covid-19 Data")
                    .font(homeFont)
                    //.foregroundColor(.newPink)
                    .padding(.top, -60)
                FollowUp()
                    .background(Color.newGray)
                    .clipShape(RoundedRectangle(cornerRadius: 16, style: .continuous))
                    //.frame(width: UIScreen.main.bounds.width, height: 150, alignment: .center)
                    .padding(.bottom)
            }
                
        }   // End of ZStack
        .edgesIgnoringSafeArea(.all)
        
    }   // End of body
        
    func imageForButton(buttonNumber: Int) -> Image {

        if self.userData.imageNumber == buttonNumber {
            return Image(systemName: "\(buttonNumber+1).circle.fill")
        } else {
            return Image(systemName: "\(buttonNumber+1).circle")
        }
    }
}
struct FollowUp: View{
    @EnvironmentObject var userData: UserData
    var body: some View{
//        ZStack{
//            Image("home").resizable().edgesIgnoringSafeArea(.horizontal).padding(.bottom, 45)
        ScrollView(.horizontal,showsIndicators: false) {
            
            HStack {
                VStack {
                    HStack {
                        Text("Whole World's Covid-19 Cases Status")
                    }
                    .font(.system(size: 13))
                    
                    HStack{
                        VStack(alignment: .center) {
                            Text("Confirmed")
                                .font(.system(size: 13))
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
                        
                        VStack(alignment: .center) {
                            Text("Recovered")
                                .font(.system(size: 13))
                                .foregroundColor(.green)
                                .multilineTextAlignment(.leading)
                            
                            HStack {
                                Text("\(worldStatInfo.totalRecovered)")
                            }
                            
                            Text("")
                        }
                        Divider()
                        VStack(alignment: .center) {
                            Text("Deaths")
                                .font(.system(size: 13))
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
                    .frame(width: UIScreen.main.bounds.width, height: 100)
                    .font(.system(size: 13))
                }
                .padding(.bottom, 45)
                ForEach(userData.followedCountriesList) {
                    followUp in DataListItem(country: followUp)
                        .frame(width: UIScreen.main.bounds.width, height: 100)
                }
            }
   //         }
        }
        
//                DataListItem(country: WorldDataStruct(id: UUID(), countryName: "Afghanistan", cases: 840, deaths: 30, totalRecovered: 54, newDeaths: 5, newCases: 56, lat: 33, long: 65, flagImgURL: "https://manta.cs.vt.edu/iOS/flags/af.png",flagImageName: "af"))
//                DataListItem(country: WorldDataStruct(id: UUID(), countryName: "Afghanistan", cases: 840, deaths: 30, totalRecovered: 54, newDeaths: 5, newCases: 56, lat: 33, long: 65, flagImgURL: "https://manta.cs.vt.edu/iOS/flags/af.png",flagImageName: "af"))
//                DataListItem(country: WorldDataStruct(id: UUID(), countryName: "Afghanistan", cases: 840, deaths: 30, totalRecovered: 54, newDeaths: 5, newCases: 56, lat: 33, long: 65, flagImgURL: "https://manta.cs.vt.edu/iOS/flags/af.png",flagImageName: "af"))
            
            
        
    }
}

struct Home_Previews: PreviewProvider {
    static var previews: some View {
        Home()
    }
}
