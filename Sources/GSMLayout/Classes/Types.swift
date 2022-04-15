//
//  Types.swift
//  GSMLayout
//
//  Created by Ji-hoon Ahn on 2022/04/15.
//

import Foundation

/// UIViews's anchor definition
@objc public protocol Anchor {
}


@objc public enum LayoutDirection : Int{
    case auto
    case ltr
    case rtl
}

@objc public enum GSMSafeAreaInsetsDidChangeMode : Int{
    /// GSMLayout won't call `UIView.safeAreaInsetsDidChange` on iOS 8/9/10.
    case disable
    /// GSMLayout will call `UIView.safeAreaInsetsDidChange` only if the UIView implement the GSMSafeAreaInsetsUpdate protocol.
    case optIn
    /// GSMLayout will automatically calls `UIView.safeAreaInsetsDidChange` if the view has implemented this method.
    case always
}
