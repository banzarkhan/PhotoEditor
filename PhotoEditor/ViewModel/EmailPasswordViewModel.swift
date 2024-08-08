//
//  EmailPasswordViewModel.swift
//  PhotoEditor
//
//  Created by Ariuna Banzarkhanova on 08/08/24.
//

import Foundation

class EmailPasswordViewModel: ObservableObject {
    @Published var isEmailValid = false
    @Published var isPasswordValid = false
    @Published var emailChecked: Bool = false
    @Published var passwordChecked: Bool = false
    @Published var isFinishedTyping: Bool = false
    
    func checkEmail(email: String){
        let emailRegex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailPredicate = NSPredicate(format: "SELF MATCHES %@", emailRegex)
        self.isEmailValid = emailPredicate.evaluate(with: email)
        self.emailChecked = true
    }
    
    func checkPassword(password: String) {
        self.isPasswordValid = password.count >= 8
        self.passwordChecked = true
    }
    
    func updateTypingStatus() {
        self.isFinishedTyping = emailChecked && passwordChecked
    }
}
