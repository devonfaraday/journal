//
//  Login.swift
//  Journal
//
//  Created by Christian McMullin on 10/7/21.
//

import SwiftUI
import Firebase

struct Login: View {
    @State var email = ""
    @State var password = ""
    @State var selection: Int?
    var isSignUp: Bool = false
    
    var body: some View {
        VStack {
            Text("Awesome Journal App Logo")
                .font(.system(size: 40))
                .multilineTextAlignment(.center)
            Spacer()
            TextField("Email", text: $email)
                .padding()
                .border(Color.black, width: 1.0)
            SecureField("Password", text: $password)
                .padding()
                .border(Color.black, width: 1.0)
            HStack {
                NavigationLink(destination: Home(), tag: 1, selection: $selection) {
                    Button(action: { login() }) {
                        Text("Sign in")
                    }
                }
                .padding()
                .foregroundColor(Color.white)
                .background(Color.green)
                .cornerRadius(10)
                NavigationLink(destination: Home(), tag: 1, selection: $selection) {
                    Button(action: { signUp() }) {
                        Text("Sign up")
                    }
                }
                .padding()
                .foregroundColor(Color.white)
                .background(Color.red)
                .cornerRadius(10)
            }
            .padding()
            Spacer()
            Spacer()
        }
        .padding()
    }
    
    func signUp() {
        Auth.auth().createUser(withEmail: email, password: password) { authResult, error in
            if error != nil {
                print(error?.localizedDescription ?? "")
            } else {
                selection = 1
            }
        }
    }
    
    func login() {
        Auth.auth().signIn(withEmail: email, password: password) { (result, error) in
            if error != nil {
                print(error?.localizedDescription ?? "")
            } else {
                selection = 1
                print("success")
            }
        }
    }
}

struct Login_Previews: PreviewProvider {
    static var previews: some View {
        
        Login()
    }
}
