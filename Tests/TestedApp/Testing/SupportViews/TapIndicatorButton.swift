import UIKit

final class TapIndicatorButton: UIButton {
    var tapped: Bool {
        get {
            return testability_customValues["isTapped"] ?? false
        }
        set {
            testability_customValues["isTapped"] = newValue
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addTarget(self, action: #selector(onTap(_:)), for: .touchUpInside)
        
        reset()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func reset() {
        tapped = false
    }
    
    @objc private func onTap(_ recognizer: UITapGestureRecognizer) {
        tapped = true
    }
}
