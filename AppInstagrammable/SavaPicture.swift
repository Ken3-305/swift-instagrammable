//
//  SavaPicture.swift
//  AppInstagrammable
//
//  Created by 松山直人 on 2021/07/09.
//

import UIKit
import SwiftUI
import CoreData

struct SavePicture: View {
    
//    @State private var uiImage: UIImage?
    @State var showingImagePicker = false
    
    var image: UIImage?
    
    @State var showAlert = false
    
    var body: some View {
        VStack {
            Button(action: {
                ImageSaver($showAlert).writeToPhotoAlbum(image: image!)
              }){
                  Text("画像を保存する")
              }.alert(isPresented: $showAlert) {
                Alert(
                    title: Text("画像を保存しました。"),
                    message: Text(""),
                    dismissButton: .default(Text("OK"), action: {
                        showAlert = false
                    }))
              }
        }
    }
    
    class ImageSaver: NSObject {
        @Binding var showAlert: Bool
        
        init(_ showAlert: Binding<Bool>) {
            _showAlert = showAlert
        }
        
        func writeToPhotoAlbum(image: UIImage) {
            UIImageWriteToSavedPhotosAlbum(image, self, #selector(didFinishSavingImage), nil)
        }

        @objc func didFinishSavingImage(_ image: UIImage, didFinishSavingWithError error: Error?, contextInfo: UnsafeRawPointer) {
            
            if error != nil {
                print("保存に失敗しました。")
            } else {
                showAlert = true
            }
        }
    }
}

struct SavePicture_Previews: PreviewProvider {
    static var previews: some View {
        SavePicture()
//        EditPicture().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}
