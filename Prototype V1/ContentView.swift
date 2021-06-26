//
//  ContentView.swift
//  Prototype V1
//
//  Created by Matthew Tan on 23/6/21.
//

import SwiftUI

struct ContentView: View {
    @State var username: String = ""
    @State var password: String = ""
    @State var logInScreen = true
    @State var signUpScreen = false
    
    var body: some View {
        VStack{
            VStack{
                HStack(alignment: .center) {
                    Text("Username:")
                        .font(.callout)
                        .bold()
                    
                    TextField("Enter username...", text: $username)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                }
                HStack {
                    Text("Password:")
                        .font(.callout)
                        .bold()
                    
                    TextField("Enter password...", text: $password)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                }
            }.padding()
            
            HStack {
                Button("Log in") {
                    print(username)
                }.padding()
                
                Button("No account? Sign up!"){
                    if (signUpScreen == false){
                        signUpScreen = true
                    }
                }.padding()
            }
        }
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
