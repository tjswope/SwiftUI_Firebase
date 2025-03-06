//
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
    @Published var firstName: String = ""
    @Published var lastName: String = ""
    
    init(email: String = "", password: String = "") {
        self.email = email
        self.password = password
    }
    
    func encode() -> [String: Any]{
        let data : [String: Any] = [
            "firstName": firstName,
            "lastName": lastName
        ]
        return data
    }
    
    func decode(data: [String: Any]?) {
        
        guard let d = data else {return}
        
        if let firstName = d["firstName"] as? String{
            self.firstName = firstName
        }
        
        if let lastName = d["lastName"] as? String{
            self.lastName = lastName
        }
    }
}
