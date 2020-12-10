//
//  SelfCheckCardWidget.swift
//  InstaCOVIDWidgetExtension
//
//  Created by Shangzheng Ji on 12/6/20.
//  Copyright © 2020 team2. All rights reserved.
//

import SwiftUI
import WidgetKit
struct SelfCheckCardWidget: Widget {
    var body: some WidgetConfiguration {
        StaticConfiguration(kind: "SelfCheckCardInfo", provider: RecordCardTimeLine()) {
            entry in
            RecordCardEntryView(entry: entry)
        }
        .configurationDisplayName("Recrod data")
        .description("Shows recrod data.")
        .supportedFamilies([.systemMedium])
    }
}

extension SelfCheckCardWidget {
    // the entry we define in the timeline
    struct RecordCarEntry: TimelineEntry {
        var date: Date = Date()
        
        var stampedNumber: Int
    }
}

extension SelfCheckCardWidget {
    /// to implement the TimelineProvider, we need to implement three methodt, placeholder(), getSnapShot(), and getTimeLine()
    struct RecordCardTimeLine: TimelineProvider {
    
        func placeholder(in context: Context) ->RecordCarEntry {
            RecordCarEntry(date: Date(),stampedNumber: 7)
        }

        func getSnapshot(in context: Context, completion: @escaping (RecordCarEntry) -> Void) {
            let entry = RecordCarEntry(date: Date(),stampedNumber: 6)
            completion(entry)
        }
        
        func getTimeline(in context: Context, completion: @escaping (Timeline<RecordCarEntry>) -> Void) {
            var entries: [RecordCarEntry] = []
            
            let currentDate = Date()
            let refeshDate = Calendar.current.date(byAdding: .day, value: 1, to: currentDate)!
            
            var stampeNumber = 5
            // we set up a sand box called group.com.ShangzhengJi.InstaCOVID to exchange the data between widget and main app
            let userDefault = UserDefaults(suiteName: "group.com.ShangzhengJi.InstaCOVID")
            stampeNumber = userDefault!.integer(forKey: "stampeNumber")
            
            let entry = RecordCarEntry(date: currentDate, stampedNumber: stampeNumber)
            entries.append(entry)
            
            let timeline = Timeline(entries: entries, policy: .after(refeshDate))
            completion(timeline)
        }
        
    }
    
    
    struct RecordCardEntryView: View {
        let entry: RecordCarEntry
        
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
                                guard index <= entry.stampedNumber else {
                                    return .unstamped
                                }
                                let firstAnimatedIndex = entry.stampedNumber
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
                
                
            }
        }
        
        struct StampSlot: View {
            enum Status {
                case unstamped
                case stampedAnimated(delayIndex: Int)
                case stamped
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
    
}

