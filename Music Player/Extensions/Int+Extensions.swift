//
//  Int+Extensions.swift
//  Music Player
//
//  Created by Sevak on 27.01.22.
//

import Foundation

extension Int {
    var minute: Int {
        return (self % 3600) / 60
    }
    var second: Int {
        return self % 60
    }
    var timeString: String {
        String(format: "%02i:%02i", minute, second)
    }
}
