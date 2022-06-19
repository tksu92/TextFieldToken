//
//
//  Created by sutk on 5/12/22.
//  Copyright © 2022 . All rights reserved.
//

import UIKit

enum TokenType: CaseIterable {
    case date, time, seconds, MM, DD, YYYY
    
    var display: String {
        switch self {
        case .date:
            return "Date"
        case .time:
            return "Time"
        case .seconds:
            return "Seconds"
        case .MM:
            return "MM"
        case .DD:
            return "DD"
        case .YYYY:
            return "YYYY"
        }
    }
    
    var mark: String {
        return "\(TokenType.markCharacter)" + self.display + "\(TokenType.markCharacter)"
    }
    
    var value: String {
        switch self {
        case .date:
            return Date().string(formatter: "dd MMM yyyy")
        case .time:
            return Date().string(formatter: "HH:mm")
        case .seconds:
            return Date().string(formatter: "ss")
        case .MM:
            return Date().string(formatter: "MM")
        case .DD:
            return Date().string(formatter: "dd")
        case .YYYY:
            return Date().string(formatter: "yyyy")
        }
    }
    static let markCharacter: Character = "$"
    
    static func gen(from markText: String) -> TokenType? {
        return TokenType.allCases.first(where: { $0.mark == markText })
    }
    
    static func parseValue(from markText: String) -> String {
        var defaultFormat = markText
        TokenType.allCases.forEach { token in
            defaultFormat = defaultFormat.replacingOccurrences(of: token.mark, with: token.value)
        }
        return defaultFormat
    }
}
