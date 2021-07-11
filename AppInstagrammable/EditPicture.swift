//
//  EditPicture.swift
//  AppInstagrammable
//
//  Created by 松山直人 on 2021/07/06.
//

import UIKit
import SwiftUI
import CoreData
import CoreImage

struct EditPicture: View {
    
//    @State private var uiImage: UIImage?
    @State var showingImagePicker = false
    
    var image: UIImage
    
    @State var viewUiImage: UIImage = UIImage(imageLiteralResourceName: "saturation")
     
    private func clear() {
        self.viewUiImage = image
        self.isActiveEdit = false
        self.inputPoint0 = 0.07
        self.inputPoint1 = 0.24
        self.inputPoint2 = 0.77
        self.inputPoint3 = 1.0
        self.inputPoint4 = 1.0
    }
    
    @State var isActiveEdit = false

    var editor = EditorController()
    var rgbhsv = RGBandHSV()
    
    @State var pixelColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0)
    @State var pixelHSV = UIColor(hue: 0, saturation: 0, brightness: 0, alpha: 0)
    
    @State var inputPoint0: CGFloat = 0.07
    @State var inputPoint1: CGFloat = 0.24
    @State var inputPoint2: CGFloat = 0.77
    @State var inputPoint3: CGFloat = 1.0
    @State var inputPoint4: CGFloat = 1.0
    
    var body: some View {
        VStack {
            HStack{
                Button(action: {
                    self.clear()
                }) {
                    Text("元に戻す")
                }
                NavigationLink(destination: SavePicture(image: viewUiImage)) {
                    Text("次へ")
                }
            }

        }
        VStack {
            if let uiImage = image {
                
                if !isActiveEdit{
                    Image(uiImage: uiImage)
                        .resizable()
                        .scaledToFit()
                        .padding(.bottom)
                } else {
                    Image(uiImage: viewUiImage)
                        .resizable()
                        .scaledToFit()
                        .padding(.bottom)
                }
                
                ScrollView(.horizontal) {
                    HStack {
                        Button(action: {
                            viewUiImage = editor.saturation(uiImage: uiImage)
                            isActiveEdit = true
                        }) {
                            VStack {
                                Image("saturation")
                                    .resizable()
                                    .frame(width: 99.0, height: 62.4, alignment: .leading)
                                    .scaledToFit()
                                Text("saturation")
                                    .font(.caption2)
                            }
                        }
                        
                        Button(action: {
                            viewUiImage = editor.delicious(uiImage: uiImage)
                            isActiveEdit = true
                        }) {
                            VStack {
                                Image("delicious")
                                    .resizable()
                                    .frame(width: 99.0, height: 62.4, alignment: .leading)
                                    .scaledToFit()
                                Text("delicious")
                                    .font(.caption2)
                            }
                        }
                        
                        Button(action: {
                            viewUiImage = editor.shadow(uiImage: uiImage)
                            isActiveEdit = true
                        }) {
                            VStack {
                                Image("shadow")
                                    .resizable()
                                    .frame(width: 99.0, height: 62.4, alignment: .leading)
                                    .scaledToFit()
                                Text("shadow")
                                    .font(.caption2)
                            }
                        }
                        
                        Button(action: {
                            viewUiImage = editor.white(uiImage: uiImage)
                            isActiveEdit = true
                        }) {
                            VStack {
                                Image("white")
                                    .resizable()
                                    .frame(width: 99.0, height: 62.4, alignment: .leading)
                                    .scaledToFit()
                                Text("white")
                                    .font(.caption2)
                            }
                        }
                        
                        Button(action: {
                            viewUiImage = editor.daylight(uiImage: uiImage)
                            isActiveEdit = true
                        }) {
                            VStack {
                                Image("daylight")
                                    .resizable()
                                    .frame(width: 99.0, height: 62.4, alignment: .leading)
                                    .scaledToFit()
                                Text("daylight")
                                    .font(.caption2)
                            }
                        }
                        
                        Button(action: {
                            viewUiImage = editor.antique(uiImage: uiImage)
                            isActiveEdit = true
                        }) {
                            VStack {
                                Image("antique")
                                    .resizable()
                                    .frame(width: 99.0, height: 62.4, alignment: .leading)
                                    .scaledToFit()
                                Text("antique")
                                    .font(.caption2)
                            }
                        }
                        
                        Button(action: {
                            viewUiImage = editor.romance(uiImage: uiImage)
                            isActiveEdit = true
                        }) {
                            VStack {
                                Image("romance")
                                    .resizable()
                                    .frame(width: 99.0, height: 62.4, alignment: .leading)
                                    .scaledToFit()
                                Text("romance")
                                    .font(.caption2)
                            }
                        }
                        
                        Button(action: {
                            viewUiImage = editor.ice(uiImage: uiImage)
                            isActiveEdit = true
                        }) {
                            VStack {
                                Image("ice")
                                    .resizable()
                                    .frame(width: 99.0, height: 62.4, alignment: .leading)
                                    .scaledToFit()
                                Text("ice")
                                    .font(.caption2)
                            }
                        }
                        
                        Button(action: {
                            viewUiImage = editor.sepia(uiImage: uiImage)
                            isActiveEdit = true
                        }) {
                            VStack {
                                Image("sepia")
                                    .resizable()
                                    .frame(width: 99.0, height: 62.4, alignment: .leading)
                                    .scaledToFit()
                                Text("sepia")
                                    .font(.caption2)
                            }
                        }
                        
                        Button(action: {
                            viewUiImage = editor.monotone(uiImage: uiImage)
                            isActiveEdit = true
                        }) {
                            VStack {
                                Image("monotone")
                                    .resizable()
                                    .frame(width: 99.0, height: 62.4, alignment: .leading)
                                    .scaledToFit()
                                Text("monotone")
                                    .font(.caption2)
                            }
                        }
                    }
                }

            } else {
                Image("saturation")
                    .resizable()
                    .scaledToFit()
                    .padding(.bottom)
            }
        }
    }
}

