//
//  AccDetails.swift
//  Prototype V1
//
//  Created by Matthew Tan on 10/7/21.
//

import Foundation

class AccDetails: ObservableObject {
    var accusername: String{
        willSet {
            objectWillChange.send()
        }
    }
    var accpassword: String{
        willSet {
            objectWillChange.send()
        }
    }
    var accemail: String{
        willSet {
            objectWillChange.send()
        }
    }
    
    init(accusername: String, accpassword: String, accemail: String){
        self.accusername = accusername
        self.accpassword = accpassword
        self.accemail = accemail
    }
}
