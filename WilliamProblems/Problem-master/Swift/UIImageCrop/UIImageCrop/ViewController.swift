//
//  ViewController.swift
//  UIImageCrop
//
//  Created by William-Weng on 2018/12/14.
//  Copyright © 2018年 William-Weng. All rights reserved.
//
/// [iOS實現自定義繪圖的幾種方式(Swift版)](https://www.jianshu.com/p/1e4bc8378c36)
/// [iOS 圖片裁剪方法 - cropping(to:)](https://hk.saowen.com/a/c29379ce0adb706df783057fc001d16b3e50626fb9ace0c4c8476e772ae9737d)
/// [Swift: How to Crop an Image](https://www.youtube.com/watch?v=UFsOXcbTQLw)

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var myImageView: UIImageView!
    @IBOutlet weak var cropView: UIView!
    @IBOutlet weak var croppedImageView: UIImageView!
    private var coverView: UIView = {
        let v = UIView()
        v.backgroundColor = .clear
        v.layer.borderColor = UIColor.yellow.cgColor
        v.layer.borderWidth = 2.0
        return v
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(coverView)
        coverView.frame = CGRect(x: 100, y: 100, width: 100, height: 100)
        myImageView.contentMode = .scaleAspectFill
        croppedImageView.contentMode = .scaleAspectFit
        let panGesture = UIPanGestureRecognizer(target: self, action: #selector(panCoverView(_:)))
        panGesture.maximumNumberOfTouches = 1
        panGesture.minimumNumberOfTouches = 1
        coverView.isUserInteractionEnabled = true
        coverView.addGestureRecognizer(panGesture)
    }
    
    @objc func panCoverView(_ gesture: UIPanGestureRecognizer) {
        let panLocation = gesture.location(in: myImageView)
        coverView.center = panLocation
        let cropFrame = view.convert(coverView.frame, to: myImageView)
        let croppedImage = myImageView.cropImage(withRect: cropFrame)
        croppedImageView.image = croppedImage
    }
    
    @IBAction func croppedWithCIImage(_ sender: UIBarButtonItem) {
        croppedImageView.image = nil
        let cropFrame = view.convert(coverView.frame, to: myImageView)
        let croppedImage = myImageView.cropImage(withRect: cropFrame)
        croppedImageView.image = croppedImage
    }
    
    @IBAction func croppedWithUIGraphics(_ sender: UIBarButtonItem) {
        croppedImageView.image = nil
        let croppedImage = UIImage.cropImage2(myImageView.image!, withRect: cropView.frame)
        croppedImageView.image = croppedImage
    }
}

extension UIImage {
    
    static func cropImage(_ image: UIImage, withRect rect: CGRect) -> UIImage? {
    
        if let cgImage = image.cgImage,
            let croppedCgImage = cgImage.cropping(to: rect) {
            return UIImage(cgImage: croppedCgImage)
        }
        
        if let ciImage = image.ciImage {
            let croppedCiImage = ciImage.cropped(to: rect)
            return UIImage(ciImage: croppedCiImage)
        }
        
        return nil
    }
    
    static func cropImage2(_ image: UIImage, withRect rect: CGRect) -> UIImage? {
       
        UIGraphicsBeginImageContext(rect.size)
        
        guard let context = UIGraphicsGetCurrentContext() else { return nil }
        
        context.translateBy(x: -rect.minX, y: -rect.minY)
        image.draw(at: .zero)
        
        let croppedImage = UIGraphicsGetImageFromCurrentImageContext()
        
        UIGraphicsEndImageContext()
        return croppedImage
    }
}
