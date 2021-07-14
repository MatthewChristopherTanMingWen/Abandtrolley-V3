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
    @State private var timeRemaining: Float = 10800
    @State private var isActive = true
    @State private var timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    
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
        }
    }
    
    var body: some View {
        
        VStack {
            
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
                .padding()
                .alert(isPresented: $alert.warning) {
                    Alert(title: Text("Warning: You have failed to return your trolley in the time given. You have 2 hours to return it or you wil receieve a fine."), dismissButton:
                            .default(Text("OK")))
                }

                Button("Return trolley"){
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
