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
                    Button("Unlock Trolley"){
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
        UnlockView(alert: .constant(Alerts( warning: false, chargefine: false, failreturn: false, twothirdfailreturn: false, successreturn: false, fine: 0)),
                   acc: .constant(AccDetails(accusername: "", accpassword: "", accemail: "")))
    }
}
