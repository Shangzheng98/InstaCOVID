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
                Text("Total cases: \(stateHistData.cases[0])")
                    .font(.footnote)
                Text("Total deaths: \(stateHistData.deaths[0])")
                    .font(.footnote)
            }
            GeometryReader { geometry in
                ZStack {
                    getLineChart(data: stateHistData.cases, width: Int(geometry.frame(in: .local).size.width), height: 100)
                        .stroke(Color.red, style: StrokeStyle(lineWidth: 2, lineJoin: .round))
                        .drawingGroup()
                    getLineChart(data: stateHistData.deaths, width: Int(geometry.frame(in: .local).size.width), height: 100)
                        .stroke(Color.blue, style: StrokeStyle(lineWidth: 2, lineJoin: .round))
                        .drawingGroup()
                }
            }
            .frame(height: 100)
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

