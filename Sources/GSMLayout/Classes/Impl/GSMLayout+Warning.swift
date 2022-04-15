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
    
//    func warnWontBeApplied(_ text: String, _ context: Context) {
//        guard GSM.logWarnings else {return}
//        warn("\(context)")
//    }
    
    func warn(_ message : String) {
        guard GSM.logWarnings else {return}
        
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
    }
    
    
    
}
