//
//  DiagnosisAvailable.swift
//  InstaCOVID
//
//  Created by Nicole Lyu on 12/3/20.
//  Copyright © 2020 team2. All rights reserved.
//

import SwiftUI



let headerFont = Font.custom(FontNameManager.RussoOne.reg, size: 30)
let homeFont = Font.custom(FontNameManager.EastSeaDokdo.regu, size: 30)

struct DiagnosisAvailable: View {
    var body: some View {
        NavigationView{
            ZStack{
                Image("background").resizable().aspectRatio(contentMode:.fill).edgesIgnoringSafeArea(.all)
                VStack{
                    Text("Start your self diagnosis record right now!")
                        .font(headerFont)
                        .multilineTextAlignment(.center)
                        .frame(width: 350, height: 500, alignment: .bottom)
                        .foregroundColor(.white)
                    NavigationLink(destination: Diagnosis()) {
                        Image(systemName: "arrowshape.turn.up.right.circle")
                            .imageScale(.large)
                            .font(Font.title.weight(.regular))
                            .foregroundColor(.newBlack)
                            .background(Color.newYellow).clipShape(Circle())
                    }
                    //                }
                }
            }
            .navigationBarTitle(Text("Self-Diagnosis"), displayMode: .inline)
        }
    }   // End of var
}


struct DiagnosisAvailable_Previews: PreviewProvider {
    static var previews: some View {
        DiagnosisAvailable()
    }
}
