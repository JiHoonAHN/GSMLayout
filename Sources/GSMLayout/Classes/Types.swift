//
//  Types.swift
//  GSMLayout
//
//  Created by Ji-hoon Ahn on 2022/04/15.
//

import Foundation

@objc public protocol Anchor{
}

@objc public protocol AnchorList{
    var topLeft: Anchor { get }
    var topCenter: Anchor { get }
    var topRight: Anchor { get }
    var centerLeft: Anchor { get }
    var center: Anchor { get }
    var centerRight: Anchor { get }
    var bottomLeft: Anchor { get }
    var bottomCenter: Anchor { get }
    var bottomRight: Anchor { get }
    
    // RTL support
    var topStart: Anchor { get }
    var topEnd: Anchor { get }
    var centerStart: Anchor { get }
    var centerEnd: Anchor { get }
    var bottomStart: Anchor { get }
    var bottomEnd: Anchor { get }
}

@objc public protocol EdgeList {
    var top: VerticalEdge { get }
    var vCenter: VerticalEdge { get }
    var bottom: VerticalEdge { get }
    var left: HorizontalEdge { get }
    var hCenter: HorizontalEdge { get }
    var right: HorizontalEdge { get }

    // RTL support
    var start: HorizontalEdge { get }
    var end: HorizontalEdge { get }
}


@objc public enum HorizontalAlign: Int {
    case left
    case center
    case right
    case none
    case start
    case end
}

@objc public enum VerticalAlign : Int{
    case top
    case center
    case bottom
    case none
}
/// UIView's horizontal edges (left/right) definition
@objc public protocol HorizontalEdge {
}

/// UIView's vertical edges (top/bottom) definition
@objc public protocol VerticalEdge {
}
public enum FitType {
    case width
    case height
    case widthFlexible
    case heightFlexible
    case content
}
@objc public enum WrapType : Int{
    case all
    case horizontally
    case vertically
}

/// UIViews's anchor definition
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
