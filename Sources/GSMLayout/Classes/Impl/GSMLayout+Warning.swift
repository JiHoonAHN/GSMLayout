//
//  GSMLayout+Warning.swift
//  GSMLayout
//
//  Created by Ji-hoon Ahn on 2022/04/15.
//

#if os(iOS) || os(tvOS)
import UIKit
#else
import AppKit
#endif

private var numberFormatter: NumberFormatter = {
    let numberFormatter = NumberFormatter()
    numberFormatter.numberStyle = .decimal
    numberFormatter.decimalSeparator = "."
    return numberFormatter
}()

extension GSMLayout{
    
     func pointContext(method: String, point: CGPoint) -> String {
        return "\(method)(to: CGPoint(x: \(point.x), y: \(point.y)))"
    }
    
     func relativeEdgeContext(method: String, edge: VerticalEdge) -> String {
        let edge = edge as! VerticalEdgeImpl<View>
        return "\(method)(to: .\(edge.type.rawValue), of: \(viewDescription(edge.view)))"
    }
    
     func relativeEdgeContext(method: String, edge: HorizontalEdge) -> String {
        let edge = edge as! HorizontalEdgeImpl<View>
        return "\(method)(to: .\(edge.type.rawValue), of: \(viewDescription(edge.view))"
    }
    
     func relativeAnchorContext(method: String, anchor: Anchor) -> String {
        let anchor = anchor as! AnchorImpl<View>
        return "\(method)(to: .\(anchor.type.rawValue), of: \(viewDescription(anchor.view)))"
    }
    
    func warnWontBeApplied(_ message: String, _ context: Context) {
        guard GSM.logWarnings else {return}
        warn("\(context()) won't be applied, \(message)")
    }
    
    func warn(_ message : String) {
        guard GSM.logWarnings else {return}
        gsmLayoutConsoleWarning("GSMLayout Warning: \(message)", view)
    }
    internal func warnPropertyAlreadySet(_ propertyName: String, propertyValue: CGFloat, _ context: Context) {
        guard GSM.logWarnings else { return }
        gsmLayoutConsoleWarning("GSMLayout Conflict: \(context()) won't be applied since it value has already been set to \(propertyValue.description).", view)
    }
    
    internal func warnPropertyAlreadySet(_ propertyName: String, propertyValue: CGSize, _ context: Context) {
        guard GSM.logWarnings else { return }
        gsmLayoutConsoleWarning("GSMLayout Conflict: \(context()) won't be applied since it value has already been set to CGSize(width: \(propertyValue.width.description), height: \(propertyValue.height.description)).", view)
    }
    
    func warnConflict(_ context : Context, _ properties : [String : Any]){
        guard GSM.logWarnings else {return}
        var warning = "GSMLayout Conflict: \(context()) won't be applied since it conflicts with the following already set properties:"
        properties.forEach{
            warning += "\n \($0.key): "
            if let floatValue = $0.value as? CGFloat {
                warning += "\(floatValue.description)"
            } else {
                warning += "\($0.value)"
            }
        }
        gsmLayoutConsoleWarning(warning, view)
    }
    
    func displayLayoutWarnings() {
        if !Thread.isMainThread {
            warn("Layout must be executed from the Main Thread!")
        }
        
        if let justify = justify {
            func context() -> String { return "justify(.\(justify.description))" }
            if !((_left != nil && _right != nil) || (shouldGSMEdges && width != nil && (_left != nil || _right != nil || _hCenter != nil))) {
                warnWontBeApplied("the left and right coordinates must be set to justify the view horizontally.", context)
            }
            
            if _hCenter != nil {
                warnWontBeApplied("justification is not applied when hCenter has been set. By default the view will be centered around the hCenter.", context)
            }
        }
        
        if let align = align {
            func context() -> String { return "align(.\(align.description))" }
            if !((_top != nil && _bottom != nil) || (shouldGSMEdges && height != nil && (_top != nil || _bottom != nil || _vCenter != nil))) {
                warnWontBeApplied("the top and bottom coordinates must be set to align the view vertically.", context)
            }
            
            if _vCenter != nil {
                warnWontBeApplied("alignment is not applied when vCenter has been set. By default the view will be centered around the specified vCenter.", context)
            }
        }
    }
    
    func viewDescription(_ view: View) -> String {
        let rect = view.getRect(keepTransform: keepTransform)
        return "(\(viewName(view)), Frame: \(rect))"
    }
    
    func viewName(_ view: View) -> String {
        return "\(type(of: view))"
    }
    
    func insetsDescription(_ insets: PEdgeInsets) -> String {
        return "UIEdgeInsets(top: \(insets.top), left: \(insets.left), bottom: \(insets.bottom), right: \(insets.right))"
    }
    
    func gsmLayoutConsoleWarning(_ message : String ,_ view : View){
        var displayText = "\n⚠️ \(message)"
        
        let rect = view.getRect(keepTransform: keepTransform)
        let x = numberFormatter.string(from: NSNumber(value: Float(rect.origin.x)))!
        let y = numberFormatter.string(from: NSNumber(value: Float(rect.origin.y)))!
        let width = numberFormatter.string(from: NSNumber(value: Float(rect.size.width)))!
        let height = numberFormatter.string(from: NSNumber(value: Float(rect.size.height)))!
        let viewName = "\(type(of: view))"
        displayText += "\n(Layouted view info: Type: \(viewName), Frame: x: \(x), y: \(y), width: \(width), height: \(height))"
        
        var currentView = view
        var hierarchy : [String] = []
        while let parent = currentView.superview{
            hierarchy.insert("\(type(of: parent))", at: 0)
            currentView = parent as! View
        }
        if hierarchy.count > 0 {
            #if swift(>=4.1)
            displayText += ", Superviews: \(hierarchy.compactMap({ $0 }).joined(separator: " -> "))"
            #else
            displayText += ", Superviews: \(hierarchy.flatMap({ $0 }).joined(separator: " -> "))"
            #endif
        }
        displayText += ", Debug description: \(view.debugDescription))\n"

        print(displayText)
        GSM.lastWarningText = message
    }
}
