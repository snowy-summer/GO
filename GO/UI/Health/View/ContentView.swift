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
                            .fill(.back)
                            .overlay {
                                Image(systemName: "bell")
                            }
                            .frame(width: 40)
                        Circle()
                            .fill(.back)
                            .overlay {
                                Image(systemName: "gearshape")
                            }
                            .frame(width: 40)
                    }
                    .padding(.horizontal)
                }
                HStack {
                    List(HealthViewCategoryListType.allCases, id: \.self) { type in
                        ImageText(imageTextData: type.data)
                            .appFont(.bodyRegular16)
                    }
                    .listStyle(.plain)
                    .frame(width: 200, height: .infinity)
                    
                    GeometryReader { geometry in
                        let width = geometry.size.width
                        let height = geometry.size.height
                        let horizontalPadding: CGFloat = 20
                        let spacing: CGFloat = 20
                        ScrollView {
                            VStack(spacing: spacing) {
                                HStack(spacing: spacing) {
                                    BurnCaloriesView()
                                        .background(.back)
                                        .clipShape(RoundedRectangle(cornerRadius: 20))
                                        .frame(width: width * 0.65,
                                               height: height * 0.35)
                                    FoodCaloriesBlockView()
                                        .background(.back)
                                        .clipShape(RoundedRectangle(cornerRadius: 20))
                                        .frame(maxWidth: .infinity)
                                        .frame( height: height * 0.35)
                                    
                                }
                                .padding(.horizontal, horizontalPadding)
                                
                                InformationBlockView()
                                    .frame(height: height * 0.4)
                                
                                RoundedRectangle(cornerRadius: 20)
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
}

#Preview {
    ContentView()
}
