//
//  UIView+GSMLayout.swift
//  GSMLayout
//
//  Created by Ji-hoon Ahn on 2022/04/14.
//

import Foundation

#if os(iOS) || os(tvOS)
import UIKit

extension UIView : Layoutable, SizeCalculable{
    
    public var gsm : GSMLayout<UIView>{
        return GSMLayout(view: self, keepTransform: true)
    }
    
    public func getRect(keepTransform: Bool) -> CGRect {
        guard !GSM.autoSizingInProgress || autoSizingRect == nil else{return autoSizingRect ?? CGRect.zero}
        if keepTransform{
            let size = bounds.size
            let origin = CGPoint(x: center.x - (size.width * layer.anchorPoint.x),
                                 y: center.y - (size.height * layer.anchorPoint.y))
            return CGRect(origin: origin, size: size)
        }else{
            return frame
        }
    }
    
    public func setRect(_ rect: CGRect, keepTransform: Bool) {
        
    }
    
    public func isLTR() -> Bool {
        switch GSM.layoutDirection{
        case .auto:
            if #available(iOS 10.0, tvOS 10.0, *){
                return effectiveUserInterfaceLayoutDirection == .leftToRight
            } else {
                return UIView.userInterfaceLayoutDirection(for: semanticContentAttribute) == .leftToRight
            }
        case .ltr: return true
        case .rtl: return false
        }
    }
}

extension UIView : AutoSizeCalculable{
    private struct gsmlayoutAssociatedKeys {
        static var gsmlayoutAutoSizingRect = UnsafeMutablePointer<Int8>.allocate(capacity: 1)
        static var gsmlayoutAutoSizingRectWithMargins = UnsafeMutablePointer<Int8>.allocate(capacity: 1)
    }


    private var autoSizingRect : CGRect?{
        get{
            return objc_getAssociatedObject(self, &gsmlayoutAssociatedKeys.gsmlayoutAutoSizingRect) as? CGRect
        }
        set{
            objc_setAssociatedObject(self, &gsmlayoutAssociatedKeys.gsmlayoutAutoSizingRect, newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
    private var autoSizingRectWithMargins: CGRect? {
        get {
            return objc_getAssociatedObject(self, &gsmlayoutAssociatedKeys.gsmlayoutAutoSizingRectWithMargins) as? CGRect
        }
        set {
            objc_setAssociatedObject(self, &gsmlayoutAssociatedKeys.gsmlayoutAutoSizingRectWithMargins, newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
    
    public func setAutoSizingRect(_ rect: CGRect, margins: PEdgeInsets) {
        
    }
    
    public func autoSizeThatFits(_ size: CGSize, layoutClosure: () -> Void) -> CGSize {
        let isAlreadyAutoSizing = GSM.autoSizingInProgress
        
        if (!isAlreadyAutoSizing) {
            GSM.autoSizingInProgress = true
        }

        autoSizingRect = CGRect(origin: CGPoint.zero, size: size)
        layoutClosure()
        
        let boundingRect = subviews.compactMap({$0.autoSizingRectWithMargins}).reduce(CGRect.zero) { (result: CGRect, autoSizingRect: CGRect) -> CGRect in
            return result.union(autoSizingRect)
        }
        if !isAlreadyAutoSizing {
            GSM.autoSizingInProgress = false
        }
        
        return boundingRect.size
    }
    
}

#endif
