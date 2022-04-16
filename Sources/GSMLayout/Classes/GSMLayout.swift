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
    public func makeConstraints(_ closure: () -> Void) {
        
    }
    
    @discardableResult
    public func remakeConstraints(_ closure: () -> Void) {
        
    }
    
    @discardableResult
    public func updateConstraints(_ closure: () -> Void) {
        
    }
    
    @discardableResult
    public func removeConstraints() {
        
    }
    
    
}
