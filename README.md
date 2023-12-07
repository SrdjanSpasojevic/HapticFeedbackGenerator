# HapticFeedbackGenerator 😊📱

🚀 **Status:** Plug and play

### Simple FeedbackGenerator library which makes it easy to apply Haptic Feedback on certain actions in your app.

## Instalation:
Just import FeedbackGenerator file into your project.

## Usage: 
```swift
FeedbackGenerator.generateFeedback(of: .success)
```

## Notes:
iOS 10 or higher is required for some vibration options.  

###### iOS 10 required options:
* electionChange 🔄
* lightImpact 💡
* mediumImpact ⚡️
* heavyImpact 💥
* success ✅
* error ❌
* warning ⚠️

###### Standard vibration options:
* peek 👀
* pop 🔵
* cancelled 🚫
* tryAgain 🔁
* failed ❌💔
