//
//  VideoImageCell.swift
//  InstagramProfilePage
//
//  Created by Jimmy on 2019/4/16.
//  Copyright © 2019 Jimmy. All rights reserved.
//

import Foundation
import UIKit
import AVFoundation

struct VideoImageModel {
    var imageName: String?
    var videoURL: String?
    var tag: Int
    
    init(imageName: String? = nil, videoURL: String? = nil, tag: Int) {
        self.imageName = imageName
        self.videoURL = videoURL
        self.tag = tag
    }
}

class VideoImageCell: UICollectionViewCell {
    private var videoImageModel: VideoImageModel?
    
    private lazy var containerView: UIView = {
        let v = UIView()
        v.translatesAutoresizingMaskIntoConstraints = false
        return v
    }()
    
    private lazy var imageView: UIImageView = {
        let i = UIImageView()
        i.translatesAutoresizingMaskIntoConstraints = false
        return i
    }()
    
    private var avplayerItem: AVPlayerItem?
    private var avplayer: AVPlayer?
    private var avplayerLayer: AVPlayerLayer?
    
    override func layoutSubviews() {
        super.layoutSubviews()
        if avplayerLayer != nil {
            avplayerLayer?.frame = imageView.bounds
        }
    }
    
    public func setData(_ model: VideoImageModel?) {
        self.videoImageModel = model
        
        if let imageName = self.videoImageModel?.imageName {
            
            self.setData(nil)
            imageView.image = UIImage(named: imageName)
            
        } else if let videoURL = self.videoImageModel?.videoURL {
            guard let url = URL(string: videoURL) else {
                setData(nil)
                return
            }
            avplayerItem = AVPlayerItem(url: url)
            if avplayer == nil {
                avplayer = AVPlayer(playerItem: avplayerItem)
                avplayerLayer = AVPlayerLayer(player: avplayer)
                avplayerLayer?.videoGravity = .resizeAspect
                avplayerLayer?.backgroundColor = UIColor.black.cgColor
            }
            
            self.avplayerLayer?.frame = self.imageView.bounds
            guard let playerLayer = self.avplayerLayer else {
                return
            }
            self.imageView.layer.insertSublayer(playerLayer, at: 0)
            
            
        } else {
            imageView.image = nil
            avplayer?.pause()
            avplayer?.replaceCurrentItem(with: nil)
            avplayerItem = nil
            avplayerLayer?.removeFromSuperlayer()
            avplayerLayer?.player = nil
            avplayer = nil
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    private func commonInit() {
        self.addSubview(imageView)
        imageView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        imageView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        imageView.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        imageView.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        print("PREPARE FOR REUSE")
        self.setData(nil)
    }
    
    public func playVideo() {
        DispatchQueue.main.async {
            self.avplayer?.play()
        }
    }
    
    public func pauseVideo() {
        DispatchQueue.main.async {
            self.avplayer?.pause()
            self.avplayer?.seek(to: kCMTimeZero, completionHandler: { (_) in
                
            })
        }
    }
}
