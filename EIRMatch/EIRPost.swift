//
//  EIRPostSaver.swift
//  EIRMatch
//
//  Created by William Tachau on 7/23/14.
//  Copyright (c) 2014 William Tachau. All rights reserved.
//

import UIKit

class EIRPost {
    
    var name : String?
    var city : City?
    var needs : Dictionary<Int, Bool>
    var title : String
    var description : String
    
    init(name: String, city: City, needs: Dictionary<Int, Bool>, title: String, description: String) {
        
        self.name = name
        self.city = city
        self.needs = needs
        self.title = title
        self.description = description
    }
}
