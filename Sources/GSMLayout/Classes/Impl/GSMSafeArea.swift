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
    
    fileprivate static func setViewSafeAreaInsets(view: UIView, insets: UIEdgeInsets, recursiveLevel: Int = 0) {
        if #available(iOS 11.0, tvOS 11.0, *) { assertionFailure() }
        view.gsmlayoutSafeAreaInsets = insets

        guard recursiveLevel > 0 else { return }
        for subview in view.subviews {
            guard !(view is UIScrollView) else { return }  // scrollview's children don't have safeAreaInsets

            let subviewSafeAreaInsets = getViewSafeAreaInsets(view: subview, parent: view, parentSafeArea: insets)
            setViewSafeAreaInsets(view: subview, insets: subviewSafeAreaInsets, recursiveLevel: recursiveLevel - 1)
        }
    }
    
    
    fileprivate static func getViewSafeAreaInsets(view: UIView, parent: UIView, parentSafeArea: UIEdgeInsets) -> UIEdgeInsets {
        let topInsetValue = max(min(parentSafeArea.top - view.frame.origin.y, parentSafeArea.top), 0)
        let bottomInsetValue = max(min(view.frame.maxY - parent.bounds.size.height + parentSafeArea.bottom, parentSafeArea.bottom), 0)

        return UIEdgeInsets(top: topInsetValue, left: 0, bottom: bottomInsetValue, right: 0)
    }
    
    fileprivate static func handleSafeAreaInsetsDidChange(view: UIView) {
        guard let currentMode = currentSafeAreaInsetsDidChangeMode else { return }
        switch currentMode {
        case .disable:
            break
        case .optIn:
            if let updatable = view as? GSMSafeAreaInsetsUpdate {
                updatable.safeAreaInsetsDidChange()
            }
        case .always:
            let methodName = "safeAreaInsetsDidChange"
            if let safeAreaInsetsDidChangeMethod = extractMethodFrom(owner: view, selector: Selector(methodName)) {
                safeAreaInsetsDidChangeMethod()
            }
        }
    }
    
    typealias Function = @convention(c) (AnyObject, Selector) -> Void
    private static func extractMethodFrom(owner: AnyObject, selector: Selector) -> (() -> Void)? {
        guard let method = owner is AnyClass ? class_getClassMethod((owner as! AnyClass), selector) :
            class_getInstanceMethod(type(of: owner), selector)
            else { return nil }
        let implementation = method_getImplementation(method)

        let function = unsafeBitCast(implementation, to: Function.self)

        return {
            function(owner, selector)
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
            if #available(iOS 11.0 , tvOS 11.0, *){ return assertionFailure() }
            let didChange : Bool = gsmlayoutSafeAreaInsets != newValue
            objc_setAssociatedObject(self, &gsmlayoutAssociatedKeys.gsmlayoutSafeAreaInsets, newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_COPY_NONATOMIC)
            
            if didChange{
                GSMSafeArea.handleSafeAreaInsetsDidChange(view: self)
            }
        }
    }
    
    
    
    func gsmlayoutComputeSafeAreaInsets() -> UIEdgeInsets{
        if #available(iOS 11.0, tvOS 11.0, *){assertionFailure()}
        
        if self.next as? UIViewController != nil{
            return self.gsmlayoutSafeAreaInsets
        }else{
            var stack : [UIView] = [self]
            var topParent = self
            while(topParent.next as? UIViewController) == nil{
                guard let parent = topParent.superview else {return .zero}
                guard !(parent is UIScrollView) else {return.zero}
                topParent = parent
                
                if (topParent.next as? UIViewController) == nil{
                    stack.append(topParent)
                }
            }
            var safeAreaInsets = topParent.gsmlayoutSafeAreaInsets

            while let currentView = stack.popLast() {
                
                safeAreaInsets = GSMSafeArea.getViewSafeAreaInsets(view: currentView, parent: topParent, parentSafeArea: safeAreaInsets)
                currentView.gsmlayoutSafeAreaInsets = safeAreaInsets

                topParent = currentView
            }
            return safeAreaInsets
        }
    }
}

#endif
