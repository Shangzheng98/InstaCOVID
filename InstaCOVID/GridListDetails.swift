//
//  GridListDetails.swift
//  InstaCOVID
//
//  Created by Shangzheng Ji on 12/6/20.
//  Copyright © 2020 team2. All rights reserved.
//

import SwiftUI
import MapKit
struct GridListDetails: View {
    @EnvironmentObject var userData: UserData
    // Input Parameter
    let country: WorldDataStruct
    @State private var showCountryAddedAlert = false
    @State private var follow = false
    var body: some View {
        // A Form cannot have more than 10 Sections.
        // Group the Sections if more than 10.
        NavigationView{
        Form {
            Section(header: Text("Country Name")) {
                Text(country.countryName)
            }
            Section(header: Text("Country Flag Image")) {
                Image(country.flagImageName)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(minWidth: 200, maxWidth: 400, alignment: .center)
            }
            Section(header: Text("Country Confirmed Cases"), footer: Text("New Confirmed Cases: \(country.newCases)").italic()) {
                Text("\(country.cases)")
            }
            
            Section(header: Text("Country Deaths"), footer: Text("New Deaths: \(country.newDeaths)").italic()) {
                Text("\(country.deaths)")
            }
            
            Section(header: Text("Country Recovered Cases")) {
                Text("\(country.totalRecovered)")
            }
            
            Section(header: Text("Follow up This Country's Status")) {
                Button(action: {
                    if !country.following {
                        userData.followedCountriesList.append(country)
                        let caseIndex = userData.countriesDataListCases.firstIndex(where: {
                            $0.countryName == country.countryName
                        })
                        let newCaseIndex = userData.countriesDataListNewCases.firstIndex(where: {
                            $0.countryName == country.countryName
                        })
                        let deathIndex = userData.countriesDataListDeaths.firstIndex(where: {
                            $0.countryName == country.countryName
                        })
                        let newDeathIndex = userData.countriesDataListNewDeaths.firstIndex(where: {
                            $0.countryName == country.countryName
                        })
                        let recoveredIndex = userData.countriesDataListRecovered.firstIndex(where: {
                            $0.countryName == country.countryName
                        })
                        let followListIndex = userData.followedCountriesList.firstIndex(where: {
                            $0.countryName == country.countryName
                        })
                        
                        userData.countriesDataListCases[caseIndex!].following = true
                        userData.countriesDataListNewCases[newCaseIndex!].following = true
                        userData.countriesDataListDeaths[deathIndex!].following = true
                        userData.countriesDataListNewDeaths[newDeathIndex!].following = true
                        userData.countriesDataListRecovered[recoveredIndex!].following = true
                        userData.followedCountriesList[followListIndex!].following = true
                        
                        
                        everyContriesDataListCases = userData.countriesDataListCases
                        everyContriesDataListNewCases = userData.countriesDataListNewCases
                        everyContriesDataListDeaths = userData.countriesDataListDeaths
                        everyContriesDataListNewDeaths = userData.countriesDataListNewDeaths
                        everyContriesDataListRecovered = userData.countriesDataListRecovered
                        
                        
                        
                        followedUpDataList = userData.followedCountriesList
                        
                        self.showCountryAddedAlert = true
                        self.follow = true
                    } else {
                        let index = userData.followedCountriesList.firstIndex(where: {
                            $0.countryName == country.countryName
                        })
                        let caseIndex = userData.countriesDataListCases.firstIndex(where: {
                            $0.countryName == country.countryName
                        })
                        let newCaseIndex = userData.countriesDataListNewCases.firstIndex(where: {
                            $0.countryName == country.countryName
                        })
                        let deathIndex = userData.countriesDataListDeaths.firstIndex(where: {
                            $0.countryName == country.countryName
                        })
                        let newDeathIndex = userData.countriesDataListNewDeaths.firstIndex(where: {
                            $0.countryName == country.countryName
                        })
                        let recoveredIndex = userData.countriesDataListRecovered.firstIndex(where: {
                            $0.countryName == country.countryName
                        })
                        
                        
                        userData.followedCountriesList.remove(at: index!)
                        userData.countriesDataListCases[caseIndex!].following = false
                        userData.countriesDataListNewCases[newCaseIndex!].following = false
                        userData.countriesDataListDeaths[deathIndex!].following = false
                        userData.countriesDataListNewDeaths[newDeathIndex!].following = false
                        userData.countriesDataListRecovered[recoveredIndex!].following = false
                        
                        
                        
                        everyContriesDataListCases = userData.countriesDataListCases
                        everyContriesDataListNewCases = userData.countriesDataListNewCases
                        everyContriesDataListDeaths = userData.countriesDataListDeaths
                        everyContriesDataListNewDeaths = userData.countriesDataListNewDeaths
                        everyContriesDataListRecovered = userData.countriesDataListRecovered
                        followedUpDataList = userData.followedCountriesList
                        self.follow = false
                    }
                    
                }) {
                    HStack {
                        if follow {
                            Image(systemName: "heart.fill")
                                .imageScale(.large)
                                .foregroundColor(.red)
                            Text("Following")
                        } else {
                            Image(systemName: "heart")
                                .imageScale(.large)
                                .foregroundColor(.red)
                            Text("Folow Up")
                        }
                        
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
        .onAppear(perform: {
            follow = country.following
        })
    }   // End of body
    }
    
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

struct GridListDetails_Previews: PreviewProvider {
    static var previews: some View {
        GridListDetails(country: WorldDataStruct(id: UUID(), countryName: "Afghanistan", cases: 840, deaths: 30, totalRecovered: 54, newDeaths: 5, newCases: 56, lat: 33, long: 65, flagImgURL: "https://manta.cs.vt.edu/iOS/flags/af.png",flagImageName: "af",following: false))
    }
}
