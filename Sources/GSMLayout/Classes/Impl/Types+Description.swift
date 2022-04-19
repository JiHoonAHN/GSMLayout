//
//  Types+Description.swift
//  GSMLayout
//
//  Created by Ji-hoon Ahn on 2022/04/19.
//

#if os(iOS) || os(tvOS)
import UIKit
#else
import AppKit
#endif

extension HorizontalAlign {
    var description: String {
        switch self {
        case .left: return "left"
        case .center: return "center"
        case .right: return "right"
        case .start: return "start"
        case .end: return "end"
        case .none: return "none"
        }
    }
}

extension VerticalAlign {
    var description: String {
        switch self {
        case .top: return "top"
        case .center: return "center"
        case .bottom: return "bottom"
        case .none: return "none"
        }
    }
}

extension CGFloat {
    var description: String {
        if self.truncatingRemainder(dividingBy: 1) == 0.0 {
            return "\(Int(self))"
        } else {
            return "\(self)"
        }
    }

    var optionnalDescription: String {
        return self == 0 ? "" : self.description
    }
}

extension FitType {
    var description: String {
        switch self {
        case .width: return ".width"
        case .height: return ".height"
        case .widthFlexible: return ".widthFlexible"
        case .heightFlexible: return ".heightFlexible"
        case .content: return ""
        }
    }
}

extension WrapType {
    var description: String {
        switch self {
        case .all: return ".all"
        case .horizontally: return ".horizontally"
        case .vertically: return ".vertically"
        }
    }
}
