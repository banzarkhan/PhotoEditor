//
//  EmailLoginViewModel.swift
//  PhotoEditor
//
//  Created by Ariuna Banzarkhanova on 07/08/24.
//

import Foundation
import FirebaseAuth

class EmailLoginViewModel: ObservableObject {
    
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
    
    func isValidEmailAddress(email: String) -> Bool {
        let emailRegex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailPredicate = NSPredicate(format: "SELF MATCHES %@", emailRegex)
        return emailPredicate.evaluate(with: email)
    }
}
