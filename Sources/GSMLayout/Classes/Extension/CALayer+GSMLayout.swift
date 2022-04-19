//
//  CALayer+GSMLayout.swift
//  GSMLayout
//
//  Created by Ji-hoon Ahn on 2022/04/19.
//

import QuartzCore

extension CALayer: Layoutable {
    public typealias View = CALayer

    public var superview: CALayer? {
        return superlayer
    }

    public var subviews: [CALayer] {
        return sublayers ?? []
    }

    public var pin: GSMLayout<CALayer> {
        return GSMLayout(view: self, keepTransform: true)
    }

    public var pinFrame: GSMLayout<CALayer> {
        return GSMLayout(view: self, keepTransform: false)
    }

    public func getRect(keepTransform: Bool) -> CGRect {
        if keepTransform {
            /*
             To adjust the layer's position and size, we don't set the layer's frame directly, because we want to keep the
             layer's transform.
             By setting the layer's center and bounds we really set the frame of the non-transformed layer, and this keep
             the layer's transform. So layer's transforms won't be affected/altered by PinLayout.
             */
            let size = bounds.size
            // See setRect(...) for details about this calculation.
            let origin = CGPoint(x: position.x - (size.width * anchorPoint.x),
                                 y: position.y - (size.height * anchorPoint.y))

            return CGRect(origin: origin, size: size)
        } else {
            return frame
        }
    }

    public func setRect(_ rect: CGRect, keepTransform: Bool) {
        let adjustedRect = Coordinates<View>.adjustRectToDisplayScale(rect)

        if keepTransform {
            /*
             To adjust the layer's position and size, we don't set the layer's frame directly, because we want to keep the
             layer's transform.
             By setting the layer's center and bounds we really set the frame of the non-transformed layer, and this keep
             the layer's transform. So layer's transforms won't be affected/altered by PinLayout.
             */

            // NOTE: The center is offset by the layer.anchorPoint, so we have to take it into account.
            position = CGPoint(x: adjustedRect.origin.x + (adjustedRect.width * anchorPoint.x),
                               y: adjustedRect.origin.y + (adjustedRect.height * anchorPoint.y))
            // NOTE: We must set only the bounds's size and keep the origin.
            bounds.size = adjustedRect.size
        } else {
            frame = adjustedRect
        }
    }

    public func isLTR() -> Bool {
        switch GSM.layoutDirection {
        case .auto: return true
        case .ltr:  return true
        case .rtl:  return false
        }
    }
}
