//
//  GSM.swift
//  GSMLayout
//
//  Created by Ji-hoon Ahn on 2022/04/15.
//

import Foundation

@objc public class GSM : NSObject {
    @objc public static var layoutDirection = LayoutDirection.ltr

    #if os(iOS) || os(tvOS)
    @objc public static var safeAreaInsetsDidChangeMode: GSMSafeAreaInsetsDidChangeMode = .optIn {
        didSet {
            GSMSafeArea.safeAreaInsetsDidChangeMode = safeAreaInsetsDidChangeMode
        }
    }
    #endif

    static private var isInitialized = false

    @objc public static func initGSMLayout() {
        #if os(iOS) || os(tvOS)
        guard !GSM.isInitialized else { return }
        GSMSafeArea.initSafeAreaSupport()
        GSM.isInitialized = true
        #endif
    }

    @objc public static func layoutDirection(_ direction: LayoutDirection) {
        self.layoutDirection = direction
    }

    internal static var autoSizingInProgress: Bool = false

    //MARK: -  Warning
    #if DEBUG
        @objc public static var logWarnings = true
    #else
        @objc public static var logWarnings = false
    #endif

    @objc public static var activeWarnings = ActiveWarnings()

    @objc public static var logMissingLayoutCalls = false

    @objc public static var lastWarningText: String?

    public static func resetWarnings() {
    #if DEBUG
        logWarnings = true
    #endif
        activeWarnings = ActiveWarnings()
    }
}

//MARK: - Activity Warnings
@objc public class ActiveWarnings: NSObject{
    public var noSpaceAvailableBetweenViews = true
    public var aspectRatioImageNotSet = true
}
