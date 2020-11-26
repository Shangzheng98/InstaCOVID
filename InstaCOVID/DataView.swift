//
//  DataView.swift
//  InstaCOVID
//
//  Created by Shangzheng Ji on 11/25/20.
//  Copyright © 2020 team2. All rights reserved.
//

import SwiftUI

struct DataView: View {
    @EnvironmentObject var userData:UserData
    
    @State private var searchItem = ""
    @State private var index = 0
    @State private var filterIndex = 0
    let filterlist = ["Cases", "New Cases", "Deaths", "New Deaths", "Recovered"]
    let styleList = ["list.bullet","square.grid.3x3.fill"]
    var body: some View {
        NavigationView {
            VStack {
                SearchBar(searchItem: $searchItem, placeholder: "Search")
                List{
                    
                    HStack{
                        Picker("", selection: $index){
                            ForEach(0..<styleList.count,id: \.self) {
                                
                                Image(systemName: styleList[$0])

                            }

                        }
//                        .frame(width: 260.0)
                        .pickerStyle(SegmentedPickerStyle())
                        Spacer()
                        Picker(filterlist[filterIndex],selection: $filterIndex) {
                            ForEach(0..<filterlist.count,id: \.self){
                                Text(self.filterlist[$0])
                                    .multilineTextAlignment(.center)
                                    .lineLimit(1)
                                    .frame(width: 100.0)
                                    
                            }
                        }
                        .padding(.horizontal, -1.0)
                        
                        .pickerStyle(MenuPickerStyle())
                    }
                    
                    ForEach(userData.searchableOrderedWorldDataList.filter{self.searchItem.isEmpty ? true : $0.localizedStandardContains(self.searchItem)}, id: \.self) {
                        item in DataListItem(country: self.searchItemCountry(searchListItem: item))
                    }
                    
                    
                }
                .navigationBarTitle(Text("COVID-19 Case Status"),displayMode: .inline)
            }
            
            
        }
        .customNavigationViewStyle()
    }
    
    func searchItemCountry(searchListItem: String) -> WorldDataStruct {
        let index = userData.countriesDataList.firstIndex(where: {$0.id.uuidString == searchListItem.components(separatedBy: "|")[0]})!
        return userData.countriesDataList[index]
    }
    var changelist:some View {
        getEveryContriesDataFromAPI(sortType: filterlist[filterIndex])
        userData.countriesDataList = everyContriesDataList
        userData.searchableOrderedWorldDataList = orderedSearchableWorldDataList
        return AnyView(ForEach(userData.searchableOrderedWorldDataList.filter{self.searchItem.isEmpty ? true : $0.localizedStandardContains(self.searchItem)}, id: \.self) {
            item in DataListItem(country: self.searchItemCountry(searchListItem: item))})
    }
}

struct DataView_Previews: PreviewProvider {
    static var previews: some View {
        DataView()
    }
}
