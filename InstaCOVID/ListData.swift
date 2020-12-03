//
//  ListData.swift
//  InstaCOVID
//
//  Created by Shangzheng Ji on 11/25/20.
//  Copyright © 2020 team2. All rights reserved.
//

import SwiftUI

struct ListData: View {
    @EnvironmentObject var userData:UserData
    let searchItem:String
    let filterIndex:Int
    var body: some View {
        if filterIndex == 0 {
            ForEach(orderedSearchableWorldDataListCases.filter{self.searchItem.isEmpty ? true : $0.localizedStandardContains(self.searchItem)}, id: \.self) {
                item in NavigationLink (destination: DataListDetails(country:self.searchItemCountry(searchListItem: item))) {
                    DataListItem(country: self.searchItemCountry(searchListItem: item))
                }
            }
        } else if filterIndex == 1 {
            ForEach(orderedSearchableWorldDataListNewCases.filter{self.searchItem.isEmpty ? true : $0.localizedStandardContains(self.searchItem)}, id: \.self) {
                item in NavigationLink (destination: DataListDetails(country:self.searchItemCountry(searchListItem: item))) {
                    DataListItem(country: self.searchItemCountry(searchListItem: item))
                }
            }
        } else if filterIndex == 2 {
            ForEach(orderedSearchableWorldDataListDeaths.filter{self.searchItem.isEmpty ? true : $0.localizedStandardContains(self.searchItem)}, id: \.self) {
                item in NavigationLink (destination: DataListDetails(country:self.searchItemCountry(searchListItem: item))) {
                    DataListItem(country: self.searchItemCountry(searchListItem: item))
                }
            }
        } else if filterIndex == 3 {
            ForEach(orderedSearchableWorldDataListNewDeaths.filter{self.searchItem.isEmpty ? true : $0.localizedStandardContains(self.searchItem)}, id: \.self) {
                item in NavigationLink (destination: DataListDetails(country:self.searchItemCountry(searchListItem: item))) {
                    DataListItem(country: self.searchItemCountry(searchListItem: item))
                }
            }
        } else {
            ForEach(orderedSearchableWorldDataListRecovered.filter{self.searchItem.isEmpty ? true : $0.localizedStandardContains(self.searchItem)}, id: \.self) {
                item in NavigationLink (destination: DataListDetails(country:self.searchItemCountry(searchListItem: item))) {
                    DataListItem(country: self.searchItemCountry(searchListItem: item))
                }
            }
        }
        
    }
    
    func searchItemCountry(searchListItem: String) -> WorldDataStruct {
        if filterIndex == 0 {
            let index = userData.countriesDataListCases.firstIndex(where: {$0.id.uuidString == searchListItem.components(separatedBy: "|")[0]})!
            return userData.countriesDataListCases[index]
        } else if filterIndex == 1 {
            let index = userData.countriesDataListNewCases.firstIndex(where: {$0.id.uuidString == searchListItem.components(separatedBy: "|")[0]})!
            return userData.countriesDataListNewCases[index]
        }
        else if filterIndex == 2 {
            let index = userData.countriesDataListDeaths.firstIndex(where: {$0.id.uuidString == searchListItem.components(separatedBy: "|")[0]})!
            return userData.countriesDataListDeaths[index]
        }
        else if filterIndex == 3 {
            let index = userData.countriesDataListNewDeaths.firstIndex(where: {$0.id.uuidString == searchListItem.components(separatedBy: "|")[0]})!
            return userData.countriesDataListNewDeaths[index]
        }
        else {
            let index = userData.countriesDataListRecovered.firstIndex(where: {$0.id.uuidString == searchListItem.components(separatedBy: "|")[0]})!
            return userData.countriesDataListRecovered[index]
        }
        
    }
}

//struct ListData_Previews: PreviewProvider {
//    static var previews: some View {
//        ListData()
//    }
//}
