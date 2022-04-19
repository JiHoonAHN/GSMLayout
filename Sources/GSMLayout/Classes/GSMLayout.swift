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
    var shouldKeepViewDimension: Bool {
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
    public var readableMargins: PEdgeInsets {
        guard #available(iOS 9.0, *) else { return .zero }
        guard let view = view as? UIView else { return .zero }

        let layoutFrame = view.readableContentGuide.layoutFrame
        guard !layoutFrame.isEmpty else { return .zero }
        
        return UIEdgeInsets(top: layoutFrame.origin.y, left: layoutFrame.origin.x,
                            bottom: view.frame.height - layoutFrame.origin.y - layoutFrame.height,
                            right: view.frame.width - layoutFrame.origin.x - layoutFrame.width)
    }

    public var layoutMargins: PEdgeInsets {
        guard let view = view as? UIView else { return .zero }
        return view.layoutMargins
    }
    
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
    public func top(_ percent: Percent) -> GSMLayout {
        func context() -> String { return "top(\(percent.description))" }
        guard let layoutSuperviewRect = layoutSuperviewRect(context) else { return self }
        setTop(percent.of(layoutSuperviewRect.height), context)
        return self
    }
    @discardableResult
    public func top(_ insets: PEdgeInsets) -> GSMLayout {
        return top(insets.top, { return "top(\(insetsDescription(insets))" })
    }
    //MARK: - Left
    @discardableResult
    public func left(_ offset: CGFloat = 0) -> GSMLayout {
        return left(offset, { return "left(\(offset.optionnalDescription))" })
    }
    @discardableResult
    public func left(_ offset: Percent) -> GSMLayout {
        return left(offset, { return "left(\(offset.description))" })
    }
    @discardableResult
    public func left(_ insets: PEdgeInsets) -> GSMLayout {
        return left(insets.left, { return "left(\(insetsDescription(insets))" })
    }
    
    @discardableResult
    public func start(_ offset: CGFloat = 0) -> GSMLayout {
        func context() -> String { return "start(\(offset.optionnalDescription))" }
        return isLTR() ? left(offset, context) : right(offset, context)
    }
    @discardableResult
    public func start(_ offset: Percent) -> GSMLayout {
        func context() -> String { return "start(\(offset.description))" }
        return isLTR() ? left(offset, context) : right(offset, context)
    }

    @discardableResult
    public func start(_ insets: PEdgeInsets) -> GSMLayout {
        func context() -> String { return "start(\(insetsDescription(insets))" }
        return isLTR() ? left(insets.left, context) : right(insets.right, context)
    }
    
    @discardableResult
    public func bottom(_ offset: CGFloat = 0) -> GSMLayout {
        return bottom(offset, { return "bottom(\(offset.optionnalDescription))" })
    }

    @discardableResult
    public func bottom(_ offset: Percent) -> GSMLayout {
        return bottom(offset, { return "bottom(\(offset.description))" })
    }

    @discardableResult
    public func bottom(_ insets: PEdgeInsets) -> GSMLayout {
        return bottom(insets.bottom, { return "bottom(\(insetsDescription(insets))" })
    }

    @discardableResult
    public func right(_ offset: CGFloat = 0) -> GSMLayout {
        return right(offset, { return "right(\(offset.optionnalDescription))" })
    }

    @discardableResult
    public func right(_ offset: Percent) -> GSMLayout {
        return right(offset, { return "right(\(offset.description))" })
    }

    @discardableResult
    public func right(_ insets: PEdgeInsets) -> GSMLayout {
        return right(insets.right, { return "right(\(insetsDescription(insets))" })
    }
    
    @discardableResult
    public func end(_ margin: CGFloat = 0) -> GSMLayout {
        func context() -> String { return "end(\(margin.optionnalDescription))" }
        return isLTR() ? right(margin, context) : left(margin, context)
    }

    @discardableResult
    public func end(_ offset: Percent) -> GSMLayout {
        func context() -> String { return "end(\(offset.description))" }
        return isLTR() ? right(offset, context) : left(offset, context)
    }

    @discardableResult
    public func end(_ insets: PEdgeInsets) -> GSMLayout {
        func context() -> String { return "end(\(insetsDescription(insets))" }
        return isLTR() ? right(insets.right, context) : left(insets.left, context)
    }

    @discardableResult
    public func hCenter(_ margin: CGFloat = 0) -> GSMLayout {
        func context() -> String { return "hCenter(\(margin.optionnalDescription))" }
        guard let layoutSuperviewRect = layoutSuperviewRect(context) else { return self }
        setHorizontalCenter((layoutSuperviewRect.width / 2) + margin, context)
        return self
    }

    @discardableResult
    public func hCenter(_ offset: Percent) -> GSMLayout {
        func context() -> String { return "hCenter(\(offset.description))" }
        guard let layoutSuperviewRect = layoutSuperviewRect(context) else { return self }
        setHorizontalCenter((layoutSuperviewRect.width / 2) + offset.of(layoutSuperviewRect.width), context)
        return self
    }

    @discardableResult
    public func vCenter(_ margin: CGFloat = 0) -> GSMLayout {
        func context() -> String { return "vCenter(\(margin.optionnalDescription))" }
        guard let layoutSuperviewRect = layoutSuperviewRect(context) else { return self }
        setVerticalCenter((layoutSuperviewRect.height / 2) + margin, context)
        return self
    }

    @discardableResult
    public func vCenter(_ offset: Percent) -> GSMLayout {
        func context() -> String { return "vCenter(\(offset.description))" }
        guard let layoutSuperviewRect = layoutSuperviewRect(context) else { return self }
        setVerticalCenter((layoutSuperviewRect.height / 2) + offset.of(layoutSuperviewRect.height), context)
        return self
    }
    //MARK: - All
    @discardableResult
    public func all(_ margin: CGFloat = 0) -> GSMLayout {
        top(margin, { "all(\(margin.optionnalDescription)) top coordinate" })
        bottom(margin, { "all(\(margin.optionnalDescription)) bottom coordinate" })
        left(margin, { "all(\(margin.optionnalDescription)) left coordinate" })
        right(margin, { "all(\(margin.optionnalDescription)) right coordinate" })
        return self
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
