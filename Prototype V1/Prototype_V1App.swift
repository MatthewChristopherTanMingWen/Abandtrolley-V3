//
//  Prototype_V1App.swift
//  Prototype V1
//
//  Created by Matthew Tan on 23/6/21.
//

import SwiftUI

@main
struct Prototype_V1App: App {
    var body: some Scene {
        WindowGroup {
            ContentView(alert: .constant(Alerts(warning: false, chargefine: false, failreturn: false, twothirdfailreturn: false, successreturn: false, fine: 0)), acc: .constant(AccDetails(accusername: "", accpassword: "", accemail: "")))
        }
    }
}
