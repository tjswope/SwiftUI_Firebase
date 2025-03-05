//
//  LoginView.swift
//  SwiftUI_Firebase
//
//  Created by Swope, Thomas on 3/5/25.
//

import SwiftUI

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
                    Text("User Name:")
                        .font(Constants.textFont)
                    TextField("user name", text: $user.userName)
                        .font(Constants.textFont)
                }.padding()
                HStack {
                    Text("Password:")
                        .font(Constants.textFont)
                    SecureField("password", text: $user.password)
                        .font(Constants.textFont)
                }.padding()
                
                Button {
                    
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
