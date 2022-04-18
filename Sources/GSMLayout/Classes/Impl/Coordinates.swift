//
//  Coordinates.swift
//  GSMLayout
//
//  Created by Ji-hoon Ahn on 2022/04/15.
//

#if os(iOS) || os(tvOS)
import UIKit
#else
import AppKit
#endif

internal var displayScale: CGFloat = getDisplayScale()
internal var onePixelLength: CGFloat = 1 / displayScale

public func _gsmlayoutSetUnitTest(scale: CGFloat?) {
    if let scale = scale {
        displayScale = scale
    } else {
        displayScale = getDisplayScale()
    }
}

final class Coordinates<View: Layoutable>{
    
    
}


private func getDisplayScale() -> CGFloat {
    #if os(iOS) || os(tvOS)
        return UIScreen.main.scale
    #elseif os(OSX)
        #if swift(>=4.1)
        return NSScreen.main?.backingScaleFactor ?? 2.0
        #else
        return NSScreen.main()?.backingScaleFactor ?? 2.0
        #endif
    #endif
}
