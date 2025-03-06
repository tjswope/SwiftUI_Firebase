//
//  UserDetailsView.swift
//  SwiftUI_Firebase
//
//  Created by Swope, Thomas on 3/5/25.
//

import SwiftUI
import FirebaseAuth
import FirebaseDatabase

struct UserDetailsView: View {
    @EnvironmentObject var user: User
    
    var body: some View {
        ZStack{
            Rectangle()
                .foregroundStyle(Color.background)
            VStack {
                Spacer()
                HStack {
                    Text("first name:")
                        .font(Constants.textFont)
                    TextField("first name", text: $user.firstName)
                        .font(Constants.textFont)
                }.padding()
                HStack {
                    Text("last name:")
                        .font(Constants.textFont)
                    TextField("last name", text: $user.lastName)
                        .font(Constants.textFont)
                }.padding()
                
                Button {
                    Task{
                        guard let uid = Auth.auth().currentUser?.uid else {return}
                        
                        let result = try? await Database.database().reference().child("users").child(uid).setValue(user.encode())
                    }
                } label: {
                    ZStack{
                        Rectangle()
                            .foregroundStyle(Color.firebaseYellow)
                            .cornerRadius(20)
                            .frame(width: 350, height: 50)
                        Text("update user info")
                            .font(Constants.textFont)
                    }
                }.padding()
                Button {
                    let result = try? Auth.auth().signOut()
                    if let _ = result {
                        user.email = ""
                        user.password = ""
                        user.isAuthenticated = false
                        user.firstName = ""
                        user.lastName = ""
                    }
                } label: {
                    ZStack{
                        Rectangle()
                            .foregroundStyle(Color.firebaseYellow)
                            .cornerRadius(20)
                            .frame(width: 350, height: 50)
                        Text("Log out")
                            .font(Constants.textFont)
                    }
                }.padding(.bottom, 50)
            }
        }
        .edgesIgnoringSafeArea(.all)
    }
}
#Preview {
    UserDetailsView()
        .environmentObject(User())
}
