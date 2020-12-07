//
//  InstaCOVIDWidget.swift
//  InstaCOVIDWidget
//
//  Created by Shangzheng Ji on 12/3/20.
//  Copyright © 2020 team2. All rights reserved.
//

import WidgetKit
import SwiftUI

//struct Provider: TimelineProvider {
//    func placeholder(in context: Context) -> SimpleEntry {
//        SimpleEntry(date: Date())
//    }
//
//    func getSnapshot(in context: Context, completion: @escaping (SimpleEntry) -> ()) {
//        let entry = SimpleEntry(date: Date())
//        completion(entry)
//    }
//
//    func getTimeline(in context: Context, completion: @escaping (Timeline<Entry>) -> ()) {
//        var entries: [SimpleEntry] = []
//
//        // Generate a timeline consisting of five entries an hour apart, starting from the current date.
//        let currentDate = Date()
//        for hourOffset in 0 ..< 5 {
//            let entryDate = Calendar.current.date(byAdding: .hour, value: hourOffset, to: currentDate)!
//            let entry = SimpleEntry(date: entryDate)
//            entries.append(entry)
//        }
//
//        let timeline = Timeline(entries: entries, policy: .atEnd)
//        completion(timeline)
//    }
//}
//
//struct SimpleEntry: TimelineEntry {
//    let date: Date
//}
//
//struct InstaCOVIDWidgetEntryView : View {
//    var entry: Provider.Entry
//
//    var body: some View {
//        Text(entry.date, style: .time)
//    }
//}

//@main
//struct InstaCOVIDWidget: Widget {
//    let kind: String = "InstaCOVIDWidget"
//
//    var body: some WidgetConfiguration {
//        StaticConfiguration(kind: kind, provider: Provider()) { entry in
//            InstaCOVIDWidgetEntryView(entry: entry)
//        }
//        .configurationDisplayName("Self-Quarantine Check Status")
//        .description("Check your progress of 14-days self quarantine.")
//    }
//}


@main
struct InstaCOVIDWidget: WidgetBundle {
    @WidgetBundleBuilder
    var body: some Widget {
        
        FollowingInfoWidget()
//        SelfCheckCardWidget()
    }
}
//struct InstaCOVIDWidget_Previews: PreviewProvider {
//    static var previews: some View {
//        InstaCOVIDWidgetEntryView(entry: SimpleEntry(date: Date()))
//            .previewContext(WidgetPreviewContext(family: .systemSmall))
//    }
//}
