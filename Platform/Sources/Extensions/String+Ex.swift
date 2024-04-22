/**
 @class String+Ex
 @date 4/21/24
 @writer kimsoomin
 @brief
 @update history
 -
 */
import Foundation

public extension String {
    func toDate(formatType: DateFormatType) -> Date? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = formatType.format
        dateFormatter.locale = Locale(identifier: "ko")
        if let date = dateFormatter.date(from: self) {
            return date
        }        
        return nil
    }
}
