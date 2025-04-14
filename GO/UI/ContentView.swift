//
//  ContentView.swift
//  GO
//
//  Created by 최승범 on 4/14/25.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        HStack {
            VStack(spacing: 20) {
                RoundedRectangle(cornerRadius: 12)
                    .fill(.purple)
                    .frame(width: 48, height: 48)
                
                RoundedRectangle(cornerRadius: 12)
                    .fill(.purple)
                    .frame(width: 48, height: 48)
                Spacer()
            }
            .padding(.horizontal)
            
            Rectangle()
                .fill(.black)
                .frame(width: 2)
                .ignoresSafeArea()
            Spacer()
            
            VStack {
                HStack {
                    Circle()
                        .frame(width: 60, height: 60)
                        .padding(.leading, 16)
                    Text("Mela")
                        .appFont(.titleBold24)
                    Spacer()
                    HStack(spacing: 16) {
                        Circle()
                            .frame(width: 40)
                        Circle()
                            .frame(width: 40)
                    }
                    .padding(.horizontal)
                }
                HStack {
                    List {
                        Text("Dashboard")
                        Text("Information")
                        Text("Calories")
                        Text("Work Out")
                        
                    }
                    .listStyle(.plain)
                    .frame(width: 200, height: .infinity)
                    
                    GeometryReader { geometry in
                        let width = geometry.size.width
                        let height = geometry.size.height
                        let horizontalPadding: CGFloat = 20
                        let spacing: CGFloat = 20
                        
                        VStack(spacing: spacing) {
                            HStack(spacing: spacing) {
                                BurnCaloriesView()
                                    .background(.gray.opacity(0.2))
                                    .clipShape(RoundedRectangle(cornerRadius: 20))
                                    .frame(width: width * 0.65,
                                           height: height * 0.35)
                                FoodCaloriesBlockView()
                                    .background(.gray.opacity(0.2))
                                    .clipShape(RoundedRectangle(cornerRadius: 20))
                                    .frame(maxWidth: .infinity)
                                    .frame( height: height * 0.35)
                                
                            }
                            .padding(.horizontal, horizontalPadding)
                            
                            InformationBlockView()
                                .frame(height: height * 0.8)
                            
                        }
                        .frame(maxWidth: .infinity,
                               maxHeight: .infinity)
                        
                    }
                    
                    
                }
            }
            
            
            
        }
        
    }
}

#Preview {
    ContentView()
}
