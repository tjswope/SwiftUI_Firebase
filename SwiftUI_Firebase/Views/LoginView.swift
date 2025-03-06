//
//  LoginView.swift
//  SwiftUI_Firebase
//
//  Created by Swope, Thomas on 3/5/25.
//

import SwiftUI
import FirebaseAuth
import FirebaseDatabase

struct LoginView: View {
    @EnvironmentObject var user: User
    
    var body: some View {
        ZStack{
            Rectangle()
                .foregroundStyle(Color.background)
            VStack {
                Spacer()
                Image("logo")
                    .resizable()
                    .frame(width: 200, height: 200)
                Spacer()
                HStack {
                    Text("email:")
                        .font(Constants.textFont)
                    TextField("email", text: $user.email)
                        .font(Constants.textFont)
                }.padding()
                HStack {
                    Text("Password:")
                        .font(Constants.textFont)
                    SecureField("password", text: $user.password)
                        .font(Constants.textFont)
                }.padding()
                
                Button {
                    Task{
                        let result = try? await Auth.auth().createUser(withEmail: user.email, password: user.password)
                        if let _ = result{
                            user.isAuthenticated = true
                        }
                    }
                } label: {
                    ZStack{
                        Rectangle()
                            .foregroundStyle(Color.firebaseYellow)
                            .cornerRadius(20)
                            .frame(width: 350, height: 50)
                        Text("Sign up")
                            .font(Constants.textFont)
                    }
                }.padding()
                Button {
                    Task{
                        guard let result = try? await Auth.auth().signIn(withEmail: user.email, password: user.password) else {return}
                        
                        user.isAuthenticated = true
                        
                        guard let uid = Auth.auth().currentUser?.uid else {return}
                        
                        guard let data = try? await Database.database().reference().child("users/\(uid)").getData() else {return}
                        
                        // cast data.value to a dictionary and pass to decode
                        guard let dictionary = data.value as? [String: String] else {return}
                        user.decode(data: dictionary)
                    }
                    
                } label: {
                    ZStack{
                        Rectangle()
                            .foregroundStyle(Color.firebaseYellow)
                            .cornerRadius(20)
                            .frame(width: 350, height: 50)
                        Text("Login")
                            .font(Constants.textFont)
                    }
                }.padding(.bottom, 50)
            }
        }
        .edgesIgnoringSafeArea(.all)
    }
}

#Preview {
    LoginView()
        .environmentObject(User())
}
