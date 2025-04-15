//
// BurnCaloriesView.swift
//  GO
//
//  Created by 최승범 on 4/14/25.
//

import SwiftUI

struct BurnCaloriesView: View {
    
    @StateObject private var viewModel = BurnCaloriesViewModel(caloriesUseCase: CaloriesCalculatorUseCase())
    
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
                                               maxBarHeight: maxBarHeight)
                                }
                            }
                            Spacer()
                        }
                        
                    
                    }
                    .padding(.vertical, 20)
                    .padding(.trailing)
                    
                }
                
            }
            
        }
        .onAppear {
            viewModel.fetchCalories()
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
            
            Circle()
                .fill(barColor)
                .frame(width: 16, height: 16)
            
            Text(text)
                .appFont(.emphasisSemiBold16)
                .foregroundColor(.primary)
                .padding(.top, 2)
            
        }
    }
}

#Preview {
    BurnCaloriesView()
}
