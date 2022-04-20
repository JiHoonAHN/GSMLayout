//
//  Percent.swift
//  GSMLayout
//
//  Created by Ji-hoon Ahn on 2022/04/14.
//

#if os(iOS) || os(tvOS)
    import UIKit
#else
    import AppKit
#endif

public struct Percent {
    let value: CGFloat

    public func of(_ value: CGFloat) -> CGFloat {
        return value * self.value / 100
    }
    
    public var description: String {
        if value.truncatingRemainder(dividingBy: 1) == 0.0 {
            return "\(Int(value))%"
        } else {
            return "\(value)%"
        }
    }
}

postfix operator %

public postfix func % (v: CGFloat) -> Percent {
    return Percent(value: v)
}

public postfix func % (v: Float) -> Percent {
    return Percent(value: CGFloat(v))
}

public postfix func % (v: Double) -> Percent {
    return Percent(value: CGFloat(v))
}

public postfix func % (v: Int) -> Percent {
    return Percent(value: CGFloat(v))
}

prefix operator -
public prefix func - (p: Percent) -> Percent {
    return Percent(value: -p.value)
}
