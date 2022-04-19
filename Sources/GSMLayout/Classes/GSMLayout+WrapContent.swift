//
//  GSMLayout+WrapContent.swift
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

    @discardableResult
    public func wrapContent() -> GSMLayout {
        return wrapContent(.all, padding: PEdgeInsets(top: 0, left: 0, bottom: 0, right: 0), { return "wrapContent()" })
    }

 
    @discardableResult
    public func wrapContent(padding: CGFloat) -> GSMLayout {
        return wrapContent(.all, padding: PEdgeInsets(top: padding, left: padding, bottom: padding, right: padding), { return "wrapContent(padding: \(padding)" })
    }
    

    @discardableResult
    public func wrapContent(padding: PEdgeInsets) -> GSMLayout {
        return wrapContent(.all, padding: padding, { return "wrapContent(padding: \(insetsDescription(padding))" })
    }

   
    @discardableResult
    public func wrapContent(_ type: WrapType) -> GSMLayout {
        return wrapContent(type, padding: PEdgeInsets(top: 0, left: 0, bottom: 0, right: 0), { return "wrapContent(\(type.description)" })
    }


    @discardableResult
    public func wrapContent(_ type: WrapType, padding: CGFloat) -> GSMLayout {
        return wrapContent(type, padding: PEdgeInsets(top: padding, left: padding, bottom: padding, right: padding), { return "wrapContent(\(type.description), padding: \(padding)" })
    }

  
    @discardableResult
    public func wrapContent(_ type: WrapType, padding: PEdgeInsets) -> GSMLayout {
        return wrapContent(type, padding: padding, { return "wrapContent(\(type.description), padding: \(insetsDescription(padding))" })
    }

    private func wrapContent(_ type: WrapType, padding: PEdgeInsets, _ context: Context) -> GSMLayout {
        let subviews = view.subviews
        guard !subviews.isEmpty else { return self }

        let firstViewRect = subviews[0].getRect(keepTransform: keepTransform)
        let boundingRect = subviews.reduce(firstViewRect, { (result, view) in
            result.union(view.getRect(keepTransform: keepTransform))
        })

        var offsetDx: CGFloat = 0
        var offsetDy: CGFloat = 0

        if type == .all || type == .horizontally {
            let contentWidth = boundingRect.width + padding.left + padding.right
            if contentWidth >= 0 {
                setWidth(contentWidth, context)
            }

            offsetDx = -boundingRect.minX + padding.left
        }

        if type == .all || type == .vertically {
            let contentHeight = boundingRect.height + padding.top + padding.bottom
            if contentHeight >= 0 {
                setHeight(contentHeight, context)
            }

            offsetDy = -boundingRect.minY + padding.top
        }

        if offsetDx != 0 || offsetDy != 0 {
            subviews.forEach { (view) in
                let viewRect = view.getRect(keepTransform: keepTransform)
                let newRect = viewRect.offsetBy(dx: offsetDx, dy: offsetDy)
                view.setRect(newRect, keepTransform: keepTransform)
            }
        }

        return self
    }
}