class EditorController {
    
    func saturation(uiImage: UIImage) -> UIImage{
        // UIImageからCIImageへの変換
        let ciImage: CIImage? = CIImage(image: uiImage)

        let ciFilter: CIFilter = CIFilter(name: "CIColorControls")!
        ciFilter.setValue(ciImage, forKey: kCIInputImageKey)
        ciFilter.setValue(2.3, forKey: "inputSaturation")
        let newCiImage = ciFilter.outputImage

        let ciContext = CIContext(options: nil)
        let outputCGImage: CGImage = ciContext.createCGImage(
            (newCiImage)!,
            from: (newCiImage?.extent)!)!
        let newUiImage = UIImage(cgImage: outputCGImage, scale: 0, orientation: uiImage.imageOrientation)
        
//        print("image: " + uiImage.description)
//        print("ciImage: " + ciImage!.description)
//        print("newCiImage: " + newCiImage!.description)
//        print("newUiImage: " + newUiImage.description)
        
        return newUiImage
    }
    
    func delicious(uiImage: UIImage) -> UIImage{
        // UIImageからCIImageへの変換
        let ciImage: CIImage? = CIImage(image: uiImage)

        let ciFilter: CIFilter = CIFilter(name: "CIColorControls")!
        ciFilter.setValue(ciImage, forKey: kCIInputImageKey)
        ciFilter.setValue(1.65, forKey: "inputSaturation")
        ciFilter.setValue(0.02, forKey: "inputBrightness")
        let newCiImage = ciFilter.outputImage

        let ciContext = CIContext(options: nil)
        let outputCGImage: CGImage = ciContext.createCGImage(
            (newCiImage)!,
            from: (newCiImage?.extent)!)!
        let newUiImage = UIImage(cgImage: outputCGImage, scale: 0, orientation: uiImage.imageOrientation)
        
        return newUiImage
    }
    
    func shadow(uiImage: UIImage) -> UIImage{
        // UIImageからCIImageへの変換
        let ciImage: CIImage? = CIImage(image: uiImage)

        let ciFilter: CIFilter = CIFilter(name: "CIColorControls")!
        ciFilter.setValue(ciImage, forKey: kCIInputImageKey)
        ciFilter.setValue(1.27, forKey: "inputSaturation")
        ciFilter.setValue(-0.13, forKey: "inputBrightness")
        let newCiImage = ciFilter.outputImage

        let ciContext = CIContext(options: nil)
        let outputCGImage: CGImage = ciContext.createCGImage(
            (newCiImage)!,
            from: (newCiImage?.extent)!)!
        let newUiImage = UIImage(cgImage: outputCGImage, scale: 0, orientation: uiImage.imageOrientation)
        
        return newUiImage
    }
    
