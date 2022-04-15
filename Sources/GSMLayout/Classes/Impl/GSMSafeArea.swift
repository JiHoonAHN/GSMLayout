//
//  GSMSafeArea.swift
//  GSMLayout
//
//  Created by Ji-hoon Ahn on 2022/04/15.
//

#if os(iOS) || os(tvOS)
import UIKit
import ObjectiveC

@available(iOS 7.0 , *)
public protocol GSMSafeAreaInsetsUpdate{
    func safeAreaInsetsDidChange()
}

internal class GSMSafeArea{
    fileprivate static var currentSafeAreaInsetsDidChangeMode : GSMSafeAreaInsetsDidChangeMode?
    
    internal static var safeAreaInsetsDidChangeMode : GSMSafeAreaInsetsDidChangeMode = .disable{
        didSet{
            guard safeAreaInsetsDidChangeMode != currentSafeAreaInsetsDidChangeMode else {return}
            
            switch safeAreaInsetsDidChangeMode{
            case .disable:
                if currentSafeAreaInsetsDidChangeMode != nil && currentSafeAreaInsetsDidChangeMode != .disable {
                    
                }
            case .optIn, .always:
                if currentSafeAreaInsetsDidChangeMode == nil || currentSafeAreaInsetsDidChangeMode == .disable {
                    if #available(iOS 11.0, tvOS 11.0, *) {
                        // Do nothing, let the iOS 11+ safeAreaInsets mecanism do his thing
                    } else {

                    }
                }
            }
            currentSafeAreaInsetsDidChangeMode = safeAreaInsetsDidChangeMode
        }
    }
    
    internal static func initSafeAreaSupport() {
        if #available(iOS 11.0, tvOS 11.0, *) {
            // noop on iOS 11, `UIView.safeAreaInsetsDidChange` is natively supported
        } else {
            guard currentSafeAreaInsetsDidChangeMode == nil else { return }
            GSMSafeArea.safeAreaInsetsDidChangeMode = .always
        }
    }
}

#endif
