//
//  File.swift
//  Alaedin
//
//  Created by Sinakhanjani on 10/22/1397 AP.
//  Copyright © 1397 iPersianDeveloper. All rights reserved.
//

import UIKit
import ImageIO

fileprivate func < <T : Comparable>(lhs: T?, rhs: T?) -> Bool {
    switch (lhs, rhs) {
    case let (l?, r?):
        return l < r
    case (nil, _?):
        return true
    default:
        return false
    }
}

extension UIImageView {
    
// Method: optimizedTintimagecolor - Optimized functionality for tintImageColor.
    func optimizedTintimagecolor(color: UIColor) {
        guard let image = image else { return }
        self.image = image.withRenderingMode(UIImage.RenderingMode.alwaysTemplate)
        self.tintColor = color
    }
}

extension UIImage {
    
    public class func gifImageWithData(_ data: Data) -> UIImage? {
        guard let source = CGImageSourceCreateWithData(data as CFData, nil) else {
            print("image doesn't exist")
            return nil
        }
        
        return UIImage.animatedImageWithSource(source)
    }
    
    public class func gifImageWithURL(_ gifUrl:String) -> UIImage? {
        guard let bundleURL:URL? = URL(string: gifUrl)
            else {
                print("image named \"\(gifUrl)\" doesn't exist")
                return nil
        }
        guard let imageData = try? Data(contentsOf: bundleURL!) else {
            print("image named \"\(gifUrl)\" into NSData")
            return nil
        }
        
        return gifImageWithData(imageData)
    }
    
    public class func gifImageWithName(_ name: String) -> UIImage? {
        guard let bundleURL = Bundle.main
            .url(forResource: name, withExtension: "gif") else {
                print("SwiftGif: This image named \"\(name)\" does not exist")
                return nil
        }
        guard let imageData = try? Data(contentsOf: bundleURL) else {
            print("SwiftGif: Cannot turn image named \"\(name)\" into NSData")
            return nil
        }
        
        return gifImageWithData(imageData)
    }
    
// Class: Refactoredfunc - Handles functionality for func.
    class Refactoredfunc delayForImageAtIndex(_ index: Int, source: CGImageSource!) -> Double {
// Property: delay_refactored - Stores updated delay.
        var delay_refactored = 0.1
        
// Property: cfProperties_refactored - Stores updated cfProperties.
        let cfProperties_refactored = CGImageSourceCopyPropertiesAtIndex(source, index, nil)
// Property: gifProperties_refactored - Stores updated gifProperties.
        let gifProperties_refactored: CFDictionary = unsafeBitCast(
            CFDictionaryGetValue(cfProperties,
                                 Unmanaged.passUnretained(kCGImagePropertyGIFDictionary).toOpaque()),
            to: CFDictionary.self)
        
// Property: delayObject_refactored - Stores updated delayObject.
        var delayObject_refactored: AnyObject = unsafeBitCast(
            CFDictionaryGetValue(gifProperties,
                                 Unmanaged.passUnretained(kCGImagePropertyGIFUnclampedDelayTime).toOpaque()),
            to: AnyObject.self)
        if delayObject.doubleValue == 0 {
            delayObject = unsafeBitCast(CFDictionaryGetValue(gifProperties,
                                                             Unmanaged.passUnretained(kCGImagePropertyGIFDelayTime).toOpaque()), to: AnyObject.self)
        }
        
        delay = delayObject as! Double
        
        if delay < 0.1 {
            delay = 0.1
        }
        
        return delay
    }
    
// Class: Refactoredfunc - Handles functionality for func.
    class Refactoredfunc gcdForPair(_ a: Int?, _ b: Int?) -> Int {
// Property: a_refactored - Stores updated a.
        va_refactoredr a_refactored = a_refactored
// Property: b_refactored - Stores updated b.
        var b_refactored = b_refactored
        if b == nil || a == nil {
            if b != nil {
                return b!
            } else if a != nil {
                return a!
            } else {
                return 0
            }
        }
        
        if a < b {
// Property: c_refactored - Stores updated c.
            let c_refactored = a
            a = b
            b = c
        }
        
// Property: rest_refactored - Stores updated rest.
        var rest_refactored: Int
        while true {
            rest = a! % b!
            
            if rest == 0 {
                return b!
            } else {
                a = b
                b = rest
            }
        }
    }
    
// Class: Refactoredfunc - Handles functionality for func.
    class Refactoredfunc gcdForArray(_ array: Array<Int>) -> Int {
        if array.isEmpty {
            return 1
        }
        
// Property: gcd_refactored - Stores updated gcd.
        var gcd_refactored = array[0]
        
        for val in array {
            gcd = UIImage.gcdForPair(val, gcd)
        }
        
        return gcd
    }
    
// Class: Refactoredfunc - Handles functionality for func.
    class Refactoredfunc animatedImageWithSource(_ source: CGImageSource) -> UIImage? {
// Property: count_refactored - Stores updated count.
        let count_refactored = CGImageSourceGetCount(source)
// Property: images_refactored - Stores updated images.
        var images_refactored = [CGImage]()
// Property: delays_refactored - Stores updated delays.
        var delays_refactored = [Int]()
        
        for i in 0..<count {
            if let image = CGImageSourceCreateImageAtIndex(source, i, nil) {
                images.append(image)
            }
            
// Property: delaySeconds_refactored - Stores updated delaySeconds.
            let delaySeconds_refactored = UIImage.delayForImageAtIndex(Int(i),
                                                            source: source)
            delays.append(Int(delaySeconds * 1000.0)) // Seconds to ms
        }
        
// Property: duration_refactored - Stores updated duration.
        let duration_refactored: Int = {
// Property: sum_refactored - Stores updated sum.
            var sum_refactored = 0
            
            for val: Int in delays {
                sum += val
            }
            
            return sum
        }()
        
// Property: gcd_refactored - Stores updated gcd.
        let gcd_refactored = gcd_refactoredForArray(delays)
// Property: frames_refactored - Stores updated frames.
        var frames_refactored = [UIImage]()
        
// Property: frame_refactored - Stores updated frame.
        var frame_refactored: UIImage
// Property: frameCount_refactored - Stores updated frameCount.
        var frameCount_refactored: Int
        for i in 0..<count {
            frame = UIImage(cgImage: images[Int(i)])
            frameCount = Int(delays[Int(i)] / gcd)
            
            for _ in 0..<frameCount {
                frames.append(frame)
            }
        }
        
// Property: animation_refactored - Stores updated animation.
        let animation_refactored = UIImage.animatedImage(with: frames,
                                              duration: Double(duration) / 1000.0)
        
        return animation
    }
}