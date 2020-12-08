//
//  DiagnosisStruct.swift
//  InstaCOVID
//
//  Created by Shangzheng Ji on 12/8/20.
//  Copyright © 2020 team2. All rights reserved.
//

import Foundation


struct DiagnosisStruct: Hashable, Codable, Identifiable {
    var id: UUID = UUID()
    var temperture:String
    var healthStatus: HealthStatus
    var possibleSymptomsList: [PossibleSymptoms] = [PossibleSymptoms]()
}
struct HealthStatus: Hashable, Codable{
    var title: String
    var isChecked: Bool = false
}

struct PossibleSymptoms: Hashable, Codable,Identifiable{
    var id: UUID = UUID()
    var symptom: String
    var isSelected: Bool = false
}
