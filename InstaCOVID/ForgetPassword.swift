//
//  ForgetPassword.swift
//  InstaCOVID
//
//  Created by Tenghui Zhang on 11/22/20.
//  Copyright © 2020 team2. All rights reserved.
//

import SwiftUI

struct ForgetPassword: View {
    //The initialze variable
    //The view when the forget oasswird is clicked
    @State private var showEnteredValues = false
    @State private var textFieldValue = ""
    @State private var checkAnswer = false
    var body: some View {
        Form{
            Section(header: Text("Show / Hide Entered Values")){
                Toggle(isOn: $showEnteredValues){
                    Text("Show Entered Value")
                }
            }
            //The security question section
            Section(header: Text("Security Question")){
                let question = UserDefaults.standard.string(forKey: "Question")
                
                Text("\(question!)")
            }
            
            
            //The answer for the selected security question
            Section(header: Text("Enter answer to selected security question")){
                HStack{
                    let answer = UserDefaults.standard.string(forKey: "Answer")
                    if self.showEnteredValues{
                        TextField("Enter Answer", text: $textFieldValue,
                                  onCommit: {
                                    // Record entered value after Return key is pressed
                                    
                                    if answer == self.textFieldValue{
                                        checkAnswer = true
                                    }
                                    else{
                                        checkAnswer = false
                                    }
                                  }
                                  
                        )
                        .keyboardType(.numbersAndPunctuation)
                        .frame(maxHeight: 50, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                    }
                    else{
                        SecureField("Enter Answer", text: $textFieldValue,
                                    onCommit: {
                                        // Record entered value after Return key is pressed
                                        if answer == self.textFieldValue{
                                            checkAnswer = true
                                        }
                                        else{
                                            checkAnswer = false
                                        }
                                    }
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
                }
                
            }
            //See the checkanswer variable for the question answer is the same with the userdata answer saved
            if checkAnswer{
                Section(header: Text("Go to settings to reset password")){
                    HStack{
                        Image(systemName: "gear").foregroundColor(/*@START_MENU_TOKEN@*/.blue/*@END_MENU_TOKEN@*/)
                        NavigationLink(destination: Settings()){
                            Text("Show Settings")
                        }
                    }
                }
            }
            else{
                Section(header: Text("Incorrect Answer")){
                    Text("Answer to the Security Question is incorrect!")
                }
            }
            
            
        }.navigationBarTitle(Text("Password Reset"), displayMode: .inline)
        //End of form
    }//End of body
}

struct ForgetPassword_Previews: PreviewProvider {
    static var previews: some View {
        ForgetPassword()
    }
}
