# HapticFeedbackGenerator

Simple FeedbackGenerator library which makes it easy to apply Haptic Feedback on certain actions in your app.

## Instalation:
Just import FeedbackGenerator file into your project.

## Usage: 
```
FeedbackGenerator.generateFeedback(of: .success)
```

## Notes:
iOS 10 or higher is required for some vibration options.  

###### iOS 10 required options:
* selectionChange
* lightImpact
* mediumImpact
* heavyImpact
* success
* error
* warning

###### Standard vibration options:
* peek
* pop
* cancelled
* tryAgain
* failed
