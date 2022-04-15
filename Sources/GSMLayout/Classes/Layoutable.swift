//
//  Layoutable.swift
//  GSMLayout
//
//  Created by Ji-hoon Ahn on 2022/04/15.
//

#if os(iOS) || os(tvOS)
import UIKit
#else
import AppKit
#endif

public protocol Layoutable: AnyObject, Equatable, CustomDebugStringConvertible {
    associatedtype View: Layoutable

    var superview: View? { get }
    var subviews: [View] { get }

    func getRect(keepTransform: Bool) -> CGRect
    func setRect(_ rect: CGRect, keepTransform: Bool)

    func convert(_ point: CGPoint, to view: View?) -> CGPoint

    func isLTR() -> Bool
}
