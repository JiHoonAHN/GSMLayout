//
//  GSMLayout.swift
//  GSMLayout
//
//  Created by Ji-hoon Ahn on 2022/04/15.
//

import Foundation

#if os(iOS) || os(tvOS)
import UIKit
public typealias PEdgeInsets = UIEdgeInsets
#else
import AppKit
public typealias PEdgeInsets = NSEdgeInsets
#endif

public class GSMLayout<View: Layoutable> {
    let view : View
    let keepTransform: Bool
    
    var _top : CGFloat?
    var _left : CGFloat?
    var _bottom : CGFloat?
    var _right : CGFloat?
    
    var _hCenter :  CGFloat?
    var _vCenter : CGFloat?
    
    var width : CGFloat?
    var minWidth: CGFloat?
    var maxWidth: CGFloat?
    var height: CGFloat?
    var minHeight: CGFloat?
    var maxHeight: CGFloat?
    
    var adjustSizeType: AdjustSizeType?
    internal var shouldKeepViewDimension: Bool {
        return adjustSizeType == nil
    }
    
    var marginTop: CGFloat?
    var marginLeft: CGFloat?
    var marginBottom: CGFloat?
    var marginRight: CGFloat?
    var shouldGSMEdges = false
    
    var justify: HorizontalAlign?
    var align: VerticalAlign?
    
    var _marginTop: CGFloat { return marginTop ?? 0 }
    var _marginLeft: CGFloat { return marginLeft ?? 0 }
    var _marginBottom: CGFloat { return marginBottom ?? 0 }
    var _marginRight: CGFloat { return marginRight ?? 0 }
    
    
    var isLayouted = false
    
    init(view : View,keepTransform : Bool){
        self.view = view
        self.keepTransform = keepTransform
#if os(iOS) || os(tvOS)
        GSM.initGSMLayout()
#endif
    }
    
    deinit{
        if !isLayouted && GSM.logMissingLayoutCalls{
            warn("GSMLayout commands have been issued without calling the 'layout()' method to complete the layout. (These warnings can be disabled by setting GSM.logMissingLayoutCalls to false)")
        }
    }
    
#if os(iOS) || os(tvOS)
    public var safeArea : PEdgeInsets{
        if let view = view as? UIView{
            if #available(iOS 11.0 , tvOS 10.0 , *){
                return view.safeAreaInsets
            }else{
                return view.gsmlayoutComputeSafeAreaInsets()
            }
        }else{
            return .zero
        }
    }
#endif
    
#if os(iOS) && compiler(>=5.5) // Xcode 13+
    public var keyboardArea: CGRect {
        guard #available(iOS 15.0, *) else { return .zero }
        guard let view = view as? UIView else { return .zero }
        
        return view.keyboardLayoutGuide.layoutFrame
    }
#endif
    
    @discardableResult
    public func top(_ offset: CGFloat = 0) -> GSMLayout {
        return top(offset, { return "top(\(offset.optionnalDescription))" })
    }
    @discardableResult
    public func left(_ offset: CGFloat = 0) -> GSMLayout {
        return left(offset, { return "left(\(offset.optionnalDescription))" })
    }
    @discardableResult
    public func bottom(_ offset: CGFloat = 0) -> GSMLayout {
        return bottom(offset, { return "bottom(\(offset.optionnalDescription))" })
    }
    @discardableResult
    public func right(_ offset: CGFloat = 0) -> GSMLayout {
        return right(offset, { return "right(\(offset.optionnalDescription))" })
    }
}

extension GSMLayout{
    func layoutSuperviewRect(_ context : Context) -> CGRect?{
        if let superview = view.superview{
            return superview.getRect(keepTransform: keepTransform)
        }else{
            return nil
        }
    }
    func layoutSuperview(_ context: Context) -> View? {
        if let superview = view.superview {
            return superview as? View
        } else {
            return nil
        }
    }
    func referenceSuperview(_ referenceView: View, _ context: Context) -> View? {
        if let superview = referenceView.superview{
            return superview as? View
        }else{
            warnWontBeApplied("the reference view \(viewDescription(referenceView)) must be added as a sub-view before being used as a reference.", context)
            return nil
        }
    }
}
