//
//  DataListItem.swift
//  InstaCOVID
//
//  Created by Shangzheng Ji on 11/25/20.
//  Copyright © 2020 team2. All rights reserved.
//

import SwiftUI

struct DataListItem: View {
    let country:WorldDataStruct
    var body: some View {
        
        HStack {
            
            getImageFromUrl(url: country.flagImgURL, defaultFilename: "ImageUnavailable")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width:80, height: 80)
            VStack(alignment: .leading) {
                HStack {
    
                    Text(country.countryName)
                    
                }
                .font(.system(size: 13))
                
                HStack{
                    VStack{
                        Text("Data: ")
                    }
                    VStack(alignment: .leading) {
                        Text("Cases")
                            .font(.system(size: 12.5))
                            
                        HStack {
                            Image(systemName: "arrow.up")
                                .foregroundColor(.red)
                                .imageScale(.small)
                            Text("\(country.cases)")
                        }
                        
                        Text("+ \(country.newCases)")
                            .foregroundColor(.gray)
                            .font(.system(size: 11))
                    }
                    Divider()
                    
                    VStack(alignment: .leading) {
                        Text("Recovered")
                            .font(.system(size: 12.5))
                            
                            .multilineTextAlignment(.leading)
                            
                        HStack {
                            Image(systemName: "cross.fill")
                                .foregroundColor(.green)
                                .imageScale(.small)
                            Text("\(country.totalRecovered)")
                        }
                        
                        Text("")
                    }
                    Divider()
                    
                    VStack(alignment: .leading) {
                        Text("Deaths")
                            .font(.system(size: 12.5))
                        HStack {
                            Image(systemName: "arrow.up")
                                .foregroundColor(.red)
                                .imageScale(.small)
                            Text("\(country.cases)")
                        }
                        
                        Text("+ \(country.newCases)")
                            .font(.system(size: 11))
                            .foregroundColor(.gray)
                    }
                }
                .frame(width: 250.0)
                .font(.system(size: 12))
                
            }
            
        }
    }
}

struct DataListItem_Previews: PreviewProvider {
    static var previews: some View {
        DataListItem(country: WorldDataStruct(id: UUID(), countryName: "Afghanistan", cases: 840, deaths: 30, totalRecovered: 54, newDeaths: 5, newCases: 56, lat: 33, long: 65, flagImgURL: "https://manta.cs.vt.edu/iOS/flags/af.png"))
            
        
    }
}
