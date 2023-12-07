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
        guard iOS10Available else {
            print("⚠️ iOS 10 required to use this feedback.")
            return
        }

        let generator: UIFeedbackGenerator?

        switch type {
        case .success:
            generator = UINotificationFeedbackGenerator()
            (generator as? UINotificationFeedbackGenerator)?.notificationOccurred(.success)
        case .error:
            generator = UINotificationFeedbackGenerator()
            (generator as? UINotificationFeedbackGenerator)?.notificationOccurred(.error)
        case .warning:
            generator = UINotificationFeedbackGenerator()
            (generator as? UINotificationFeedbackGenerator)?.notificationOccurred(.warning)
        case .selectionChange:
            generator = UISelectionFeedbackGenerator()
            (generator as? UISelectionFeedbackGenerator)?.selectionChanged()
        case .lightImpact, .mediumImpact, .heavyImpact:
            let style: UIImpactFeedbackGenerator.FeedbackStyle = {
                switch type {
                case .lightImpact: return .light
                case .mediumImpact: return .medium
                case .heavyImpact: return .heavy
                default: return .light // Default to light if the type is not recognized
                }
            }()
            generator = UIImpactFeedbackGenerator(style: style)
            (generator as? UIImpactFeedbackGenerator)?.impactOccurred()
        case .peek, .pop, .cancelled, .tryAgain, .failed:
            playSystemSound(for: type)
            generator = nil
        }

        generator?.prepare()
    }

    private static func playSystemSound(for type: FeedbackType) {
        let soundID: SystemSoundID

        switch type {
        case .peek: soundID = 1519
        case .pop: soundID = 1520
        case .cancelled: soundID = 1521
        case .tryAgain: soundID = 1102
        case .failed: soundID = 1107
        default: return
        }

        AudioServicesPlaySystemSound(soundID)
    }

    private static var iOS10Available: Bool {
        return #available(iOS 10.0, *)
    }
}
