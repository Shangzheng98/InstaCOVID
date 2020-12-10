//
//  GridListItem.swift
//  InstaCOVID
//
//  Created by Shangzheng Ji on 11/30/20.
//  Copyright © 2020 team2. All rights reserved.
//

import SwiftUI

struct GridListItem: View {
    @EnvironmentObject var userData:UserData
    @State private var flipped = false
    @State private var animate3d = false
    @State private var showDetails = false
    let country: WorldDataStruct
    var shape = RoundedRectangle(cornerRadius: 15, style: .continuous)
    var body: some View {
        if (!country.following) {
            Image(country.flagImageName)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .clipShape(shape)
                .onTapGesture {
                    self.showDetails.toggle()
                }
                .sheet(isPresented: $showDetails, content: {
                    GridListDetails(country: country)
                })
        } else {
            Image(country.flagImageName)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .clipShape(shape)
                .onTapGesture {
                    self.showDetails.toggle()
                }
                .overlay(
                    Image(systemName: "star.fill")
                        .foregroundColor(.yellow)
                    , alignment: .topTrailing
                )
                .sheet(isPresented: $showDetails, content: {
                    GridListDetails(country: country)
                })
        }
        
    }
    
    
}
struct GridListItem_Previews: PreviewProvider {
    static var previews: some View {
        GridListItem(country: WorldDataStruct(id: UUID(), countryName: "Afghanistan", cases: 840, deaths: 30, totalRecovered: 54, newDeaths: 5, newCases: 56, lat: 33, long: 65, flagImgURL: "https://manta.cs.vt.edu/iOS/flags/af.png", flagImageName: "af", following: false))
    }
}
