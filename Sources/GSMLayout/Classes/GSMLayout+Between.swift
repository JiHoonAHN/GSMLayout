//
//  GSMLayout+Between.swift
//  GSMLayout
//
//  Created by Ji-hoon Ahn on 2022/04/19.
//

#if os(iOS) || os(tvOS)
    import UIKit
#else
    import AppKit
#endif
    
extension GSMLayout {

    //
    // horizontallyBetween(...)
    //
    @discardableResult
    public func horizontallyBetween(_ view1: View, and view2: View, aligned: VerticalAlign = .none) -> GSMLayout {
        func context() -> String { return betweenContext("horizontallyBetween", view1, view2, aligned) }
        guard self.view != view1 && self.view != view2 else {
            warnWontBeApplied("the view being layouted cannot be used as one of the references.", context)
            return self
        }

        guard view1 != view2 else {
            warnWontBeApplied("reference views must be different.", context)
            return self
        }

        let anchors: [Anchor]
        switch aligned {
        case .top:    anchors = [view1.anchor.topLeft, view1.anchor.topRight, view2.anchor.topLeft, view2.anchor.topRight]
        case .center: anchors = [view1.anchor.centerLeft, view1.anchor.centerRight, view2.anchor.centerLeft, view2.anchor.centerRight]
        case .bottom: anchors = [view1.anchor.bottomLeft, view1.anchor.bottomRight, view2.anchor.bottomLeft, view2.anchor.bottomRight]
        case .none:   anchors = [view1.anchor.topLeft, view1.anchor.topRight, view2.anchor.topLeft, view2.anchor.topRight]
        }

        guard let coordinates = computeCoordinates(forAnchors: anchors, context),
            coordinates.count == anchors.count else { return self }

        let view1MinX = coordinates[0].x
        let view1MaxX = coordinates[1].x
        let view2MinX = coordinates[2].x
        let view2MaxX = coordinates[3].x

        if view1MaxX <= view2MinX {
            setLeft(view1MaxX, context)
            setRight(view2MinX, context)
            applyVerticalAlignment(aligned, coordinates: [coordinates[0]], context: context)
        } else if view2MaxX <= view1MinX {
            setLeft(view2MaxX, context)
            setRight(view1MinX, context)
            applyVerticalAlignment(aligned, coordinates: [coordinates[1]], context: context)
        } else {
            guard GSM.logWarnings && GSM.activeWarnings.noSpaceAvailableBetweenViews else { return self }
            warnWontBeApplied("there is no horizontal space between these views. (noSpaceAvailableBetweenViews)", context)
        }

        return self
    }

    //
    // verticallyBetween(...)
    //
    @discardableResult
    public func verticallyBetween(_ view1: View, and view2: View, aligned: HorizontalAlign = .none) -> GSMLayout {
        func context() -> String { return betweenContext("verticallyBetween", view1, view2, aligned) }
        guard self.view != view1 && self.view != view2 else {
            warnWontBeApplied("the view being layouted cannot be used as one of the references.", context)
            return self
        }

        guard view1 != view2 else {
            warnWontBeApplied("reference views must be different.", context)
            return self
        }

        let anchors: [Anchor]
        switch aligned {
        case .left:   anchors = [view1.anchor.topLeft, view1.anchor.bottomLeft, view2.anchor.topLeft, view2.anchor.bottomLeft]
        case .center: anchors = [view1.anchor.topCenter, view1.anchor.bottomCenter, view2.anchor.topCenter, view2.anchor.bottomCenter]
        case .right:  anchors = [view1.anchor.topRight, view1.anchor.bottomRight, view2.anchor.topRight, view2.anchor.bottomRight]
        case .start:  anchors = isLTR() ?
                                  [view1.anchor.topLeft, view1.anchor.bottomLeft, view2.anchor.topLeft, view2.anchor.bottomLeft] :
                                  [view1.anchor.topRight, view1.anchor.bottomRight, view2.anchor.topRight, view2.anchor.bottomRight]
        case .end:    anchors = isLTR() ?
                                  [view1.anchor.topRight, view1.anchor.bottomRight, view2.anchor.topRight, view2.anchor.bottomRight] :
                                  [view1.anchor.topLeft, view1.anchor.bottomLeft, view2.anchor.topLeft, view2.anchor.bottomLeft]
        case .none:   anchors = [view1.anchor.topLeft, view1.anchor.bottomLeft, view2.anchor.topLeft, view2.anchor.bottomLeft]
        }

        guard let coordinates = computeCoordinates(forAnchors: anchors, context),
            coordinates.count == anchors.count else { return self }

        let view1MinY = coordinates[0].y
        let view1MaxY = coordinates[1].y
        let view2MinY = coordinates[2].y
        let view2MaxY = coordinates[3].y

        if view1MaxY <= view2MinY {
            setTop(view1MaxY, context)
            setBottom(view2MinY, context)
            applyHorizontalAlignment(aligned, coordinates: [coordinates[0]], context: context)
        } else if view2MaxY <= view1MinY {
            setTop(view2MaxY, context)
            setBottom(view1MinY, context)
            applyHorizontalAlignment(aligned, coordinates: [coordinates[1]], context: context)
        } else {
            guard GSM.logWarnings && GSM.activeWarnings.noSpaceAvailableBetweenViews else { return self }
            warnWontBeApplied("there is no vertical space between these views. (noSpaceAvailableBetweenViews)", context)
        }

        return self
    }
}

// MARK: private
extension GSMLayout {
    fileprivate func betweenContext(_ type: String, _ view1: View, _ view2: View, _ aligned: HorizontalAlign) -> String {
        return betweenContext(type, view1, view2, aligned: aligned == HorizontalAlign.none ? nil : aligned.description)
    }

    fileprivate func betweenContext(_ type: String, _ view1: View, _ view2: View, _ aligned: VerticalAlign) -> String {
        return betweenContext(type, view1, view2, aligned: aligned == VerticalAlign.none ? nil : aligned.description)
    }

    private func betweenContext(_ type: String, _ view1: View, _ view2: View, aligned: String?) -> String {
        if let aligned = aligned {
            return "\(type)(\(viewDescription(view1)), \(viewDescription(view1)), aligned: .\(aligned))"
        } else {
            return "\(type)(\(viewDescription(view1)), \(viewDescription(view1)))"
        }
    }
}
