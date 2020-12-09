//
//  MonitorListItem.swift
//  InstaCOVID
//
//  Created by Ruichang Chen on 2020/12/3.
//  Copyright © 2020 team2. All rights reserved.
//

import SwiftUI

struct MonitorListItem: View {
    
    let stateHistData: StateHistDataStruct
    
    var body: some View {
        VStack (alignment: .leading){
            HStack(alignment: .center) {
                Text(stateHistData.stateName)
                    .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
                    .bold()
                    .foregroundColor(.blue)
                Spacer()
                Text("Total case: \(stateHistData.data[0].totalCase)")
                    .foregroundColor(.red)
                    .font(.system(size: 14))
                    .bold()
            }
            VStack {
                Text("Day case")
                    .font(.system(size: 20))
                    .bold()
                    .foregroundColor(.gray)
                GeometryReader { geometry in
                    ZStack {
                        dashLine()
                            .stroke(style: StrokeStyle(lineWidth: 1, dash: [5]))
                            .frame(height: 1)
                            .offset(y: -geometry.size.height / 2)
                        Text("\(stateHistData.maxCase)")
                            .font(.system(size: 14))
                            .foregroundColor(.gray)
                            .offset(x: -geometry.size.width / 2 + 20, y: -geometry.size.height / 2 + 10)
                        getGraphCapsule(stateHistData: stateHistData, height: geometry.size.height)
                    }
                }
                .frame(height: 100)
            }
        }
        
    }
    /*
     Create dashLine in the View
     */
    struct dashLine: Shape {
        func path(in rect: CGRect) -> Path {
            var path = Path()
            path.move(to: CGPoint(x: 0, y: 0))
            path.addLine(to: CGPoint(x: rect.width, y: 0))
            return path
        }
    }
    
    /*
     Create a set of cpasule to display the state hist data
     */
    func getGraphCapsule(stateHistData: StateHistDataStruct, height: CGFloat) -> some View {
        ScrollView (.horizontal){
            HStack (alignment: .bottom, spacing: 1){
                ForEach(stateHistData.data) { dayData in
                    Capsule()
                        .fill(Color.blue)
                        .frame(width: 3, height: max(CGFloat(dayData.increaseCase + 1) * height / CGFloat(stateHistData.maxIncreaseCase), 5))
                }
            }
            .rotation3DEffect(.degrees(180), axis: (x: 0, y: 1, z: 0))
        }
    }
    
    /*
     Create a path for display the data
     */
    
    func getLineChart(data: [Int], width: Int, height: Int) -> Path {
        var path = Path()
        let max = Double(data.max()!)
        let min = Double(data.min()!)
        let yStep = Double(Double(height)/(max-min))
        let xStep = Double(Double(width)/Double(data.count))
        let p1 = CGPoint(x:0, y: (Double(data[0]) - min) * yStep)
        path.move(to: p1)
        for index in 1 ..< data.count {
            let p2 = CGPoint(x: xStep * Double(index), y: yStep*Double(data[index])-min)
            path.addLine(to: p2)
        }
        return path
    }
}

