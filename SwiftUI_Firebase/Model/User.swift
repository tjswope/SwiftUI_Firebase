ail//
//  User.swift
//  SwiftUI_Firebase
//
//  Created by Swope, Thomas on 3/5/25.
//

import Foundation

class User: ObservableObject{
    @Published var email: String
    @Published var password: String
    @Published var isAuthenticated: Bool = false
    
    init(email: String = "", password: String = "") {
        self.email = email
        self.password = password
    }
}
