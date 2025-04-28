//
//  WaterIntakeDetailView.swift
//  GO
//
//  Created by 최승범 on 4/28/25.
//

import Foundation

import SwiftUI

struct WaterIntakeDetailView: View {
    
    @StateObject var viewModel: WaterIntakeDetailViewModel = WaterIntakeDetailViewModel()

    var body: some View {
        GeometryReader { geometry in
            let width = geometry.size.width
            let height = geometry.size.height
            VStack(spacing: 20) {
                
                headerView(size: geometry.size)
                    .clipShape(RoundedRectangle(cornerRadius: 20))
                
                weeklyWaterGraphView()
                    .frame(maxWidth: .infinity)
                    .frame(height: height * 0.5)
                    .clipShape(RoundedRectangle(cornerRadius: 20))
            }
            .padding(.horizontal)
        }
        .onAppear {
            viewModel.action(.fetchWaterData)
        }
    }
    
    private func headerView(size: CGSize) -> some View {
        let width = size.width
        let height = size.height
        
        return VStack(spacing: 16) {
            HStack {
                Text("Today's Water Intake")
                    .appFont(.listTitleBold20)
                Spacer()
            }
            Divider()
            
            HStack {
                VStack(spacing: 8) {
                    Spacer()
                    HStack {
                        Text("\(viewModel.todayWater, specifier: "%.1f")L")
                            .appFont(.titleBold24)
                        Text(" / \(viewModel.goalWater, specifier: "%.1f")L")
                            .appFont(.bodyLargeRegular18)
                    }
                    
                    if viewModel.isGoalReached {
                        Text("🎉 목표 달성!")
                            .appFont(.tagSemiBold12)
                            .foregroundColor(.blue)
                    }
                    Spacer()
                    HStack {
                        Button(action: {
                            viewModel.action(.addWater(amount: 0.2)) // 예시로 200ml 추가
                        }) {
                            Text("+ Drink (200ml)")
                                .appFont(.emphasisSemiBold16)
                                .padding(.vertical, 10)
                                .padding(.horizontal, 20)
                                .background(Color.blue)
                                .foregroundColor(.white)
                                .clipShape(RoundedRectangle(cornerRadius: 12))
                        }
                        Button(action: {
                            viewModel.action(.addWater(amount: 0.2)) // 예시로 200ml 추가
                        }) {
                            Text("+ Drink (custom)")
                                .appFont(.emphasisSemiBold16)
                                .padding(.vertical, 10)
                                .padding(.horizontal, 20)
                                .background(Color.blue)
                                .foregroundColor(.white)
                                .clipShape(RoundedRectangle(cornerRadius: 12))
                        }
                    }
                }
                Spacer()
                Rectangle() // 물마시는 이미지 
                    .frame(width: width * 0.4)
            }
            .padding(.horizontal)
        
            
            Divider()
            
            HStack(spacing: 20) {
                ForEach(WeekDay.allCases, id: \.self) { item in
                    ZStack {
                        Circle()
                            .fill(.white)
                            .stroke(.gray, lineWidth: 2)
                        Text(item.singleName)
                            .appFont(.emphasisSemiBold16)
                    }
                }
            }
            .frame(height: height * 0.08)
        }
        .padding()
        .background(.white)
    }
    
    private func weeklyWaterGraphView() -> some View {
        GeometryReader { geometry in
            let width = geometry.size.width
            let height = geometry.size.height
            let barHeight = height * 0.6
            
            VStack(alignment: .leading, spacing: 8) {
                Text("Weekly Water Intake")
                    .appFont(.listTitleBold20)
                Text("이번 주 하루 평균 섭취량은 \(viewModel.weeklyAverage, specifier: "%.1f")L입니다")
                    .appFont(.emphasisSemiBold16)
                Divider()
                
                ZStack(alignment: .bottom) {
                    HStack(alignment: .bottom) {
                        Spacer()
                        ForEach(viewModel.weeklyWaterData) { water in
                            Spacer()
                            chartGraph(percent: water.percent,
                                       text: water.text,
                                       isHighlighted: water.isToday,
                                       maxBarHeight: barHeight,
                                       color: .water)
                        }
                        Spacer()
                    }
                    .padding(.horizontal)
                    
                    VStack(alignment: .leading) {
                        Text("Average")
                        RoundedRectangle(cornerRadius: 20)
                            .frame(maxWidth: .infinity)
                            .frame(maxHeight: 8)
                        HStack {
                            Text("1.2")
                                .appFont(.titleBold24)
                            Text("L")
                                .appFont(.emphasisSemiBold16)
                                .foregroundStyle(.gray)
                        }
                    }
                    .padding(.horizontal)
                    .offset(y: -barHeight * 0.5) // 평균이 차지하는 퍼센트
                }
                
                
            }
        }
        .padding()
        .background(.white)
    }
    
    private func chartGraph(percent: CGFloat,
                             text: String,
                            isHighlighted: Bool = false,
                             maxBarHeight: CGFloat,
                             color: Color) -> some View {
        let barHeight = maxBarHeight * percent
        let barColor = isHighlighted ? color : Color.gray.opacity(0.3)
        
        return VStack(spacing: 4) {
            Spacer()
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
    HealthView()
}
