//
//  DisplayPersonalInfo.swift
//  InstaCOVID
//
//  Created by Tenghui Zhang on 11/22/20.
//  Copyright © 2020 team2. All rights reserved.
//

import SwiftUI

struct DisplayPersonalInfo: View {
    @State private var photo:Data? = nil
    @State private var name = ""
    @State private var gender = ""
    @State private var birth = ""
    @State private var nationality = ""
    @State private var phone = ""
    @State private var identity = ""
    @State private var country = ""
    
    
    var body: some View {
        
        
            Form{
                //The picture section
                Section(header: Text("")){
                    if photo != nil{
                        getImageFromBinaryData(binaryData: photo, defaultFilename: "DefaultContactPhoto")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(maxWidth: 500, alignment: .center)
                    }
                    else{
                        Image("DefaultContactPhoto")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(maxWidth: 500, alignment: .center)
                    }
                    
                }
                
                //The name section
                Section(header: Text("Name")){
                    Text(name)
                }
                
                
                //The gender section
                
                Section(header: Text("Gender")){
                    Text(gender)
                }
                
                //The date of birth
                Section(header: Text("Date of Birth")){
                    Text(birth)
                    
                }
                
                //Nationality section
                Section(header: Text("Nationality")){
                    Text(nationality)
                }
                
                //Phone number section
                Section(header: Text("Phone Number")){
                    Text(phone)
                }
                
                //Identity section
                Section(header: Text("Identity")){
                    Text(identity)
                }
                
                //Current living country
                Section(header: Text("Current living country")){
                    Text(country)
                }
                
                //Edit information
                Section(header: Text("Change profile")){
                    //The navigation link for the first time set up
                    NavigationLink(destination: EditInfoSetting(name: $name, photo: $photo, gender: $gender, birth: $birth, nationality: $nationality, phone: $phone, identity: $identity, country: $country)) {
                        HStack {
                            Image(systemName: "square.and.pencil")
                            Text("Edit Personal Information")
                                .font(.system(size: 18))
                                .foregroundColor(.blue)
                        }
                    }
                    .frame(minWidth: 400, maxWidth: 500, alignment: .center)
                
                
                
                
                
                
            }
                .navigationBarTitle(Text("Personal Account Information"), displayMode: .inline)//End of form
        }.onAppear {
            photo = UserDefaults.standard.data(forKey: "Photo")
            name = UserDefaults.standard.string(forKey: "Name")!
            gender = UserDefaults.standard.string(forKey: "Gender")!
            birth = UserDefaults.standard.string(forKey: "Birth")!
            nationality = UserDefaults.standard.string(forKey: "Nationality")!
            phone = UserDefaults.standard.string(forKey: "Phone")!
            identity = UserDefaults.standard.string(forKey: "Identity")!
            country = UserDefaults.standard.string(forKey: "LivingCountry")!
            
            
        }
        //end of navigation view
    }//end of body
    
}

struct DisplayPersonalInfo_Previews: PreviewProvider {
    static var previews: some View {
        DisplayPersonalInfo()
    }
}
