//
//  LoginView.swift
//  PhotoEditor
//
//  Created by Ariuna Banzarkhanova on 07/08/24.
//

import SwiftUI
import FirebaseAuth

struct LoginView: View {
    @StateObject var emailLoginVM = LoginViewModel()
    
    @State var email = ""
    @State var password = ""
    
    @State var isRegisterOpened = false
    @State var isForgotPassword = false
    @State var isFinishedTyping = false
    
    var body: some View {
        NavigationStack{
            VStack(alignment: .leading, spacing: 10) {
                EmailPasswordView(email: $email, password: $password, isFinishedTyping: $isFinishedTyping)
                
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
                        .disabled(!isFinishedTyping)
                        
                        Button("Sign in with Google") {
                            Task {
                                await emailLoginVM.loginWithGoogle()
                            }
                        } .buttonStyle(.bordered)
                        
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
    LoginView()
}
