//
//  SensorDataRecorder.swift
//  KnuckleRanker WatchKit Extension
//
//  Created by 広井 芳秋 on 2020/09/21.
//  Copyright © 2020 Yoshiaki Hiroi. All rights reserved.
//

import Foundation

class SensorDataRecorder {
    private var dataList = [SensorData]()
    
    func addData(timestamp: TimeInterval, data: [Double]) {
        self.dataList.append(SensorData(timestamp: timestamp, value: data))
    }
    
    func save() {
        if !self.dataList.isEmpty {
            let record = SensorDataRecord(data: self.dataList)
            // FIXME: convert record object to CSV file (or format for CloudKit)
        }
        self.dataList.removeAll()
    }
}

struct SensorData {
    let timestamp: TimeInterval
    let value: [Double]
}

extension SensorData: CustomStringConvertible {
    var description: String {
        return "[\(self.timestamp)] "
            + self.value.map { String($0) }.joined(separator: ", ")
    }
}

struct SensorDataRecord {
    let data: [SensorData]
}
