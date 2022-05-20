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
    @State var showingUnlockView = false
    @State var showingRegisterPopover = false
    
    @State public var dusername: String = ""
    @State var dpassword: String = ""
    @State var demail: String = ""
    @State var created: Bool = false
    
    func setacc() {
        acc.accusername = dusername
        acc.accpassword = dpassword
        acc.accemail = demail
    }
    
    var body: some View {
        NavigationView {
            
            ZStack {
                
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
                    .padding()
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
                    .padding()
                    
                    HStack(alignment: .center) {
                        
                                                
                        //                        NavigationLink("No account? Sign up!", destination: RegisterView(acc: $acc))
                        //                            .padding()
                        //                            .font(.system(size: 20))
                        //                            .foregroundColor(.red)
                        
                        Button("No account? Sign up!"){
                            showingRegisterPopover = true
                        }
                        .popover(isPresented: $showingRegisterPopover) {
                            NavigationView{
                                
                                ZStack {
                                    
                                    VStack{
                                        
                                        TextField("Enter username...", text: $dusername)
                                            .padding()
                                            .textFieldStyle(RoundedBorderTextFieldStyle())
                                            .font(.system(size: 20))
                                            .disableAutocorrection(true)
                                            .autocapitalization(.none)
                                        
                                        TextField("Enter card info...", text: $demail)
                                            .padding()
                                            .textFieldStyle(RoundedBorderTextFieldStyle())
                                            .font(.system(size: 20))
                                            .disableAutocorrection(true)
                                            .autocapitalization(.none)
                                        
                                        TextField("Enter password...", text: $dpassword)
                                            .padding()
                                            .textFieldStyle(RoundedBorderTextFieldStyle())
                                            .font(.system(size: 20))
                                            .disableAutocorrection(true)
                                            .autocapitalization(.none)
                                        
                                        Button("Create account"){
                                            setacc()
                                            created = true
                                        }
                                        .padding()
                                        .font(.system(size: 20))
                                        .foregroundColor(.white)
                                        .background(Color.blue)
                                        .cornerRadius(10)
                                        .alert(isPresented: $created) {
                                            Alert(title: Text("Your account has been made!"), dismissButton: .default(Text("OK")))
                                        }
                                        
                                    }.padding()
                                        .navigationTitle("Create your account")
                                }
                            }
                        }
                        
                        .padding()
                        .font(.system(size: 20))
                        .foregroundColor(.blue)
                        
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
                        .foregroundColor(.white)
                        .background(Color.blue)
                        .cornerRadius(10)
                        
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
