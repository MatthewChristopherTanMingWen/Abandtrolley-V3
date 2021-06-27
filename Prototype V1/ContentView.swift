//
//  ContentView.swift
//  Prototype V1
//
//  Created by Matthew Tan on 23/6/21.
//

import SwiftUI

struct ContentView: View {
    @State var accusername: String = ""
    @State var accpassword: String = ""
    @State var accemail: String = ""
    @State var username: String = ""
    @State var password: String = ""
    @State var trolleycode: String = "0"
    @State var logInScreen = true
    @State var signUpScreen = false
    @State var wronginfo = false
    
    var body: some View {
        if (signUpScreen == false && logInScreen == true) {
            VStack{
                VStack{
                    VStack(alignment: .leading) {
                        Text("Username:")
                            .font(.callout)
                            .bold()
                            .font(.system(size: 20))
                        
                        TextField("Enter username...", text: $username)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                    }
                    VStack(alignment: .leading) {
                        Text("Password:")
                            .font(.callout)
                            .bold()
                            .font(.system(size: 20))
                        
                        TextField("Enter password...", text: $password)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                    }
                }.padding()
                
                HStack(alignment: .center) {
                    Button("Log in") {
                        print(username)
                        print(password)
                        if (username == accusername && password == accpassword){
                            logInScreen = false
                        }
                        else {
                            wronginfo = true
                        }
                    }
                    .padding()
                    .font(.system(size: 20))
                    
                    Button("No account? Sign up!"){
                        if (signUpScreen == false){
                            signUpScreen = true
                        }
                    }
                    .padding()
                    .font(.system(size: 20))
                }
            }.alert(isPresented: $wronginfo) {
                Alert(title: Text("Your username or password is incorrect"), dismissButton: .default(Text("OK")))
            }
        }
        else if (signUpScreen == true){
            VStack{
                VStack{
                    VStack(alignment: .leading) {
                        Text("Username:")
                            .font(.callout)
                            .bold()
                            .font(.system(size: 20))
                        
                        TextField("Enter username...", text: $accusername)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                    }
                    VStack(alignment: .leading) {
                        Text("Email:")
                            .font(.callout)
                            .bold()
                            .font(.system(size: 20))
                        
                        TextField("Enter Email...", text: $accemail)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                    }
                    VStack(alignment: .leading) {
                        Text("Password:")
                            .font(.callout)
                            .bold()
                            .font(.system(size: 20))
                        
                        TextField("Enter password...", text: $accpassword)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                    }
                }.padding()
                
                Button("Create account"){
                    if (signUpScreen == true){
                        signUpScreen = false
                    }
                }
            }
        }
        else if (logInScreen == false){
            VStack{
                Text("Unlock your trolley")
                    .offset(y: -300)
                    .font(.system(size: 30))
                HStack(alignment: .center) {
                    Text("Trolley Code:")
                        .font(.callout)
                        .bold()
                        .font(.system(size: 20))
                    
                    TextField("Enter code on trolley...", text: $trolleycode)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                }
            }.padding()
            
            Button("Unlock Trolley"){
                if (signUpScreen == true){
                    signUpScreen = false
                }
            }
        }
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
