//
//  SizeCalculable.swift
//  GSMLayout
//
//  Created by Ji-hoon Ahn on 2022/04/15.
//

#if os(iOS) || os(tvOS)
import UIKit
#else
import AppKit
#endif

public protocol SizeCalculable {
    func sizeThatFits(_ size: CGSize) -> CGSize
}
