//
//  DateFormat.swift
//  TestGitHub
//
//  Created by Olga Vorona on 23.12.2020.
//


import Foundation

@objc public enum DateFormat: Int, CaseIterable, CustomStringConvertible {
    case standard
    case serverFull
    
    var value: String {
        switch self {
        
        case .serverFull: return "yyyy-MM-dd'T'HH:mm:ssZ"
        case .standard: return "dd.MM.yyyy"
        }
    }
    
    public var description: String {
        return value
    }
}

class CachedDateFormatter {
    
    private static let dispatchQueue = DispatchQueue(label: String(describing: CachedDateFormatter.self))
    
    private static var formatters: [String: DateFormatter] = [:]
    
    static func formatDate(_ date: Date, with format: DateFormat) -> String {
        return fetchFormatter(format).string(from: date)
    }
    
    static func date(from stringDate: String, of format: DateFormat) -> Date? {
        return fetchFormatter(format).date(from: stringDate)
    }
    
    
    static func fetchFormatter(_ format: DateFormat) -> DateFormatter {
        return dispatchQueue.sync {
            let key = format.description
            if let formatter = formatters[key] {
                return formatter
            } else {
                let formatter = DateFormatter()
                formatter.timeZone = .current
                formatter.locale = .current
                formatter.dateFormat = format.value
                formatters[key] = formatter
                return formatter
            }
        }
    }
}
