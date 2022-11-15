import UIKit

extension  UIColor {
    
    convenience init(hex: Int) {
        self.init(
            red: CGFloat((hex & 0xff0000) >> 16) / 255,
            green: CGFloat((hex & 0x00ff00) >> 8) / 255,
            blue: CGFloat((hex & 0x0000ff)) / 255,
            alpha: 1.0
        )
    }
}
