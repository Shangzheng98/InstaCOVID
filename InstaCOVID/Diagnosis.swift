//
//  SwiftUIView.swift
//  InstaCOVID
//
//  Created by Shangzheng Ji on 11/30/20.
//  Copyright © 2020 team2. All rights reserved.
//

import SwiftUI
import WidgetKit

struct Diagnosis: View {

    @EnvironmentObject var userData: UserData
    let choicesForAnswer = ["°C", "°F"]
    //y the state variables for the Diagnosis view
    @State private var personalHealthStatusIndex = 0
    @State private var personalPossibleSymptomsSelectedIndex = [Int]()
    @State private var times = 0
    @State private var personalHealthStatusChecked = false
    @State private var personalPossibleSymptomsChecked = false
    
    @State private var selectedIndex = 0
    @State private var textFieldValue = ""
    
    @State private var showMissingDataAlert = false
    @State private var showSavedAlert = false
    
    
    @State var personalHealthStatus: [HealthStatus] = [HealthStatus(title: "No Covid-19 symptom"), HealthStatus(title: "Feel uncomfortable, quarantine myself at home"), HealthStatus(title: "Under the observation of medical institutions")]
    
    @State var personalPossibleSymptoms: [PossibleSymptoms] = [PossibleSymptoms(symptom: "Self-identified great"), PossibleSymptoms(symptom: "Fever, below 37.3 °C (99.14 °F)"), PossibleSymptoms(symptom: "Fever, above 37.3 °C (99.14 °F)"), PossibleSymptoms(symptom: "Cough and such respiratory symptom"), PossibleSymptoms(symptom: "Fatigue"), PossibleSymptoms(symptom: "Other symptoms")]
    
    var body: some View {
        Form {
            Section(header: Text("Today's Temperature")) {
                HStack {
                    TextField("", text: $textFieldValue)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .keyboardType(.decimalPad)
                    Picker("", selection: $selectedIndex) {
                        ForEach(0 ..< choicesForAnswer.count, id: \.self) {
                            Text(self.choicesForAnswer[$0])
                        }
                    }
                    .pickerStyle(SegmentedPickerStyle())
                }
            }
            
            Section(header: Text("Personal Health Status（select one）")) {
                List{
                    ForEach(0..<personalHealthStatus.count){ index in
                        HStack{
                            Button(action: {
                                personalHealthStatus[index].isChecked = personalHealthStatus[index].isChecked ? false : true
                                personalHealthStatusIndex = index
                                if  personalHealthStatus[index].isChecked {
                                    times += 1
                                } else {
                                    times -= 1
                                }
                                
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
                    ForEach(0..<personalPossibleSymptoms.count){ index in
                        HStack{
                            Button(action: {
                                
                                personalPossibleSymptoms[index].isSelected = personalPossibleSymptoms[index].isSelected ? false : true
                                if personalPossibleSymptoms[index].isSelected {
                                    personalPossibleSymptomsSelectedIndex.append(index)
                                }
                                else {
                                    let i = personalPossibleSymptomsSelectedIndex.firstIndex(of: index)
                                    personalPossibleSymptomsSelectedIndex.remove(at: i!)
                                }
                                print(personalPossibleSymptomsSelectedIndex)
                                //personalPossibleSymptomsIndex = index
                            }) {
                                HStack{
                                    if personalPossibleSymptoms[index].isSelected {
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
                                    
                                    Text(personalPossibleSymptoms[index].symptom)
                                }
                            }.buttonStyle(BorderlessButtonStyle())
                        }
                    }
                }
            }
            .alert(isPresented: $showMissingDataAlert, content: {
                self.missingAlert
            })
            Section(header: Text("Self-quarantine Record Card")) {
                RecordCard( animatedStamps: userData.recordDay)
            }
            
        }   // End of Form
        .navigationBarTitle(Text("Self-Diagnosis"), displayMode: .inline)
        .alert(isPresented: $showSavedAlert, content: {
            self.savedAlert
        })
        
        .navigationBarItems(trailing: Button(action: {
            save()
        }) {
            Text("save")
        })
    }
    
    
    func save() {
        if times > 1 || personalPossibleSymptomsSelectedIndex.count  == 0 || textFieldValue == ""{
            self.showMissingDataAlert = true
        } else {
            
            var disgnosis = DiagnosisStruct(temperture: textFieldValue + choicesForAnswer[selectedIndex], healthStatus: personalHealthStatus[personalHealthStatusIndex])
            
            
            for index in 0 ..< personalPossibleSymptomsSelectedIndex.count {
                disgnosis.possibleSymptomsList.append(personalPossibleSymptoms[index])
                
            }
            
            userData.diagnosisHistoryList.append(disgnosis)
            diagnosisStructlist = userData.diagnosisHistoryList
            self.showSavedAlert = true
            let currentDate = Date()
            
            // keep tracing the if the record is 14 days continuely, if not, the record card will become 0 staped.
            if userData.recordDay != 14
            {
                if currentDate < lastRecord.addingTimeInterval(26*60*60){
                    userData.recordDay += 1
                    numberOfStampe = userData.recordDay
                    userData.lastRecordDate = currentDate
                    lastRecord = userData.lastRecordDate
                    
                    let dateFormatter = DateFormatter()
                    dateFormatter.dateFormat = "yyyy-MM-dd"


                    let dateString = dateFormatter.string(from: userData.lastRecordDate)
                    UserDefaults.standard.set(dateString,forKey: "lastRecordDate")
                    UserDefaults.standard.set(numberOfStampe, forKey: "stampeNumber")
                    // reflash the timeline of widget to reflash the view of widget.
                    WidgetCenter.shared.reloadAllTimelines()
                }
                else {
                    userData.recordDay = 1
                    numberOfStampe = userData.recordDay
                    userData.lastRecordDate = currentDate
                    lastRecord = userData.lastRecordDate
                    
                    let dateFormatter = DateFormatter()
                    
                    dateFormatter.dateFormat = "yyyy-MM-dd"

                    let dateString = dateFormatter.string(from: userData.lastRecordDate)
                    UserDefaults.standard.set(dateString,forKey: "lastRecordDate")
                    UserDefaults.standard.set(numberOfStampe, forKey: "stampeNumber")
                    // reflash the timeline of widget to reflash the view of widget.
                    WidgetCenter.shared.reloadAllTimelines()
                }
                
                
                let userDefault = UserDefaults(suiteName:"group.com.ShangzhengJi.InstaCOVID")
                userDefault?.set(numberOfStampe, forKey: "stampeNumber")
            }
            // after saving successfully, play audio to user.
            applaudSoundAudioPlayer!.play()
        }
    }
    
    var savedAlert: Alert {
        return Alert(title: Text("Self-Diagnosis Record Saved!"),
          message: Text("Your self-diagnosis record has been successfully saved to the phone."),
          dismissButton: .default(Text("OK")))
    }
    
    var missingAlert: Alert {
        return Alert(title: Text("Missing Information!"), message: Text("Record requires temperature, ONE health Status, and Symptoms"), dismissButton: .default(Text("OK")))
    }
}

struct Diagnosis_Previews: PreviewProvider {
    static var previews: some View {
        Diagnosis()
    }
}
