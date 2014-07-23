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

