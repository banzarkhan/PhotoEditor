//
//  PhotoLibraryView.swift
//  PhotoEditor
//
//  Created by Ariuna Banzarkhanova on 08/08/24.
//

import SwiftUI
import PhotosUI

struct PhotoLibraryView: View {
    @StateObject var model = DrawingViewModel()
    
    @State private var selectedItem: PhotosPickerItem?
    @State var image: UIImage?
    
    @State private var showCamera = false
    
    @State private var currentScale: CGFloat = 1.0
    @State private var currentAngle: Angle = .zero
    
    var body: some View {
        ZStack{
            NavigationStack{
                VStack {
                    if let _ = UIImage(data: model.imageData) {
                        DrawingScreenView()
                            .environmentObject(model)
                            .toolbar(content: {
                                ToolbarItem(placement: .navigationBarLeading) {
                                    
                                    Button(action: model.cancelImageEditing, label: {
                                        Image(systemName: "xmark")
                                    })
                                }
                            })
                    } else {
                        Text("Add picture")
                            .font(.title2)
                        PhotosPicker("Photos", selection: $selectedItem, matching: .images)
                            .onChange(of: selectedItem) {
                                Task {
                                    if let data = try? await selectedItem?.loadTransferable(type: Data.self) {
                                        model.imageData = data
                                    }
                                    print("Failed to load the image")
                                }
                            }
                        
                        Button("Camera") {
                            self.showCamera.toggle()
                        }
                    }
                }
                .padding()
                if model.addNewBox{
                    
                    Color.black.opacity(0.75)
                        .ignoresSafeArea()
                    
                    // TextField...
                    TextField("Type Here", text: $model.textBoxes[model.currentIndex].text)
                        .font(.system(size: 35, weight: model.textBoxes[model.currentIndex].isBold ? .bold : .regular))
                        .colorScheme(.dark)
                        .foregroundColor(model.textBoxes[model.currentIndex].textColor)
                        .padding()
                    
                    // add and cancel button...
                    HStack{
                        
                        Button(action: {
                            // toggling the isAdded...
                            model.textBoxes[model.currentIndex].isAdded = true
                            // closing the view...
                            model.toolPicker.setVisible(true, forFirstResponder: model.canvas)
                            model.canvas.becomeFirstResponder()
                            withAnimation{
                                model.addNewBox = false
                            }
                        }, label: {
                            Text("Add")
                                .fontWeight(.heavy)
                                .foregroundColor(.black)
                                .padding()
                        })
                        
                        Spacer()
                        
                        Button(action: model.cancelTextView, label: {
                            Text("Cancel")
                                .fontWeight(.heavy)
                                .foregroundColor(.black)
                                .padding()
                        })
                    }
                    .overlay(
                        HStack(spacing: 15){
                            
                            // Color Picker...
                            ColorPicker("", selection: $model.textBoxes[model.currentIndex].textColor)
                                .labelsHidden()
                            
                            Button(action: {
                                model.textBoxes[model.currentIndex].isBold.toggle()
                            }, label: {
                                Text(model.textBoxes[model.currentIndex].isBold ? "Normal" : "Bold")
                                    .fontWeight(.bold)
                                    .foregroundColor(.black)
                            })
                        }
                    )
                    .frame(maxHeight: .infinity, alignment: .top)
                }
            }
            .fullScreenCover(isPresented: $showCamera) {
                CameraView(selectedImage: $image)
            }
        }
        
    }
}

#Preview {
    PhotoLibraryView()
}
