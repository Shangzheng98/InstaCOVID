//
//  DiagnosisStruct.swift
//  InstaCOVID
//
//  Created by Shangzheng Ji on 12/8/20.
//  Copyright © 2020 team2. All rights reserved.
//

import Foundation

var lastRecord = Date()
var numberOfStampe = 0
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

/// load the new font
struct FontNameManager {
    //MARK: name of font family
    
    struct SansitaSwashed {
        static let black = "AmericanTypewriter"
        static let bold = "AmericanTypewriter-Light"
        static let extraBold = "AmericanTypewriter-Semibold"
        static let light = "AmericanTypewriter-Bold"
        static let medium = "AmericanTypewriter-Condensed"
        static let regular = "AmericanTypewriter-CondensedLight"
        static let semiBold = "AmericanTypewriter-CondensedBold"
    }
    
    struct RussoOne {
        static let reg = "RussoOne-Regular"
    }
    
    struct EastSeaDokdo {
        static let regu = "EastSeaDokdo-Regular"
        
    }
}
