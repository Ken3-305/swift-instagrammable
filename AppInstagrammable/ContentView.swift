//
//  ContentView.swift
//  AppInstagrammable
//
//  Created by 松山直人 on 2021/07/06.
//

import UIKit
import SwiftUI
import CoreData

struct ContentView: View {
    
    @State private var image: UIImage?
    @State var showingImagePicker = false
    
    var body: some View {
        NavigationView{
            VStack {
                if let uiImage = image {
                    Image(uiImage: uiImage)
                        .resizable()
                        .scaledToFit()
                        .padding(.bottom)
                    NavigationLink(destination: EditPicture(image: image ?? UIImage(imageLiteralResourceName: "saturation"))) {
                        Text("画像を編集")
                    }
//                    Image(uiImage: uiImage)
//                        .resizable()
//                        .frame(width: 200, height: 200)
//                        .clipShape(Circle())
                } else {
                    Image("noimage")
                        .resizable()
                        .scaledToFit()
                        .padding(.bottom)
                }
                Spacer().frame(height: 32)
                Button(action: {
                    showingImagePicker = true
                }) {
                    Text("カメラロールから選択")
                }
            }
            .sheet(isPresented: $showingImagePicker) {
                ImagePicker(sourceType: .photoLibrary, selectedImage: $image)
            .navigationBarTitle(Text("画像を選択"))
            }
        }
    }
}

// SwiftUI独自の機能としては提供されていないので、UIKitで実装
struct ImagePicker: UIViewControllerRepresentable {
    
    var sourceType: UIImagePickerController.SourceType = .photoLibrary
    
    @Binding var selectedImage: UIImage?
    @Environment(\.presentationMode) private var presentationMode
    
    func makeUIViewController(context: UIViewControllerRepresentableContext<ImagePicker>) -> UIImagePickerController {
        
        let imagePicker = UIImagePickerController()
        imagePicker.allowsEditing = false
        imagePicker.sourceType = sourceType
        imagePicker.delegate = context.coordinator
        
        return imagePicker
    }
    
    func updateUIViewController(_ uiViewController: UIImagePickerController, context: UIViewControllerRepresentableContext<ImagePicker>) {
        
    }
    
    func makeCoordinator() -> Coordinator {
        return Coordinator(self)
    }
    
    final class Coordinator: NSObject, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
        
        var parent: ImagePicker
        
        init(_ parent: ImagePicker) {
            self.parent = parent
        }
        
        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
            
            if let image = info[.originalImage] as? UIImage {
                parent.selectedImage = image
            }
            
            parent.presentationMode.wrappedValue.dismiss()
        }
    }
}
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}
