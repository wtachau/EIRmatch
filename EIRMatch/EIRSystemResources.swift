//
//  EIRSystemResources.swift
//  EIRMatch
//
//  Created by William Tachau on 7/21/14.
//  Copyright (c) 2014 William Tachau. All rights reserved.
//

import UIKit
import Foundation

func UIColorFromRGB(red: Int, green:Int, blue:Int) -> UIColor {
    return UIColor(
        red: CGFloat(red) / 255.0,
        green: CGFloat(green) / 255.0,
        blue: CGFloat(blue) / 255.0,
        alpha: CGFloat(1.0)
    )
}

let backgroundColor = UIColorFromRGB(13, 33, 140)
let buttonColor = UIColorFromRGB(34, 150, 229)

let lightBlue = UIColorFromRGB(62, 152, 248)
let lightGreen = UIColorFromRGB(49, 242, 149)
let lightPurple = UIColorFromRGB(84, 24, 242)

let navBarHeight = CGFloat(64)

var postSaver = EIRPostSaver()
var postLoader = EIRPostLoader()

enum City : Int {
    case SanFrancisco = 1
    case NewYork
    case LosAngeles
    case Sunnyvale
    case LasVegas
    case OrangeCounty
    case Other
    func string() -> String {
        switch self {
        case .SanFrancisco:
            return "San Francisco"
        case .NewYork:
            return "New York"
        case .LosAngeles:
            return "Los Angeles"
        case .Sunnyvale:
            return "Sunnyvale"
        case .LasVegas:
            return "Las Vegas"
        case .OrangeCounty:
            return "Orange County"
        case .Other:
            return "Other"
        }
    }
}

enum Role : Int {
    case Management = 1, Developer, Design
    func string() -> String {
        switch self {
        case .Management:
            return "Management"
        case .Developer:
            return "Developer"
        case .Design:
            return "Design"
        }
    }
}

