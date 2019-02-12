//
//  DianChanCollectionViewLayout.swift
//  InstagramProfilePage
//
//  Created by Jimmy on 2019/1/23.
//  Copyright © 2019 Jimmy. All rights reserved.
//

import Foundation
import UIKit

/**
 
 |==========|===================|
 | 0        |3                  |
 |          |                   |
 |          |                   |
 |==========|                   |
 |1         |                   |
 |          |                   |
 |          |                   |
 |==========|=========|=========|
 |2         |4        |5        |
 |          |         |         |
 |          |         |         |
 |==========|=========|=========|
 |6                   |7        |
 |                    |         |
 |                    |         |
 |                    |=========|
 |                    |8        |
 |                    |         |
 |                    |         |
 |====================|=========|
 |9         |10       |11       |
 |          |         |         |
 |          |         |         |
 |==========|=========|=========|
 */


class DianChanCollectionViewLayout: UICollectionViewFlowLayout {
    
    private var contentBounds = CGRect.zero
    private var cachedAttributes = [UICollectionViewLayoutAttributes]()
    
    override func prepare() {
        super.prepare()
        
        guard let collectionView = collectionView else {return}
        
        // 先清除 被記錄的 attributes
        cachedAttributes.removeAll()
        // 初始化 contentBounds (這是可滑動的 frame)
        contentBounds = CGRect(origin: .zero, size: collectionView.bounds.size)
        
        let count = collectionView.numberOfItems(inSection: 0)
        // 設定 間隔
        minimumInteritemSpacing = 10
        
        // Start setting up the attributes
        var currentIndex = 0
        
        let cvWidth = collectionView.bounds.width
        let insetLeft = sectionInset.left
        let insetRight = sectionInset.right
        
        // 計算最小格子的寬度
        let smallBlockWidth = (cvWidth - (insetLeft + minimumInteritemSpacing * 2 + insetRight)) / 3.0
        // 設定小格子的大小 (同寬高)
        let smallBlockSize = CGSize(width: smallBlockWidth, height: smallBlockWidth)
        
        // 計算第一個格子的 frame
        var firstFrame = CGRect(x: insetLeft,
                                y: sectionInset.top,
                                width: smallBlockWidth,
                                height: smallBlockWidth)
        // 計算一組 12 格的總高度
        let unitHeight = smallBlockWidth * 6 + minimumInteritemSpacing * 6
        
        // 逐一設定 attribute
        while currentIndex < count {
            var segmentFrame = CGRect.zero
            
            let remainder = currentIndex % 12
            
            switch (remainder) {
            case 0:
                
                var multiplier: CGFloat = 1
                
                if CGFloat(currentIndex) / 12.0 < 1 {
                    multiplier = 0
                }
                
                // 當新的組要開始畫的時候，計算第一個格子的位置
                let origin = CGPoint(x: firstFrame.origin.x,
                                     y: firstFrame.origin.y + multiplier * unitHeight)
                firstFrame = CGRect(origin: origin,
                                    size: firstFrame.size)
                segmentFrame = firstFrame
                
            case 1...2:
                let origin = CGPoint(x: firstFrame.origin.x, y: firstFrame.origin.y + CGFloat(remainder) * (minimumInteritemSpacing + smallBlockWidth))
                segmentFrame = CGRect(origin: origin, size: firstFrame.size)
            case 3:
                // 第一大格子
                let origin = CGPoint(x: firstFrame.origin.x + smallBlockWidth + minimumInteritemSpacing, y: firstFrame.origin.y)
                let size = CGSize(width: smallBlockWidth * 2 + minimumInteritemSpacing, height: smallBlockWidth * 2 + minimumInteritemSpacing)
                segmentFrame = CGRect(origin: origin, size: size)
            case 4:
                // 第一大格子下面左邊的小格子
                let origin = CGPoint(x: firstFrame.origin.x + minimumInteritemSpacing + smallBlockWidth, y: firstFrame.origin.y + 2 * (minimumInteritemSpacing + smallBlockWidth))
                segmentFrame = CGRect(origin: origin, size: smallBlockSize)
            case 5:
                // 第一大格子下面億右邊的小格子
                let origin = CGPoint(x: firstFrame.origin.x + 2 * (minimumInteritemSpacing + smallBlockWidth), y: firstFrame.origin.y + 2 * (minimumInteritemSpacing + smallBlockWidth))
                segmentFrame = CGRect(origin: origin, size: smallBlockSize)
                
            case 6:
                // 第二大格子
                let origin = CGPoint(x: firstFrame.origin.x, y: firstFrame.origin.y + 3 * (smallBlockWidth + minimumInteritemSpacing))
                let size = CGSize(width: smallBlockWidth * 2 + minimumInteritemSpacing, height: smallBlockWidth * 2 + minimumInteritemSpacing)
                segmentFrame = CGRect(origin: origin, size: size)
                
            case 7:
                let origin = CGPoint(x: firstFrame.origin.x + 2 * (minimumInteritemSpacing + smallBlockWidth), y: firstFrame.origin.y + 3 * (smallBlockWidth + minimumInteritemSpacing))
                segmentFrame = CGRect(origin: origin, size: smallBlockSize)
            case 8:
                let origin = CGPoint(x: firstFrame.origin.x + 2 * (minimumInteritemSpacing + smallBlockWidth), y: firstFrame.origin.y + 4 * (smallBlockWidth + minimumInteritemSpacing))
                segmentFrame = CGRect(origin: origin, size: smallBlockSize)
            case 9:
                let origin = CGPoint(x: firstFrame.origin.x + 0 * (minimumInteritemSpacing + smallBlockWidth), y: firstFrame.origin.y + 5 * (smallBlockWidth + minimumInteritemSpacing))
                segmentFrame = CGRect(origin: origin, size: smallBlockSize)
            case 10:
                let origin = CGPoint(x: firstFrame.origin.x + 1 * (minimumInteritemSpacing + smallBlockWidth), y: firstFrame.origin.y + 5 * (smallBlockWidth + minimumInteritemSpacing))
                segmentFrame = CGRect(origin: origin, size: smallBlockSize)
            case 11:
                let origin = CGPoint(x: firstFrame.origin.x + 2 * (minimumInteritemSpacing + smallBlockWidth), y: firstFrame.origin.y + 5 * (smallBlockWidth + minimumInteritemSpacing))
                segmentFrame = CGRect(origin: origin, size: smallBlockSize)
            default:
                continue;
            }
            
            // 紀錄 attribute
            cacheAttributes(with: segmentFrame, for: IndexPath(item: currentIndex, section: 0))
            currentIndex += 1
        }
        
    }
    
