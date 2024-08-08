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
    @State var isFinishedTyping = false
    
    var body: some View {
        VStack(alignment: .leading) {
            EmailPasswordView(email: $email, password: $password, isFinishedTyping: $isFinishedTyping)
            HStack {
                Spacer()
                Button("Register") {
                    registerVM.registerNewUser(email: email, password: password)
                }
                .buttonStyle(.borderedProminent)
                .disabled(!isFinishedTyping)
                Spacer()
            }
        }
        .padding()
    }
}

#Preview {
    RegisterView()
}
