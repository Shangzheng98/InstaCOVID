//
//  DisplayPersonalInfo.swift
//  InstaCOVID
//
//  Created by Tenghui Zhang on 11/22/20.
//  Copyright © 2020 team2. All rights reserved.
//

import SwiftUI

struct DisplayPersonalInfo: View {
    @State private var photo = UserDefaults.standard.data(forKey: "Photo")
//    @State private var name = UserDefaults.standard.string(forKey: "Name")
    @State private var name = ""
    @State private var gender = UserDefaults.standard.string(forKey: "Gender")
    @State private var birth = UserDefaults.standard.string(forKey: "Birth")
    @State private var nationality = UserDefaults.standard.string(forKey: "Nationality")
    @State private var phone = UserDefaults.standard.string(forKey: "Phone")
    @State private var identity = UserDefaults.standard.string(forKey: "Identity")
    @State private var country = UserDefaults.standard.string(forKey: "LivingCountry")
    
    
    var body: some View {
        
        NavigationView{
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
                    Text(gender!)
                }
                
                //The date of birth
                Section(header: Text("Date of Birth")){
                    Text(birth!)
                    
                }
                
                //Nationality section
                Section(header: Text("Nationality")){
                    Text(nationality!)
                }
                
                //Phone number section
                Section(header: Text("Phone Number")){
                    Text("\(phone!)")
                }
                
                //Identity section
                Section(header: Text("Identity")){
                    Text(identity!)
                }
                
                //Current living country
                Section(header: Text("Current living country")){
                    Text(country!)
                }
                
                //Edit information
                Section(header: Text("Change profile")){
                    //The navigation link for the first time set up
                    NavigationLink(destination: EditInfoSetting(name: $name)) {
                        HStack {
                            Text("Edit Personal Information")
                                .font(.system(size: 18))
                        }
                    }
                    .frame(minWidth: 400, maxWidth: 500, alignment: .center)
                }
                
                
                
                
                
            }.navigationBarTitle(Text("Personal Account Information"), displayMode: .inline)//End of form
        }.onAppear {
            name = UserDefaults.standard.string(forKey: "Name")!
        }
        //end of navigation view
    }//end of body
    
}

struct DisplayPersonalInfo_Previews: PreviewProvider {
    static var previews: some View {
        DisplayPersonalInfo()
    }
}
