//
//  User.swift
//  SwiftUI_Firebase
//
//  Created by Swope, Thomas on 3/5/25.
//

import Foundation

class User: ObservableObject{
    @Published var userName: String
    @Published var password: String
    @Published var isAuthenticated: Bool = false
    
    init(userName: String = "", password: String = "") {
        self.userName = userName
        self.password = password
    }
}
