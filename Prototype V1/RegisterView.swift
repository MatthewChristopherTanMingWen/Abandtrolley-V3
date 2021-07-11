//
//  RegisterView.swift
//  Prototype V1
//
//  Created by Matthew Tan on 10/7/21.
//

import SwiftUI

struct RegisterView: View {
    
    @Binding var acc: AccDetails
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
        NavigationView{
            
            VStack{
                
                VStack(alignment: .leading) {
                    
                    Text("Username:")
                        .font(.system(size: 20))
                        .font(.callout)
                        .bold()
                    
                    TextField("Enter username...", text: $dusername)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .font(.system(size: 20))
                        .disableAutocorrection(true)
                        .autocapitalization(.none)
                }.aspectRatio(contentMode: .fill)
                .frame(width: UIScreen.main.bounds.width/1.1, height: UIScreen.main.bounds.width/5)
                
                VStack(alignment: .leading) {
                    
                    Text("Email:")
                        .font(.system(size: 20))
                        .font(.callout)
                        .bold()
                    
                    TextField("Enter Email...", text: $demail)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .font(.system(size: 20))
                        .disableAutocorrection(true)
                        .autocapitalization(.none)
                }.aspectRatio(contentMode: .fill)
                .frame(width: UIScreen.main.bounds.width/1.1, height: UIScreen.main.bounds.width/5)
                
                VStack(alignment: .leading) {
                    
                    Text("Password:")
                        .font(.system(size: 20))
                        .font(.callout)
                        .bold()
                    
                    TextField("Enter password...", text: $dpassword)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .font(.system(size: 20))
                        .disableAutocorrection(true)
                        .autocapitalization(.none)
                }.aspectRatio(contentMode: .fill)
                .frame(width: UIScreen.main.bounds.width/1.1, height: UIScreen.main.bounds.width/5)
                
                Button("Create account"){
                    setacc()
                    created = true
                }
                .padding()
                .font(.system(size: 25))
                .foregroundColor(.red)
                .alert(isPresented: $created) {
                    Alert(title: Text("Your account has been made!"), dismissButton: .default(Text("OK")))
                }
                
            }.padding()
            .navigationTitle("Create your account")
        }
    }
}

struct RegisterView_Previews: PreviewProvider {
    static var previews: some View {
        RegisterView(acc: .constant(AccDetails(accusername: "", accpassword: "", accemail: "")))
    }
}
