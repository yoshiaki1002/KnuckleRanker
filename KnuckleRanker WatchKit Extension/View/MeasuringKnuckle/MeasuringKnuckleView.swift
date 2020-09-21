//
//  MeasuringKnuckleView.swift
//  KnuckleRanker WatchKit Extension
//
//  Created by 広井 芳秋 on 2020/09/05.
//  Copyright © 2020 Yoshiaki Hiroi. All rights reserved.
//

import SwiftUI
import Combine

struct MeasuringKnuckleView: View {
    @ObservedObject private var viewModel: MeasuringKnuckleViewModel
    
    init(viewModel: MeasuringKnuckleViewModel) {
        self.viewModel = viewModel
    }
    
    @ViewBuilder
    var body: some View {
        if !viewModel.isTimerFinished {
            CountDownView(count: $viewModel.timerCount).onAppear {
                self.viewModel.startTimer(to: 3)
            }
        } else {
            VStack {
                Text("Start")
                    .font(.system(size: 22.0))
                    .fontWeight(.heavy)
                Text("Punching")
                    .font(.system(size: 22.0))
                    .fontWeight(.heavy)
            }.onAppear {
                self.viewModel.vibrate()
                self.viewModel.startSensor()
            }
        }
    }
}

struct CountDownView: View {
    @Binding var count: Int
    
    var body: some View {
        Text("\(self.count)")
            .font(.system(size: 65.0))
            .fontWeight(.heavy)
    }
}



struct MeasuringKnuckleView_Previews: PreviewProvider {
    static var previews: some View {
        MeasuringKnuckleView(viewModel: MeasuringKnuckleViewModel())
    }
}
