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
                    .foregroundColor(/*@START_MENU_TOKEN@*/.blue/*@END_MENU_TOKEN@*/)
            }
            GeometryReader { geometry in
                ZStack {
                    getGraphCapsule(stateHistData: stateHistData, height: geometry.size.height)
                }
            }
            .frame(height: 100)
        }
    }
    
    func getGraphCapsule(stateHistData: StateHistDataStruct, height: CGFloat) -> some View {
        HStack (alignment: .bottom){
            ForEach(stateHistData.data) { dayData in
                Capsule()
                    .fill(Color.gray)
                    .frame(width: 3, height: CGFloat(dayData.increaseCase + 1) * height / CGFloat(stateHistData.maxIncreaseCase))
            }
        }
    }
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

