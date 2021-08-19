//
//  LockView.swift
//  Prototype V1
//
//  Created by Matthew Tan on 11/7/21.
//

import SwiftUI

struct LockView: View {
    
    @Binding var alert: Alerts
    @Binding var acc: AccDetails
    @State var trolleyreturncode: String = "0"
    @State private var wronginfo2: Bool = false
    @State private var choices: String? = nil
    @State private var startTime =  Date()
    @State private var timerString = "0.00"
    @State private var timeRemaining: Float = 1820
    @State private var isActive = true
    @State private var timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    @State private var showingPopover = false
    @State private var showingPopover4 = false
    
    func charge() {
        if (timeRemaining == 0){
            if (alert.fine == 0){
                timeRemaining = 7200
                alert.fine = 1
                alert.warning = true
            }
            else if (alert.fine > 0){
                alert.chargefine = true
                isActive = false
            }
        } else if (timeRemaining == 1800){
            alert.twothirdfailreturn = true
        }
    }
    
    var body: some View {
        
        ZStack {
            
            Color.yellow
                .opacity(0.75)
                .ignoresSafeArea()
            
            VStack(alignment: .center) {
                
                Text("""
Time remaining:
\(String(format: "%02d", Int(timeRemaining/3600))): \(String(format: "%02d", Int(timeRemaining) % 3600 / 60)): \(String(format: "%02d", Int(timeRemaining) % 3600 % 60))
""")
                    .font(.largeTitle)
                    .foregroundColor(.white)
                    .multilineTextAlignment(.center)
                    .padding(.horizontal, 20)
                    .padding(.vertical, 5)
                    .background(
                        Capsule()
                            .fill(Color.black)
                            .opacity(0.75)
                    )
                
                VStack(alignment: .leading) {
                    
                    Text("Trolley Return Area Code:")
                        .font(.system(size: 30))
                        .font(.callout)
                        .bold()
                    
                    TextField("Enter return area code...", text: $trolleyreturncode)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .font(.system(size: 25))
                }
                .offset(x:0)
                .frame(width: 350, height: 100)
                .padding()
                .alert(isPresented: $alert.warning) {
                    Alert(title: Text("Warning: You have failed to return your trolley in the time given. You have 1qq hours to return it or you will receieve a fine."), dismissButton:
                            .default(Text("OK")))
                }
                .alert(isPresented: $alert.twothirdfailreturn) {
                    Alert(title: Text("Warning: You have 30 minutess remaining to return your trolley before you receieve a fine. Please return your trolley in the remaining time to avoid a fine"), dismissButton:
                            .default(Text("OK")))
                }
                
                Button("Scan QR code"){
                    if (trolleyreturncode != "1234"){
                        wronginfo2 = true
                        self.choices = "wrong"
                    }
                    else if (timeRemaining != 0) {
                        alert.successreturn = true
                        isActive = false
                        self.choices = "correct"
                    }
                }.font(.system(size:25))
                .alert(isPresented: $wronginfo2) {
                    Alert(title: Text("This return area is invalid."), dismissButton: .default(Text("OK")))
                }
                
                NavigationLink("", destination: UnlockView(alert: $alert, acc: $acc), tag: "correct", selection: $choices)
                    .opacity(0)
                
                HStack {
                    
                    Button(action: {
                        showingPopover = true
                    }) {
                        VStack(spacing: 10) {
                            Image(systemName: "newspaper")
                                .resizable()
                                .scaledToFit()
                            Text("How to return your trolley")
                                .font(.system(size: 13))
                        }
                        .frame(width: 200, height: 100)
                    }
                    .popover(isPresented: $showingPopover) {
                        ScrollView{
                            
                            VStack(alignment: .leading) {
                                
                                Text("Returning your trolley")
                                    .font(.system(size: 30))
                                    .font(.callout)
                                    .bold()
                                    .padding()
                                
                                Text("Step 1:")
                                    .font(.system(size: 20))
                                    .bold()
                                    .padding()
                                
                                Text("Find a trolley bay. They can usually be found in carpark areas.")
                                    .padding()
                                
                                Image("Trolley_Bay_2")
                                    .resizable()
                                    .scaledToFit()
                                    .padding()
                                
                                Text("Step 2:")
                                    .font(.system(size: 20))
                                    .bold()
                                    .padding()
                                
                                Text("To return your trolley, return it like a usual trolley by inserting the key into the lock.")
                                    .padding()
                                
                                Text("Step 3:")
                                    .font(.system(size: 20))
                                    .bold()
                                    .padding()
                                
                                Text("Hold the key in place and scan the QR code on the ground with this app to lock the trolley.")
                                    .padding()
                                
                                Text("You have now successfully returned your trolley!")
                                    .padding()
                                
                            }
                        }
                        .font(.headline)
                        .padding()
                    }
                    
                    Button(action: {
                        showingPopover4 = true
                    }) {
                        VStack(spacing: 10) {
                            Image(systemName: "location.viewfinder")
                                .resizable()
                                .scaledToFit()
                            Text("Locate Trolley Bay")
                                .font(.system(size: 17))
                        }
                        .frame(width: 220, height: 100)
                    }
                    .popover(isPresented: $showingPopover4) {
                        VStack(alignment: .leading) {
                            
                            Text("Nearby trolley return stations:")
                                .font(.system(size: 30))
                                .font(.callout)
                                .bold()
                                .padding()
                            
                            Image("Map_1")
                                .resizable()
                                .scaledToFit()
                                .padding()
                        }
                    }
                }
                .offset(x:10, y:70)
                
                
            }.navigationTitle("Return your trolley")
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
                
            }.navigationBarBackButtonHidden(true)
        }
    }
    
    struct LockView_Previews: PreviewProvider {
        static var previews: some View {
            LockView(alert: .constant(Alerts( warning: false, chargefine: false, failreturn: false, twothirdfailreturn: false, successreturn: false, fine: 0)),
                     acc: .constant(AccDetails(accusername: "", accpassword: "", accemail: "")))
        }
    }
