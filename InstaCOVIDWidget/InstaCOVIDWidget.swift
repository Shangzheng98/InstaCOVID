//
//  InstaCOVIDWidget.swift
//  InstaCOVIDWidget
//
//  Created by Shangzheng Ji on 12/3/20.
//  Copyright © 2020 team2. All rights reserved.
//

import WidgetKit
import SwiftUI


@main
struct InstaCOVIDWidget: WidgetBundle {
    @WidgetBundleBuilder
    var body: some Widget {
        
        WorldInfoWidget()
        SelfCheckCardWidget()
    }
}

