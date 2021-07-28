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
    
    var body: some View {
        NavigationView{
            
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
                            self.choice = "correct"
                        }
                        else {
                            wronginfo = true
                            self.choice = "wrong"
                        }
                        
                    }.font(.system(size: 30))
                    .padding()
                }.alert(isPresented: $wronginfo) {
                    Alert(title: Text("This trolley code is invalid"), dismissButton: .default(Text("OK")))
                }
                
                NavigationLink("", destination: LockView(alert: $alert, acc: $acc
                ), tag: "correct", selection: $choice)
                    .opacity(0)
                
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
                .offset(y:90)
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
                            
                            Text("To unlock a trolley, first you have to locate a trolley to unlock. Trolleys should be easy to find at the entrance of supermarkets at the trolley bay. The image below is an example of one such trolley bay.")
                                .padding()
                            
                            Image("Trolley_Bay_1")
                                .resizable()
                                .scaledToFit()
                                .padding()
                            
                            Text("Step 2:")
                                .font(.system(size: 20))
                                .bold()
                                .padding()
                            
                            Text("Then, to unlock your trolley, simply scan the QR code on the trolley. Ensure that the trolley you are unlocking is at the end of the trolley bay so that you are able to remove it once you have unlocked it. Then remove the chain key from the lock to use the trolley!")
                                .padding()
                            
                            Text("Step 3:")
                                .font(.system(size: 20))
                                .bold()
                                .padding()
                            
                            Text("Once you have scanned the QR code successfully, you will be given 3 hours of usage until you have to return it to a trolley bay. You have now successfully unlocked your trolley!")
                                .padding()
                            
                        }
                    }
                    .font(.headline)
                    .padding()
                }
                
            }.navigationTitle("Unlock your trolley \(acc.accusername)")
            
        }
        .alert(isPresented: $alert.chargefine) {
            Alert(title: Text("You have been fined for failing to return your trolley."), dismissButton: .default(Text("OK")))
        }
        .navigationBarBackButtonHidden(true)
    }
}

struct UnlockView_Previews: PreviewProvider {
    static var previews: some View {
        UnlockView(alert: .constant(Alerts( warning: false, chargefine: false, failreturn: false, twothirdfailreturn: false, thirtyminfailreturn: false, successreturn: false, fine: 0)),
                   acc: .constant(AccDetails(accusername: "", accpassword: "", accemail: "")))
    }
}
