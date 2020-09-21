//
//  HostingController.swift
//  KnuckleRanker WatchKit Extension
//
//  Created by 広井 芳秋 on 2020/09/05.
//  Copyright © 2020 Yoshiaki Hiroi. All rights reserved.
//

import WatchKit
import Foundation
import SwiftUI

class MeasuringHostingController: WKHostingController<MeasuringKnuckleView> {
    override var body: MeasuringKnuckleView {
        return MeasuringKnuckleView(viewModel: MeasuringKnuckleViewModel())
    }
}

class ProfileHostingController: WKHostingController<MeasuringKnuckleView> {
    override var body: MeasuringKnuckleView {
        return MeasuringKnuckleView(viewModel: MeasuringKnuckleViewModel())
    }
}
