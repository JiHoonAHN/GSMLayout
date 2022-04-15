//
//  GSM.swift
//  GSMLayout
//
//  Created by Ji-hoon Ahn on 2022/04/15.
//

import Foundation

@objc public class GSM : NSObject{
    @objc public static var layoutDirection = LayoutDirection.ltr
    
    static private var isInitialized = false
    
    @objc public static func initGSMLayout() {
        #if os(iOS) || os(tvOS)
        guard !GSM.isInitialized else { return }
        GSMSafeArea.initSafeAreaSupport()
        GSM.isInitialized = true
        #endif
    }
    
    @objc public static func layoutDirection(_ direction : LayoutDirection){
        layoutDirection = direction
    }

    internal static var autoSizingInProgress: Bool = false
    
    //MARK: - Warning
    #if DEBUG
        @objc public static var logWarnings = true
    #else
        @objc public static var logWarnings = false
    #endif

    @objc public static var activeWarnings = ActiveWarnings()

    @objc public static var logMissingLayoutCalls = false
    
    // Contains GSMLayout last warning's text. Used by GSMLayout's Unit Tests.
    @objc public static var lastWarningText: String?
    
    public static func resetWarnings() {
    #if DEBUG
        logWarnings = true
    #endif
        activeWarnings = ActiveWarnings()
    }
}
//MARK: - Activity Warnings
@objc public class ActiveWarnings : NSObject{
    /// When set to true, a warning is displayed if there is no space available between views
    /// specified in a call to `horizontallyBetween(...)` or `verticallyBetween(...)`.
    public var noSpaceAvailableBetweenViews = true

    /// When set to true, a warning is displayed if 'aspectRatio()' is called on a UIImageView without a valid UIImage.
    public var aspectRatioImageNotSet = true
}
