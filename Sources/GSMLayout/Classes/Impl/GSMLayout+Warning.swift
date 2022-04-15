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
    
    func warn(_ message : String) {
        guard GSM.logWarnings else {return}
        
    }
    
    
    func gsmLayoutConsoleWarning(_ message : String ,_ view : UIView){
        var displayText = "\n⚠️ \(message)"
        
        
        
    }
    
    
    
}
