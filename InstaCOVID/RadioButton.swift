//
//  RadioButton.swift
//  InstaCOVID
//
//  Created by Nicole Lyu on 12/9/20.
//  Copyright © 2020 team2. All rights reserved.
//

import SwiftUI

struct RadioButtonField: View {
    let id: String
    let label: String
    let size: CGFloat
    let color: Color
    let textSize: CGFloat
    let isMarked: Bool
    let callback: (String) -> ()
    
    init(
        id: String,
        label: String,
        size: CGFloat = 20,
        color: Color = Color.blue,
        textSize: CGFloat = 14,
        isMarked: Bool = false,
        callback: @escaping (String) -> ()
    ){
        self.id = id
        self.label = label
        self.size = size
        self.color = color
        self.textSize = textSize
        self.isMarked = isMarked
        self.callback = callback
    }
    
    var body: some View {
        Button(action: {self.callback(self.id)}){
            HStack (alignment: .center, spacing: 10){
                if self.isMarked {
                    Image(systemName: "checkmark.circle.fill")
                        .renderingMode(.original)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .foregroundColor(.green)
                        
                        .frame(width:self.size, height: self.size)
                        //.animation(.easeIn)
                } else{
                    Image(systemName: "circle")
                        .renderingMode(.original)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .foregroundColor(.primary)
                        .frame(width:self.size, height: self.size)
                        //.animation(.easeOut)
                }
                Text(label)
                    .font(Font.system(size: textSize))
                Spacer()
            }.foregroundColor(self.color)
        }.foregroundColor(Color.white)
    }
}

enum Status: String {
    case noSymptom = "No Covid-19 symptom"
    case quarantineAtHome = "Feel uncomfortable, quarantine myself at home"
    case underObservation = "Under the observation of medical institutions"
}

struct RadioButtonGroups: View {
    let callback: (String) -> ()
    
    @State var selectedId: String = ""
    
    var body: some View {
        VStack {
            radioNoSymptomMajority
            radioQuarantineAtHomeMajority
            radioUnderObservationMajority
        }
    }
    var radioNoSymptomMajority: some View {
        RadioButtonField(
            id: Status.noSymptom.rawValue,
            label: Status.noSymptom.rawValue,
            isMarked: selectedId == Status.noSymptom.rawValue ? true : false,
            callback: radioGroupCallback)
    }
    var radioQuarantineAtHomeMajority: some View {
        RadioButtonField(
            id: Status.quarantineAtHome.rawValue,
            label: Status.quarantineAtHome.rawValue,
            isMarked: selectedId == Status.quarantineAtHome.rawValue ? true : false,
            callback: radioGroupCallback)
    }
    var radioUnderObservationMajority: some View {
        RadioButtonField(
            id: Status.underObservation.rawValue,
            label: Status.underObservation.rawValue,
            isMarked: selectedId == Status.underObservation.rawValue ? true : false,
            callback: radioGroupCallback)
    }
    
    func radioGroupCallback(id: String) {
        selectedId = id
        callback(id)
    }
}
