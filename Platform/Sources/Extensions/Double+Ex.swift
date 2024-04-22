/**
 @class Double+Ex
 @date 4/21/24
 @writer kimsoomin
 @brief
 @update history
 -
 */
import Foundation


public extension Double {
    var decimalFormat: String {
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .decimal
        guard let priceString = numberFormatter.string(from: NSNumber(value: self)) else {
            return ""
        }
        return priceString
    }
}
