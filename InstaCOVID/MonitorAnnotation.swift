//
//  MonitorAnnotation.swift
//  InstaCOVID
//
//  Created by Ruichang Chen on 2020/12/3.
//  Copyright © 2020 team2. All rights reserved.
//

import SwiftUI

struct MonitorAnnotation: View {
    let country: WorldDataStruct
    
    var body: some View {
        
        HStack {
            Image(country.flagImageName)
                .resizable()
                .frame(width:40)
                .clipShape(Circle())
                .overlay(Circle().stroke(Color.white, lineWidth: 1))
            VStack {
                HStack {
                    Text(country.countryName)
                        .multilineTextAlignment(.center)
                }
                .font(.system(size: 13))
                VStack(alignment: .leading) {
                    Text("Confirmed:")
                        .font(.system(size: 12.5))
                        .foregroundColor(.red)
                    Text("\(country.cases)")
                        .font(.system(size: 12.5))
                        .foregroundColor(.red)
                    HStack {
                        Image(systemName: "arrow.up")
                            .imageScale(.small)
                            .foregroundColor(.gray)
                                                        
                        Text("\(country.newCases)")
                            .foregroundColor(.gray)
                            .font(.system(size: 11))
                    }
                }
                .font(.system(size: 12))
            }
        }.frame(width: 130, height: 70)
        //.background(Color.clear)
        .clipShape(RoundedRectangle(cornerRadius: 20, style: .continuous))
    }
}

struct MonitorAnnotation_Previews: PreviewProvider {
    static var previews: some View {
        MonitorAnnotation(country: WorldDataStruct(id: UUID(), countryName: "Afghanistan", cases: 840, deaths: 30, totalRecovered: 54, newDeaths: 5, newCases: 56, lat: 33, long: 65, flagImgURL: "https://manta.cs.vt.edu/iOS/flags/af.png",flagImageName: "af", following: false))
    }
}
