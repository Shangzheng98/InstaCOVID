//
//  DataListDetails.swift
//  InstaCOVID
//
//  Created by Shangzheng Ji on 11/25/20.
//  Copyright © 2020 team2. All rights reserved.
//

import SwiftUI
import MapKit

struct DataListDetails: View {
    @EnvironmentObject var userData: UserData
    // Input Parameter
    let country: WorldDataStruct
    @State private var showCountryAddedAlert = false
    
    var body: some View {
        // A Form cannot have more than 10 Sections.
        // Group the Sections if more than 10.
        Form {
            Section(header: Text("Country Name")) {
                Text(country.countryName)
            }
            Section(header: Text("Country Flag Image")) {
                // Public function getImageFromUrl is given in UtilityFunctions.swift
                Image(country.flagImageName)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(minWidth: 300, maxWidth: 500, alignment: .center)
            }
            Section(header: Text("Country Confirmed Cases"), footer: Text("New Confirmed Cases: \(country.newCases)").italic()) {
                Text(country.cases)
            }
            
            Section(header: Text("Country Deaths"), footer: Text("New Deaths: \(country.newDeaths)").italic()) {
                Text(country.deaths)
            }
            
            Section(header: Text("Country Recovered Cases")) {
                Text(country.totalRecovered)
            }
            
            Section(header: Text("Follow up This Country's Status")) {
                Button(action: {
                    userData.followedCountriesList.append(country)
                    let newCountry = "\(country.id)|\(country.countryName)|\(country.totalCases)|\(country.totalDeaths)|\(country.totalrecovered)|\(country.newDeaths)|\(country.newCases)|\(country.lat)|\(country.long)|\(country.flagImgURL)|\(country.flagImageName)"
                    
                    userData.searchableOrderedWorldDataList.append(newCountry)
                    everyContriesDataListCases = userData.countriesDataList
                    orderedSearchableWorldDataList = userData.searchableOrderedWorldDataList
                    self.showCountryAddedAlert = true
                }) {
                    HStack {
                        Image(systemName: "plus")
                            .imageScale(.large)
                            .foregroundColor(/*@START_MENU_TOKEN@*/.blue/*@END_MENU_TOKEN@*/)
                        Text("Add to Follow Up")
                    }
                }
                .alert(isPresented: $showCountryAddedAlert, content: { self.countryAddedAlert })
            }
            
            Section(header: Text("Country Map")) {
                NavigationLink(destination: countryMap) {
                    HStack {
                        Image(systemName: "map.fill")
                            .imageScale(.medium)
                            .font(Font.title.weight(.regular))
                            .foregroundColor(.blue)
                        Text("Show Country Map")
                            .font(.system(size: 16))
                    }
                    .frame(minWidth: 300, maxWidth: 500, alignment: .leading)
                }
            }
            
        }   // End of Form
        .navigationBarTitle(Text("Country Details"), displayMode: .inline)
        .font(.system(size: 14))
        
    }   // End of body
    
    var countryMap: some View {
        return AnyView(MapView(mapType: MKMapType.standard, latitude: country.lat, longitude: country.long, delta: 15.0, deltaUnit: "degrees", annotationTitle: country.countryName, annotationSubtitle: country.countryName)
                        .navigationBarTitle(Text(country.countryName), displayMode: .inline)
                        .edgesIgnoringSafeArea(.all) )
    }
    
    var countryAddedAlert: Alert {
        Alert(title: Text("Successfully Follow Up!"),
              message: Text("This country is followed up and you can see it on the Home page!"),
              dismissButton: .default(Text("OK")) )
    }
}

struct DataListDetails_Previews: PreviewProvider {
    static var previews: some View {
        DataListDetails(country: WorldDataStruct(id: UUID(), countryName: "Afghanistan", cases: 840, deaths: 30, totalRecovered: 54, newDeaths: 5, newCases: 56, lat: 33, long: 65, flagImgURL: "https://manta.cs.vt.edu/iOS/flags/af.png",flagImageName: "af"))
    }
}
