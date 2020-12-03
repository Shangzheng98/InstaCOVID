//
//  Widgwt.swift
//  Widgwt
//
//  Created by Shangzheng Ji on 11/20/20.
//  Copyright © 2020 team2. All rights reserved.
//

import WidgetKit
import SwiftUI

struct SelfCheckEntry: TimelineEntry {
    let date: Date
    let points: Int
}

struct Provider: TimelineProvider {
    
    func placeholder(in context: Context) -> SelfCheckEntry {
        SelfCheckEntry(date: Date(), points: 4)
    }
    
    func getSnapshot(in context: Context, completion: @escaping (SelfCheckEntry) -> ()) {
        let entry = SelfCheckEntry(date: Date(), points: 4)
        completion(entry)
    }
    
    func getTimeline(in context: Context, completion: @escaping (Timeline<Entry>) -> ()) {
        let entry = SelfCheckEntry(date: Date(), points: 4)
        let timeline = Timeline(entries: [entry], policy: .atEnd)
        completion(timeline)
    }
}

struct WidgwtEntryView : View {
    var entry: Provider.Entry
    
    var body: some View {
        Text(entry.date, style: .time)
    }
}

@main
struct Widgwt: Widget {
    let kind: String = "Widgwt"
    
    var body: some WidgetConfiguration {
        StaticConfiguration(kind: kind, provider: Provider()) { entry in
            WidgwtEntryView(entry: entry)
        }
        .configurationDisplayName("Self-Quarantine Check Status")
        .description("Check your progress of 14-days self quarantine.")
    }
}

struct Widgwt_Previews: PreviewProvider {
    static var previews: some View {
        WidgwtEntryView(entry: SelfCheckEntry(date: Date(), points: 4))
            .previewContext(WidgetPreviewContext(family: .systemSmall))
    }
}