    func white(uiImage: UIImage) -> UIImage{
        // UIImageからCIImageへの変換
        let ciImage: CIImage? = CIImage(image: uiImage)

        let ciFilter: CIFilter = CIFilter(name: "CIColorControls")!
        ciFilter.setValue(ciImage, forKey: kCIInputImageKey)
        ciFilter.setValue(0.52, forKey: "inputSaturation")
        ciFilter.setValue(0.1, forKey: "inputBrightness")
        let newCiImage = ciFilter.outputImage

        let ciContext = CIContext(options: nil)
        let outputCGImage: CGImage = ciContext.createCGImage(
            (newCiImage)!,
            from: (newCiImage?.extent)!)!
        let newUiImage = UIImage(cgImage: outputCGImage, scale: 0, orientation: uiImage.imageOrientation)
        
        return newUiImage
    }
    
    func daylight(uiImage: UIImage) -> UIImage{
        
        // UIImageからCIImageへの変換
        let ciImage: CIImage? = CIImage(image: uiImage)
        
        let ciFilter: CIFilter = CIFilter(name: "CIToneCurve")!
        ciFilter.setValue(ciImage, forKey: kCIInputImageKey)
        ciFilter.setValue(CIVector(x: 0.0,  y: 0.07), forKey: "inputPoint0")
        ciFilter.setValue(CIVector(x: 0.25, y: 0.24), forKey: "inputPoint1")
        ciFilter.setValue(CIVector(x: 0.5,  y: 0.77), forKey: "inputPoint2")
        ciFilter.setValue(CIVector(x: 0.75, y: 1.0), forKey: "inputPoint3")
        ciFilter.setValue(CIVector(x: 1.0,  y: 1.0), forKey: "inputPoint4")
        let ciImage2 = ciFilter.outputImage

        let ciFilter2: CIFilter = CIFilter(name: "CIColorControls")!
        ciFilter2.setValue(ciImage2, forKey: kCIInputImageKey)
        ciFilter2.setValue(0.98, forKey: "inputSaturation")
        ciFilter2.setValue(0.11, forKey: "inputBrightness")
        let newCiImage = ciFilter2.outputImage

        let ciContext = CIContext(options: nil)
        let outputCGImage: CGImage = ciContext.createCGImage(
            (newCiImage)!,
            from: (newCiImage?.extent)!)!
        let newUiImage = UIImage(cgImage: outputCGImage, scale: 0, orientation: uiImage.imageOrientation)
        
        return newUiImage
    }
    
    func antique(uiImage: UIImage) -> UIImage{
        
        // UIImageからCIImageへの変換
        let ciImage: CIImage? = CIImage(image: uiImage)
        
        let ciFilter: CIFilter = CIFilter(name: "CIToneCurve")!
        ciFilter.setValue(ciImage, forKey: kCIInputImageKey)
        ciFilter.setValue(CIVector(x: 0.0,  y: 0.0), forKey: "inputPoint0")
        ciFilter.setValue(CIVector(x: 0.25, y: 0.37), forKey: "inputPoint1")
        ciFilter.setValue(CIVector(x: 0.5,  y: 0.52), forKey: "inputPoint2")
        ciFilter.setValue(CIVector(x: 0.75, y: 0.62), forKey: "inputPoint3")
        ciFilter.setValue(CIVector(x: 1.0,  y: 0.93), forKey: "inputPoint4")
        let ciImage2 = ciFilter.outputImage

        let ciFilter2: CIFilter = CIFilter(name: "CIColorControls")!
        ciFilter2.setValue(ciImage2, forKey: kCIInputImageKey)
        ciFilter2.setValue(0.98, forKey: "inputSaturation")
        ciFilter2.setValue(-0.05, forKey: "inputBrightness")
        let newCiImage = ciFilter2.outputImage

        let ciContext = CIContext(options: nil)
        let outputCGImage: CGImage = ciContext.createCGImage(
            (newCiImage)!,
            from: (newCiImage?.extent)!)!
        let newUiImage = UIImage(cgImage: outputCGImage, scale: 0, orientation: uiImage.imageOrientation)
        
        return newUiImage
    }
    
