//
//  SettingMenu.swift
//  InstaCOVID
//
//  Created by Shangzheng Ji on 12/7/20.
//  Copyright © 2020 team2. All rights reserved.
//

import SwiftUI

struct SettingMenu: View {
    @State private var Notauthenticated = true
    @State private var photo:Data? = nil
    @State private var userName:String = "not setting"
    @EnvironmentObject var userData: UserData
    @State var country = "***"
    var body: some View {
        NavigationView {
            Form {
                Section {
                    NavigationLink(destination: DisplayPersonalInfo()) {
                        loadingProfile
                    }
                }
                
                List {
                    NavigationLink(destination: FollowingListView())
                    {
                        HStack {
                            Image(systemName: "star.fill")
                                .imageScale(/*@START_MENU_TOKEN@*/.medium/*@END_MENU_TOKEN@*/)
                                .padding()
                            Text("Following List")
                        }
                    }
                    
                    NavigationLink(destination: ManageSelfQuarantine()) {
                        HStack {
                            Image(systemName: "cross.circle")
                                .imageScale(.medium)
                                .padding()
                            Text("Self-Quarantine Card")
                        }
                    }
                }
                
                
                List {
                    NavigationLink(destination: DiagnisisHistoryView()) {
                        HStack {
                            Image(systemName: "rectangle.stack.badge.person.crop")
                                .imageScale(.medium)
                                .padding()
                            
                            Text("Diagnisis Record list")
                            
                            
                        }
                        
                        
                        
                    }
                }
            }
            .navigationBarTitle(Text("Me"), displayMode: .inline)
        }
        .onAppear(perform: {
            photo = userData.profilePhoto
            userName = UserDefaults.standard.string(forKey:"Username") ?? "not login"
            country = UserDefaults.standard.string(forKey: "LivingCountry") ?? "***"
        })
        
        
    }
    
    var loadingProfile : some View {
        
        return AnyView(HStack {
            if photo != nil{
                getImageFromBinaryData(binaryData: userData.profilePhoto, defaultFilename: "DefaultContactPhoto")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 100,height: 100)
                    .clipShape(Circle())
                    .overlay(
                        Circle().stroke(Color.white, lineWidth: 1)
                    )
                    .shadow(radius: 5)
                    .padding()
            }
            else{
                Image("DefaultContactPhoto")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 100,height: 100)
                    .clipShape(Circle())
                    .overlay(
                        Circle().stroke(Color.white, lineWidth: 1)
                    )
                    .shadow(radius: 5)
                    .padding()
            }
            VStack {
                Text(userName)
                    .font(.headline)
                    .foregroundColor(.secondary)
                    .fixedSize(horizontal: false, vertical: /*@START_MENU_TOKEN@*/true/*@END_MENU_TOKEN@*/)
                    .multilineTextAlignment(.leading)
                Text("Country: \(country)")
            }
            
        })
    }
}

struct SettingMenu_Previews: PreviewProvider {
    static var previews: some View {
        SettingMenu()
    }
}
