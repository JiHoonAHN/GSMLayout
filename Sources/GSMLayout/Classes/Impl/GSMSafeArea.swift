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

extension UIView{
    fileprivate struct gsmlayoutAssociatedKeys {
        static var gsmlayoutSafeAreaInsets = UnsafeMutablePointer<Int8>.allocate(capacity: 1)
    }
    
    fileprivate(set) var gsmlayoutSafeAreaInsets: UIEdgeInsets {
        get{
            if #available(iOS 11.0, tvOS 11.0, *) { assertionFailure() }
            
            if GSMSafeArea.currentSafeAreaInsetsDidChangeMode == nil || GSMSafeArea.currentSafeAreaInsetsDidChangeMode == .disable{
                if let viewController = self.next as? UIViewController{
                    if #available(iOS 11.0, tvOS 11.0, *) {
                        return UIEdgeInsets(top: viewController.topLayoutGuide.length, left: 0, bottom: viewController.bottomLayoutGuide.length, right: 0)
                    }else{
                        return UIEdgeInsets(top: viewController.topLayoutGuide.length, left: 0,
                                            bottom: viewController.bottomLayoutGuide.length, right: 0)
                    }
                }else{
                    return.zero
                }
            }else{
                return objc_getAssociatedObject(self, &gsmlayoutAssociatedKeys.gsmlayoutSafeAreaInsets) as? UIEdgeInsets ?? .zero
            }
        }
        set{
            
        }
    }
    
    
    
    //    func gsmlayoutComputeSafeAreaInsets() -> UIEdgeInsets{
    //        if #available(iOS 11.0, tvOS 11.0, *){
    //            return
    //        }else{
    //
    //        }
    //    }
}

#endif
