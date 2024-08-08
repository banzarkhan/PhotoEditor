//
//  PhotoEditorApp.swift
//  PhotoEditor
//
//  Created by Ariuna Banzarkhanova on 07/08/24.
//

import SwiftUI
import Firebase
import GoogleSignIn

@main
struct PhotoEditorApp: App {
    
    init() {
        DispatchQueue.global(qos: .userInitiated).async {
            FirebaseApp.configure()
        }
    }
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .onOpenURL(perform: { url in
                    GIDSignIn.sharedInstance.handle(url)
                })
        }
    }
}
