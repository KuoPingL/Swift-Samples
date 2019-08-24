//
//  DianChanVideosViewController.swift
//  InstagramProfilePage
//
//  Created by Jimmy on 2019/4/15.
//  Copyright © 2019 Jimmy. All rights reserved.
//

import UIKit
import AVFoundation

struct DianChanVideosViewControllerConstants {
    static let cellID = "cell"
    static let sampleMP4_URL = "http://techslides.com/demos/sample-videos/small.mp4";
}

class DianChanVideosViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    
    private lazy var models : [VideoImageModel] = {
        return [
            VideoImageModel(imageName: "www", videoURL: nil, tag: 0),
            VideoImageModel(imageName: nil, videoURL: DianChanVideosViewControllerConstants.sampleMP4_URL, tag: 1),
            VideoImageModel(imageName: "www", videoURL: nil, tag: 2),
            VideoImageModel(imageName: "www", videoURL: nil, tag: 3),
            VideoImageModel(imageName: nil, videoURL: DianChanVideosViewControllerConstants.sampleMP4_URL, tag: 4),
            VideoImageModel(imageName: nil, videoURL: DianChanVideosViewControllerConstants.sampleMP4_URL, tag: 5)
        ]
    }()
    
    private var avPlayerItem: AVPlayerItem?
    private var avPlayer: AVPlayer?
    private var avPlayerLayer: AVPlayerLayer?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView?.register(VideoImageCell.self, forCellWithReuseIdentifier: DianChanVideosViewControllerConstants.cellID)
        let flowout = collectionView!.collectionViewLayout as! UICollectionViewFlowLayout;
        flowout.itemSize = collectionView!.bounds.size;
        flowout.scrollDirection = .horizontal;
        flowout.minimumInteritemSpacing = 0;
        flowout.minimumLineSpacing = 0;
        collectionView?.isPagingEnabled = true;
        
        
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return models.count;
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        var cell = collectionView.dequeueReusableCell(withReuseIdentifier: DianChanVideosViewControllerConstants.cellID, for: indexPath) as? VideoImageCell
        if cell == nil {
            cell = VideoImageCell(frame: .zero)
        }
        cell?.backgroundColor = .yellow
        cell?.setData(models[indexPath.row])
//        let url = URL(string: DianChanVideosViewControllerConstants.sampleMP4_URL)
//        avPlayerItem = AVPlayerItem(url: url!)
//
//        if (avPlayer == nil) {
//            avPlayer = AVPlayer(playerItem: avPlayerItem)
//        } else {
//            avPlayer?.replaceCurrentItem(with: avPlayerItem)
//        }
//        avPlayerLayer = AVPlayerLayer(player: avPlayer)
//        avPlayerLayer?.videoGravity = .resizeAspectFill
//        avPlayerLayer?.frame = cell.bounds
//        if let layer = avPlayerLayer {
//            cell?.layer.addSublayer(layer)
//        }
        
        return cell!
    }
    
    override func collectionView(_ collectionView: UICollectionView, didEndDisplaying cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        print("END DISPLAY \(cell) \n\tTAG: \(models[indexPath.row].tag)")
//        avPlayer?.pause()
//        avPlayerLayer?.removeFromSuperlayer()
        if let cell = cell as? VideoImageCell {
            cell.pauseVideo()
        }
    }
    
    override func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        print("WILL DISPLAY \(cell) \n\tTAG: \(models[indexPath.row].tag)")
//        avPlayer?.play()
        if let cell = cell as? VideoImageCell {
            cell.playVideo()
        }
    }
    
    
    
    
//    override func scrollViewDidScroll(_ scrollView: UIScrollView) {
//        if let cells = collectionView?.visibleCells {
//            for cell in cells {
//                let transform = Transform
//            }
//        }
//    }
}
