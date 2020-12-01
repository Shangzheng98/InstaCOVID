//
//  WorldDataStruct.swift
//  InstaCovid
//
//  Created by Nicole Lyu on 11/20/20.
//

import SwiftUI

struct WorldDataStruct: Hashable, Codable, Identifiable {
    var id: UUID
    var countryName: String
    var cases: Int
    var deaths: Int
    var totalRecovered: Int
    var newDeaths: Int
    var newCases: Int
    var lat: Double
    var long: Double
    var flagImgURL:String
    var flagImageName:String
}


struct WorldStatStruct: Hashable, Codable {
    var totalCases: String
    var newCases: String
    var totalDeaths:String
    var newDeaths: String
    var totalRecovered:String
    
}
