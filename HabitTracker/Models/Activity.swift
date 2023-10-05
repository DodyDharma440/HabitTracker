//
//  Activity.swift
//  HabitTracker
//
//  Created by Dodi Aditya on 04/10/23.
//

import Foundation
import SwiftUI

enum ActivityCategory: String, CaseIterable {
    case daily = "Daily"
    case weekly = "Weekly"
    case monthly = "Monthly"
    
    var color: Color {
        switch self {
        case .daily:
            return .pink
        case .weekly:
            return .blue
        case .monthly:
            return .orange
        }
    }
    
    var imageName: String {
        switch self {
        case .daily:
            return "calendar"
        case .weekly:
            return "calendar.day.timeline.left"
        case .monthly:
            return "circle.inset.filled"
        }
    }
}

struct Activity: Codable, Identifiable {
    var id = UUID()
    
    let title: String
    let description: String
    let category: ActivityCategory.RawValue
    var completionCount: Int
}
