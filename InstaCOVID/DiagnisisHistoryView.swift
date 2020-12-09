//
//  DiagnisisHistoryView.swift
//  InstaCOVID
//
//  Created by Tenghui Zhang on 11/22/20.
//  Copyright © 2020 team2. All rights reserved.
//

import SwiftUI
//It will disokat the list of the saved diagnisis data
struct DiagnisisHistoryView: View {
    @EnvironmentObject var userData:UserData
    var body: some View {
        List {
            //Using the list to list the element
            ForEach(userData.diagnosisHistoryList,id: \.self) { item in
                VStack(alignment: .leading) {
                    VStack(alignment: .leading) {
                        HStack() {
                            Image(systemName: "thermometer")
                                .imageScale(.medium)
                                .foregroundColor(.red)
                            Text("Temperature: \(item.temperture)")
                        }
                    }
                    Spacer()
                    
                    VStack(alignment: .leading) {
                        Text("Status: \(item.healthStatus.title)")
                    }
                    Spacer()
                    VStack(alignment:.leading) {
                        Text("Sysptoms:")
                        ForEach(item.possibleSymptomsList, id: \.self) {
                            symptom in
                            Text("\(symptom.symptom)")
                            
                        }
                    }
                    
                    
                    
                }
                
            }
        }
        .navigationBarTitle(Text("Self-Diagnosis Records"), displayMode: .inline)
    }
}

struct DiagnisisHistoryView_Previews: PreviewProvider {
    static var previews: some View {
        DiagnisisHistoryView()
    }
}
