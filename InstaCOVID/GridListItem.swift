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
    
    let country: WorldDataStruct
    var shape = RoundedRectangle(cornerRadius: 20, style: .continuous)
    var body: some View {
//        let binding = Binding<Bool>(get: { self.flipped }, set: {
//            updateBinding($0)
//        })
        Image(country.flagImageName)
            .resizable()
            .aspectRatio(contentMode: .fit)
            .clipShape(shape)
            .onTapGesture {
                self.flipped.toggle()
                userData.flipped.toggle()
            }
            
//        if self.flipped {
//            VisualEffectBlur(blurStyle: .systemUltraThinMaterial, vibrancyStyle: .fill) {
//                Image("ImageUnavailable")
//                    .resizable()
//                    .scaledToFit()
//                    .frame(width: 240, height: 150)
//                    .modifier(FlipEffect(flipped: binding, angle: animate3d ? 180 : 0, axis: (x: 0, y: 1)))
//                    .onTapGesture {
//                        withAnimation(Animation.linear(duration: 0.8)) {
//                                                      self.animate3d.toggle()
//
//                        }
//                    }
//            }
//        } else {
//            Image(country.flagImageName)
//                .resizable()
//                .aspectRatio(contentMode: .fit)
//                .modifier(FlipEffect(flipped: binding, angle: animate3d ? 180 : 0, axis: (x: 0, y: 1)))
//                .onTapGesture {
//                    withAnimation(Animation.linear(duration: 0.8)) {
//                                                  self.animate3d.toggle()
//                        }
//            }
//
//        }
        
        
    }
    
    
    func updateBinding(_ value: Bool) {
        // If card was just flipped and at front, change the card
        userData.flipped = value
        flipped = value
    }
}
struct FlipEffect: GeometryEffect {
    
    var animatableData: Double {
        get { angle }
        set { angle = newValue }
    }
    
    @Binding var flipped: Bool
    var angle: Double
    let axis: (x: CGFloat, y: CGFloat)
    
    func effectValue(size: CGSize) -> ProjectionTransform {
        
        // We schedule the change to be done after the view has finished drawing,
        // otherwise, we would receive a runtime error, indicating we are changing
        // the state while the view is being drawn.
        DispatchQueue.main.async {
            self.flipped = self.angle >= 90 && self.angle < 270
        }
        let tweakedAngle = flipped ? -180 + angle : angle
        
        let a = CGFloat(Angle(degrees: tweakedAngle).radians)
        
        var transform3d = CATransform3DIdentity;
        transform3d.m34 = -1/max(size.width, size.height)
        
        transform3d = CATransform3DRotate(transform3d, a, axis.x, axis.y, 0)
        transform3d = CATransform3DTranslate(transform3d, -size.width/2.0, -size.height/2.0, 0)
        
        let affineTransform = ProjectionTransform(CGAffineTransform(translationX: size.width/2.0, y: size.height / 2.0))
        
        return ProjectionTransform(transform3d).concatenating(affineTransform)
    }
    
}

struct GridListItem_Previews: PreviewProvider {
    static var previews: some View {
        GridListItem(country: WorldDataStruct(id: UUID(), countryName: "Afghanistan", cases: 840, deaths: 30, totalRecovered: 54, newDeaths: 5, newCases: 56, lat: 33, long: 65, flagImgURL: "https://manta.cs.vt.edu/iOS/flags/af.png", flagImageName: "af", following: false))
    }
}
