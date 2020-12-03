//
//  SwiftUIView.swift
//  InstaCOVID
//
//  Created by Shangzheng Ji on 11/30/20.
//  Copyright © 2020 team2. All rights reserved.
//

import SwiftUI

struct HealthStatus{
    var title: String
    var isChecked: Bool = false
}

struct PossibleSymptoms{
    var symptom: String
    var isSelected: Bool = false
}

struct Diagnosis: View {
    let choicesForAnswer = ["°C", "°F"]
    @State private var selectedIndex = 0
    @State private var textFieldValue = ""
    
    @State var personalHealthStatus: [HealthStatus] = [HealthStatus(title: "No Covid-19 symptom"), HealthStatus(title: "Feel uncomfortable, quarantine myself at home"), HealthStatus(title: "Under the observation of medical institutions")]
    
    @State var personalPossibleSymptoms: [PossibleSymptoms] = [PossibleSymptoms(symptom: "Self-identified great"), PossibleSymptoms(symptom: "Fever, below 37.3 °C (99.14 °F)"), PossibleSymptoms(symptom: "Fever, above 37.3 °C (99.14 °F)"), PossibleSymptoms(symptom: "Cough and such respiratory symptom"), PossibleSymptoms(symptom: "Fatigue"), PossibleSymptoms(symptom: "Other symptoms")]
    
    var body: some View {
        Form {
            Section(header: Text("Today's Temperature")) {
                HStack {
                    TextField("", text: $textFieldValue)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                    
                    Picker("", selection: $selectedIndex) {
                        ForEach(0 ..< choicesForAnswer.count, id: \.self) {
                            Text(self.choicesForAnswer[$0])
                        }
                    }
                    .pickerStyle(SegmentedPickerStyle())
                }
            }
            
            Section(header: Text("Personal Health Status")) {
                List{
                    ForEach(0..<personalHealthStatus.count){ index in
                        HStack{
                            Button(action: {
                                personalHealthStatus[index].isChecked = personalHealthStatus[index].isChecked ? false : true
                            }) {
                                HStack{
                                    if personalHealthStatus[index].isChecked {
                                        Image(systemName: "checkmark.circle.fill")
                                            .foregroundColor(.green)
                                            .imageScale(.large)
                                            .animation(.easeIn)
                                    } else{
                                        Image(systemName: "circle")
                                            .foregroundColor(.primary)
                                            .imageScale(.large)
                                            .animation(.easeOut)
                                    }
                                    
                                    Text(personalHealthStatus[index].title)
                                }
                            }.buttonStyle(BorderlessButtonStyle())
                        }
                    }
                }
            }
            Section(header: Text("Do you have the following symptoms?")) {
                List{
                    ForEach(0..<personalPossibleSymptoms.count){ i in
                        HStack{
                            Button(action: {
                                personalPossibleSymptoms[i].isSelected = personalPossibleSymptoms[i].isSelected ? false : true
                            }) {
                                HStack{
                                    if personalPossibleSymptoms[i].isSelected {
                                        Image(systemName: "checkmark.circle.fill")
                                            .foregroundColor(.green)
                                            .imageScale(.large)
                                            .animation(.easeIn)
                                    } else{
                                        Image(systemName: "circle")
                                            .foregroundColor(.primary)
                                            .imageScale(.large)
                                            .animation(.easeOut)
                                    }
                                    
                                    Text(personalPossibleSymptoms[i].symptom)
                                }
                            }.buttonStyle(BorderlessButtonStyle())
                        }
                    }
                }
            }
            Section(header: Text("Self-quarantine Record Card")) {
                
            }
            
        }   // End of Form
        .navigationBarTitle(Text("Self-Diagnosis"), displayMode: .inline)
    }
}

struct Diagnosis_Previews: PreviewProvider {
    static var previews: some View {
        Diagnosis()
    }
}
