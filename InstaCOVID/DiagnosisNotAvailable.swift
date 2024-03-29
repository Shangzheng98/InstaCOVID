//
//  DiagnosisNotAvailable.swift
//  InstaCOVID
//
//  Created by Nicole Lyu on 12/3/20.
//  Copyright © 2020 team2. All rights reserved.
//

import SwiftUI

struct DiagnosisNotAvailable: View {
    var body: some View {
        NavigationView{
            ZStack{
                Image("background").resizable().aspectRatio(contentMode:.fill).edgesIgnoringSafeArea(.all)
                VStack{
                    //                if (alreadySignInCheck){
                    Text("The personal information is not assigned yet, please go to Settings to finish it up!")
                        .font(headerFont)
                        .multilineTextAlignment(.center)
                        .frame(width: 350, height: 500, alignment: .bottom)
                        .foregroundColor(.white)
                    NavigationLink(destination: LogView()) {
                        Image(systemName: "arrowshape.turn.up.right.circle")
                            .imageScale(.large)
                            .font(Font.title.weight(.regular))
                            .foregroundColor(.newBlack)
                            .background(Color.newYellow).clipShape(Circle())
                    }
                }
            }
        }
        
        .navigationBarTitle(Text("Self-Diagnosis"), displayMode: .inline)
//        .onAppear(perform:{getCustomFontNames()})
        
    }   // End of var
}

extension Color{
    // define new colors in the Color struct
    static let newYellow = Color(red: 221/255, green: 183/255, blue: 2/255)
    static let newBlack = Color(red: 50/255, green: 51/255, blue: 53/255)
    static let newPink = Color(red: 151/255, green: 30/255, blue: 87/255)
    static let newGray = Color(red: 245/255, green: 245/255, blue: 245/255)
}

struct DiagnosisNotAvailable_Previews: PreviewProvider {
    static var previews: some View {
        DiagnosisNotAvailable()
    }
}