    func romance(uiImage: UIImage) -> UIImage{
        
        // UIImageからCIImageへの変換
        let ciImage: CIImage? = CIImage(image: uiImage)
        
        let ciFilter: CIFilter = CIFilter(name: "CIToneCurve")!
        ciFilter.setValue(ciImage, forKey: kCIInputImageKey)
        ciFilter.setValue(CIVector(x: 0.0,  y: 0.05), forKey: "inputPoint0")
        ciFilter.setValue(CIVector(x: 0.25, y: 0.57), forKey: "inputPoint1")
        ciFilter.setValue(CIVector(x: 0.5,  y: 0.67), forKey: "inputPoint2")
        ciFilter.setValue(CIVector(x: 0.75, y: 1.0), forKey: "inputPoint3")
        ciFilter.setValue(CIVector(x: 1.0,  y: 1.0), forKey: "inputPoint4")
        let ciImage2 = ciFilter.outputImage

        let ciFilter2: CIFilter = CIFilter(name: "CIColorControls")!
        ciFilter2.setValue(ciImage2, forKey: kCIInputImageKey)
        ciFilter2.setValue(0.98, forKey: "inputSaturation")
        ciFilter2.setValue(-0.05, forKey: "inputBrightness")
        let newCiImage = ciFilter2.outputImage

        let ciContext = CIContext(options: nil)
        let outputCGImage: CGImage = ciContext.createCGImage(
            (newCiImage)!,
            from: (newCiImage?.extent)!)!
        let newUiImage = UIImage(cgImage: outputCGImage, scale: 0, orientation: uiImage.imageOrientation)
        
        return newUiImage
    }
    
    func ice(uiImage: UIImage) -> UIImage{
        
        // UIImageからCIImageへの変換
        let ciImage: CIImage? = CIImage(image: uiImage)
        
        let ciFilter: CIFilter = CIFilter(name: "CIToneCurve")!
        ciFilter.setValue(ciImage, forKey: kCIInputImageKey)
        ciFilter.setValue(CIVector(x: 0.0,  y: 0.0), forKey: "inputPoint0")
        ciFilter.setValue(CIVector(x: 0.25, y: 0.51), forKey: "inputPoint1")
        ciFilter.setValue(CIVector(x: 0.5,  y: 0.63), forKey: "inputPoint2")
        ciFilter.setValue(CIVector(x: 0.75, y: 1.0), forKey: "inputPoint3")
        ciFilter.setValue(CIVector(x: 1.0,  y: 1.0), forKey: "inputPoint4")
        let ciImage2 = ciFilter.outputImage

        let ciFilter2: CIFilter = CIFilter(name: "CIColorControls")!
        ciFilter2.setValue(ciImage2, forKey: kCIInputImageKey)
        ciFilter2.setValue(1.15, forKey: "inputSaturation")
        ciFilter2.setValue(-0.03, forKey: "inputBrightness")
        let ciImage3 = ciFilter2.outputImage
        
        let ciFilter3: CIFilter = CIFilter(name: "CITemperatureAndTint")!
        ciFilter3.setValue(ciImage3, forKey: kCIInputImageKey)
        ciFilter3.setValue(CIVector(x: 4430, y: 0), forKey: "inputNeutral")
        ciFilter3.setValue(CIVector(x: 6500, y: 0), forKey: "inputTargetNeutral")
        let newCiImage = ciFilter3.outputImage

        let ciContext = CIContext(options: nil)
        let outputCGImage: CGImage = ciContext.createCGImage(
            (newCiImage)!,
            from: (newCiImage?.extent)!)!
        let newUiImage = UIImage(cgImage: outputCGImage, scale: 0, orientation: uiImage.imageOrientation)
        
        return newUiImage
    }
    
    func sepia(uiImage: UIImage) -> UIImage{
        
        // UIImageからCIImageへの変換
        let ciImage: CIImage? = CIImage(image: uiImage)
        
        let ciFilter: CIFilter = CIFilter(name: "CISepiaTone")!
        ciFilter.setValue(ciImage, forKey: kCIInputImageKey)
        let newCiImage = ciFilter.outputImage

        let ciContext = CIContext(options: nil)
        let outputCGImage: CGImage = ciContext.createCGImage(
            (newCiImage)!,
            from: (newCiImage?.extent)!)!
        let newUiImage = UIImage(cgImage: outputCGImage, scale: 0, orientation: uiImage.imageOrientation)
        
        return newUiImage
    }
    
    func monotone(uiImage: UIImage) -> UIImage{
        
        // UIImageからCIImageへの変換
        let ciImage: CIImage? = CIImage(image: uiImage)
        
        let ciFilter: CIFilter = CIFilter(name: "CIPhotoEffectMono")!
        ciFilter.setValue(ciImage, forKey: kCIInputImageKey)
        let newCiImage = ciFilter.outputImage

        let ciContext = CIContext(options: nil)
        let outputCGImage: CGImage = ciContext.createCGImage(
            (newCiImage)!,
            from: (newCiImage?.extent)!)!
        let newUiImage = UIImage(cgImage: outputCGImage, scale: 0, orientation: uiImage.imageOrientation)
        
        return newUiImage
    }
    
