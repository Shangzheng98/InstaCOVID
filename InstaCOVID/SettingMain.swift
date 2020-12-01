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
                        TextField("Username", text: $enteredUsername)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                            .frame(width: 300, height: 36)
                            .padding()
                        //password section
                        SecureField("Password", text: $enteredPassword)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                            .frame(width: 300, height: 36)
                            .padding()
                        
                        Button(action: {
                            /*
                             UserDefaults provides an interface to the user’s defaults database,
                             where you store key-value pairs persistently across launches of your app.
                             */
                            // Retrieve the password from the user’s defaults database under the key "Password"
                            let validPassword = UserDefaults.standard.string(forKey: "Password")
                            
                            let validUsername = UserDefaults.standard.string(forKey: "Username")
                            
                            /*
                             If the user has not yet set a password, validPassword = nil
                             In this case, allow the user to login.
                             */
                            
                            if  self.enteredPassword == validPassword && self.enteredUsername == validUsername {
                                userData.userAuthenticated = true
                                self.showInvalidPasswordAlert = false
                                
                            } else {
                                self.showInvalidPasswordAlert = true
                            }
                            
                        }) {
                            Text("Login")
                                .frame(width: 100, height: 36, alignment: .center)
                                .background(
                                    RoundedRectangle(cornerRadius: 16)
                                        .strokeBorder(Color.black, lineWidth: 1))
                                .padding()
                        }
                        .alert(isPresented: $showInvalidPasswordAlert, content: { self.invalidPasswordAlert })
                        
                        //The navigation link for the forget password and username
                        NavigationLink(destination: ForgetPassword()) {
                            HStack {
                                Text("Forget Password / Username")
                                    .font(.system(size: 18))
                            }
                        }
                        .frame(minWidth: 400, maxWidth: 600, alignment: .center)
                        
                        
                        let username = UserDefaults.standard.string(forKey: "Username")
                        let password = UserDefaults.standard.string(forKey: "Password")
                        
                        if username != nil && password != nil{
                            //The navigation link for the first time set up
                            NavigationLink(destination: EditInfoSetting()) {
                                HStack {
                                    Text("Edit Personal Information")
                                        .font(.system(size: 18))
                                }
                            }
                            .frame(minWidth: 400, maxWidth: 500, alignment: .center)
                        }
                        else{
                            
                            //The navigation link for the first time set up
                            NavigationLink(destination: FirstTimeSetting()) {
                                HStack {
                                    Text("Haven't sign up yet? Click here")
                                        .font(.system(size: 18))
                                }
                            }
                            .frame(minWidth: 400, maxWidth: 500, alignment: .center)
                        }
                        
                        
                        
                        
                        
                        
                    }//end of vstack
                }//end of showsIndiator
            }//end of zStack
        }//end of navigation view
    }//end of body
    
    /*
     ------------------------------
     MARK: - Invalid Password Alert
     ------------------------------
     */
    var invalidPasswordAlert: Alert {
        Alert(title: Text("Invalid Password!"),
              message: Text("Please enter a valid Username / password to unlock the app!"),
              dismissButton: .default(Text("OK")) )
        
        // Tapping OK resets @State var showInvalidPasswordAlert to false.
    }
    
    
}

struct SettingMain_Previews: PreviewProvider {
    static var previews: some View {
        SettingMain()
    }
}


