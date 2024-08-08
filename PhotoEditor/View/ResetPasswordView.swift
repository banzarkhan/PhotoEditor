//
//  ResetPasswordView.swift
//  PhotoEditor
//
//  Created by Ariuna Banzarkhanova on 08/08/24.
//

import SwiftUI
import Firebase
import FirebaseAuth

struct ResetPasswordView: View {
    @Environment(\.dismiss) var dismiss
    
    @State var email = ""
    @State var isEmailSent = false
    
    var body: some View {
        VStack(alignment: .leading) {
            if isEmailSent {
                Text("Email with a reset password link was sent to \(email)")
            } else {
                Text("Enter your email and password")
                TextField("Email", text: $email)
                    .autocapitalization(.none)
                HStack {
                    Spacer()
                    VStack {
                        Button("Reset password") {
                            Auth.auth().sendPasswordReset(withEmail: email) { error in
                                // ...
                            }
                            isEmailSent = true
                            print("email was sent")
                        }
                        .buttonStyle(.borderedProminent)
                    }
                    Spacer()
                }
            }
        }
        .toolbar{
            Button("Done") {
                dismiss()
            }
        }
    }
}

#Preview {
    ResetPasswordView()
}
