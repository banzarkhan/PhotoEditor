//
//  RegisterView.swift
//  PhotoEditor
//
//  Created by Ariuna Banzarkhanova on 08/08/24.
//

import SwiftUI
import FirebaseAuth

struct RegisterView: View {
    @StateObject var registerVM = RegisterViewModel()
    
    @State var email = ""
    @State var password = ""
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("Enter your email and password")
            TextField("Email", text: $email)
                .textFieldStyle()
            SecureField("Password", text: $password)
                .textFieldStyle()
            HStack {
                Spacer()
                Button("Register") {
                    registerVM.registerNewUser(email: email, password: password)
                }
                .buttonStyle(.borderedProminent)
                Spacer()
            }
        }
        .padding()
    }
}

#Preview {
    RegisterView()
}
