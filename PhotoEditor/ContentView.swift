//
//  ContentView.swift
//  PhotoEditor
//
//  Created by Ariuna Banzarkhanova on 07/08/24.
//

import SwiftUI
import Firebase
import FirebaseAuth

struct ContentView: View {
    @State private var userLoggedIn = (Auth.auth().currentUser != nil)
    
    @State var loadingState: LoadingState = .idle
    
    var body: some View {
        VStack {
            switch loadingState {
            case .loading:
                ProgressView()
            case .loaded:
                if userLoggedIn {
                    PhotoLibraryView()
                } else {
                    LoginView()
                }
            case .idle:
                Text("")
            }
        }.onAppear {
            loadAuthState()
        }
    }
}

#Preview {
    ContentView()
}

extension ContentView {
    private func loadAuthState() {
            loadingState = .loading
            DispatchQueue.global(qos: .userInitiated).async {
                Auth.auth().addStateDidChangeListener { auth, user in
                    DispatchQueue.main.async {
                        userLoggedIn = (user != nil)
                        loadingState = .loaded
                    }
                }
            }
        }
}
