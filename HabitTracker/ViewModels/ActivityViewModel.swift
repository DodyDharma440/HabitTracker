//
//  ActivityViewModel.swift
//  HabitTracker
//
//  Created by Dodi Aditya on 04/10/23.
//

import Foundation

class ActivityViewModel: ObservableObject {
    private let key = "activites"
    
    @Published var activities = [Activity]() {
        didSet {
            let encoder = JSONEncoder()
            
            if let data = try? encoder.encode(activities) {
                UserDefaults.standard.set(data, forKey: key)
            }
        }
    }
    
    @Published var isShowForm = false
    @Published var initialFormCategory: ActivityCategory = .daily
    
    @Published var isShowDelete = false
    @Published var deletedActivity: Activity? = nil
    
    @Published var activeCategory: ActivityCategory? = nil
    
    init() {
        let decoder = JSONDecoder()
        
        if let defaultData = UserDefaults.standard.object(forKey: key) {
            if let decodedData = try? decoder.decode([Activity].self, from: defaultData as! Data) {
                activities = decodedData
                return
            }
        }
        
        activities = []
    }
    
    func getCategoryCount(category: ActivityCategory) -> Int {
        let datas = activities.filter { $0.category == category.rawValue }
        return datas.count
    }
    
    func onConfirmDelete(activity: Activity) {
        isShowDelete = true
        deletedActivity = activity
    }
    
    func onDelete() {
        if let activity = deletedActivity {
            activities = activities.filter { $0.id != activity.id }
        }
    }
    
    func onUpdateCount(id: UUID, count: Int) {
        let index = activities.firstIndex { $0.id == id }
        if let index = index {
            activities[index].completionCount = count
        }
    }
    
    func getFilteredActivites() -> [Activity] {
        if let category = activeCategory {
            return activities.filter { $0.category == category.rawValue }
        }
        return activities
    }
}
