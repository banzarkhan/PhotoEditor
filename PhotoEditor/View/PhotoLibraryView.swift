//
//  PhotoLibraryView.swift
//  PhotoEditor
//
//  Created by Ariuna Banzarkhanova on 08/08/24.
//

import SwiftUI
import PhotosUI

struct PhotoLibraryView: View {
    @StateObject var drawingVM = DrawingViewModel()
    
    @State private var selectedItem: PhotosPickerItem?
    @State var image: UIImage?
    
    @State private var showCamera = false
    
    @State private var currentScale: CGFloat = 1.0
    @State private var currentAngle: Angle = .zero
    
    var body: some View {
        NavigationStack{
            VStack {
                
                
                Text("Add picture")
                    .font(.title2)
                PhotosPicker("Photos", selection: $selectedItem, matching: .images)
                    .onChange(of: selectedItem) {
                        Task {
                            if let data = try? await selectedItem?.loadTransferable(type: Data.self) {
                                image = UIImage(data: data)
                            }
                            print("Failed to load the image")
                        }
                    }
                
                Button("Camera") {
                    self.showCamera.toggle()
                }
            }
            .padding()
            .fullScreenCover(isPresented: $showCamera) {
                CameraView(selectedImage: $image)
            }
        }
    }
}

#Preview {
    PhotoLibraryView()
}
