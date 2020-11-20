//
//  WorldDataStruct.swift
//  InstaCovid
//
//  Created by Nicole Lyu on 11/20/20.
//

import SwiftUI

struct WorldDataStruct: Hashable, Codable, Identifiable {
    var id: UUID
    var country_name: String
    var cases: String
    var deaths: String
    var region: String
    var total_recovered: String
    var new_deaths: String
    var new_cases: String
    var serious_critical: String
    var active_cases: String
    var total_cases_per_1m_population: String
    var deaths_per_1m_population: String
    var total_tests: String
    var tests_per_1m_population: String
}

