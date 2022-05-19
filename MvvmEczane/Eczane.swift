//
//  Eczane.swift
//  MvvmEczane
//
//  Created by Tuncay FORMA on 17.05.2022.
//

import Foundation

struct Eczane:Codable{
    let name:String
    let dist:String
    let address:String
    let phone:String
    let loc:String
}

struct EczaneResponse:Codable{
    let success:Bool
    let result:[Eczane]
}
