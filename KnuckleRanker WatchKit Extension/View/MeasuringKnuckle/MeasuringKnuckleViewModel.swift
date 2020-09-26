//
//  MeasuringKnuckleViewModel.swift
//  KnuckleRanker WatchKit Extension
//
//  Created by 広井 芳秋 on 2020/09/13.
//  Copyright © 2020 Yoshiaki Hiroi. All rights reserved.
//

import SwiftUI
import Combine
import CoreMotion

class MeasuringKnuckleViewModel: ObservableObject {
    @Published var timerCount = 0
    @Published var isTimerFinished = false
    private var cancellable: AnyCancellable?
    
    private var motionManager: CMMotionManager?
    private var recorder: SensorDataRecorder?
    
    deinit {
        self.cancellable?.cancel()
        self.stopSensor()
    }
    
    func startTimer(to: Int) {
        self.timerCount = to
        // https://developer.apple.com/documentation/foundation/timer/3329589-publish
        self.cancellable?.cancel()
        self.cancellable = Timer.publish(every: 1.0, on: .main, in: .common)
            .autoconnect()
            .sink() { _ in
                if self.timerCount > 0 {
                    self.timerCount -= 1
                }
                if self.timerCount == 0 {
                    self.isTimerFinished = true
                    self.cancellable?.cancel()
                }
            }
    }
    
    func vibrate() {
        // https://developer.apple.com/documentation/watchkit/wkinterfacedevice/1628128-play
        WKInterfaceDevice.current().play(.start)
    }
    
    func startSensor() {
        self.recorder = SensorDataRecorder()
        self.motionManager = CMMotionManager()
        guard let manager = self.motionManager else {
            return
        }
        if !manager.isAccelerometerAvailable {
            print("startSensor: accelerometer is not available.")
            return
        }
        manager.accelerometerUpdateInterval = 1 / 30 // 30Hz
        manager.startAccelerometerUpdates(to: .main, withHandler: self.updateAccelerometer)
    }
    
    func stopSensor() {
        if let manager = self.motionManager, manager.isAccelerometerActive {
            manager.stopAccelerometerUpdates()
            self.motionManager = nil
        }
        self.recorder = nil
    }
    
    private func updateAccelerometer(data: CMAccelerometerData?, error: Error?) {
        if let error = error {
            print("updateAccelerometer: error \(error.localizedDescription)")
            return
        }
        guard let data = data else {
            print("updateAccelerometer: error (data is nil))")
            return
        }
        if let recorder = self.recorder {
            recorder.addData(
                timestamp: data.timestamp,
                data: [data.acceleration.x, data.acceleration.y, data.acceleration.z]
            )
        }
    }
}