    func lip(uiImage: UIImage) -> UIImage{
        
        // UIImageからCIImageへの変換
        let ciImage: CIImage? = CIImage(image: uiImage)
        
        let ciFilter: CIFilter = CIFilter(name: "CIPhotoEffectMono")!
        ciFilter.setValue(ciImage, forKey: kCIInputImageKey)
        let newCiImage = ciFilter.outputImage

        let ciContext = CIContext(options: nil)
        let outputCGImage: CGImage = ciContext.createCGImage(
            (newCiImage)!,
            from: (newCiImage?.extent)!)!
        let newUiImage = UIImage(cgImage: outputCGImage, scale: 0, orientation: uiImage.imageOrientation)
        
        return newUiImage
    }
}

// そのピクセルの画素値を抽出するクラス
extension UIImage {
    
    func getColor(pos: CGPoint) -> UIColor {

        let imageData = self.cgImage!.dataProvider!.data
        let data : UnsafePointer = CFDataGetBytePtr(imageData)
        let scale = UIScreen.main.scale
        let address : Int = ((Int(self.size.width) * Int(pos.y * scale)) + Int(pos.x * scale)) * 4
        let r = CGFloat(data[address])
        let g = CGFloat(data[address+1])
        let b = CGFloat(data[address+2])
        let a = CGFloat(data[address+3])

        return UIColor(red: r, green: g, blue: b, alpha: a)
    }
}

// RGBとHSVを変換するクラス
class RGBandHSV {
    // RGBからHSVに変換する関数
    func rgb2hsv (r: CGFloat, g: CGFloat, b: CGFloat, a: CGFloat) -> UIColor {
        // R,G,Bのうち、最大値と最小値を元絵m流
        let max = max(r, g, b)
        let min = min(r, g, b)
        var h: CGFloat = 0
        var s: CGFloat = 0
        var v: CGFloat = max

        if (max != min) {
          // H(色相)
            if (max == r){
                h = 60 * (g - b) / (max-min)
            }
            if (max == g){
                h = 60 * (b - r) / (max-min) + 120
            }
            if (max == b){
                h = 60 * (r - g) / (max-min) + 240
            }

          // S(彩度)
          s = (max - min) / max
        }

        if (h < 0){
          h = h + 360
        }

        h =  round(h)
        s =  round(s * 100)
        v =  round((v / 255) * 100)
        
        return UIColor(hue: h, saturation: s, brightness: v, alpha: a);
    }
    
    // HSVからRGBに変換する関数
    func hsv2rgb (_h: CGFloat, _s: CGFloat, _v: CGFloat, _a: CGFloat) -> UIColor {
        
        var h: CGFloat = _h
        var s: CGFloat = _s
        var v: CGFloat = _v
        let a: CGFloat = _a
        
        let max = v
        let min = max - ((s / 255) * max)
        var r: CGFloat = 0
        var g: CGFloat = 0
        var b: CGFloat = 0
        
        if (h == 360){
          h = 0
        }

        s = s / 100
        v = v / 100

        if (s == 0){
          r = v * 255
          g = v * 255
          b = v * 255
          return UIColor(red: r, green: g, blue: b, alpha: a)
        }

        let dh = floor(h / 60)
        let p = v * (1 - s)
        let q = v * (1 - s * (h / 60 - dh))
        let t = v * (1 - s * (1 - (h / 60 - dh)))

        if (dh == 0){
            r = v
            g = t
            b = p
        } else if (dh == 1){
            r = q
            g = v
            b = p
        } else if (dh == 2){
            r = p
            g = v
            b = t
        } else if (dh == 3){
            r = p
            g = q
            b = v
        } else if (dh == 4){
            r = t
            g = p
            b = v
        } else {
            r = v
            g = p
            b = q
        }

        r =  round(r * 255)
        g =  round(g * 255)
        b =  round(b * 255)
        return UIColor(red: r, green: g, blue: b, alpha: a)
    }
}


struct EditPicture_Previews: PreviewProvider {
    static var previews: some View {
        EditPicture(image: UIImage(imageLiteralResourceName: "saturation"))
//        EditPicture().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}
