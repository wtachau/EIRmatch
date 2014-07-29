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

let appDelegate = UIApplication.sharedApplication().delegate as AppDelegate

let backgroundColor = UIColorFromRGB(13, 33, 140)
let buttonColor = UIColorFromRGB(34, 150, 229)

let lightBlue = UIColorFromRGB(62, 152, 248)
let lightGreen = UIColorFromRGB(49, 242, 149)
let lightPurple = UIColorFromRGB(84, 24, 242)

let navBarHeight = CGFloat(64)

//var postSaver = EIRPostSaver()
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
            return "Developers"
        case .Design:
            return "Designers"
        }
    }
    func image() -> UIImage {
        switch self {
        case .Management:
            return UIImage(named: "management.png")
        case .Developer:
            return UIImage(named: "developer.png")
        case .Design:
            return UIImage(named: "design.png")
        }
    }
}



//
//  RBResizer.swift
//  Locker
//
//  Created by Hampton Catlin on 6/20/14.
//  Copyright (c) 2014 rarebit. All rights reserved.
//


func RBSquareImageTo(image: UIImage, size: CGSize) -> UIImage {
    return RBResizeImage(RBSquareImage(image), size)
}

func RBSquareImage(image: UIImage) -> UIImage {
    var originalWidth  = image.size.width
    var originalHeight = image.size.height
    
    var edge: CGFloat
    if originalWidth > originalHeight {
        edge = originalHeight
    } else {
        edge = originalWidth
    }
    
    var posX = (originalWidth  - edge) / 2.0
    var posY = (originalHeight - edge) / 2.0
    
    var cropSquare = CGRectMake(posX, posY, edge, edge)
    
    var imageRef = CGImageCreateWithImageInRect(image.CGImage, cropSquare);
    return UIImage(CGImage: imageRef, scale: UIScreen.mainScreen().scale, orientation: image.imageOrientation)
}

func RBResizeImage(image: UIImage, targetSize: CGSize) -> UIImage {
    let size = image.size
    
    let widthRatio  = targetSize.width  / image.size.width
    let heightRatio = targetSize.height / image.size.height
    
    // Figure out what our orientation is, and use that to form the rectangle
    var newSize: CGSize
    if(widthRatio > heightRatio) {
        newSize = CGSizeMake(size.width * heightRatio, size.height * heightRatio)
    } else {
        newSize = CGSizeMake(size.width * widthRatio,  size.height * widthRatio)
    }
    
    // This is the rect that we've calculated out and this is what is actually used below
    let rect = CGRectMake(0, 0, newSize.width, newSize.height)
    
    // Actually do the resizing to the rect using the ImageContext stuff
    UIGraphicsBeginImageContextWithOptions(newSize, false, 1.0)
    image.drawInRect(rect)
    let newImage = UIGraphicsGetImageFromCurrentImageContext()
    UIGraphicsEndImageContext()
    
    return newImage
}
