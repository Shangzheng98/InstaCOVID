//
//  DiagnosisNotAvailable.swift
//  InstaCOVID
//
//  Created by Nicole Lyu on 12/3/20.
//  Copyright © 2020 team2. All rights reserved.
//

import SwiftUI

//struct FontNameManager {
//  //MARK: name of font family
//  struct SansitaSwashed {
//    static let black = "AmericanTypewriter"
//    static let bold = "AmericanTypewriter-Light"
//    static let extraBold = "AmericanTypewriter-Semibold"
//    static let light = "AmericanTypewriter-Bold"
//    static let medium = "AmericanTypewriter-Condensed"
//    static let regular = "AmericanTypewriter-CondensedLight"
//    static let semiBold = "AmericanTypewriter-CondensedBold"
//  }
//}
//
//let headerFont = Font.custom(FontNameManager.SansitaSwashed.medium, size: 38)

struct DiagnosisNotAvailable: View {
    var body: some View {
        NavigationView{
            VStack{
//                if (alreadySignInCheck){
                    Text("The personal information is not assigned yet, please go to Settings to finish it up!")
                        .font(headerFont)
                    NavigationLink(destination: LogView()) {
                        Image(systemName: "arrowshape.turn.up.forward.circle")
                            .imageScale(.large)
                            .font(Font.title.weight(.regular))
                            .foregroundColor(.blue)
                    }
//                }else{
//
//                    Text("Start your self diagnosis record right now!")
//                        .font(headerFont)
//                    NavigationLink(destination: Diagnosis()) {
//                        Image(systemName: "arrowshape.turn.up.forward.circle")
//                            .imageScale(.large)
//                            .font(Font.title.weight(.regular))
//                            .foregroundColor(.blue)
//                    }
//                }
            }
        }
        .navigationBarTitle(Text("Self-Diagnosis"), displayMode: .inline)
        .onAppear(perform:{getCustomFontNames()})
    }   // End of var
   
    
    func getCustomFontNames() {
      // get each of the font families
      for family in UIFont.familyNames.sorted() {
        let names = UIFont.fontNames(forFamilyName: family)
        // print array of names
        print("Family: \(family) Font names: \(names)")
      }
    }
    
//    /*
//     --------------------------------
//     MARK: - Check Password Entered
//     --------------------------------
//     */
//    var alreadySignInCheck: Bool {
//        let username = UserDefaults.standard.string(forKey: "Username")
//        let password = UserDefaults.standard.string(forKey: "Password")
//
//        if (username == nil && password == nil){
//            return true
//        }else{
//            return false
//        }
//    }
}


struct DiagnosisNotAvailable_Previews: PreviewProvider {
    static var previews: some View {
        DiagnosisNotAvailable()
    }
}
