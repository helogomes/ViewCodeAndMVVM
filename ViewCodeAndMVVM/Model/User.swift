//
//  Person.swift
//  ViewCodeAndMVVM
//
//  Created by user218997 on 11/07/22.
//

import Foundation
import UIKit

struct UserResult: Codable {
    var group: [User]
}

struct User: Codable {
    var name:String
    var age:Int
    var profession:String
    var salary:String
    var imageUser:String
    var isEnableHeart:Bool
    var identifier:Int
}
