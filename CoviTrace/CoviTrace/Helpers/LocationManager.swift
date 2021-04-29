//
//  LocationManager.swift
//  CoviTrace
//
//  Created by Stanford L. Khumalo on 18/02/2021.
//

import Combine
import Foundation

class LocationManager: NSObject, ObservableObject {
    let objectWillChange = PassthroughSubject<Void, Never>()
    
    @Published var someVar: Int = 0 {
        willSet { objectWillChange.send() }
    }
    
    override init(){
        super.init()
    }
}
