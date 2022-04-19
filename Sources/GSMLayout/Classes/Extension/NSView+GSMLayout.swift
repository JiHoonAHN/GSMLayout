//
//  NSView+GSMLayout.swift
//  GSMLayout
//
//  Created by Ji-hoon Ahn on 2022/04/19.
//

import Foundation

#if os(macOS)
import AppKit

extension NSView: Layoutable {
    public typealias View = NSView

    public var pin: GSMLayout<NSView> {
        return PinLayout(view: self, keepTransform: true)
    }

    public var pinFrame: GSMLayout<NSView> {
        return PinLayout(view: self, keepTransform: false)
    }

    public func getRect(keepTransform: Bool) -> CGRect {
        if let superview = superview, !superview.isFlipped {
            var flippedRect = frame
            flippedRect.origin.y = superview.frame.height - flippedRect.height - flippedRect.origin.y
            return flippedRect
        } else {
            return frame
        }
    }

    public func setRect(_ rect: CGRect, keepTransform: Bool) {
        let adjustedRect = Coordinates<View>.adjustRectToDisplayScale(rect)

        if let superview = superview, !superview.isFlipped {
            var flippedRect = adjustedRect
            flippedRect.origin.y = superview.frame.height - flippedRect.height - flippedRect.origin.y
            frame = flippedRect
        } else {
            frame = adjustedRect
        }
    }

    public func isLTR() -> Bool {
        switch Pin.layoutDirection {
        case .auto: return self.userInterfaceLayoutDirection == .leftToRight
        case .ltr:  return true
        case .rtl:  return false
        }
    }
}

extension NSControl: SizeCalculable {

}

#endif
