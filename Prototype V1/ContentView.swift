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
    @State var trolleyreturncode: String = "0"
    @State var logInScreen = true
    @State var signUpScreen = false
    @State var trolleyUnlockScreen = false
    @State var wronginfo = false
    @State var twothirdfailreturn = false
    @State var failreturn = false
    @State var successreturn = false
    @State var isTimerRunning = false
    @State var chargefine = false
    @State var fine = 0
    @State private var startTime =  Date()
    @State private var timerString = "0.00"
    @State private var timeRemaining: Double = 10800.00
    @State private var isActive = false
    @State private var timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    func charge() {
        if (timeRemaining == 0){
            if (fine == 0){
                timeRemaining = 7200
                fine = 1
            }
            else if (fine > 0){
                chargefine = true
                trolleyUnlockScreen = false
                logInScreen = false
                isActive = false
            }
        }
    }
    
    var body: some View {
        
        if (signUpScreen == false && logInScreen == true) {
            
            VStack{
                
                VStack{
                    
                    Text("Log In")
                        .offset(y: -270)
                        .font(.system(size: 30))
                    
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
                    
                    Button("Done") {
                        if (username == accusername && password == accpassword){
                            logInScreen = false
                            wronginfo = false
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
                    
                    Text("Create your account")
                        .offset(y: -270)
                        .font(.system(size: 30))
                    
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
        
        else if (logInScreen == false && trolleyUnlockScreen == false){
            
            VStack{
                
                VStack{
                    
                    Text("Unlock your trolley \(username)")
                        .offset(y: -300)
                        .font(.system(size: 30))
                    
                    VStack(alignment: .leading) {
                        
                        Text("Trolley Code:")
                            .font(.callout)
                            .bold()
                            .font(.system(size: 20))
                        
                        TextField("Enter code on trolley...", text: $trolleycode)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                    }
                    
                    Button("Unlock Trolley"){
                        if (trolleyUnlockScreen == false){
                            if (trolleycode == "1234"){
                                trolleyUnlockScreen = true
                                timeRemaining = 10800.00
                                isActive = true
                                wronginfo = false
                            }
                            else {
                                wronginfo = true
                            }
                        }
                    }
                }.alert(isPresented: $wronginfo) {
                    Alert(title: Text("This trolley code is invalid"), dismissButton: .default(Text("OK")))
                }
                .alert(isPresented: $successreturn) {
                    Alert(title: Text("Thank you for returning your trolley!"), dismissButton: .default(Text("OK")))
                }
                .alert(isPresented: $chargefine) {
                    Alert(title: Text("You have been fined for failing to return your trolley."), dismissButton: .default(Text("OK")))
                }
            }
        }
        else if (trolleyUnlockScreen == true){
            
            VStack(alignment: .center) {
                
                if (timeRemaining >= 3600){
                    Text("Time: \(timeRemaining/3600) hours")
                        .font(.largeTitle)
                        .foregroundColor(.white)
                        .padding(.horizontal, 20)
                        .padding(.vertical, 5)
                        .background(
                            Capsule()
                                .fill(Color.black)
                                .opacity(0.75)
                        )
                }
                
                else if (timeRemaining < 3600 && timeRemaining >= 60){
                    Text("Time: \(timeRemaining/60) minutes")
                        .font(.largeTitle)
                        .foregroundColor(.white)
                        .padding(.horizontal, 20)
                        .padding(.vertical, 5)
                        .background(
                            Capsule()
                                .fill(Color.black)
                                .opacity(0.75)
                        )
                }
                
                else if (timeRemaining < 60 && timeRemaining > 0){
                    Text("Time: \(timeRemaining) seconds")
                        .font(.largeTitle)
                        .foregroundColor(.white)
                        .padding(.horizontal, 20)
                        .padding(.vertical, 5)
                        .background(
                            Capsule()
                                .fill(Color.black)
                                .opacity(0.75)
                        )
                }
                
                Text("Return your trolley")
                    .offset(y: -300)
                    .font(.system(size: 30))
                
                VStack(alignment: .leading) {
                    
                    Text("Trolley Return Area Code:")
                        .font(.callout)
                        .bold()
                        .font(.system(size: 20))
                    
                    TextField("Enter code at trolley return area...", text: $trolleyreturncode)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                }
                .padding()
                
                Button("Return trolley"){
                    if (trolleyUnlockScreen == true){
                        if (trolleyreturncode == "1234"){
                            if (timeRemaining != 0) {
                                trolleyUnlockScreen = false
                                logInScreen = false
                                successreturn = true
                                isActive = false
                                wronginfo = false
                            }
                        }
                        else {
                            wronginfo = true
                        }
                    }
                }
            }.alert(isPresented: $wronginfo) {
                Alert(title: Text("This return area is invalid."), dismissButton: .default(Text("OK")))
            }
            .alert(isPresented: $successreturn) {
                Alert(title: Text("Thank you for returning your trolley!"), dismissButton: .default(Text("OK")))
            }
            .alert(isPresented: $chargefine) {
                Alert(title: Text("You have been fined for failing to return your trolley."), dismissButton: .default(Text("OK")))
            }
            .onReceive(timer) { time in
                guard self.isActive else { return }
                if self.timeRemaining > 0 {
                    self.timeRemaining -= 1
                    charge()
                }
            }.onReceive(NotificationCenter.default.publisher(for: UIApplication.willResignActiveNotification)) { _ in
                self.isActive = false
            }
            .onReceive(NotificationCenter.default.publisher(for: UIApplication.willEnterForegroundNotification)) { _ in
                self.isActive = true
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
