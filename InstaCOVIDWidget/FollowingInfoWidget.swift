//
//  FollowingInfoWidget.swift
//  InstaCOVIDWidgetExtension
//
//  Created by Shangzheng Ji on 12/6/20.
//  Copyright © 2020 team2. All rights reserved.
//
import WidgetKit
import SwiftUI
import Intents

struct FollowingInfoWidget: Widget {
    var body: some WidgetConfiguration {
        StaticConfiguration(kind: "FollowingInfo", provider: WorldInfoTimeLine()) {
            entry in
            WorldInfoEntryView(entry: entry)
        }
        .configurationDisplayName("World COVID-19 Data")
        .description("Shows the World COVID-19 Data.")
        .supportedFamilies([.systemMedium, .systemLarge])
    }
}

extension FollowingInfoWidget {
    struct WorldInfoEntry: TimelineEntry {
        var date: Date
        var contry: WorldStatStruct
    }
    
    struct InfoLoader {
        
        static func getInfo(completion: @escaping (Result<WorldStatStruct, Error>) -> Void) {
            let APIKey = "889af3ca3fmshd882371958ac448p100118jsn58444a268212"
            let url = URL(string: "https://coronavirus-monitor-v2.p.rapidapi.com/coronavirus/worldstat.php")!
            var urlRequest = URLRequest(url: url)
            let headers = [
                "x-rapidapi-key": APIKey,
                "x-rapidapi-host": "coronavirus-monitor-v2.p.rapidapi.com"
            ]
            
            urlRequest.httpMethod="GET"
            urlRequest.allHTTPHeaderFields = headers
            let task = URLSession.shared.dataTask(with: urlRequest) {
                (data, response, error) in
                guard error == nil else {
                    completion(.failure(error!))
                    return
                }
                
                let jsonResponse = try! JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions.mutableContainers)
                
                var totalCases = "", newCases = "", totalDeaths = "", newDeaths = "", totalRecovered = ""
                
                if let jsonObject = jsonResponse as? [String: Any] {
                    if let cases = jsonObject["total_cases"] as? String {
                        totalCases = cases
                    }
                    
                    if let newCasesGeted = jsonObject["new_cases"] as? String {
                        newCases = newCasesGeted
                    }
                    
                    if let totalDeathGeted = jsonObject["total_deaths"] as? String {
                        totalDeaths = totalDeathGeted
                    }
                    
                    if let newDeathsGeted = jsonObject["new_deaths"] as? String {
                        newDeaths = newDeathsGeted
                    }
                    
                    if let recovered = jsonObject["total_recovered"] as? String {
                        totalRecovered = recovered
                    }
                }
                
                let worldInfo = WorldStatStruct(totalCases: totalCases, newCases: newCases, totalDeaths: totalDeaths, newDeaths: newDeaths, totalRecovered: totalRecovered)
                completion(.success(worldInfo))
                
            }
            task.resume()
        }
    }
}
extension FollowingInfoWidget {
    struct WorldInfoTimeLine: TimelineProvider {
        
        
        
//        typealias  Entry = WorldInfo
        
        func placeholder(in context: Context) -> WorldInfoEntry{
            WorldInfoEntry(date: Date(), contry: WorldStatStruct(totalCases: "-", newCases: "-", totalDeaths: "-", newDeaths: "-", totalRecovered: "-"))
        }
        
        func getSnapshot(in context: Context, completion: @escaping (WorldInfoEntry) -> Void) {
            let entry = WorldInfoEntry(date: Date(), contry: WorldStatStruct(totalCases: "-", newCases: "-", totalDeaths: "-", newDeaths: "-", totalRecovered: "-"))
            completion(entry)
        }
        
        func getTimeline(in context: Context, completion: @escaping (Timeline<WorldInfoEntry>) -> Void) {
            var entries: [WorldInfoEntry] = []

            let currentDate = Date()
            let refeshDate = Calendar.current.date(byAdding: .day, value: 1, to: currentDate)!
            
            InfoLoader.getInfo { result in
                let info: WorldStatStruct
                if  case .success(let getedWorldInfo) = result {
                    info = getedWorldInfo
                } else {
                    info = WorldStatStruct(totalCases: "-", newCases: "-", totalDeaths: "-", newDeaths: "-", totalRecovered: "-")
                }
                let entry = WorldInfoEntry(date: currentDate, contry: info)
                entries.append(entry)
                let timeline = Timeline(entries: entries, policy: .after(refeshDate))
                completion(timeline)
            }

//            WidgetCenter.shared.reloadAllTimelines()
        }
        
        
    }
    
    
    struct WorldInfoEntryView: View {
        let entry: WorldInfoEntry
        
        var body: some View {
            ZStack {
                VStack( spacing: 4) {
                    HStack {
                        Image(systemName: "globe")
                            .imageScale(.medium)
                            .foregroundColor(/*@START_MENU_TOKEN@*/.blue/*@END_MENU_TOKEN@*/)
                            .frame(alignment:.leading)
                        Text("World COVID-19 Data")
                            .foregroundColor(.gray)
                        date
                    }
                    HStack (spacing: 4){
                        VStack(alignment:.center,spacing: 4) {
                            Text("Confirmed")
                            Text("\(entry.contry.totalCases.replacingOccurrences(of: ",", with: ""))")
                                .foregroundColor(.red)
                            Divider()
                            HStack {
                                Image(systemName: "arrow.up")
                                    .imageScale(.small)
                                    .foregroundColor(.gray)
                                
                                Text("\(entry.contry.newCases.replacingOccurrences(of: ",", with: ""))")
                                    .foregroundColor(.gray)
                                    .font(.system(size: 11))
                            }
                        }
                        VStack(alignment: .center,spacing: 19) {
                            Text("Recovered")
                            Text("\(entry.contry.totalRecovered.replacingOccurrences(of: ",", with: ""))")
                                .foregroundColor(.green)
                                .padding(.bottom)

                        }
                        
                        VStack(alignment: .center,spacing: 4) {
                            Text("Deaths")
                            Text("\(entry.contry.totalDeaths.replacingOccurrences(of: ",", with: ""))")
                                .foregroundColor(.black)
                            Divider()
                            HStack {
                                Image(systemName: "arrow.up")
                                    .imageScale(.small)
                                    .foregroundColor(.gray)
                                
                                Text("\(entry.contry.newDeaths.replacingOccurrences(of: ",", with: ""))")
                                    .foregroundColor(.gray)
                                    .font(.system(size: 11))
                            }
                        }
                        
                            
                    }
            
                }
            }

        }
        
        var date: some View {
            let date = Date()
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "MM-dd"
            let currentDate = dateFormatter.string(from: date)
            return AnyView(Text(currentDate))
        }
    }
}

//struct FollowingInfoWidget_Previews: PreviewProvider {
//    static var previews: some View {
//        FollowingInfoWidget.WorldInfoEntryView(entry: FollowingInfoWidget.WorldInfoEntry(date: Date(), contry: WorldStatStruct(totalCases: "100000", newCases: "10000", totalDeaths: "100000", newDeaths: "100000", totalRecovered: "100000")))
//            .previewContext(WidgetPreviewContext(family: .systemMedium))
//    }
//}
