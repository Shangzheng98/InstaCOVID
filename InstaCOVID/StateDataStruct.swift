//
//  StateDataStruct.swift
//  InstaCovid
//
//  Created by Nicole Lyu on 11/20/20.
//

import SwiftUI


struct StateDataStruct: Hashable, Codable, Identifiable {
    var id: UUID
    var stateName: String
    var cases: Int
    var deaths: Int
    var newDeaths: Int
    var newCases: Int
    var lat: Double
    var long: Double
}
