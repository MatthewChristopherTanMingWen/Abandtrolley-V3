//
//  UnlockView.swift
//  Prototype V1
//
//  Created by Matthew Tan on 10/7/21.
//

import SwiftUI

struct UnlockView: View {
    
    @Binding var alert: Alerts
    @Binding var acc: AccDetails
    @State var trolleycode: String = "0"
    @State private var wronginfo: Bool = false
    @State private var choice: String? = nil
    @State private var showingPopover2 = false
    @State var word = "Unlock"
    
    @State var trolleyreturncode: String = "0"
    @State private var wronginfo2: Bool = false
    @State private var startTime =  Date()
    @State private var timerString = "0.00"
    @State private var timeRemaining: Float = 1840
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
        
        //UnlockView
        
        
        
        
        
        
        
        NavigationView{
            
            ZStack {
                
                VStack{
                    
                    VStack(alignment: .leading) {
                        
                        Text("Trolley Code:")
                            .font(.system(size: 35))
                            .font(.callout)
                            .bold()
                        
                        TextField("Enter code on trolley...", text: $trolleycode)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                            .font(.system(size: 30))
                            .scaledToFit()
                    }.aspectRatio(contentMode: .fill)
                        .frame(width: UIScreen.main.bounds.width/1.1, height: UIScreen.main.bounds.width/4)
                        .padding()
                    
                    VStack {
                        Button("Scan QR code"){
                            if (trolleycode == "1234"){
                                self.choice = "Correct"
                                word = "Lock"
                            }
                            else {
                                wronginfo = true
                                self.choice = "Wrong"
                                word = "Unlock"
                            }
                            
                        }.font(.system(size: 30))
                            .padding()
                    }.alert(isPresented: $wronginfo) {
                        Alert(title: Text("This trolley code is invalid"), dismissButton: .default(Text("OK")))
                    }
                    
                    //NavigationLink("", destination: LockView(alert: $alert, acc: $acc), tag: "Correct", selection: $choice)
                    //.opacity(0)
                    
                    Button(action: {
                        showingPopover2 = true
                    }) {
                        VStack(spacing: 10) {
                            Image(systemName: "newspaper")
                                .resizable()
                                .scaledToFit()
                            Text("How to unlock your trolley")
                                .font(.system(size: 17))
                        }
                        .frame(width: 220, height: 100)
                    }
                    .popover(isPresented: $showingPopover2) {
                        ScrollView{
                            
                            VStack(alignment: .leading) {
                                
                                Text("Unlocking your trolley")
                                    .font(.system(size: 30))
                                    .font(.callout)
                                    .bold()
                                    .padding()
                                
                                Text("Step 1:")
                                    .font(.system(size: 20))
                                    .bold()
                                    .padding()
                                
                                Text("Find a trolley. Trolleys can typically be found near the entrance of supermarkets at the trolley bay.")
                                    .padding()
                                
                                Image("Trolley_Bay_1")
                                    .resizable()
                                    .scaledToFit()
                                    .padding()
                                
                                Text("Step 2:")
                                    .font(.system(size: 20))
                                    .bold()
                                    .padding()
                                
                                Text("To unlock your trolley, simply scan the QR code on the trolley.")
                                    .padding()
                                
                                Text("Step 3:")
                                    .font(.system(size: 20))
                                    .bold()
                                    .padding()
                                
                                Text("Once you have scanned the QR code successfully, you will be given 3 hours of usage until you have to return it to a trolley bay")
                                    .padding()
                                
                                Text("You have now successfully unlocked your trolley!")
                                    .padding()
                            }
                            .font(.headline)
                            .padding()
                        }
                    }
                    .offset(y:70)
                }
                .opacity(word == "Unlock" ? 1:0)
                
                //LockView
                
                
                
                
                
                
                
                
                ZStack {
                    
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
                                self.choice = "wrong"
                                word = "Lock"
                            }
                            else if (timeRemaining != 0) {
                                alert.successreturn = true
                                isActive = false
                                self.choice = "correct"
                                word = "Unlock"
                            }
                        }.font(.system(size:25))
                            .alert(isPresented: $wronginfo2) {
                                Alert(title: Text("This return area is invalid."), dismissButton: .default(Text("OK")))
                            }
                        
                        //NavigationLink("", destination: UnlockView(alert: $alert, acc: $acc), tag: "correct", selection: $choices2)
                        //   .opacity(0)
                        
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
                        
                        
                    }
                    .opacity(word == "Lock" ? 1:0)
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
                    
                }.navigationTitle("\(word) your trolley \(acc.accusername)")
            }
            
            
            //.alert(isPresented: $alert.chargefine) {
            //   Alert(title: Text("You have been fined for failing to return your trolley."), dismissButton: .default(Text("OK")))
            // }
            
        }
        .navigationBarBackButtonHidden(true)
    }
}

struct UnlockView_Previews: PreviewProvider {
    static var previews: some View {
        UnlockView(alert: .constant(Alerts( warning: false, chargefine: false, failreturn: false, twothirdfailreturn: false, successreturn: false, fine: 0)),
                   acc: .constant(AccDetails(accusername: "", accpassword: "", accemail: "")))
    }
}