    private func cacheAttributes(with frame: CGRect, for indexPath: IndexPath) {
        
        let attributes = UICollectionViewLayoutAttributes(forCellWith: indexPath)
        attributes.frame = frame
        cachedAttributes.append(attributes)
        
        // 重新計算 contentBounds (要包含新的 frame 的)
        contentBounds = contentBounds.union(frame)
    }
    
    override var collectionViewContentSize: CGSize {
        return contentBounds.size
    }
    
    override func shouldInvalidateLayout(forBoundsChange newBounds: CGRect) -> Bool {
        guard let collectionView = collectionView else { return false }
        // 只要 bounds 沒改變，就不要 invalidate
        return !newBounds.size.equalTo(collectionView.bounds.size)
    }
    
    /// - Tag: LayoutAttributesForItem
    override func layoutAttributesForItem(at indexPath: IndexPath) -> UICollectionViewLayoutAttributes? {
        return cachedAttributes[indexPath.item]
    }
    
    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        var attributesArray = [UICollectionViewLayoutAttributes]()
        
        // find cells that are within the rect
        // 尋找在 rect 中的 attributes
        // firstMatchIndex 先找到第一個在 rect 中的 attribute index
        guard let lastIndex = cachedAttributes.indices.last,
            let firstMatchIndex =  binarySearch(rect, start: 0, end: lastIndex) else {
                return attributesArray
        }
        
        // Starting from the match, loop up and down through the array until all the attributes
        // have been added within the query rect.
        // 將所有在 rect 中間的 attributes 全部儲存並回傳
        for attributes in cachedAttributes[..<firstMatchIndex].reversed() {
            guard attributes.frame.maxY >= rect.minY else {
                break;
            }
            attributesArray.append(attributes)
        }
        
        for attributes in cachedAttributes[firstMatchIndex...] {
            guard attributes.frame.minY <= rect.maxY else { break }
            attributesArray.append(attributes)
        }
        
        return attributesArray
    }
    
    private func binarySearch(_ rect: CGRect, start: Int, end: Int) -> Int? {
        if end < start {return nil}
        let mid = (start + end) / 2
        
        let attr = cachedAttributes[mid]
        if attr.frame.intersects(rect) {
            return mid
        } else {
            if attr.frame.maxY < rect.minY {
                return binarySearch(rect, start: mid + 1, end: end)
            } else {
                return binarySearch(rect, start: start, end: mid - 1)
            }
        }
    }
    
}
