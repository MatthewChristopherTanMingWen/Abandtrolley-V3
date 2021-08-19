//
//  ContentView.swift
//  Prototype V1
//
//  Created by Matthew Tan on 23/6/21.
//

import SwiftUI

struct ContentView: View {
    
    @Binding var alert: Alerts
    @Binding var acc: AccDetails
    
    @State private var selection: String? = nil
    @State var username: String = ""
    @State var password: String = ""
    @State var wronginfo = false

    var body: some View {
        NavigationView {
            
            
            ZStack {
                
                Color.yellow
                    .opacity(0.75)
                    .ignoresSafeArea()
                
                VStack {
                    
                    VStack(alignment: .leading) {
                        Text("Username:")
                            .font(.callout)
                            .bold()
                            .font(.system(size: 20))
                        TextField("Enter username...", text: $username)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                            .disableAutocorrection(true)
                            .autocapitalization(.none)
                    }
                    VStack(alignment: .leading) {
                        
                        Text("Password:")
                            .font(.callout)
                            .bold()
                            .font(.system(size: 20))
                        
                        TextField("Enter password...", text: $password)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                            .disableAutocorrection(true)
                            .autocapitalization(.none)
                    }
                    
                    HStack(alignment: .center) {
                        
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
                    
                    NavigationLink("", destination: UnlockView(alert: $alert, acc: $acc), tag: "unlock", selection: $selection)
                        .opacity(0)
                    
                }.padding()
                .navigationTitle("Log In")
            }
        
        }
        .navigationBarBackButtonHidden(true)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(alert: .constant(Alerts(warning: false, chargefine: false, failreturn: false, twothirdfailreturn: false, successreturn: false, fine: 0)), acc: .constant(AccDetails(accusername: "", accpassword: "", accemail: "")))
    }
}
