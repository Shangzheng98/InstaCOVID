//
//  StateDataStruct.swift
//  InstaCovid
//
//  Created by Nicole Lyu on 11/20/20.
//

import SwiftUI

struct StateDataStruct: Hashable, Codable, Identifiable {
    var id: UUID
    var date: Int
    var states: Int
    var positive: Int
    var negative: Int
    var pending: Int
    var hospitalizedCurrently: Int
    var hospitalizedCumulative: Int
    var inIcuCurrently: Int
    var inIcuCumulative: Int
    var onVentilatorCurrently: Int
    var onVentilatorCumulative: Int
    var recovered: Int
    var dateChecked: String
    var death: Int
    var hospitalized: Int
    var totalTestResults: Int
    var lastModified: String
    var total: Int
    var posNeg: Int
    var deathIncrease: Int
    var hospitalizedIncrease: Int
    var negativeIncrease: Int
    var positiveIncrease: Int
    var totalTestResultsIncrease: Int
    var hash: String
}
