//
//  EmailLoginView.swift
//  PhotoEditor
//
//  Created by Ariuna Banzarkhanova on 07/08/24.
//

import SwiftUI
import FirebaseAuth

struct EmailLoginView: View {
    @StateObject var emailLoginVM = EmailLoginViewModel()
    
    @State var email = ""
    @State var password = ""
    
    @State var isValidEmail = false
    @State var isTypingFinished = false
    
    @State var isRegisterOpened = false
    @State var isForgotPassword = false
    
    var body: some View {
        NavigationStack{
            VStack(alignment: .leading, spacing: 10) {
                Text("Enter your email and password")
                TextField("Email", text: $email, onCommit: {
                    isValidEmail = emailLoginVM.isValidEmailAddress(email: email)
                    isTypingFinished = true
                    self.email = email
                })
                .textFieldStyle()
                SecureField("Password", text: $password)
                    .textFieldStyle()
                Button("Forgot password?"){
                    isForgotPassword = true
                }
                HStack {
                    Spacer()
                    VStack {
                        Button("Sign in") {
                            emailLoginVM.loginWithEmail(email: email, password: password)
                        }
                        .buttonStyle(.borderedProminent)
                        
                        Button("Sign in with Google"){
                            Task {
                                await emailLoginVM.loginWithGoogle()
                            }
                        }.buttonStyle(.bordered)
                        Button("Register") {
                            isRegisterOpened = true
                        }
                    }
                    Spacer()
                }
            }
            .navigationDestination(isPresented: $isRegisterOpened) {
                RegisterView(email: email)
            }
            .sheet(isPresented: $isForgotPassword) {
                ResetPasswordView(email: email)
            }
            .padding()
        }
    }
}

#Preview {
    EmailLoginView()
}
