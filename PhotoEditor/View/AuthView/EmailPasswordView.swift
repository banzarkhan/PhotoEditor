//
//  EmailPasswordView.swift
//  PhotoEditor
//
//  Created by Ariuna Banzarkhanova on 08/08/24.
//

import SwiftUI

struct EmailPasswordView: View {
    @StateObject var emailPassVM = EmailPasswordViewModel()
    
    @Binding var email: String
    @Binding var password: String
    @Binding var isFinishedTyping: Bool
    
    var body: some View {
        VStack(alignment: .leading, spacing: 20) {
            Text("Enter your email and password")
            
            if emailPassVM.emailChecked && !emailPassVM.isEmailValid {
                Text("Incorrect email")
                    .foregroundColor(.red)
            }
            
            TextField("Email", text: $email, onCommit: {
                emailPassVM.checkEmail(email: email)
                emailPassVM.updateTypingStatus()
                isFinishedTyping = emailPassVM.isFinishedTyping
            })
            .onChange(of: email) { oldValue, newValue in
                emailPassVM.emailChecked = false
                isFinishedTyping = false
            }
            
            if emailPassVM.passwordChecked && !emailPassVM.isPasswordValid {
                Text("Password should have at least 8 characters")
                    .foregroundColor(.red)
            }
            
            SecureField("Password", text: $password, onCommit: {
                emailPassVM.checkPassword(password: password)
                emailPassVM.updateTypingStatus()
                isFinishedTyping = emailPassVM.isFinishedTyping
            })
            .onChange(of: password) { oldValue, newValue in
                emailPassVM.passwordChecked = false
                isFinishedTyping = false
            }
        }
        .textFieldStyle(RoundedBorderTextFieldStyle())
        .textInputAutocapitalization(.never)
    }
}

//#Preview {
//    EmailPasswordView(isFinishedTyping: .constant(true))
//}
