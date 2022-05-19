//
//  Observable.swift
//  MvvmEczane
//
//  Created by Tuncay FORMA on 17.05.2022.
//

import Foundation

class Observable<T>{
    var value:T?{
        didSet{
            listener.forEach{
                $0(value)
            }
        }
    }
    init(_ value:T?){
        self.value = value
    }
    private var listener:[((T?)->Void)] = []
    
    func bind(_ listener: @escaping(T?)->Void){
        listener(value)
        self.listener.append(listener)
    }
}
