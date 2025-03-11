//
//  UserDetailsView.swift
//  SwiftUI_Firebase
//
//  Created by Swope, Thomas on 3/5/25.
//

import SwiftUI

struct UserDetailsView: View {
    @EnvironmentObject var user: User
    
    var body: some View {
        ZStack{
            Rectangle()
                .foregroundStyle(Color.backGroundGrey)
            VStack {
                Spacer()
                
                Button {
                    
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
