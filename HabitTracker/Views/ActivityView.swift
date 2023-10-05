//
//  ActivityView.swift
//  HabitTracker
//
//  Created by Dodi Aditya on 04/10/23.
//

import SwiftUI

struct ActivityView: View {
    @StateObject var activityVm = ActivityViewModel()
    
    init() {
        UINavigationBar.appearance().largeTitleTextAttributes = [.foregroundColor: UIColor.white]
        UINavigationBar.appearance().titleTextAttributes = [.foregroundColor: UIColor.white]
    }
    
    var activities: [Activity] {
        activityVm.getFilteredActivites()
    }
    
    var body: some View {
        NavigationView {
            ZStack(alignment: .topLeading) {
                Color("darkBg")
                    .ignoresSafeArea()
                
                HStack {
                    Spacer()
                    Image(systemName: "calendar")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 250, height: 250)
                        .offset(x: 50, y: -150)
                        .foregroundColor(.gray)
                        .opacity(0.05)
                }
                
                
                VStack(alignment: .leading, spacing: 10) {
                    CategoriesView()
                    
                    VStack(alignment: .leading) {
                        HStack {
                            Text("\(activityVm.activeCategory?.rawValue ?? "All") Activities")
                                .font(.title2)
                                .fontWeight(.semibold)
                                
                            Spacer()
                            
                            if let _ = activityVm.activeCategory {
                                Button {
                                    activityVm.activeCategory = nil
                                } label: {
                                    Text("Clear Filter")
                                        .font(.subheadline)
                                        .foregroundColor(.secondary)
                                }
                            }
                        } // HStack
                        .padding(.horizontal, 24)
                        
                        
                        if activities.count > 0 {
                            ScrollView {
                                VStack(spacing: 20) {
                                    ForEach(activities, id: \.self.id) { activity in
                                        
                                        NavigationLink {
                                            ActivityDetailView(activity: activity) { count in
                                                activityVm.onUpdateCount(id: activity.id, count: count)
                                            }
                                        } label: {
                                            ActivityItemView(activity: activity) {
                                                activityVm.onConfirmDelete(activity: activity)
                                            }
                                            
                                            
                                        }
                                    }
                                }
                                .padding(.horizontal, 24)
                            }
                            .padding(.vertical)
                        } else {
                            VStack {
                                Text("You don't have any activities yet.")
                                    .foregroundColor(.secondary)
                            }
                            .frame(maxWidth: .infinity, maxHeight: .infinity)
                        }
                        
                        
                        
                        HStack {
                            Spacer()
                            Button {
                                activityVm.isShowForm = true
                                activityVm.initialFormCategory = .daily
                            } label: {
                                Image(systemName: "plus")
                                    .foregroundColor(.white)
                                    .padding(12)
                                    .background(
                                        LinearGradient(colors: [.purple, .purple.opacity(0.7)], startPoint: .bottomLeading, endPoint: .topTrailing)
                                    )
                                    .cornerRadius(10)
                                    .padding(.trailing, 6)
                            }
                        }
                        .padding(.horizontal, 24)
                    }
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 36)
                    .background(.white)
                    .cornerRadius(36, corners: [.topLeft, .topRight])
                    .padding(.top, 24)
                    .ignoresSafeArea()
                } // VStack
                .padding(.top)
            } // ZStack
            .navigationTitle("Habits Tracker")
            .sheet(isPresented: $activityVm.isShowForm) {
                AddActivityView()
            }
            .alert("Delete Activity", isPresented: $activityVm.isShowDelete) {
                Button("Yes, Delete", role: .destructive) {
                    activityVm.onDelete()
                }
                Button("Cancel", role: .cancel) {}
            } message: {
                Text("Are you sure to delete activity with title \"\(activityVm.deletedActivity?.title ?? "")\"?")
            }
        }
        .environmentObject(activityVm)
    }
}

struct ActivityView_Previews: PreviewProvider {
    static var previews: some View {
        ActivityView()
    }
}
