//
//  RegisterView.swift
//  Prototype V1
//
//  Created by Matthew Tan on 10/7/21.
//

import SwiftUI

struct RegisterView: View {
    
    @Binding var acc: AccDetails
    @Environment(\.presentationMode) var presentation
    @State public var dusername: String = ""
    @State var dpassword: String = ""
    @State var demail: String = ""
    
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
                        .font(.callout)
                        .bold()
                    
                    TextField("Enter username...", text: $dusername)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .disableAutocorrection(true)
                        .autocapitalization(.none)
                }.aspectRatio(contentMode: .fill)
                .frame(width: UIScreen.main.bounds.width/1.1, height: UIScreen.main.bounds.width/5)
                
                VStack(alignment: .leading) {
                    
                    Text("Email:")
                        .font(.callout)
                        .bold()
                    
                    TextField("Enter Email...", text: $demail)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .disableAutocorrection(true)
                        .autocapitalization(.none)
                }.aspectRatio(contentMode: .fill)
                .frame(width: UIScreen.main.bounds.width/1.1, height: UIScreen.main.bounds.width/5)
                
                VStack(alignment: .leading) {
                    
                    Text("Password:")
                        .font(.callout)
                        .bold()
                    
                    TextField("Enter password...", text: $dpassword)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .disableAutocorrection(true)
                        .autocapitalization(.none)
                }.aspectRatio(contentMode: .fill)
                .frame(width: UIScreen.main.bounds.width/1.1, height: UIScreen.main.bounds.width/5)
                
                Button("Create account"){
                    setacc()
                }
                .padding()
                .font(.system(size: 20))
                .foregroundColor(.red)
                
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
