//
//  ContentView.swift
//  Prototype V1
//
//  Created by Matthew Tan on 23/6/21.
//

import SwiftUI

//
//struct LogInView: View {
//    var body: some View {
//        Text("Log In")
//    }
//}
//
//struct LockView: View {
//    var body: some View {
//        Text("Lock")
//    }
//}
struct ContentView: View {
    
    //    enum views {
    //        case start, register, login, unlock, lock
    //    }
    
    //    var viewsstate = views.login
    
    @Binding var alert: Alerts
    @Binding var acc: AccDetails
    
    @State private var selection: String? = nil
    @State var username: String = ""
    @State var password: String = ""
    //    @State var trolleycode: String = "0"
    //    @State var trolleyreturncode: String = "0"
    //    @State var logInScreen = true
    //    @State var signUpScreen = false
    //    @State var trolleyUnlockScreen = false
    @State var wronginfo = false
    //    @State var twothirdfailreturn = false
    //    @State var failreturn = false
    //    @State var successreturn = false
    //    @State var isTimerRunning = false
    //    @State var fine = 0
    //    @State var chargefine = false
    //    @State var warning = false
    //    @State private var startTime =  Date()
    //    @State private var timerString = "0.00"
    //    @State private var timeRemaining: Float = 10
    //    @State private var isActive = false
    //    @State private var timer = Timer.publish(every: 1, //on: .main, in: .common).autoconnect()
    //
    //    func charge() {
    //        if (timeRemaining == 0){
    //            if (fine == 0){
    //                timeRemaining = 7200
    //                fine = 1
    //                warning = true
    //            }
    //            else if (fine > 0){
    //                chargefine = true
    //                trolleyUnlockScreen = false
    //                logInScreen = false
    //                isActive = false
    //            }
    //        }
    //    }
    
