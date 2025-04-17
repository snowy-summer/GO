//
// BurnCaloriesCardView.swift
//  GO
//
//  Created by 최승범 on 4/14/25.
//

import SwiftUI

struct BurnCaloriesCardView: View {
    
    @StateObject private var viewModel = BurnCaloriesCardViewModel(caloriesUseCase: BurnCaloriesCalculatorUseCase())
    
    var body: some View {
        GeometryReader { geometry in
            VStack {
                // 상단 이름
                HStack {
                    Image(systemName: "flame.fill")
                        .resizable()
                        .foregroundStyle(.red)
                        .frame(width: 17, height: 23)
                    Text("Burn Calories")
                        .appFont(.listTitleBold20)
                    
                    Text(viewModel.duration)
                        .appFont(.tagSemiBold12)
                        .foregroundStyle(.sub)
                        .padding(.horizontal)
                    Spacer()
                    
                }
                .padding(20)
                
                
                HStack {
                    VStack(spacing: 20) {
                        // 칼로리 글자 표시
                        VStack {
                            HStack {
                                Text("Today")
                                    .appFont(.subHeadLineMedium15)
                                Spacer()
                            }
                            .padding(.leading, 20)
                            HStack {
                                Spacer()
                                Text("\(viewModel.todayCalories)")
                                    .appFont(.listTitleBold20)
                                Text("kcal")
                                    .appFont(.tagSemiBold12)
                            }
                            .padding(.horizontal)
                        }
                        
                        VStack {
                            HStack {
                                Text("Average")
                                    .appFont(.subHeadLineMedium15)
                                Spacer()
                            }
                            .padding(.leading, 20)
                            HStack {
                                Spacer()
                                Text("\(viewModel.averageCalories)")
                                    .appFont(.listTitleBold20)
                                Text("kcal")
                                    .appFont(.tagSemiBold12)
                            }
                            .padding(.horizontal)
                        }
                        
                        
                    }
                    .frame(width: geometry.size.width * 0.2)
                    
                    // 그래프
                    GeometryReader { geometry in
                        let maxBarHeight = geometry.size.height
                        HStack(alignment: .bottom){
                            ForEach(viewModel.calories) { calories in
                                HStack {
                                    Spacer()
                                    chartGraph(percent: calories.percent,
                                               text: calories.text,
                                               isHighlighted: calories.isToday,
                                               maxBarHeight: maxBarHeight)
                                }
                            }
                            Spacer()
                        }
                        .padding(.bottom)
                        .frame(height: geometry.size.height)
                        .frame(maxWidth: .infinity)
                        
                    
                    }
                    .padding(.bottom, 20)
                    .padding(.trailing)
                    
                }
                
            }
            
        }
        .onAppear {
            viewModel.action(.fetchCalories)
        }
    }
    
    func chartGraph(percent: CGFloat,
                    text: String,
                    isHighlighted: Bool = false,
                    maxBarHeight: CGFloat) -> some View {
        let barHeight = maxBarHeight * CGFloat(percent)
        let barColor = isHighlighted ? Color.calories : Color.gray.opacity(0.3)
        
        return VStack(spacing: 4) {
            RoundedRectangle(cornerRadius: 10)
                .fill(barColor)
                .frame(width: 20, height: barHeight)
                .scaleEffect(y: viewModel.isAnimating ? 1.0 : 0.0, anchor: .bottom)
                .animation(.easeOut(duration: 0.8), value: viewModel.isAnimating)
            
            Circle()
                .fill(barColor)
                .frame(width: 16, height: 16)
            
            Text(text)
                .appFont(.emphasisSemiBold16)
                .foregroundColor(.primary)
                .padding(.top, 2)
            
        }
        .onAppear {
            viewModel.action(.animationOn)
        }
    }
}

#Preview {
    BurnCaloriesCardView()
}
