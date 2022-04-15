//
//  GSM.swift
//  GSMLayout
//
//  Created by Ji-hoon Ahn on 2022/04/15.
//

import Foundation

@objc public class GSM : NSObject{
    
    static private var isInitialized = false
    
    @objc public static func initGSMLayout() {
        #if os(iOS) || os(tvOS)
        guard !GSM.isInitialized else { return }
        GSM.isInitialized = true
        #endif
    }

}
