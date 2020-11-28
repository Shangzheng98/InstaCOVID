//
//  FirstTimeSetting.swift
//  InstaCOVID
//
//  Created by Tenghui Zhang on 11/25/20.
//  Copyright © 2020 team2. All rights reserved.
//

import SwiftUI
var personalInfo = PersonalInformationStruct(name: "", gender: "", dateOfBirth: "", nationality: "", phoneNumber: "", identity: "", country: "", username: "", password: "")

struct FirstTimeSetting: View {
    /*
     Display this view as a Modal View and enable it to dismiss itself
     to go back to the previous view in the navigation hierarchy.
     */
    @Environment(\.presentationMode) var presentationMode
    //The initialize of the variable
    let selectionList = ["Camera", "Library"]
    @State private var nameTextFieldValue = ""
    @State private var showmissingInputDataAlert = false
    @State private var selectedIndex = 0
    @State private var selectionGenderList = ["Male", "Female"]
    @State private var selectedGenderIndex = 0
    @State private var photoImageData: Data? = nil
    @State private var showImagePicker = false
    @State private var dateAndTime = Date()
    var dateClosedRange: ClosedRange<Date> {
        // Set minimum date to 100 years earlier than the current year
        let minDate = Calendar.current.date(byAdding: .year, value: -100, to: Date())!
        
        // Set maximum date to 2 years later than the current year
        let maxDate = Calendar.current.date(byAdding: .year, value: 2, to: Date())!
        return minDate...maxDate
    }
    
    @State private var nationalityTextFieldValue = ""
    @State private var phoneTextFieldValue = ""
    @State private var identityTextFieldValue = ""
    @State private var currentLivingCountryTextFieldValue = ""
    @State private var usernameTextFieldValue = ""
    @State private var passwordTextFieldValue = ""
    
