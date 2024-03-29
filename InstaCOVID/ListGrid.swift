//
//  ListGrid.swift
//  InstaCOVID
//
//  Created by Shangzheng Ji on 11/26/20.
//  Copyright © 2020 team2. All rights reserved.
//

import SwiftUI

struct ListGrid: View {
    @EnvironmentObject var userData:UserData
    let searchItem:String
    let filterIndex: Int
    let columns = [ GridItem(.adaptive(minimum: 100), spacing: 10) ]
    var shape = RoundedRectangle(cornerRadius: 20, style: .continuous)
    var body: some View {
        ZStack {
            ScrollView {
                
                
                LazyVGrid(columns: columns,spacing:10) {
                    if filterIndex == 0 {
                        ForEach(orderedSearchableWorldDataListCases.filter{self.searchItem.isEmpty ? true : $0.localizedStandardContains(self.searchItem)}, id: \.self) {
                            contry in GridListItem(country: self.searchItemCountry(searchListItem: contry))
                                .scaledToFit()
                                
                                
                        }
                    } else if filterIndex == 1 {
                        ForEach(orderedSearchableWorldDataListNewCases.filter{self.searchItem.isEmpty ? true : $0.localizedStandardContains(self.searchItem)}, id: \.self) {
                            contry in GridListItem(country: self.searchItemCountry(searchListItem: contry))
                                .scaledToFit()
                                .overlay(
                                shape
                                    .inset(by: 0.5)
                                    .stroke(Color.primary.opacity(1), lineWidth: 1)
                                )
                        }
                    } else if filterIndex == 2 {
                        ForEach(orderedSearchableWorldDataListDeaths.filter{self.searchItem.isEmpty ? true : $0.localizedStandardContains(self.searchItem)}, id: \.self) {
                            contry in GridListItem(country: self.searchItemCountry(searchListItem: contry))
                                .scaledToFit()
                        }
                    } else if filterIndex == 3 {
                        ForEach(orderedSearchableWorldDataListNewDeaths.filter{self.searchItem.isEmpty ? true : $0.localizedStandardContains(self.searchItem)}, id: \.self) {
                            contry in GridListItem(country: self.searchItemCountry(searchListItem: contry))
                                .scaledToFit()
                        }
                    } else {
                        ForEach(orderedSearchableWorldDataListRecovered.filter{self.searchItem.isEmpty ? true : $0.localizedStandardContains(self.searchItem)}, id: \.self) {
                            contry in GridListItem(country: self.searchItemCountry(searchListItem: contry))
                                .scaledToFit()
                        }
                    }
                    
                }
                
            }
            
        }
        .padding()
        
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

