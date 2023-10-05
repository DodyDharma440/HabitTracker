//
//  CategoryCardView.swift
//  HabitTracker
//
//  Created by Dodi Aditya on 04/10/23.
//

import SwiftUI

struct CategoryCardView: View {
    var category: ActivityCategory
    var isExpanded = false
    
    @EnvironmentObject var activityVm: ActivityViewModel
    
    @State private var isAnimated = false
    @State private var isExpandedLocal = false
    
    var count: Int {
        activityVm.getCategoryCount(category: category)
    }
    
    var body: some View {
        HStack {
            VStack(alignment: isExpandedLocal ? .leading : .center, spacing: 12) {
                if isExpandedLocal {
                    Image(systemName: category.imageName)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 30, height: 30)
                        .opacity(isAnimated ? 1 : 0)
                        .animation(.default, value: isAnimated)
                }
                
                HStack {
                    VStack(alignment: isExpandedLocal ? .leading : .center, spacing: 6) {
                        Text("\(category.rawValue)")
                            .font(.headline)
                            .fontWeight(.semibold)
                        
                        if isExpandedLocal {
                            HStack {
                                Circle()
                                    .fill(.white)
                                    .frame(width: 8, height: 8)
                                Text("\(count) Task\(count > 1 ? "s" : "")")
                                    .font(.subheadline)
                            }
                            .opacity(isAnimated ? 1 : 0)
                            .animation(.default, value: isAnimated)
                        }
                    }
                    
                    if isExpandedLocal {
                        Spacer()
                    }
                }
                .frame(maxWidth: .infinity)
                
                if isExpandedLocal {
                    Button {
                        activityVm.isShowForm = true
                        activityVm.initialFormCategory = category
                    } label: {
                        Image(systemName: "plus")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 18, height: 18)
                            .opacity(isAnimated ? 1 : 0)
                            .padding(.top, 10)
                            .animation(.default, value: isAnimated)
                    }
                }
            } // VStack
            
            if isExpandedLocal {
                Spacer()
            }
        } // HStack
        .frame(width: isExpandedLocal ? 100 : .none)
        .padding(.horizontal)
        .padding(.vertical, isExpandedLocal ? 24 : 16)
        .background(
            ZStack {
                Color.white
                LinearGradient(
                    colors: [category.color.opacity(1), category.color.opacity(0.7)],
                    startPoint: .bottomLeading,
                    endPoint: .topTrailing
                )
            }
        )
        .foregroundColor(.white)
        .cornerRadius(20)
        .onTapGesture {
            activityVm.activeCategory = category
        }
        .onChange(of: isExpanded) { newValue in
            if newValue == false {
                isAnimated = newValue
            } else {
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.6) {
                    isAnimated = newValue
                }
            }
            
            
            DispatchQueue.main.asyncAfter(deadline: .now() + (newValue == true ? 0.2 : 0.4)) {
                withAnimation(.interpolatingSpring(stiffness: 100, damping: 15)) {
                    isExpandedLocal = newValue
                }
            }
        }
    }
}

struct CategoryCardView_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            Color("darkBg")
                .ignoresSafeArea()
            CategoriesView()
                .environmentObject(ActivityViewModel())
        }
    }
}
