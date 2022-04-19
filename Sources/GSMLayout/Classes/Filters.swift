//
//  Filters.swift
//  GSMLayout
//
//  Created by Ji-hoon Ahn on 2022/04/18.
//

#if os(iOS) || os(tvOS)
import UIKit

// Filter out all hidden views (isHidden is true or alpha is 0)
public func visible(_ views: [UIView]) -> [UIView] {
    return views.filter({ !$0.isHidden && $0.alpha > 0 })
}

#endif
