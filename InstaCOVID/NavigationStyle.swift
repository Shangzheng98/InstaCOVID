//
//  NavigationStyle.swift
//  InstaCOVID
//
//  Created by Nicole Lyu on 11/20/20.
//  Copyright © 2020 team2. All rights reserved.
//
import SwiftUI
 
extension View {
  
    public func customNavigationViewStyle() -> some View {
 
        if UIDevice.current.userInterfaceIdiom == .phone {
            // Use single column navigation view for iPhone
            return AnyView(self.navigationViewStyle(StackNavigationViewStyle()))
        } else {
            // Use double column navigation view for iPad
            return AnyView(self
                .navigationViewStyle(DoubleColumnNavigationViewStyle())
                .padding(.leading, 1)  // Workaround to show master view until Apple fixes the bug
            )
        }
    }
  
}
 
