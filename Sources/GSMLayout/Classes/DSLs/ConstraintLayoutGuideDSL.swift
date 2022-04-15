//
//  ConstraintLayoutGuideDSL.swift
//  GSMLayout
//
//  Created by Ji-hoon Ahn on 2022/04/15.
//

#if os(iOS) || os(tvOS)
import UIKit
#else
import AppKit
#endif

@available(iOS 9.0, OSX 10.11, *)
final class ConstraintLayoutGuideDSL<View : Layoutable>{
    
    @discardableResult
    public func makeConstraints(_ closure: (_ make : Void) -> Void){
        
    }
}
