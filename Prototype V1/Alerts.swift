//
//  Alerts.swift
//  Prototype V1
//
//  Created by Matthew Tan on 10/7/21.
//

import Foundation

class Alerts: ObservableObject {
    
    var warning: Bool{
        willSet {
            objectWillChange.send()
        }
    }
    
    var chargefine: Bool{
        willSet {
            objectWillChange.send()
        }
    }
    
    var failreturn: Bool{
        willSet {
            objectWillChange.send()
        }
    }
    
    var twothirdfailreturn: Bool{
        willSet {
            objectWillChange.send()
        }
    }
    
    var thirtyminfailreturn: Bool{
        willSet {
            objectWillChange.send()
        }
    }
    
    var successreturn: Bool{
        willSet {
            objectWillChange.send()
        }
    }
    
    var fine: Int{
        willSet {
            objectWillChange.send()
        }
    }
    
    init(warning: Bool, chargefine: Bool, failreturn: Bool, twothirdfailreturn: Bool, thirtyminfailreturn: Bool, successreturn: Bool, fine: Int) {
        self.warning = warning
        self.chargefine = chargefine
        self.failreturn = failreturn
        self.twothirdfailreturn = twothirdfailreturn
        self.thirtyminfailreturn = thirtyminfailreturn
        self.successreturn = successreturn
        self.fine = fine
    }
}
