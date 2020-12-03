//
//  Monitor.swift
//  InstaCOVID
//
//  Created by Ruichang Chen on 2020/12/3.
//  Copyright © 2020 team2. All rights reserved.
//

import SwiftUI
import MapKit

struct Monitor: View {
    @State private var userTrackingMode: MapUserTrackingMode = .follow
    @State private var region = MKCoordinateRegion(
        center: CLLocationCoordinate2D(latitude: 37.6, longitude: -95.6),
        span: MKCoordinateSpan(latitudeDelta: 40, longitudeDelta: 40)
    )
    @EnvironmentObject var userData: UserData
    
    let selectionImageName = ["map", "list.dash"]
    @State private var selectedIndex = 0
    
    var body: some View {
        NavigationView {
            VStack(spacing: 0.0) {
                Picker("Display", selection: $selectedIndex) {
                    ForEach(0 ..< selectionImageName.count, id: \.self) {
                        Image(systemName: selectionImageName[$0])
                    }
                }
                .pickerStyle(SegmentedPickerStyle())
                if selectedIndex == 0 {
                    Map(
                        coordinateRegion: $region,
                        interactionModes: MapInteractionModes.all,
                        showsUserLocation: true,
                        userTrackingMode: $userTrackingMode,
                        annotationItems: userData.countriesDataListCases
                    ) { country in
                        MapAnnotation(coordinate: CLLocationCoordinate2D(latitude: country.lat, longitude: country.long), anchorPoint: CGPoint(x: 0.5, y: 0.5)) {
                            ZStack {
                                RoundedRectangle(cornerRadius: 5)
                                    .foregroundColor(.white)
                                    .opacity(/*@START_MENU_TOKEN@*/0.8/*@END_MENU_TOKEN@*/)
                                MonitorAnnotation(country: country)
                            }
                        }
                    }
                }
                else {
                    List {
                        Text("Working in progress")
                    }
                }
            }
            .navigationBarTitle("COVID-19 Case Monitor", displayMode: .inline)
        }
    }
}

struct Monitor_Previews: PreviewProvider {
    static var previews: some View {
        Monitor()
            .environmentObject(UserData())
    }
}
