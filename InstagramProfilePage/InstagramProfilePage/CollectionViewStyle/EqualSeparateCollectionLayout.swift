//
//  EqualSeparateCollectionLayout.swift
//  InstagramProfilePage
//
//  Created by Jimmy on 2019/1/23.
//  Copyright © 2019 Jimmy. All rights reserved.
//

import Foundation
import UIKit

class EqualSeparateCollectionLayout: UICollectionViewFlowLayout {
    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        let attributesArray = super.layoutAttributesForElements(in: rect)
        if let attributes = attributesArray {
            var array:[UICollectionViewLayoutAttributes]? = []
            for attribute in attributes {
                array?.append(applyLayoutAttributes(attribute))
            }
            print("RETURN ARRAY")
            print(array)
            return array
        }
        return attributesArray
    }
    
    override func layoutAttributesForItem(at indexPath: IndexPath) -> UICollectionViewLayoutAttributes? {
        let attribute = super.layoutAttributesForItem(at: indexPath)
        if let att = attribute {
            return applyLayoutAttributes(att)
        }
        print(attribute)
        return attribute
    }
    
    private func applyLayoutAttributes(_ attributes: UICollectionViewLayoutAttributes) -> UICollectionViewLayoutAttributes {
        let width = self.collectionViewContentSize.width
        let leftMargin = self.sectionInset.left
        let rightMargin = self.sectionInset.right
        
        guard let collectionView = self.collectionView,
            collectionView.numberOfItems(inSection: attributes.indexPath.section) > 0 else {
                return attributes
        }
        
        let itemsInSection = collectionView.numberOfItems(inSection: attributes.indexPath.section)
        
        print("Items in section : \(itemsInSection)")
        let firstXPosition = (width - (leftMargin + rightMargin)) / (2 * CGFloat(itemsInSection))
        print("First X : \(firstXPosition)")
        let xPosition = firstXPosition + (2 * firstXPosition * CGFloat(attributes.indexPath.item))
        print("X : \(xPosition)")
        attributes.center = CGPoint(x: leftMargin + xPosition, y: attributes.center.y)
        print("attributes.center : \(attributes.center)")
        attributes.frame = attributes.frame.integral
        print(attributes)
        return attributes
    }
}
