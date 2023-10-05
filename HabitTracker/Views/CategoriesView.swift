//
//  CategoriesView.swift
//  HabitTracker
//
//  Created by Dodi Aditya on 04/10/23.
//

import SwiftUI

struct CategoriesView: View {
    @State private var isExpanded = false
    
    var body: some View {
        VStack {
            HStack {
                Text("Categories")
                    .font(.title2)
                    .fontWeight(.semibold)
                    .foregroundColor(.white)
                    
                Spacer()
                
                Button {
                    isExpanded.toggle()
                } label: {
                    Image(systemName: "chevron.down")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 12, height: 12)
                        .foregroundColor(.white)
                        .rotationEffect(.degrees(isExpanded ? 0 : 90))
                }
            }
            .padding(.horizontal)
            .padding(.bottom, 10)
            
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 20) {
                    ForEach(ActivityCategory.allCases, id: \.self.rawValue) { category in
                        CategoryCardView(category: category, isExpanded: isExpanded)
                            .transition(.opacity)
                    } // Loop
                } // HStack
                .padding(.horizontal)
            } // ScrollView
            .foregroundColor(.white)
        }
    }
}

struct CategoriesView_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            Color("darkBg")
                .ignoresSafeArea()
            CategoriesView()
                .environmentObject(ActivityViewModel())
        }
    }
}