    var body: some View {
        NavigationView{
            Form{
                Group{
                    //The name section
                    Section(header: Text("Name")){
                        TextField("Enter your name", text: $nameTextFieldValue)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                            .disableAutocorrection(true)
                            .autocapitalization(.words)
                    }.alert(isPresented: $showmissingInputDataAlert, content: { self.missingInputDataAlert })
                    HStack{
                        // Form{
                        VStack{
                            //The picture section for the section picker with take photo or photo library
                            //   Section(){
                            Picker("Photo", selection: $selectedIndex) {
                                ForEach(0 ..< selectionList.count, id: \.self) {
                                    Text(self.selectionList[$0])
                                }
                            }
                            .pickerStyle(SegmentedPickerStyle())
                            .padding()
                            //Check the selseteIndex for the different picture way
                            if(selectedIndex == 0){
                                Button(action: {
                                    self.showImagePicker = true
                                }) {
                                    HStack {
                                        Image(systemName: "square.and.arrow.up.on.square")
                                            .imageScale(.small)
                                            .font(Font.title.weight(.regular))
                                            .foregroundColor(.blue)
                                        Text("Open Camera")
                                    }
                                }.sheet(isPresented: self.$showImagePicker) {
                                    PhotoCaptureView(showImagePicker: self.$showImagePicker,
                                                     photoImageData: self.$photoImageData,
                                                     cameraOrLibrary: "Camera")
                                }
                                
                            }
                            else{
                                Button(action: {
                                    self.showImagePicker = true
                                }) {
                                    HStack {
                                        Image(systemName: "square.and.arrow.up.on.square")
                                            .imageScale(.small)
                                            .font(Font.title.weight(.regular))
                                            .foregroundColor(.blue)
                                        Text("Open Photo Library")
                                    }
                                }.sheet(isPresented: self.$showImagePicker) {
                                    PhotoCaptureView(showImagePicker: self.$showImagePicker,
                                                     photoImageData: self.$photoImageData,
                                                     cameraOrLibrary: "Photo Library")
                                }
                            }
                            //}
                        }//end of vstack
                        //}//end of form
                        
                        //Check the picture is taken or not, if not use the default setting
                        
                        if photoImageData != nil{
                            Section(header: Text("")) {
                                getImageFromBinaryData(binaryData: self.photoImageData, defaultFilename: "DefaultContactPhoto")
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(minWidth: 100, maxWidth: 100, alignment: .center)
                                
                            }
                        }
                        else{
                            Section(header: Text("")) {
                                Image("DefaultContactPhoto")
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(minWidth: 135, maxWidth: 135, alignment: .center)
                                
                            }
                        }
                    }//end of HStack
                    //The gender section
                    
                    Section(header: Text("Gender")){
                        Picker("Priority", selection: $selectedGenderIndex) {
                            ForEach(0 ..< selectionGenderList.count, id: \.self) {
                                Text(self.selectionGenderList[$0])
                            }
                        }
                    }.pickerStyle(SegmentedPickerStyle())
                    
                    //The date of birth
                    Section(header: Text("Date of Birth")){
                        DatePicker(
                            selection: $dateAndTime,
                            in: dateClosedRange,
                            displayedComponents: [.date]  // 🔴 Sets DatePicker to pick a date and time
                        ){
                            Text("Please select date of birth")
                                .font(.system(size: 14))
                        }
                        
                    }.alert(isPresented: $showmissingInputDataAlert, content: { self.missingInputDataAlert })
                    
                    //Nationality section
                    Section(header: Text("Nationality")){
                        TextField("Enter your nationality", text: $nationalityTextFieldValue)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                            .disableAutocorrection(true)
                            .autocapitalization(.words)
                    }.alert(isPresented: $showmissingInputDataAlert, content: { self.missingInputDataAlert })
                    
                    //Phone number section
                    Section(header: Text("Phone Number")){
                        TextField("Enter your phone number", text: $phoneTextFieldValue)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                            .disableAutocorrection(true)
                            .autocapitalization(.words)
                    }.alert(isPresented: $showmissingInputDataAlert, content: { self.missingInputDataAlert })
                    
                    //Identity section
                    Section(header: Text("Identity")){
                        TextField("Enter your job", text: $identityTextFieldValue)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                            .disableAutocorrection(true)
                            .autocapitalization(.words)
                    }.alert(isPresented: $showmissingInputDataAlert, content: { self.missingInputDataAlert })
                    
                    //Current living country
                    Section(header: Text("Current living country")){
                        TextField("Enter your current living country", text: $currentLivingCountryTextFieldValue)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                            .disableAutocorrection(true)
                            .autocapitalization(.words)
                    }.alert(isPresented: $showmissingInputDataAlert, content: { self.missingInputDataAlert })
                    
                    //Username section
                    Section(header: Text("Username")){
                        HStack {
                            TextField("Enter Username", text: $usernameTextFieldValue
                            )
                            .keyboardType(.numbersAndPunctuation)
                            .frame(maxHeight: 50, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                            
                            // Button to clear the text field
                            Button(action: {
                                self.usernameTextFieldValue = ""
                            }) {
                                Image(systemName: "clear")
                                    .imageScale(.medium)
                                    .font(Font.title.weight(.regular))
                            }
                        }   // End of HStack
                        .frame(minWidth: 300, maxWidth: 500)
                    }
                    
                    //password section
                    Section(header: Text("Password")){
                        HStack {
                            TextField("Enter Password", text: $passwordTextFieldValue
                            )
                            .keyboardType(.numbersAndPunctuation)
                            .frame(maxHeight: 50, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                            
                            
                            
                            // Button to clear the text field
                            Button(action: {
                                self.passwordTextFieldValue = ""
                            }) {
                                Image(systemName: "clear")
                                    .imageScale(.medium)
                                    .font(Font.title.weight(.regular))
                            }
                        }   // End of HStack
                        .frame(minWidth: 300, maxWidth: 500)
                    }
                }//end of group
                //Save button
                Section(header: Text("Save profile")){
                    Button(action: {
                        if !usernameTextFieldValue.isEmpty || !passwordTextFieldValue.isEmpty{
                            /*
                             UserDefaults provides an interface to the user’s defaults database,
                             where you store key-value pairs persistently across launches of your app.
                             */
                            // Store the password in the user’s defaults database under the key "Password"
                            UserDefaults.standard.set(self.nameTextFieldValue, forKey: "Name")
                            
                            UserDefaults.standard.set(selectionGenderList[selectedGenderIndex], forKey: "Gender")
                            
                            UserDefaults.standard.set(photoImageData, forKey: "Photo")
                            
                            UserDefaults.standard.set(dateAndTime, forKey: "Birth")
                            
                            UserDefaults.standard.set(nationalityTextFieldValue, forKey: "Nationality")
                            
                            UserDefaults.standard.set(phoneTextFieldValue, forKey: "Phone")
                            UserDefaults.standard.set(identityTextFieldValue, forKey: "Identity")
                            UserDefaults.standard.set(currentLivingCountryTextFieldValue, forKey: "LivingCountry")
                            UserDefaults.standard.set(usernameTextFieldValue, forKey: "Username")
                            UserDefaults.standard.set(passwordTextFieldValue, forKey: "Password")
                            // Dismiss this View and go back
                            self.presentationMode.wrappedValue.dismiss()
                            
                            
                        }
                    }) {
                        Text("Save all the personal information")
                            .frame(width: 300, height: 36, alignment: .center)
                            .background(
                                RoundedRectangle(cornerRadius: 16)
                                    .strokeBorder(Color.black, lineWidth: 1)
                            )
                    }
                    
                }
                
                
            }.navigationBarTitle(Text("Setting up personal account"), displayMode: .inline)//End of form
        }//end of navigation view
    }//end of body
    /*
     --------------------------------
     MARK: - Missing Input Data Alert
     --------------------------------
     */
    var missingInputDataAlert: Alert {
        Alert(title: Text("Missing Infromation!"),
              message: Text("Please enter Information!"),
              dismissButton: .default(Text("OK")) )
        /*
         Tapping OK resets @State var showMissingInputDataAlert to false.
         */
    }
}

struct FirstTimeSetting_Previews: PreviewProvider {
    static var previews: some View {
        FirstTimeSetting()
    }
}
