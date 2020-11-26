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
    var body: some View {
        ForEach(userData.searchableOrderedWorldDataList.filter{self.searchItem.isEmpty ? true : $0.localizedStandardContains(self.searchItem)}, id: \.self) {
            item in DataListItem(country: self.searchItemCountry(searchListItem: item))
        }
    }
    
    func searchItemCountry(searchListItem: String) -> WorldDataStruct {
        let index = userData.countriesDataList.firstIndex(where: {$0.id.uuidString == searchListItem.components(separatedBy: "|")[0]})!
        return userData.countriesDataList[index]
    }
}

//struct ListData_Previews: PreviewProvider {
//    static var previews: some View {
//        ListData()
//    }
//}
