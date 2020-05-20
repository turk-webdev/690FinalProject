//
//  ReportModel.swift
//  FinalProject
//
//  Created by Turk Erdin on 5/19/20.
//  Copyright © 2020 Turk Erdin. All rights reserved.
//

import Foundation

enum StructError: Error {
    case castingIssue
}

struct Minutes: Decodable {
    let m00: String?
    let m15: String?
    let m30: String?
    let m45: String?
}

//struct Hours: Decodable {
//    let h00: [Minutes]
//    let h01: [Minutes]
//    let h02: [Minutes]
//    let h03: [Minutes]
//    let h04: [Minutes]
//    let h05: [Minutes]
//    let h06: [Minutes]
//    let h07: [Minutes]
//    let h08: [Minutes]
//    let h09: [Minutes]
//    let h10: [Minutes]
//    let h11: [Minutes]
//    let h12: [Minutes]
//    let h13: [Minutes]
//    let h14: [Minutes]
//    let h15: [Minutes]
//    let h16: [Minutes]
//    let h17: [Minutes]
//    let h18: [Minutes]
//    let h19: [Minutes]
//    let h20: [Minutes]
//    let h21: [Minutes]
//    let h22: [Minutes]
//    let h23: [Minutes]
//}

struct Hours: Decodable {
    let h00: Minutes?
    let h01: Minutes?
    let h02: Minutes?
    let h03: Minutes?
    let h04: Minutes?
    let h05: Minutes?
    let h06: Minutes?
    let h07: Minutes?
    let h08: Minutes?
    let h09: Minutes?
    let h10: Minutes?
    let h11: Minutes?
    let h12: Minutes?
    let h13: Minutes?
    let h14: Minutes?
    let h15: Minutes?
    let h16: Minutes?
    let h17: Minutes?
    let h18: Minutes?
    let h19: Minutes?
    let h20: Minutes?
    let h21: Minutes?
    let h22: Minutes?
    let h23: Minutes?
    
    private enum CodingKeys: String, CodingKey {
        case h00 = "h00",
        h01 = "h01",
        h02 = "h02",
        h03 = "h03",
        h04 = "h04",
        h05 = "h05",
        h06 = "h06",
        h07 = "h07",
        h08 = "h08",
        h09 = "h09",
        h10 = "h10",
        h11 = "h11",
        h12 = "h12",
        h13 = "h13",
        h14 = "h14",
        h15 = "h15",
        h16 = "h16",
        h17 = "h17",
        h18 = "h18",
        h19 = "h19",
        h20 = "h20",
        h21 = "h21",
        h22 = "h22",
        h23 = "h23"
    }
}
