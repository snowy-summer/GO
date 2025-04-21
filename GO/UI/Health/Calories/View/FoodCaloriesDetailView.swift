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
                        .frame(height: height * 0.9 )
                        .background(.white)
                        .clipShape(RoundedRectangle(cornerRadius: 20))
                    
                    MealCardView(type: .breakfast,
                                 height: height,
                                 isExpanded: $isBreakfastExpanded)
                    .background(.white)
                    .clipShape(RoundedRectangle(cornerRadius: 20))
                    
                    MealCardView(type: .lunch,
                                 height: height,
                                 isExpanded: $isLunchfastExpanded)
                    .background(.white)
                    .clipShape(RoundedRectangle(cornerRadius: 20))
                    
                    MealCardView(type: .dinner,
                                 height: height,
                                 isExpanded: $isDinnerfastExpanded)
                    .background(.white)
                    .clipShape(RoundedRectangle(cornerRadius: 20))
                    
                    MealCardView(type: .snack,
                                 height: height,
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
            let size = min(geometry.size.width, geometry.size.height) * 0.4
            let lineWidth: CGFloat = size * 0.2
            let width = geometry.size.width
            VStack(spacing: 16) {
                // 헤더
                HStack {
                    Image(systemName: "carrot")
                    Text("Food Calories")
                        .appFont(.sectionTitleBold28)
                    Spacer()
                    dateNavigator
                }
                .padding(.top)
                
                Spacer()
                
                // 칼로리 & 원형 차트
                    VStack {
                        HStack {
                            VStack {
                                Text("오늘 섭취 열량")
                                    .appFont(.cardTitleSemibold22)
                                HStack(spacing: 4) {
                                    Text("1,249")
                                        .appFont(.largeTitleBold34)
                                    Text("/ 1,890")
                                        .appFont(.largeTitleBold34)
                                    Text("kcal")
                                        .appFont(.primaryButtonSemiBold16)
                                }
                                .padding()
                            }
                            Spacer()
                            ZStack {
                                Circle()
                                    .trim(from: 0.0, to: 1)
                                    .stroke(Color.gray.opacity(0.2),
                                            style: StrokeStyle(lineWidth: lineWidth, lineCap: .round))
                                    .frame(width: size, height: size)
                                
                                VStack {
                                    Text("641")
                                        .appFont(.largeTitleBold34)
                                    Text("남은 열량")
                                        .appFont(.tagSemiBold12)
                                }
                                
                                Circle()
                                    .trim(from: 0.0, to: 0.25)
                                    .stroke(Color.foodCalories,
                                            style: StrokeStyle(lineWidth: lineWidth, lineCap: .round))
                                    .rotationEffect(.degrees(-90))
                                    .animation(.easeOut(duration: 0.8), value: 0.25)
                                    .frame(width: size, height: size)
                            }
                            .frame(width: size * 1.2, height: size * 1.2)
                        }
                        .padding()
                        HStack {
                            Spacer()
                            NutrientCardView(width: width,
                                             type: .carbs,
                                             value: 100,
                                             state: .over)
                            Spacer()
                            NutrientCardView(width: width,
                                             type: .protein,
                                             value: 120,
                                             state: .normal)
                            Spacer()
                            NutrientCardView(width: width,
                                             type: .fat,
                                             value: 86,
                                             state: .under)
                            Spacer()
                        }
                    }
                    .padding(.horizontal)
                    
                    Spacer()
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .padding(.horizontal, 20)
        }
    }
    
    private struct NutrientCardView: View {
        let width: CGFloat
        let type: NutrientType
        let value: Double
        let state: ValueState
        
        var body: some View {
            VStack(spacing: 8) {
                HStack {
                    Circle()
                        .fill(type.color)
                        .frame(width: width * 0.015)
                    Text(type.label + " (g)")
                        .appFont(.emphasisSemiBold16)
                        .foregroundStyle(.gray)
                }
                
                HStack {
                    Text("\(value, specifier: "%.0f")")
                        .appFont(.listTitleBold20)
                    Text(" / 200")
                        .appFont(.listTitleBold20)
                        .foregroundStyle(.gray)
                }
                
                Text(state.title)
                    .appFont(.emphasisSemiBold16)
                    .padding(.horizontal)
                    .background(state.color)
                    .clipShape(RoundedRectangle(cornerRadius: 40))
            }
            .padding()
            .frame(width: width * 0.25, height: width * 0.12)
            .clipShape(RoundedRectangle(cornerRadius: 20))
            .overlay(
                RoundedRectangle(cornerRadius: 20)
                    .stroke(Color.gray.opacity(0.5), lineWidth: 4)
            )
        }
    }
    
    private struct MealCardView: View {
        let type: MealType
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
                            Text(type.label)
                                .appFont(.sectionTitleBold28)
                            
                            Spacer()
                            
                            Text("226")
                                .appFont(.cardTitleSemibold22)
                            Text("kcal")
                                .appFont(.bodyRegular16)
                        }
                        
                        HStack {
                            Circle()
                                .fill(.carbs)
                                .frame(width: 20, height: 20)
                            Text("32 g")
                            
                            Circle()
                                .fill(.protein)
                                .frame(width: 20, height: 20)
                            Text("12 g")
                            
                            Circle()
                                .fill(.fat)
                                .frame(width: 20, height: 20)
                            Text("8 g")
                            Spacer()
                            
                        }
                    }
                    .padding(.horizontal)
                    //                    .offset(x: 0, y: 20)
                }
            )
            .padding()
            .tint(.black)
        }
        
        private func foodCardView(size: CGFloat) -> some View {
            VStack {
                HStack(alignment: .top, spacing: 16) {
                    RoundedRectangle(cornerRadius: 12)
                        .fill(Color.gray.opacity(0.2))
                        .frame(width: size * 0.25, height: size * 0.25)
                        .overlay(Text("Meal Photo"))
                    
                    VStack(alignment: .leading, spacing: 8) {
                        Text("시리얼 100g")
                            .appFont(.cardTitleSemibold22)
                        
                        VStack(alignment: .leading, spacing: 20) {
                            nutrientBar(type: .carbs, value: 32)
                            nutrientBar(type: .protein, value: 12)
                            nutrientBar(type: .fat, value: 8)
                        }
                    }
                    
                    Spacer()
                }
            }
        }
        
        private func nutrientBar(type: NutrientType,
                                 value: CGFloat) -> some View {
            
            GeometryReader { geometry in
                let width = geometry.size.width
                let height = geometry.size.height
                HStack {
                    VStack(alignment: .leading) {
                        Text(type.label)
                            .appFont(.tagSemiBold12)
                        Text("\(value, specifier: "%.1f") g")
                            .appFont(.emphasisSemiBold16)
                        
                    }
                    .frame(width: width * 0.1,  alignment: .leading)
                    
                    ZStack(alignment: .leading) {
                        RoundedRectangle(cornerRadius: 100)
                            .fill(Color.gray.opacity(0.2))
                            .frame(height: height * 0.6)
                            .frame(maxWidth: width * 0.9)
                        
                        RoundedRectangle(cornerRadius: 100)
                            .fill(type.color)
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
