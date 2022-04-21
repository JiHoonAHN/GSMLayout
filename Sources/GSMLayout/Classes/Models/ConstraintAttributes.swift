#if os(iOS) || os(tvOS)
    import UIKit
#else
    import AppKit
#endif

struct ConstraintAttributes : OptionSet, ExpressibleByIntegerLiteral{
    
    typealias IntegerLiteralType = UInt

    internal init(rawValue: UInt) {
        self.rawValue = rawValue
    }
    internal init(_ rawValue: UInt) {
        self.init(rawValue: rawValue)
    }
    internal init(nilLiteral: ()) {
        self.rawValue = 0
    }
    internal init(integerLiteral rawValue: IntegerLiteralType) {
        self.init(rawValue: rawValue)
    }
    
    internal private(set) var rawValue: UInt
    internal static var allZeros: ConstraintAttributes { return 0 }
    internal static func convertFromNilLiteral() -> ConstraintAttributes { return 0 }
    internal var boolValue: Bool { return self.rawValue != 0 }
    
    internal func toRaw() -> UInt { return self.rawValue }
    internal static func fromRaw(_ raw: UInt) -> ConstraintAttributes? { return self.init(raw) }
    internal static func fromMask(_ raw: UInt) -> ConstraintAttributes { return self.init(raw) }
    
    // normal
    
    internal static let none: ConstraintAttributes = 0
    internal static let left: ConstraintAttributes = ConstraintAttributes(UInt(1) << 0)
    internal static let top: ConstraintAttributes = ConstraintAttributes(UInt(1) << 1)
    internal static let right: ConstraintAttributes = ConstraintAttributes(UInt(1) << 2)
    internal static let bottom: ConstraintAttributes = ConstraintAttributes(UInt(1) << 3)
    internal static let leading: ConstraintAttributes = ConstraintAttributes(UInt(1) << 4)
    internal static let trailing: ConstraintAttributes = ConstraintAttributes(UInt(1) << 5)
    internal static let width: ConstraintAttributes = ConstraintAttributes(UInt(1) << 6)
    internal static let height: ConstraintAttributes = ConstraintAttributes(UInt(1) << 7)
    internal static let centerX: ConstraintAttributes = ConstraintAttributes(UInt(1) << 8)
    internal static let centerY: ConstraintAttributes = ConstraintAttributes(UInt(1) << 9)
    internal static let lastBaseline: ConstraintAttributes = ConstraintAttributes(UInt(1) << 10)
    
    @available(iOS 8.0, OSX 10.11, *)
    internal static let firstBaseline: ConstraintAttributes = ConstraintAttributes(UInt(1) << 11)

    @available(iOS 8.0, *)
    internal static let leftMargin: ConstraintAttributes = ConstraintAttributes(UInt(1) << 12)

    @available(iOS 8.0, *)
    internal static let rightMargin: ConstraintAttributes = ConstraintAttributes(UInt(1) << 13)

    @available(iOS 8.0, *)
    internal static let topMargin: ConstraintAttributes = ConstraintAttributes(UInt(1) << 14)

    @available(iOS 8.0, *)
    internal static let bottomMargin: ConstraintAttributes = ConstraintAttributes(UInt(1) << 15)

    @available(iOS 8.0, *)
    internal static let leadingMargin: ConstraintAttributes = ConstraintAttributes(UInt(1) << 16)

    @available(iOS 8.0, *)
    internal static let trailingMargin: ConstraintAttributes = ConstraintAttributes(UInt(1) << 17)

    @available(iOS 8.0, *)
    internal static let centerXWithinMargins: ConstraintAttributes = ConstraintAttributes(UInt(1) << 18)

    @available(iOS 8.0, *)
    internal static let centerYWithinMargins: ConstraintAttributes = ConstraintAttributes(UInt(1) << 19)
    
    // aggregates
    
    internal static let edges: ConstraintAttributes = [.horizontalEdges, .verticalEdges]
    internal static let horizontalEdges: ConstraintAttributes = [.left, .right]
    internal static let verticalEdges: ConstraintAttributes = [.top, .bottom]
    internal static let directionalEdges: ConstraintAttributes = [.directionalHorizontalEdges, .directionalVerticalEdges]
    internal static let directionalHorizontalEdges: ConstraintAttributes = [.leading, .trailing]
    internal static let directionalVerticalEdges: ConstraintAttributes = [.top, .bottom]
    internal static let size: ConstraintAttributes = [.width, .height]
    internal static let center: ConstraintAttributes = [.centerX, .centerY]
    
    @available(iOS 8.0, *)
    internal static let margins: ConstraintAttributes = [.leftMargin, .topMargin, .rightMargin, .bottomMargin]

    @available(iOS 8.0, *)
    internal static let directionalMargins: ConstraintAttributes = [.leadingMargin, .topMargin, .trailingMargin, .bottomMargin]

    @available(iOS 8.0, *)
    internal static let centerWithinMargins: ConstraintAttributes = [.centerXWithinMargins, .centerYWithinMargins]
    
    
}