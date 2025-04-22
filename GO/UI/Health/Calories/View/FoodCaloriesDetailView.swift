//
//  FoodCaloriesDetailView.swift
//  GO
//
//  Created by 최승범 on 4/20/25.
//

import SwiftUI

struct FoodCaloriesDetailView: View {
    
    @StateObject private var viewModel: FoodDetailViewModel = FoodDetailViewModel()
    
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
                    
                    MealCardView(height: height,
                                 viewModel: MealCardViewModel(type: .breakfast,
                                                              data: viewModel.breakfast))
                    .background(.white)
                    .clipShape(RoundedRectangle(cornerRadius: 20))
                    
                    MealCardView(height: height,
                                 viewModel: MealCardViewModel(type: .lunch,
                                                              data: viewModel.lunch))
                    .background(.white)
                    .clipShape(RoundedRectangle(cornerRadius: 20))
                    
                    MealCardView(height: height,
                                 viewModel: MealCardViewModel(type: .dinner,
                                                              data: viewModel.dinner))
                    .background(.white)
                    .clipShape(RoundedRectangle(cornerRadius: 20))
                    
                    MealCardView(height: height,
                                 viewModel: MealCardViewModel(type: .snack,
                                                              data: viewModel.snack))
                    .background(.white)
                    .clipShape(RoundedRectangle(cornerRadius: 20))
                }
            }
            .padding()
        }
        .background(.back)
        .onAppear {
            viewModel.action(.fetchData)
        }
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
                                Text("\(viewModel.totalCalories)")
                                    .appFont(.largeTitleBold34)
                                Text("/ \(viewModel.goalCalories)")
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
                                Text("\(viewModel.remainCalories)")
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
                                         value: viewModel.totalCarbs,
                                         state: .over)
                        Spacer()
                        NutrientCardView(width: width,
                                         type: .protein,
                                         value: viewModel.totalProtein,
                                         state: .normal)
                        Spacer()
                        NutrientCardView(width: width,
                                         type: .fat,
                                         value: viewModel.totalFat,
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
        let value: Int
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
                    Text("\(value)")
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
    
    
    
}

#Preview {
    FoodCaloriesDetailView()
}
