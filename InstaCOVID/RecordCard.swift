//
//  RecordCard.swift
//  InstaCOVID
//
//  Created by Shangzheng Ji on 12/8/20.
//  Copyright © 2020 team2. All rights reserved.
//

import SwiftUI

struct RecordCard: View {
    @EnvironmentObject var userData: UserData
    // pamater for the starting piont of animation
    var animatedStamps = 0
    var columns:[GridItem] {
        [GridItem](repeating: GridItem(.flexible(minimum: 10)), count: 7)
    }
    var body: some View {
        VStack {
            VStack {
                Text("Record Card")
                    .font(Font.title2.bold())
                    .padding(.top, 10)
                
                LazyVGrid(columns: columns,spacing:10) {
                    ForEach(1...14, id: \.self) { index in
                        let status: StampSlot.Status = {
                            guard index <= userData.recordDay else {
                                return .unstamped
                            }
                            let firstAnimatedIndex = userData.recordDay - animatedStamps
                            if index >= firstAnimatedIndex {
                                return .stampedAnimated(delayIndex: index - firstAnimatedIndex)
                            } else {
                                return .stamped
                            }
                        }()
                        StampSlot(status: status, dayNumber: index)
                    }
                }
            }
            
            Group {
                Text(userData.recordDay < 14 ? "You are \(14 - userData.recordDay) days left to finish self-quarantine" : "You have finished the self-quarantine. Keep safe!")
            }
        }
    }
}

extension RecordCard {
    // the sub struct for a stamp
    struct StampSlot: View {
        
        // the enumation of state of stampl
        enum Status {
            case unstamped // not stamp
            case stampedAnimated(delayIndex: Int) // stamp with a animation
            case stamped // has stamped
        }
        
        var status: Status
        var dayNumber: Int
        @State private var stamped = false
        
        var body: some View {
            ZStack{
                Circle().fill(Color(red: 1.0, green: 1.0, blue: 240/250))
                
                switch status {
                case .stamped, .stampedAnimated:
                    VStack {
                        Text("day \(dayNumber)")
                            .font(.system(size: 11))
                        Image(systemName: "seal.fill")
                            .scaleEffect(stamped ? 1 : 2)
                            .opacity(stamped ? 1 : 0)
                            .foregroundColor(.blue)
                    }
                    
                default:
                    EmptyView()
                }
            }
            .aspectRatio(1, contentMode: .fit)
            .onAppear {
                switch status {
                case .stamped:
                    stamped = true
                case .stampedAnimated(let delayIndex):
                    // the delay of  animation will increase as index going up
                    let delay = Double(delayIndex + 1) * 0.2
                    withAnimation(Animation.spring(response: 0.5, dampingFraction: 0.8).delay(delay)) {
                        stamped = true
                    }
                default:
                    stamped = false
                }
            }
            
        }
    }
}
struct RecordCard_Previews: PreviewProvider {
    static var previews: some View {
        //RecordCard()
        RecordCard(animatedStamps: 4)
    }
}
