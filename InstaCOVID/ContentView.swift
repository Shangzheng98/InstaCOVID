//
//  ContentView.swift
//  InstaCOVID
//
//  Created by Shangzheng Ji on 11/20/20.
//

import SwiftUI
 
struct ContentView: View {
    var body: some View {
        TabView {
            Home()
                .tabItem {
                    Image(systemName: "house.fill")
                    Text("Home")
                }
//            FavoritesList()
//                .tabItem {
//                    Image(systemName: "star.fill")
//                    Text("Favorites")
//                }
//            NowPlayingsList()
//                .tabItem {
//                    Image(systemName: "rectangle.stack.fill")
//                    Text("Now Playing")
//                }
//            MovieSearch()
//                .tabItem {
//                    Image(systemName: "magnifyingglass.circle.fill")
//                    Text("Movie Search")
//
//                }
//            GenresList()
//                .tabItem {
//                    Image(systemName: "list.and.film")
//                    Text("Genres")
//                }
        }   // End of TabView
            .font(.headline)
            .imageScale(.medium)
            .font(Font.title.weight(.regular))
    }
}
 
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
