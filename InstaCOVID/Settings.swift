//
//  Settings.swift
//  InstaCOVID
//
//  Created by Tenghui Zhang on 11/25/20.
//  Copyright © 2020 team2. All rights reserved.
//

import SwiftUI

struct Settings: View {
    /*
     Display this view as a Modal View and enable it to dismiss itself
     to go back to the previous view in the navigation hierarchy.
     */
    @Environment(\.presentationMode) var presentationMode
    let searchCategories = ["In what city or town did your mother and father meet?", "In what city or town were you born?", "What did you want to be when you grew up?", "What do you remember most from your childhood?", "What is the name of the boy or girl that you first kissed?", "What is the name of the first school you attended?", "What is the name of your favourite childhood friend?", "What is the name of your first pet?", "What is your mother's maiden name?", "What was your favorite place to visit as a child?"]
    @State private var showEnteredValues = false
    @State private var selectedIndex = 4
    //Answer
    @State private var textFieldValue = ""
    //Username
    @State private var textField1Value = ""
    //Password
    @State private var textField2Value = ""
    //Verify Password
    @State private var textField3Value = ""
    @State private var showUnmatchedPasswordAlert = false
    @State private var showPasswordSetAlert = false
    var body: some View {
  //      NavigationView{
            Form{
                
                Section(header: Text("Show / Hide Entered Values")){
                    Toggle(isOn: $showEnteredValues){
                        Text("Show Entered Value")
                    }
                }.alert(isPresented: $showPasswordSetAlert, content: { self.passwordSetAlert })
                //Choosing the different questions for the security
                Section(header: Text("Select a Security Question")){
                    Picker("Selected:", selection: $selectedIndex) {
                        ForEach(0 ..< searchCategories.count, id: \.self) {
                            Text(searchCategories[$0]).font(.system(size: 12))
                        }
                        
                        
                    }
                    .frame(minWidth: 300, maxWidth: 500)
                    
                }
                
                //Aswer the question and save it to the userdata
                Section(header: Text("Enter answer to selected security question")){
                    HStack {
                        if self.showEnteredValues{
                            TextField("Enter Answer", text: $textFieldValue
                            )
                            .keyboardType(.numbersAndPunctuation)
                            .frame(maxHeight: 50, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                            
                        }
                        else{
                            SecureField("Enter Answer", text: $textFieldValue
                            )
                            .keyboardType(.numbersAndPunctuation)
                            .frame(maxHeight: 50, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                            
                        }
                        
                        
                        // Button to clear the text field
                        Button(action: {
                            self.textFieldValue = ""
                        }) {
                            Image(systemName: "clear")
                                .imageScale(.medium)
                                .font(Font.title.weight(.regular))
                        }
                    }   // End of HStack
                    .frame(minWidth: 300, maxWidth: 500)
                }
                //Save the password to the user data
                Section(header: Text("Enter Username")){
                    HStack {
                        if self.showEnteredValues{
                            TextField("Enter Username", text: $textField1Value
                            )
                            .keyboardType(.numbersAndPunctuation)
                            .frame(maxHeight: 50, alignment: .center
                            )
                        }
                        else{SecureField("Enter Password", text: $textField1Value
                                         
                        )
                        .keyboardType(.numbersAndPunctuation)
                        .frame(maxHeight: 50, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)}
                        
                        
                        // Button to clear the text field
                        Button(action: {
                            self.textField1Value = ""
                        }) {
                            Image(systemName: "clear")
                                .imageScale(.medium)
                                .font(Font.title.weight(.regular))
                        }
                    }   // End of HStack
                    .frame(minWidth: 300, maxWidth: 500)
                }
                //Save the password to the user data
                Section(header: Text("Enter Password")){
                    HStack {
                        if self.showEnteredValues{
                            TextField("Enter Password", text: $textField2Value
                            )
                            .keyboardType(.numbersAndPunctuation)
                            .frame(maxHeight: 50, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                        }
                        else{SecureField("Enter Password", text: $textField2Value
                                         
                        )
                        .keyboardType(.numbersAndPunctuation)
                        .frame(maxHeight: 50, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)}
                        
                        
                        // Button to clear the text field
                        Button(action: {
                            self.textField2Value = ""
                        }) {
                            Image(systemName: "clear")
                                .imageScale(.medium)
                                .font(Font.title.weight(.regular))
                        }
                    }   // End of HStack
                    .frame(minWidth: 300, maxWidth: 500)
                }
                //Check the value for the password is the same
                Section(header: Text("Verify Password")){
                    HStack {
                        if self.showEnteredValues{
                            TextField("Verify Password", text: $textField3Value
                                      
                            )
                            .keyboardType(.numbersAndPunctuation)
                            .frame(maxHeight: 50, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                        }
                        else{SecureField("Verify Password", text: $textField3Value
                        )
                        .keyboardType(.numbersAndPunctuation)
                        .frame(maxHeight: 50, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)}
                        
                        
                        // Button to clear the text field
                        Button(action: {
                            self.textField3Value = ""
                        }) {
                            Image(systemName: "clear")
                                .imageScale(.medium)
                                .font(Font.title.weight(.regular))
                        }
                    }   // End of HStack
                    .frame(minWidth: 300, maxWidth: 500)
                }
                //If it is the same save the value
                Section(header: Text("Set Password")){
                    Button(action: {
                        if !textField2Value.isEmpty {
                            if textField2Value == textField3Value {
                                /*
                                 UserDefaults provides an interface to the user’s defaults database,
                                 where you store key-value pairs persistently across launches of your app.
                                 */
                                // Store the password in the user’s defaults database under the key "Password"
                                UserDefaults.standard.set(self.textField2Value, forKey: "Password")
                            
                                UserDefaults.standard.set(searchCategories[selectedIndex], forKey: "Question")
                                
                                UserDefaults.standard.set(textFieldValue, forKey: "Answer")
                                
                                UserDefaults.standard.set(textField1Value, forKey: "Username")
                                
                                
                                
                                //Initialize the value
                                self.textFieldValue = ""
                                self.textField1Value = ""
                                self.textField2Value = ""
                                self.textField3Value = ""
                                self.showPasswordSetAlert = true
                                // Dismiss this View and go back
                                self.presentationMode.wrappedValue.dismiss()
                                
                            } else {
                                self.showUnmatchedPasswordAlert = true
                            }
                        }
                    }) {
                        Text("Set Password to Unlock App")
                            .frame(width: 300, height: 36, alignment: .center)
                            .background(
                                RoundedRectangle(cornerRadius: 16)
                                    .strokeBorder(Color.black, lineWidth: 1)
                            )
                    }
                    .alert(isPresented: $showUnmatchedPasswordAlert, content: { self.unmatchedPasswordAlert })
                    
                }
                
                
            }
            //End of form
            
            
      //  } //End of NavigationView
    } // End of body
    /*
     --------------------------
     MARK: - Password Set Alert
     --------------------------
     */
    var passwordSetAlert: Alert {
        Alert(title: Text("Password Set!"),
              message: Text("Password you entered is set to unlock the app!"),
              dismissButton: .default(Text("OK")) )
    }
    /*
     --------------------------------
     MARK: - Unmatched Password Alert
     --------------------------------
     */
    var unmatchedPasswordAlert: Alert {
        Alert(title: Text("Unmatched Password!"),
              message: Text("Two entries of the password must match!"),
              dismissButton: .default(Text("OK")) )
    }
}
struct Settings_Previews: PreviewProvider {
    static var previews: some View {
        Settings()
    }
}
