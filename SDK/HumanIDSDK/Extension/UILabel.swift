//
//  UILabel.swift
//  HumanIDSDK
//
//  Created by fanni suyuti on 09/10/19.
//  Copyright © 2019 HumanID. All rights reserved.
//

import Foundation

extension UILabel {
    func attributedTextIndex(point: CGPoint) -> Int {
        
        let textStorage = NSTextStorage(attributedString: self.attributedText!)
        let layoutManager = NSLayoutManager()
        textStorage.addLayoutManager(layoutManager)
        
        let textContainer = NSTextContainer(size: self.frame.size)
        textContainer.lineFragmentPadding = 0
        textContainer.maximumNumberOfLines = self.numberOfLines
        textContainer.lineBreakMode = self.lineBreakMode
        layoutManager.addTextContainer(textContainer)

        let index = layoutManager.characterIndex(for: point, in: textContainer, fractionOfDistanceBetweenInsertionPoints: nil)
        return index
    }
}
