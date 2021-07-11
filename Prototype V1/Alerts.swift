//
//  Alerts.swift
//  Prototype V1
//
//  Created by Matthew Tan on 10/7/21.
//

import Foundation

class Alerts: ObservableObject {
    var wronginfo: Bool{
        willSet {
            objectWillChange.send()
        }
    }
    
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
    
    init(wronginfo: Bool, warning: Bool, chargefine: Bool, failreturn: Bool, twothirdfailreturn: Bool, successreturn: Bool, fine: Int) {
        self.wronginfo = wronginfo
        self.warning = warning
        self.chargefine = chargefine
        self.failreturn = failreturn
        self.twothirdfailreturn = twothirdfailreturn
        self.successreturn = successreturn
        self.fine = fine
    }
}
