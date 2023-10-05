//
//  AddActivityView.swift
//  HabitTracker
//
//  Created by Dodi Aditya on 04/10/23.
//

import SwiftUI

struct AddActivityView: View {
    @Environment(\.dismiss) var dismiss
    
    @EnvironmentObject var activityVm: ActivityViewModel
    
    @State private var title = ""
    @State private var description = ""
    @State private var category: ActivityCategory = .daily
    
    var isCanSubmit: Bool {
        title != "" && description != ""
    }
    
    var body: some View {
        NavigationView {
            VStack(alignment: .leading, spacing: 20) {
                Text("Add New Activity")
                    .font(.title)
                    .fontWeight(.semibold)
                
                TextField("Title", text: $title)
                    .padding(.horizontal)
                    .padding(.vertical, 14)
                    .overlay(
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(.gray, lineWidth: 1)
                    )
                
                TextField("Description", text: $description)
                    .padding(.horizontal)
                    .padding(.vertical, 14)
                    .overlay(
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(.gray, lineWidth: 1)
                    )
                
                VStack(alignment: .leading, spacing: 10) {
                    Text("Select Category")
                        .font(.subheadline)
                    
                    GeometryReader { proxy in
                        ZStack(alignment: .leading) {
                            RoundedRectangle(cornerRadius: 10)
                                .fill(
                                    LinearGradient(colors: [category.color, category.color.opacity(0.7)], startPoint: .bottomLeading, endPoint: .topTrailing)
                                )
                                .frame(width: proxy.size.width /  CGFloat(ActivityCategory.allCases.count))
                                .offset(x: getCategoryOffset(category, containerWidth: proxy.size.width))
                            
                            HStack {
                                ForEach(ActivityCategory.allCases, id: \.self) { cat in
                                    let isActive = category == cat
                                    
                                    if cat == .weekly {
                                        Spacer()
                                    }
                                    
                                    Button {
                                        withAnimation {
                                            category = cat
                                        }
                                    } label: {
                                        Text("\(cat.rawValue)")
                                            .foregroundColor(isActive ? .white : .black)
                                            .frame(maxWidth: .infinity)
                                    }
                                    
                                    if cat == .weekly {
                                        Spacer()
                                    }
                                }
                            } // HStack
                        } // ZStack
                        .background(
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(.gray.opacity(0.5), lineWidth: 1)
                        )
                    } // GeometryReader
                    .frame(height: 50)
                } // VStack
                
                
                Button {
                    let activity = Activity(title: title, description: description, category: category.rawValue, completionCount: 0)
                    activityVm.activities.append(activity)
                    dismiss()
                } label: {
                    Text("Save")
                        .font(.title3)
                        .fontWeight(.semibold)
                        .padding(.horizontal, 20)
                        .padding(.vertical)
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity)
                        .background(
                            LinearGradient(
                                colors: [.purple, .purple.opacity(0.7)],
                                startPoint: .bottomLeading,
                                endPoint: .topTrailing
                            )
                        )
                        .cornerRadius(16)
                        .opacity(isCanSubmit ? 1 : 0.7)
                } // Button
                .disabled(!isCanSubmit)
                
                Spacer()
            } // VStack
            .padding(24)
            .toolbar {
                Button {
                    dismiss()
                } label: {
                    Image(systemName: "multiply")
                }
                .tint(.black)
            }
            .onAppear {
                category = activityVm.initialFormCategory
            }
        }
    }
    
    func getCategoryOffset(_ category: ActivityCategory, containerWidth: Double) -> Double {
        let buttonWidth = containerWidth / Double(ActivityCategory.allCases.count)
        
        switch category {
        case .daily:
            return 0
        case .weekly:
            return buttonWidth
        case .monthly:
            return buttonWidth * 2
        }
    }
}

struct AddActivityView_Previews: PreviewProvider {
    static var previews: some View {
        AddActivityView()
            .environmentObject(ActivityViewModel())
    }
}
