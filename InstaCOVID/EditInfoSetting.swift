//
//  EditInfoSetting.swift
//  InstaCOVID
//
//  Created by Tenghui Zhang on 11/22/20.
//  Copyright © 2020 team2. All rights reserved.
//

import SwiftUI

struct EditInfoSetting: View {
    /*
     Display this view as a Modal View and enable it to dismiss itself
     to go back to the previous view in the navigation hierarchy.
     */
    @Environment(\.presentationMode) var presentationMode
    @EnvironmentObject var userData: UserData
    //The initialize of the variable
    let selectionList = ["Camera", "Library"]
    //Initialize binding variable
    @Binding var name : String
    @Binding var photo: Data?
    @Binding var gender: String
    @Binding var birth: String
    @Binding var nationality: String
    @Binding var phone: String
    @Binding var identity: String
    @Binding var country: String
    
   // @State private var nameTextFieldValue = ""
   // @State private var verifyTextField = ""
    @State private var showmissingInputDataAlert = false
    @State private var showSavingInputDataAlert = false
    @State private var selectedIndex = 0
    @State private var selectionGenderList = ["Male", "Female"]
    //@State private var photoImageData:Data? = nil
    @State private var selectedGenderIndex = 0
    @State private var showImagePicker = false
    @State private var dateAndTime = Date()
    var dateClosedRange: ClosedRange<Date> {
        // Set minimum date to 100 years earlier than the current year
        let minDate = Calendar.current.date(byAdding: .year, value: -100, to: Date())!
        
        // Set maximum date to 2 years later than the current year
        let maxDate = Calendar.current.date(byAdding: .year, value: 2, to: Date())!
        return minDate...maxDate
    }
    let searchCategories = ["In what city or town did your mother and father meet?", "In what city or town were you born?", "What did you want to be when you grew up?", "What do you remember most from your childhood?", "What is the name of the boy or girl that you first kissed?", "What is the name of the first school you attended?", "What is the name of your favourite childhood friend?", "What is the name of your first pet?", "What is your mother's maiden name?", "What was your favorite place to visit as a child?"]
    @State private var selectedIndexForQuestion = 4
    //Answer
    @State private var textFieldValue = ""
    
    
    var body: some View {
        //    NavigationView{
        Form{
            Group{
                //The name section
                Section(header: Text("Name")){
                    TextField("Enter your name", text: $name)
//                    TextField("Enter your name", text: $name)
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
                                                 photoImageData: self.$photo,
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
                                                 photoImageData: self.$photo,
                                                 cameraOrLibrary: "Photo Library")
                            }
                        }
                        //}
                    }//end of vstack
                    //}//end of form
                    
                    //Check the picture is taken or not, if not use the default setting
                    
                    if photo != nil{
                        Section(header: Text("")) {
                            getImageFromBinaryData(binaryData: self.photo, defaultFilename: "DefaultContactPhoto")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(minWidth: 100, maxWidth: 100, alignment: .center)
                            
                        }
                    }
                    else{
                        Section(header: Text(" ")) {
                            Image("DefaultContactPhoto")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(minWidth: 100, maxWidth: 100, alignment: .center)
                            
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
                    TextField("Enter your nationality", text: $nationality)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .disableAutocorrection(true)
                        .autocapitalization(.words)
                }.alert(isPresented: $showmissingInputDataAlert, content: { self.missingInputDataAlert })
                
                //Phone number section
                Section(header: Text("Phone Number")){
                    TextField("Enter your phone number", text: $phone)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .disableAutocorrection(true)
                        .autocapitalization(.words)
                }.alert(isPresented: $showmissingInputDataAlert, content: { self.missingInputDataAlert })
                
                //Identity section
                Section(header: Text("Identity")){
                    TextField("Enter your job", text: $identity)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .disableAutocorrection(true)
                        .autocapitalization(.words)
                }.alert(isPresented: $showmissingInputDataAlert, content: { self.missingInputDataAlert })
                
                //Current living country
                Section(header: Text("Current living country")){
                    TextField("Enter your current living country", text: $country)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .disableAutocorrection(true)
                        .autocapitalization(.words)
                }.alert(isPresented: $showmissingInputDataAlert, content: { self.missingInputDataAlert })
                
                
                
                
            }//end of group
            
            //Save button
            Section(header: Text("Save profile")){
                Button(action: {
                    if (!name.isEmpty || photo != nil || !nationality.isEmpty || !phone.isEmpty || !identity.isEmpty || !country.isEmpty) {
                        /*
                         UserDefaults provides an interface to the user’s defaults database,
                         where you store key-value pairs persistently across launches of your app.
                         */
                        // Store the password in the user’s defaults database under the key "Password"
                        UserDefaults.standard.set(name, forKey: "Name")
                        
                        
                        UserDefaults.standard.set(selectionGenderList[selectedGenderIndex], forKey: "Gender")
                        gender = selectionGenderList[selectedGenderIndex]
                        if photo != nil {
                            UserDefaults.standard.set(photo, forKey: "Photo")
                        
                            userData.profilePhoto = photo
                        }
                        
                        // Create an instance of DateFormatter
                        let dateFormatter2 = DateFormatter()
                        
                        // Set the date format to yyyy-MM-dd
                        dateFormatter2.dateFormat = "yyyy-MM-dd"
                        
                        // Format dateAndTime under the dateFormatter and convert it to String
                        
                        let travelDate = dateFormatter2.string(from: dateAndTime)
                        
                        
                        UserDefaults.standard.set(travelDate, forKey: "Birth")
                        birth = travelDate
                        
                        UserDefaults.standard.set(nationality, forKey: "Nationality")
                      
                        UserDefaults.standard.set(phone, forKey: "Phone")

                        UserDefaults.standard.set(identity, forKey: "Identity")
                        
                        UserDefaults.standard.set(country, forKey: "LivingCountry")
                        
                        
                        // Dismiss this View and go back
                        self.presentationMode.wrappedValue.dismiss()
                     //   self.updateInfo()
                        showSavingInputDataAlert = true
                        
                    }
                    else{
                        showmissingInputDataAlert = true
                    }
                }) {
                    Text("Save all the personal information")
                        .frame(width: 300, height: 36, alignment: .center)
                        .background(
                            RoundedRectangle(cornerRadius: 16)
                                .strokeBorder(Color.black, lineWidth: 1)
                        )
                }
                
            }.alert(isPresented: $showSavingInputDataAlert, content: { self.saveInputDataAlert })
            
            
        }.navigationBarTitle(Text("Setting up personal account"), displayMode: .inline)//End of form
        // }//end of navigation view
    }//end of body
    /*
     --------------------------------
     MARK: - Missing Input Data Alert
     --------------------------------
     */
    var missingInputDataAlert: Alert {
        Alert(title: Text("Wrong Infromation!"),
              message: Text("Please enter Information!"),
              dismissButton: .default(Text("OK")) )
        /*
         Tapping OK resets @State var showMissingInputDataAlert to false.
         */
    }
    
    /*
     --------------------------------
     MARK: - Add success Input Data Alert
     --------------------------------
     */
    var saveInputDataAlert: Alert {
        Alert(title: Text("Congratulation!"),
              message: Text("You are successfully save your account!"),
              dismissButton: .default(Text("OK")))
        /*
         Tapping OK resets @State var showMissingInputDataAlert to false.
         */
    }

}
