//
//  EczaneViewModel.swift
//  MvvmEczane
//
//  Created by Tuncay FORMA on 17.05.2022.
//

import Foundation

struct EczaneListViewModel{
    var eczaneler : Observable<[EczaneTableCellViewModel]> = Observable([])
}
struct EczaneTableCellViewModel{
    let name:String
    let dist:String
    let address:String
    let phone:String
    let loc:String
}
