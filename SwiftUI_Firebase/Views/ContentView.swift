//
//  ContentView.swift
//  SwiftUI_Firebase
//
//  Created by Swope, Thomas on 3/5/25.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var user: User
    
    var body: some View {
        if user.isAuthenticated{
            UserDetailsView()
        } else {
            LoginView()
        }
    }
}

#Preview {
    ContentView()
        .environmentObject(User())
}
