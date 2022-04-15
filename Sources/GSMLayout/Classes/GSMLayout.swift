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
    let view : UIView
    let keepTransform: Bool

    var isLayouted = false

    
    init(view : UIView,keepTransform : Bool){
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
                return UIEdgeInsets() //MARK: <- 수정해야됨
            }
        }
    }
    #endif
    
}
