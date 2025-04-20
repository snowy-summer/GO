//
//  FoodCaloriesDetailView.swift
//  GO
//
//  Created by 최승범 on 4/20/25.
//

import SwiftUI

struct FoodCaloriesDetailView: View {
    
    @State var isBreakfastExpanded: Bool = false
    @State var isLunchfastExpanded: Bool = false
    @State var isDinnerfastExpanded: Bool = false
    @State var isSnackfastExpanded: Bool = false
    
    var body: some View {
        
        GeometryReader { geometry in
            let width = geometry.size.width
            let height = geometry.size.height
            
            ScrollView {
                VStack(spacing: 24) {
                    headerSectionView()
                        .frame(height: height * 0.5 )
                        .background(.white)
                        .clipShape(RoundedRectangle(cornerRadius: 20))
                    
                    MealCardView(height: height,
                                 isExpanded: $isBreakfastExpanded)
                    .background(.white)
                    .clipShape(RoundedRectangle(cornerRadius: 20))
                    
                    MealCardView(height: height,
                                 isExpanded: $isLunchfastExpanded)
                    .background(.white)
                    .clipShape(RoundedRectangle(cornerRadius: 20))
                    
                    MealCardView(height: height,
                                 isExpanded: $isDinnerfastExpanded)
                    .background(.white)
                    .clipShape(RoundedRectangle(cornerRadius: 20))
                    
                    MealCardView(height: height,
                                 isExpanded: $isSnackfastExpanded)
                    .background(.white)
                    .clipShape(RoundedRectangle(cornerRadius: 20))
                }
            }
            .padding()
        }
        .background(.back)
    }
    
    private var dateNavigator: some View {
        HStack {
            Button {
                //                viewModel.action(.previousPage)
            } label: {
                Image(systemName: "chevron.backward")
                    .foregroundStyle(.black)
            }
            
            Text("2025.04.15")
                .appFont(.listTitleBold20)
            
            Button {
                //                viewModel.action(.nextPage)
            } label: {
                Image(systemName: "chevron.forward")
                    .foregroundStyle(.black)
            }
        }
        .padding()
    }
    
    private func headerSectionView() -> some View {
        GeometryReader { geometry in
            let lineWidth: CGFloat = geometry.size.height * 0.12
            let size = min(geometry.size.width, geometry.size.height) * 0.5
            
            VStack(spacing: 16) {
                HStack {
                    Image(systemName: "carrot")
                    
                    Text("Food Calories")
                        .appFont(.sectionTitleBold28)
                    
                    Spacer()
                    
                    dateNavigator
                }
                .padding(.top)
                Spacer()
                HStack {
                    HStack(spacing: 4) {
                        Text("1,240 / 1,890")
                            .appFont(.listTitleBold20)
                        Text("kcal")
                            .appFont(.tagSemiBold12)
                    }
                    Spacer()
                    ZStack {
                        Circle()
                            .trim(from: 0.0, to: 1)
                            .stroke(Color.gray.opacity(0.2),
                                    style: StrokeStyle(lineWidth: lineWidth, lineCap: .round))
                            .frame(width: size, height: size)
                        
                        Circle()
                            .trim(from: 0.0, to: 0.25)
                            .stroke(Color.foodCalories,
                                    style: StrokeStyle(lineWidth: lineWidth, lineCap: .round))
                            .rotationEffect(.degrees(-90))
                            .animation(.easeOut(duration: 0.8), value: 0.25)
                            .frame(width: size, height: size)
                    }
                    .frame(width: size * 1.2, height:  size * 1.2)
                    
                }
                .padding()
                
                Spacer()
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .padding(.horizontal, 20)
        }
    }
    
    private struct MealCardView: View {
        
        let height: CGFloat
        
        @Binding var isExpanded: Bool
        
        var body: some View {
            DisclosureGroup(
                isExpanded: $isExpanded,
                content: {
                    foodCardView(size: height)
                        .padding()
                },
                label: {
                    VStack {
                        
                        HStack {
                            Text("Snack")
                                .appFont(.sectionTitleBold28)
                            
                            Spacer()
                            
                            Text("226")
                                .appFont(.cardTitleSemibold22)
                            Text("kcal")
                                .appFont(.bodyRegular16)
                        }
                        
                        HStack {
                            Circle()
                                .frame(width: 20, height: 20)
                            Text("32 g")
                            
                            Circle()
                                .frame(width: 20, height: 20)
                            Text("12 g")
                            
                            Circle()
                                .frame(width: 20, height: 20)
                            Text("8 g")
                            Spacer()
                            
                        }
                    }
                    .padding()
//                    .offset(x: 0, y: 20)
                }
            )
            .padding()
            .tint(.black)
        }
        
        private func foodCardView(size: CGFloat) -> some View {
            HStack(alignment: .top, spacing: 16) {
                RoundedRectangle(cornerRadius: 12)
                    .fill(Color.gray.opacity(0.2))
                    .frame(width: size * 0.25, height: size * 0.25)
                    .overlay(Text("Meal Photo"))
                
                VStack(alignment: .leading, spacing: 8) {
                    Text("닭가슴살 + 고구마 530 Kcal")
                        .appFont(.cardTitleSemibold22)
                    
                    VStack(alignment: .leading, spacing: 20) {
                        nutrientBar(label: "Carbs", value: 32, color: .blue)
                        nutrientBar(label: "Protein", value: 24, color: .green)
                        nutrientBar(label: "Fat", value: 8, color: .orange)
                    }
                }
                
                Spacer()
            }
        }
        
        private func nutrientBar(label: String,
                                 value: CGFloat,
                                 color: Color) -> some View {
            
            GeometryReader { geometry in
                let width = geometry.size.width
                let height = geometry.size.height
                HStack {
                    VStack(alignment: .leading) {
                        Text(label)
                            .appFont(.tagSemiBold12)
                        Text("\(value, specifier: "%.1f") g")
                            .appFont(.emphasisSemiBold16)
                        
                    }
                    .frame(width: width * 0.08,  alignment: .leading)
                    
                    ZStack(alignment: .leading) {
                        RoundedRectangle(cornerRadius: 100)
                            .fill(Color.gray.opacity(0.2))
                            .frame(height: height * 0.6)
                            .frame(maxWidth: width * 0.9)
                        
                        RoundedRectangle(cornerRadius: 100)
                            .fill(color)
                            .frame(height: height * 0.6)
                            .frame(width: width * 0.2)
                        
                        // 적정량 표시선 (0.8 위치)
                        VStack {
                            Text("80 g")
                                .appFont(.tagSemiBold12)
                            RoundedRectangle(cornerRadius: 4)
                                .fill(Color.black.opacity(0.5))
                                .frame(width: 4)
                                .frame(height: height * 0.7)
                        }
                        .offset(x: width * 0.9 * 0.8, y: -height * 0.3) // 👉 0.8 지점
                    }
                }
            }
        }
    }

}

#Preview {
    FoodCaloriesDetailView()
}
