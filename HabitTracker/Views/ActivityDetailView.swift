//
//  ActivityDetailView.swift
//  HabitTracker
//
//  Created by Dodi Aditya on 05/10/23.
//

import SwiftUI

struct ActivityDetailView: View {
    @Environment(\.dismiss) private var dismiss
    
    var activity: Activity
    var onUpdateCount: (Int) -> Void
    
    @State private var completionCount = 0
    
    var category: ActivityCategory {
        ActivityCategory(rawValue: activity.category) ?? .daily
    }
    
    var body: some View {
        GeometryReader { proxy in
            ZStack(alignment: .top) {
                LinearGradient(colors: [category.color, category.color.opacity(0.7)], startPoint: .bottomLeading, endPoint: .topTrailing)
                    .frame(height: proxy.size.height * 0.5)
                    .ignoresSafeArea()
                
                HStack {
                    Button {
                        dismiss()
                    } label: {
                        Image(systemName: "arrow.left")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 20, height: 20)
                            .padding()
                            .background(.white)
                            .foregroundColor(category.color)
                            .clipShape(Circle())
                    }
                    
                    Spacer()
                } // HStack
                .padding(.top, 1)
                .padding(.horizontal, 20)
                
                HStack {
                    Spacer()
                    Image(systemName: category.imageName)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 200, height: 200)
                        .foregroundColor(category.color.opacity(0.5))
                        .padding(.top)
                        .offset(x: 50)
                } // HStack
                
                VStack {
                    Spacer()
                    VStack {
                        Text(activity.title)
                            .font(.largeTitle)
                            .bold()
                        
                        Divider()
                        
                        VStack(spacing: 8) {
                            HStack {
                                Text("About this activity")
                                    .font(.footnote)
                                    .fontWeight(.semibold)
                                    .foregroundColor(.secondary)
                                Spacer()
                            }
                            
                            HStack {
                                Text(activity.description)
                                Spacer()
                            }
                        }
                        .padding(.vertical)
                        
                        Divider()
                        
                        VStack(spacing: 8) {
                            HStack {
                                Text("Completion count")
                                    .font(.footnote)
                                    .fontWeight(.semibold)
                                    .foregroundColor(.secondary)
                                Spacer()
                            }
                            
                            Stepper(value: $completionCount, in: 0...1000) {
                                Text("\(completionCount)")
                                    .font(.title)
                                    .fontWeight(.semibold)
                            }
                        }
                        .padding(.vertical)
                        
                        Spacer()
                    } // VStack
                    .padding(.vertical, 30)
                    .padding(.horizontal, 20)
                    .frame(height: proxy.size.height * 0.8)
                    .frame(maxWidth: .infinity)
                    .background(.white)
                    .cornerRadius(36, corners: [.topLeft, .topRight])
                }
            } // ZStack
        } // GeometryReader
        .onChange(of: completionCount) { newValue in
            onUpdateCount(completionCount)
        }
        .onAppear {
            completionCount = activity.completionCount
        }
        .navigationBarBackButtonHidden()
    }
}

#Preview {
    ActivityDetailView(activity: Activity(title: "Title", description: "Lorem ipsu dolor sit amet", category: ActivityCategory.daily.rawValue, completionCount: 0), onUpdateCount: { _ in })
}
