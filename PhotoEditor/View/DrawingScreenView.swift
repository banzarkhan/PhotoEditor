//
//  DrawingScreenView.swift
//  PhotoEditor
//
//  Created by Ariuna Banzarkhanova on 09/08/24.
//

import SwiftUI
import PencilKit

struct DrawingScreenView: View {
    @EnvironmentObject var model: DrawingViewModel
    
    var body: some View {
        
        ZStack{
            
            GeometryReader{proxy -> AnyView in
                
                let size = proxy.frame(in: .global)
                
                DispatchQueue.main.async {
                    if model.rect == .zero{
                        model.rect = size
                    }
                }
                
                return AnyView (
                
                    ZStack{
                        
                        // UIkit Pencil Kit Drawing View...
                        CanvasView(canvas: $model.canvas, imageData: $model.imageData, toolPicker: $model.toolPicker,rect: size.size)
                        
                        // CUstom Texts....
                        
                        // displaying text boxes..
                        ForEach(model.textBoxes){box in
                            
                            Text(model.textBoxes[model.currentIndex].id == box.id && model.addNewBox ? "" : box.text)
                                // you can also include text size in model..
                                // and can use those text sizes in these text boxes...
                                .font(.system(size: 30))
                                .fontWeight(box.isBold ? .bold : .none)
                                .foregroundColor(box.textColor)
                                .offset(box.offset)
                            // drag gesutre...
                                .gesture(DragGesture().onChanged({ (value) in
                                    
                                    let current = value.translation
                                    // Adding with last Offset...
                                    let lastOffset = box.lastOffset
                                    let newTranslation = CGSize(width: lastOffset.width + current.width, height: lastOffset.height + current.height)
                                    
                                    model.textBoxes[getIndex(textBox: box)].offset = newTranslation
                                    
                                }).onEnded({ (value) in
                                    
                                    // saving the last offset for exact drag postion...
                                    model.textBoxes[getIndex(textBox: box)].lastOffset = model.textBoxes[getIndex(textBox: box)].offset
                                    
                                }))
                            // editing the typed one...
                                .onLongPressGesture {
                                    // closing the toolbar...
                                    model.toolPicker.setVisible(false, forFirstResponder: model.canvas)
                                    model.canvas.resignFirstResponder()
                                    model.currentIndex = getIndex(textBox: box)
                                    withAnimation{
                                        model.addNewBox = true
                                    }
                                }
                        }
                    }
                )
            }
        }
        .toolbar(content: {
            ToolbarItem(placement: .navigationBarTrailing) {
                
                Button(action: model.saveImage, label: {
                    Text("Save")
                })
            }
            
            ToolbarItem(placement: .navigationBarTrailing) {
                
                Button(action: {
                    
                    // creating One New Box...
                    model.textBoxes.append(TextBox())
                    
                    // upating index..
                    model.currentIndex = model.textBoxes.count - 1
                    
                    withAnimation{
                        model.addNewBox.toggle()
                    }
                    // closing the tool bar...
                    model.toolPicker.setVisible(false, forFirstResponder: model.canvas)
                    model.canvas.resignFirstResponder()
                }, label: {
                    Image(systemName: "plus")
                })
            }
        })
    }
    
    func getIndex(textBox: TextBox)->Int{
        
        let index = model.textBoxes.firstIndex { (box) -> Bool in
            return textBox.id == box.id
        } ?? 0
        
        return index
    }
}

#Preview {
    DrawingScreenView()
}
