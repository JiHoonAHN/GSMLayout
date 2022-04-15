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
            
        }
        
    }
    
    
}
