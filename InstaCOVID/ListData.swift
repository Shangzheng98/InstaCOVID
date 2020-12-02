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
            let index = everyContriesDataListCases.firstIndex(where: {$0.id.uuidString == searchListItem.components(separatedBy: "|")[0]})!
            return everyContriesDataListCases[index]
        } else if filterIndex == 1 {
            let index = everyContriesDataListNewCases.firstIndex(where: {$0.id.uuidString == searchListItem.components(separatedBy: "|")[0]})!
            return everyContriesDataListNewCases[index]
        }
        else if filterIndex == 2 {
            let index = everyContriesDataListDeaths.firstIndex(where: {$0.id.uuidString == searchListItem.components(separatedBy: "|")[0]})!
            return everyContriesDataListDeaths[index]
        }
        else if filterIndex == 3 {
            let index = everyContriesDataListNewDeaths.firstIndex(where: {$0.id.uuidString == searchListItem.components(separatedBy: "|")[0]})!
            return everyContriesDataListNewDeaths[index]
        }
        else {
            let index = everyContriesDataListRecovered.firstIndex(where: {$0.id.uuidString == searchListItem.components(separatedBy: "|")[0]})!
            return everyContriesDataListRecovered[index]
        }
        
    }
}

//struct ListData_Previews: PreviewProvider {
//    static var previews: some View {
//        ListData()
//    }
//}
