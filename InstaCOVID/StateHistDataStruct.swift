//
//  StateHistDataStruct.swift
//  InstaCOVID
//
//  Created by Ruichang Chen on 2020/12/3.
//  Copyright © 2020 team2. All rights reserved.
//

import Foundation

/*
 {"date":20201202,"state":"AK","positive":32531,"probableCases":null,"negative":992112,"pending":null,"totalTestResultsSource":"totalTestsViral","totalTestResults":1024643,"hospitalizedCurrently":164,"hospitalizedCumulative":768,"inIcuCurrently":null,"inIcuCumulative":null,"onVentilatorCurrently":23,"onVentilatorCumulative":null,"recovered":7165,"dataQualityGrade":"A","lastUpdateEt":"12/2/2020 03:59","dateModified":"2020-12-02T03:59:00Z","checkTimeEt":"12/01 22:59","death":122,"hospitalized":768,"dateChecked":"2020-12-02T03:59:00Z","totalTestsViral":1024643,"positiveTestsViral":39543,"negativeTestsViral":984058,"positiveCasesViral":null,"deathConfirmed":122,"deathProbable":null,"totalTestEncountersViral":null,"totalTestsPeopleViral":null,"totalTestsAntibody":null,"positiveTestsAntibody":null,"negativeTestsAntibody":null,"totalTestsPeopleAntibody":null,"positiveTestsPeopleAntibody":null,"negativeTestsPeopleAntibody":null,"totalTestsPeopleAntigen":null,"positiveTestsPeopleAntigen":null,"totalTestsAntigen":null,"positiveTestsAntigen":null,"fips":"02","positiveIncrease":697,"negativeIncrease":5318,"total":1024643,"totalTestResultsIncrease":6015,"posNeg":1024643,"deathIncrease":0,"hospitalizedIncrease":19,"hash":"a67835c9975e7a741cbe7511d7b8014f238f7381","commercialScore":0,"negativeRegularScore":0,"negativeScore":0,"positiveScore":0,"score":0,"grade":""}
 */

struct StateHistDataStruct: Hashable, Codable, Identifiable {
    var id: UUID
    var stateName: String
    var maxCase: Int
    var maxIncreaseCase: Int
    var maxIncreaseDeath: Int
    var data: [StateDayData]
}

struct StateDayData: Hashable, Codable, Identifiable {
    var id: UUID
    var date: Int
    var totalCase: Int
    var increaseCase: Int
    var totalDeath: Int
    var increaseDeath: Int
    var totalTestResultIncrease: Int
}
