//
//  DisplayPersonalInfo.swift
//  InstaCOVID
//
//  Created by Tenghui Zhang on 11/22/20.
//  Copyright © 2020 team2. All rights reserved.
//

import SwiftUI

struct DisplayPersonalInfo: View {
    
    var body: some View {
        
        NavigationView{
            Form{
                
                //The picture section
                Section(header: Text("")){
                    let photo = UserDefaults.standard.data(forKey: "Photo")
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
                    let name = UserDefaults.standard.string(forKey: "Name")
                    Text(name!)
                }
                
                
                //The gender section
                
                Section(header: Text("Gender")){
                    let gender = UserDefaults.standard.string(forKey: "Gender")
                    Text(gender!)
                }
                
                //The date of birth
                Section(header: Text("Date of Birth")){
                    let birth = UserDefaults.standard.string(forKey: "Birth")
                    Text(birth!)
                    
                }
                
                //Nationality section
                Section(header: Text("Nationality")){
                    let nationality = UserDefaults.standard.string(forKey: "Nationality")
                    Text(nationality!)
                }
                
                //Phone number section
                Section(header: Text("Phone Number")){
                    let phone = UserDefaults.standard.string(forKey: "Phone")
                    Text("+\(phone!)")
                }
                
                //Identity section
                Section(header: Text("Identity")){
                    let identity = UserDefaults.standard.string(forKey: "Identity")
                    Text(identity!)
                }
                
                //Current living country
                Section(header: Text("Current living country")){
                    let country = UserDefaults.standard.string(forKey: "LivingCountry")
                    Text(country!)
                }
                
                
                
                
                
            }.navigationBarTitle(Text("Personal Account Information"), displayMode: .inline)//End of form
        }//end of navigation view
    }//end of body
    
}

struct DisplayPersonalInfo_Previews: PreviewProvider {
    static var previews: some View {
        DisplayPersonalInfo()
    }
}
