//
//  SettingMain.swift
//  InstaCOVID
//
//  Created by Tenghui Zhang on 11/22/20.
//  Copyright © 2020 team2. All rights reserved.
//

import SwiftUI

struct SettingMain: View {
    // Subscribe to changes in UserData
    @EnvironmentObject var userData: UserData
    
    @State private var enteredPassword = ""
    @State private var showInvalidPasswordAlert = false
    @State private var enteredUsername = ""
    @State private var showInvalidUsernameAlert = false
    
    var body: some View {
        NavigationView{
            ZStack {
                //The log view for the log view with the welcome picture, password blank , log and forget section
                Color.gray.opacity(0.1).edgesIgnoringSafeArea(.all)
                ScrollView(.vertical, showsIndicators: false) {
                    VStack {
                        Image("LoginImage")
                            .resizable()
                            .frame(width: 200, height: 120, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                    
                        //Username section
                        SecureField("Username", text: $enteredUsername)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                            .frame(width: 300, height: 36)
                            .padding()
                        //password section
                        SecureField("Password", text: $enteredPassword)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                            .frame(width: 300, height: 36)
                            .padding()
                        
                        
                        
                    }//end of vstack
                }//end of showsIndiator
            }//end of zStack
        }//end of navigation view
    }//end of body
    /*
     ------------------------------
     MARK: - Invalid Username Alert
     ------------------------------
     */
    var invalidUsernameAlert: Alert {
        Alert(title: Text("Invalid Username!"),
              message: Text("Please enter a valid username to unlock the app!"),
              dismissButton: .default(Text("OK")) )
        
        // Tapping OK resets @State var showInvalidPasswordAlert to false.
    }
    
    /*
     ------------------------------
     MARK: - Invalid Password Alert
     ------------------------------
     */
    var invalidPasswordAlert: Alert {
        Alert(title: Text("Invalid Password!"),
              message: Text("Please enter a valid password to unlock the app!"),
              dismissButton: .default(Text("OK")) )
        
        // Tapping OK resets @State var showInvalidPasswordAlert to false.
    }
    
    
}

struct SettingMain_Previews: PreviewProvider {
    static var previews: some View {
        SettingMain()
    }
}
