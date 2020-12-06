//
//  FeedbackGenerator.swift
//
//  Created by Srdjan Spasojevic on 12/13/18.
//  Copyright © 2018 Srdjan Spasojevic. All rights reserved.
//

import UIKit
import AudioToolbox.AudioServices

enum FeedbackType {
    /**
     Selection Change - Date picker changing values haptic feedback
     iOS 10 required
     */
    case selectionChange
    /**
     Light Impact - iOS 10 required
     */
    case lightImpact
    /**
     Medium Impact - iOS 10 required
     */
    case mediumImpact
    /**
     Heavy Impact - iOS 10 required
     */
    case heavyImpact
    /**
     Success - iOS 10 required
     */
    case success
    /**
     Error - iOS 10 required
     */
    case error
    /**
     Warning - iOS 10 required
     */
    case warning
    /**
     Peek - iOS 10 required
     */
    case peek
    /**
     Pop
     */
    case pop
    /**
     Cancelled -
     */
    case cancelled
    /**
     Try Again -
     */
    case tryAgain
    /**
     Failed - Failed login vibration feedback
     */
    case failed
}

/**
 Feedback Generator - Generate Haptic (Vibration) Feedback
 */
class FeedbackGenerator {
    // MARK: Public methods
    /**
     Generate Haptic Feedback Of Given Type
     
     Some of FeedbackType's are available only on iOS 10.0 or higher. (success, error, warning, selectionChange, light-mediun-heavy impact require iOS 10.0 or higher. peek, pop, cancelled, tryAgain, failed require iOS 9.0 or higher)
     */
    static public func generateFeedback(of type: FeedbackType) {
        if type == .success && iOS10Available {
            let success = UINotificationFeedbackGenerator()
            success.prepare()
            success.notificationOccurred(.success)
        } else if type == .error && iOS10Available {
            let error = UINotificationFeedbackGenerator()
            error.prepare()
            error.notificationOccurred(.error)
        } else if type == .warning && iOS10Available {
            let warning = UINotificationFeedbackGenerator()
            warning.prepare()
            warning.notificationOccurred(.warning)
        } else if type == .selectionChange && iOS10Available {
            let selection = UISelectionFeedbackGenerator()
            selection.prepare()
            selection.selectionChanged()
        } else if type == .lightImpact && iOS10Available {
            let impact = UIImpactFeedbackGenerator(style: .light)
            impact.prepare()
            impact.impactOccurred()
        } else if type == .mediumImpact && iOS10Available {
            let impact = UIImpactFeedbackGenerator(style: .medium)
            impact.prepare()
            impact.impactOccurred()
        } else if type == .heavyImpact && iOS10Available {
            // Strong boom
            let impact = UIImpactFeedbackGenerator(style: .heavy)
            impact.prepare()
            impact.impactOccurred()
        } else if type == .peek {
            // 'Peek' feedback (weak boom)
            let peek = SystemSoundID(1519)
            AudioServicesPlaySystemSound(peek)
        } else if type == .pop {
            // 'Pop' feedback (strong boom)
            let pop = SystemSoundID(1520)
            AudioServicesPlaySystemSound(pop)
        } else if type == .cancelled {
            // 'Cancelled' feedback (three sequential weak booms)
            let cancelled = SystemSoundID(1521)
            AudioServicesPlaySystemSound(cancelled)
        } else if type == .tryAgain {
            // 'Try Again' feedback (week boom then strong boom)
            let tryAgain = SystemSoundID(1102)
            AudioServicesPlaySystemSound(tryAgain)
        } else if type == .failed {
            // 'Failed' feedback (three sequential strong booms)
            let failed = SystemSoundID(1107)
            AudioServicesPlaySystemSound(failed)
        }
    }

    private static var iOS10Available: Bool {
        var toReturn = false
        if #available(iOS 10.0, *) {
            toReturn = true
        } else {
            print("⚠️ iOS 10 required to use this feedback.")
        }
        return toReturn
    }
}
