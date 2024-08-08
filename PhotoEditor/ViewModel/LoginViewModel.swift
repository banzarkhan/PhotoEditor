//
//  LoginViewModel.swift
//  PhotoEditor
//
//  Created by Ariuna Banzarkhanova on 07/08/24.
//

import Foundation
import FirebaseAuth

class LoginViewModel: ObservableObject {
    @Published var isEmailValid = false
    @Published var isPasswordValid = false
    
    
    func loginWithEmail(email: String, password: String) {
        Auth.auth().signIn(withEmail: email, password: password) { (result, error) in
            if error != nil {
                print(error?.localizedDescription ?? "")
            } else {
                print("success")
            }
        }
    }
    
    func loginWithGoogle() async {
        do {
            try await Authentication().googleOauth()
        } catch {
            // Handle the error here
            print("An error occurred: \(error)")
        }
    }
}
 
