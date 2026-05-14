//
//  FeedbackGenerator.swift
//
//  Created by Srdjan Spasojevic on 12/13/18.
//  Copyright © 2018 Srdjan Spasojevic. All rights reserved.
//

import AudioToolbox.AudioServices
import UIKit
enum FeedbackType {
    case selectionChange
    case lightImpact
    case mediumImpact
    case heavyImpact
    case success
    case error
    case warning
    case peek
    case pop
    case cancelled
    case tryAgain
    case failed
}

@MainActor
final class FeedbackGenerator {
    private static let selectionFeedback = UISelectionFeedbackGenerator()
    private static let notificationFeedback = UINotificationFeedbackGenerator()
    private static let lightImpactFeedback = UIImpactFeedbackGenerator(style: .light)
    private static let mediumImpactFeedback = UIImpactFeedbackGenerator(style: .medium)
    private static let heavyImpactFeedback = UIImpactFeedbackGenerator(style: .heavy)
    static func generateFeedback(of type: FeedbackType) {
        switch type {
        case .peek, .pop, .cancelled, .tryAgain, .failed:
            playSystemSound(for: type)
        case .success, .error, .warning:
            guard #available(iOS 10.0, *) else {
                return
            }
            notificationFeedback.prepare()
            switch type {
            case .success:
                notificationFeedback.notificationOccurred(.success)
            case .error:
                notificationFeedback.notificationOccurred(.error)
            case .warning:
                notificationFeedback.notificationOccurred(.warning)
            default:
                break
            }
        case .selectionChange:
            guard #available(iOS 10.0, *) else {
                return
            }
            selectionFeedback.prepare()
            selectionFeedback.selectionChanged()
        case .lightImpact, .mediumImpact, .heavyImpact:
            guard #available(iOS 10.0, *) else {
                return
            }
            let generator: UIImpactFeedbackGenerator
            switch type {
            case .lightImpact:
                generator = lightImpactFeedback
            case .mediumImpact:
                generator = mediumImpactFeedback
            case .heavyImpact:
                generator = heavyImpactFeedback
            default:
                generator = lightImpactFeedback
            }
            generator.prepare()
            generator.impactOccurred()
        }
    }

    private static func playSystemSound(for type: FeedbackType) {
        let soundID: SystemSoundID
        switch type {
        case .peek:
            soundID = 1519
        case .pop:
            soundID = 1520
        case .cancelled:
            soundID = 1521
        case .tryAgain:
            soundID = 1102
        case .failed:
            soundID = 1107
        default:
            return
        }
        AudioServicesPlaySystemSound(soundID)
    }
}