    var body: some View {
        NavigationView {
            VStack {
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
                
                HStack(alignment: .center) {
                    NavigationLink("Unlock trolley", destination: UnlockView(alert: $alert, acc: $acc), tag: "unlock", selection: $selection)
                    
                    Button("Done") {
                        if (username == acc.accusername && password == acc.accpassword){
                            self.selection = "unlock"
                        }
                        else {
                            wronginfo = true
                            self.selection = "lock"
                        }
                    }
                    .padding()
                    .font(.system(size: 20))
                    .foregroundColor(.green)
                    
                    NavigationLink("No account? Sign up!", destination: RegisterView(acc: $acc))
                        .padding()
                        .font(.system(size: 20))
                        .foregroundColor(.red)
                }.alert(isPresented: $wronginfo) {
                    Alert(title: Text("Your username or password is incorrect"), dismissButton: .default(Text("retry")))
                }
            }.padding()
            .navigationTitle("Log In")
        }
        .navigationBarBackButtonHidden(true)
    }
}
//        Group {
//            if viewsstate == .register {
//                RegisterView()
//            } else if viewsstate == .login {
//                LogInView()
//            } else if viewsstate == .unlock {
//                UnlockView()
//            } else if viewsstate == .lock {
//                LockView()
//            }
//        }
//
//        //log in screen
//        if (signUpScreen == false && logInScreen == true) {
//
//            VStack{
//
//                VStack{
//
//                    Text("Log In")
//                        .offset(y: -270)
//                        .font(.system(size: 30))
//
//                    VStack(alignment: .leading) {
//
//                        Text("Username:")
//                            .font(.callout)
//                            .bold()
//                            .font(.system(size: 20))
//
//                        TextField("Enter username...", text: $username)
//                            .textFieldStyle(RoundedBorderTextFieldStyle())
//                    }
//                    VStack(alignment: .leading) {
//
//                        Text("Password:")
//                            .font(.callout)
//                            .bold()
//                            .font(.system(size: 20))
//
//                        TextField("Enter password...", text: $password)
//                            .textFieldStyle(RoundedBorderTextFieldStyle())
//                    }
//                }.padding()
//
//                HStack(alignment: .center) {
//
//                    Button("Done") {
//                        if (username == accusername && password == accpassword){
//                            logInScreen = false
//                            wronginfo = false
//                        }
//                        else {
//                            wronginfo = true
//                        }
//                    }
//                    .padding()
//                    .font(.system(size: 20))
//                    .foregroundColor(.green)
//
//                    Button("No account? Sign up!"){
//                        if (signUpScreen == false){
//                            signUpScreen = true
//                        }
//                    }
//                    .padding()
//                    .font(.system(size: 20))
//                    .foregroundColor(.red)
//                }
//
//            }.alert(isPresented: $wronginfo) {
//                Alert(title: Text("Your username or password is incorrect"), dismissButton: .default(Text("retry")))
//            }
//        }
//        //create an account screen
//        else if (signUpScreen == true){
//
//            VStack{
//
//                VStack{
//
//                    Text("Create your account")
//                        .offset(y: -270)
//                        .font(.system(size: 30))
//
//                    VStack(alignment: .leading) {
//
//                        Text("Username:")
//                            .font(.callout)
//                            .bold()
//                            .font(.system(size: 20))
//
//                        TextField("Enter username...", text: $accusername)
//                            .textFieldStyle(RoundedBorderTextFieldStyle())
//                    }
//
//                    VStack(alignment: .leading) {
//
//                        Text("Email:")
//                            .font(.callout)
//                            .bold()
//                            .font(.system(size: 20))
//
//                        TextField("Enter Email...", text: $accemail)
//                            .textFieldStyle(RoundedBorderTextFieldStyle())
//                    }
//
//                    VStack(alignment: .leading) {
//
//                        Text("Password:")
//                            .font(.callout)
//                            .bold()
//                            .font(.system(size: 20))
//
//                        TextField("Enter password...", text: $accpassword)
//                            .textFieldStyle(RoundedBorderTextFieldStyle())
//                    }
//                }.padding()
//
//                Button("Create account"){
//                    if (signUpScreen == true){
//                        signUpScreen = false
//                    }
//                }
//            }
//        }
//        //Unlock trolley screen
//        else if (logInScreen == false && trolleyUnlockScreen == false){
//
//            VStack{
//
//                VStack{
//
//                    Text("Unlock your trolley \(username)")
//                        .offset(y: -300)
//                        .font(.system(size: 30))
//
//                    VStack(alignment: .leading) {
//
//                        Text("Trolley Code:")
//                            .font(.callout)
//                            .bold()
//                            .font(.system(size: 20))
//
//                        TextField("Enter code on trolley...", text: $trolleycode)
//                            .textFieldStyle(RoundedBorderTextFieldStyle())
//                    }
//
//                    Button("Unlock Trolley"){
//                        if (trolleycode == "1234"){
//                            trolleyUnlockScreen = true
//                            timeRemaining = 10
//                            isActive = true
//                        }
//                        else {
//                            wronginfo = true
//                        }
//
//                    }.alert(isPresented: $wronginfo) {
//                        Alert(title: Text("This trolley code is invalid"), dismissButton: .default(Text("OK")))
//                    }
//                }
//            }
//            .alert(isPresented: $chargefine) {
//                Alert(title: Text("You have been fined for failing to return your trolley."), dismissButton: .default(Text("OK")))
//            }
//        }
//        //trolley timer and return
//        else if (trolleyUnlockScreen == true){
//
//            VStack(alignment: .center) {
//
//                if (timeRemaining >= 3600){
//                    Text("Time: \(timeRemaining/3600) hours")
//                        .font(.largeTitle)
//                        .foregroundColor(.white)
//                        .padding(.horizontal, 20)
//                        .padding(.vertical, 5)
//                        .background(
//                            Capsule()
//                                .fill(Color.black)
//                                .opacity(0.75)
//                        )
//                }
//
//                else if (timeRemaining < 3600 && timeRemaining >= 60){
//                    Text("Time: \(timeRemaining/60) minutes")
//                        .font(.largeTitle)
//                        .foregroundColor(.white)
//                        .padding(.horizontal, 20)
//                        .padding(.vertical, 5)
//                        .background(
//                            Capsule()
//                                .fill(Color.black)
//                                .opacity(0.75)
//                        )
//                }
//
//                else if (timeRemaining < 60 && timeRemaining > 0){
//                    Text("Time: \(timeRemaining) seconds")
//                        .font(.largeTitle)
//                        .foregroundColor(.white)
//                        .padding(.horizontal, 20)
//                        .padding(.vertical, 5)
//                        .background(
//                            Capsule()
//                                .fill(Color.black)
//                                .opacity(0.75)
//                        )
//                }
//
//                Text("Return your trolley")
//                    .offset(y: -300)
//                    .font(.system(size: 30))
//
//                VStack(alignment: .leading) {
//
//                    Text("Trolley Return Area Code:")
//                        .font(.callout)
//                        .bold()
//                        .font(.system(size: 20))
//
//                    TextField("Enter code at trolley return area...", text: $trolleyreturncode)
//                        .textFieldStyle(RoundedBorderTextFieldStyle())
//                }
//                .padding()
//
//                Button("Return trolley"){
//                    if (trolleyreturncode != "1234"){
//                        wronginfo = true
//                    }
//                    else if (timeRemaining != 0) {
//                        trolleyUnlockScreen = false
//                        successreturn = true
//                        isActive = false
//                        logInScreen = false
//                    }
//                }.alert(isPresented: $wronginfo) {
//                    Alert(title: Text("This return area is invalid."), dismissButton: .default(Text("OK")))
//                }
//            }
//            .alert(isPresented: $warning) {
//                Alert(title: Text("Warning: You have failed to return your trolley in the time given. You have 2 hours to return it or you will receieve a fine."), dismissButton: //.default(Text("OK")))
//            }
//            .onReceive(timer) { time in
//                guard self.isActive else { return }
//                if self.timeRemaining > 0 {
//                    self.timeRemaining -= 1
//                    charge()
//                }
//            }.onReceive(NotificationCenter.default.publisher(for: UIApplication.willResignActiveNotification)) { _ in
//                self.isActive = false
//            }
//            .onReceive(NotificationCenter.default.publisher(for: UIApplication.willEnterForegroundNotification)) { _ in
//                self.isActive = true
//            }
//        }
//}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(alert: .constant(Alerts(wronginfo: false, warning: false, chargefine: false, failreturn: false, twothirdfailreturn: false, successreturn: false, fine: 0)), acc: .constant(AccDetails(accusername: "", accpassword: "", accemail: "")))
    }
}
