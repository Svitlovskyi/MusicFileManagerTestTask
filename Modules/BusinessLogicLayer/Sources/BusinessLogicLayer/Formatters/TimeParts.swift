//
//  TimeParts.swift
//  MusicFileManagerApp
//
//  Created by Maksym Svitlovskyi on 23.03.2022.
//

import Foundation


/// Represents parts of time
public struct TimeParts: CustomStringConvertible {
    public var seconds = 0
    public var minutes = 0
    /// The string representation of the time parts (ex: 07:37)
    public var description: String {
        return NSString(format: "%02d:%02d", minutes, seconds) as String
    }
}

public extension Int {
    /// The time parts for this integer represented from total seconds in time.
    /// -- returns: A TimeParts struct that describes the parts of time
    func toTimeParts() -> TimeParts {
        let seconds = self
        var mins = 0
        var secs = seconds
        if seconds >= 60 {
            mins = Int(seconds / 60)
            secs = seconds - (mins * 60)
        }
        
        return TimeParts(seconds: secs, minutes: mins)
    }
    
    /// The string representation of the time parts (ex: 07:37)
    func asTimeString() -> String {
        return toTimeParts().description
    }
}
