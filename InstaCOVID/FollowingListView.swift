//
//  FollowingListView.swift
//  InstaCOVID
//
//  Created by Tenghui Zhang on 11/22/20.
//  Copyright © 2020 team2. All rights reserved.
//

import SwiftUI

struct FollowingListView: View {
    @EnvironmentObject var userData: UserData
    var body: some View {
        List {
            ForEach(userData.followedCountriesList,id: \.self) { country in
                NavigationLink(destination: DataListDetails(country: country)) {
                    DataListItem(country: country)
                }
                
            }
        }
        .navigationBarTitle(Text("Following list"), displayMode: .inline)
        .navigationBarItems(trailing:
            Button(action: {
                userData.followedCountriesList.removeAll()
                for index in 0..<userData.countriesDataListCases.count {
                    userData.countriesDataListCases[index].following = false
                }
                for index in 0..<userData.countriesDataListDeaths.count {
                    userData.countriesDataListDeaths[index].following = false
                }
                for index in 0..<userData.countriesDataListRecovered.count {
                    userData.countriesDataListRecovered[index].following = false
                }
                for index in 0..<userData.countriesDataListNewCases.count {
                    userData.countriesDataListNewCases[index].following = false
                }
                for index in 0..<userData.countriesDataListNewDeaths.count {
                    userData.countriesDataListNewDeaths[index].following = false
                }
                
                everyContriesDataListCases = userData.countriesDataListCases
                everyContriesDataListNewCases = userData.countriesDataListNewCases
                everyContriesDataListDeaths = userData.countriesDataListDeaths
                everyContriesDataListNewDeaths = userData.countriesDataListNewDeaths
                everyContriesDataListRecovered = userData.countriesDataListRecovered
                
                
                followedUpDataList = userData.followedCountriesList
            }) {
                Image(systemName: "x.circle")
            }
        )
    }
}

struct FollowingListView_Previews: PreviewProvider {
    static var previews: some View {
        FollowingListView()
    }
}
