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
    @State private var styleIndex = 0
    @State private var filterIndex = 0
    let filterlist = ["Cases", "New Cases", "Deaths", "New Deaths", "Recovered"]
    let styleList = ["list.bullet","square.grid.3x3.fill"]
    var body: some View {
        ZStack {
            NavigationView {
                VStack {
                    SearchBar(searchItem: $searchItem, placeholder: "Search")
                    List{
                        
                        HStack{
                            Picker("", selection: $styleIndex){
                                ForEach(0..<styleList.count,id: \.self) {
                                    
                                    Image(systemName: styleList[$0])

                                }

                            }
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
                        
                        if styleIndex == 0 {
                            ListData(searchItem: self.searchItem,filterIndex: self.filterIndex)
                            //ListData(searchItem: self.searchItem)
                        } else {
                            ListGrid(searchItem: self.searchItem, filterIndex: self.filterIndex)
                        }
                    
                        
                    }
                    
                    .navigationBarTitle(Text("COVID-19 Case Status"),displayMode: .inline)
                }
                
                
            }
            .customNavigationViewStyle()
            
        }
        
    }
}

struct DataView_Previews: PreviewProvider {
    static var previews: some View {
        DataView().environmentObject(UserData())
    }
}
