//
//  GSMLayout+Size.swift
//  GSMLayout
//
//  Created by Ji-hoon Ahn on 2022/04/19.
//

#if os(iOS) || os(tvOS)
import UIKit
#else
import AppKit
#endif

enum AdjustSizeType {
    case fitTypeWidth
    case fitTypeHeight
    case fitTypeWidthFlexible
    case fitTypeHeightFlexible
    case fitTypeContent
    
    case aspectRatio(CGFloat)
    
    var isFlexible: Bool {
        if case .fitTypeWidthFlexible = self {
            return true
        } else if case .fitTypeHeightFlexible = self {
            return true
        } else {
            return false
        }
    }
    
    internal var requiresSizeCalculable: Bool {
        switch self {
        case .fitTypeWidth, .fitTypeHeight,
                .fitTypeWidthFlexible, .fitTypeHeightFlexible,
                .fitTypeContent:
            return true
        case .aspectRatio(_):
            return false
        }
    }
    
    func toFitType() -> FitType? {
        switch self {
        case .fitTypeWidth: return .width
        case .fitTypeHeight: return .height
        case .fitTypeWidthFlexible: return .widthFlexible
        case .fitTypeHeightFlexible: return .heightFlexible
        default: return nil
        }
    }
}

extension FitType {
    func toAdjustSizeType() -> AdjustSizeType {
        switch self {
        case .width: return .fitTypeWidth
        case .height: return .fitTypeHeight
        case .widthFlexible: return .fitTypeWidthFlexible
        case .heightFlexible: return .fitTypeHeightFlexible
        case .content: return .fitTypeContent
        }
    }
}

extension GSMLayout{
    @discardableResult
    public func size(_ size: CGSize) -> GSMLayout {
        return setSize(size, { return "size(CGSize(width: \(size.width), height: \(size.height)))" })
    }
    
    @discardableResult
    public func size(_ sideLength: CGFloat) -> GSMLayout {
        return setSize(CGSize(width: sideLength, height: sideLength), { return "size(sideLength: \(sideLength))" })
    }
    
    @discardableResult
    public func size(_ percent: Percent) -> GSMLayout {
        func context() -> String { return "size(\(percent.description))" }
        guard let layoutSuperviewRect = layoutSuperviewRect(context) else { return self }
        let size = CGSize(width: percent.of(layoutSuperviewRect.width), height: percent.of(layoutSuperviewRect.height))
        return setSize(size, context)
    }
    
    @discardableResult
    public func size(of view: View) -> GSMLayout {
        func context() -> String { return "size(of \(viewDescription(view)))" }
        return setSize(view.getRect(keepTransform: keepTransform).size, context)
    }
    
    
    @discardableResult
    public func aspectRatio(of view: View) -> GSMLayout {
        let rect = view.getRect(keepTransform: keepTransform)
        return setAdjustSizeType(.aspectRatio(rect.width / rect.height), { "aspectRatio(of: \(viewDescription(view)))" })
    }
    
    
#if os(iOS) || os(tvOS)
    @discardableResult
    public func aspectRatio() -> GSMLayout {
        func context() -> String { return "aspectRatio()" }
        guard let imageView = view as? UIImageView else {
            warnWontBeApplied("the layouted view must be an UIImageView() to use the aspectRatio() method without parameter.", context)
            return self
        }
        
        guard let imageSize = imageView.image?.size else {
            guard GSM.logWarnings && GSM.activeWarnings.aspectRatioImageNotSet else { return self }
            warnWontBeApplied("the layouted UIImageView's image hasn't been set (aspectRatioImageNotSet)", context)
            return self
        }
        
        return setAdjustSizeType(.aspectRatio(imageSize.width / imageSize.height), context)
    }
#endif
    
    
    @discardableResult
    public func sizeToFit(_ fitType: FitType = .content) -> GSMLayout {
        return setAdjustSizeType(fitType.toAdjustSizeType(), { return "sizeToFit(\(fitType.description))" })
    }
}

//MARK: - Private Method
extension GSMLayout {
    func setSize(_ size: CGSize, _ context: Context) -> GSMLayout {
        setWidth(size.width, { return "\(context())'s width" })
        setHeight(size.height, { return "\(context())'s height" })
        return self
    }
    
    func setAdjustSizeType(_ type: AdjustSizeType?, _ context: Context) -> GSMLayout {
        guard adjustSizeType == nil else {
            warnAdjustSizeConflict(context: context)
            return self
        }
        
        if let type = type {
            if case let AdjustSizeType.aspectRatio(ratio) = type, ratio <= 0 {
                warnWontBeApplied("the aspectRatio (\(ratio)) must be greater than zero.", context)
                return self
            } else if type.requiresSizeCalculable, !(view is SizeCalculable) {
                warnWontBeApplied("GSMLayout cannot comptute this view's size. This type of views doesn't conform to the protocol SizeCalculable.", context)
                return self
            }
        }
        
        adjustSizeType = type
        
        return self
    }
    
    private func warnAdjustSizeConflict(context: Context) {
        guard let adjustSizeType = adjustSizeType else { return }
        let conflict: String
        switch adjustSizeType {
        case .fitTypeWidth, .fitTypeHeight, .fitTypeWidthFlexible, .fitTypeHeightFlexible, .fitTypeContent:
            conflict = "sizeToFit(\(adjustSizeType.toFitType()!.description))."
        case .aspectRatio(let ratio):
            conflict = "aspectRatio(\(ratio))"
        }
        
        warn("GSMLayout Conflict: \(context()) won't be applied since it conflicts with \(conflict).")
    }
}
