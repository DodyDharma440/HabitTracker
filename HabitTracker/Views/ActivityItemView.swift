//
//  ActivityItemView.swift
//  HabitTracker
//
//  Created by Dodi Aditya on 04/10/23.
//

import SwiftUI

struct ActivityItemView: View {
    var activity: Activity
    var onDelete: () -> Void
    
    var category: ActivityCategory {
        ActivityCategory(rawValue: activity.category) ?? .daily
    }
    
    var body: some View {
        HStack(spacing: 14) {
            Image(systemName: category.imageName)
                .resizable()
                .scaledToFit()
                .frame(width: 20, height: 20)
                .padding()
                .foregroundColor(.white)
                .background(
                    LinearGradient(
                        colors: [category.color, category.color.opacity(0.7)],
                        startPoint: .bottomLeading,
                        endPoint: .topTrailing)
                )
                .cornerRadius(10)
            
            VStack(alignment: .leading, spacing: 4) {
                Text(activity.title)
                    .fontWeight(.semibold)
                    .foregroundColor(.primary)
                Text("\(activity.completionCount) Completed")
                    .font(.subheadline)
                    .foregroundColor(.secondary)
            }
            
            Spacer()
            
            Button {
                onDelete()
            } label: {
                Image(systemName: "trash")
                    .resizable()
                    .frame(width: 14, height: 14)
                    .padding(10)
                    .foregroundColor(.white)
                    .background(.red.opacity(0.9))
                    .cornerRadius(8)
            }
        } // HStack
    }
}

struct ActivityItemView_Previews: PreviewProvider {
    static var previews: some View {
        ActivityItemView(activity: Activity(title: "Test", description: "test", category: ActivityCategory.daily.rawValue, completionCount: 10), onDelete: {})
    }
}
