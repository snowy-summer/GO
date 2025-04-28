//
//  StepsDetailView.swift
//  GO
//
//  Created by 최승범 on 4/22/25.
//

import SwiftUI
import Charts

struct StepsDetailView: View {
    
    @StateObject var viewModel: StepsDetailViewModel = StepsDetailViewModel()

    var body: some View {
        GeometryReader { geometry in
            let width = geometry.size.width
            let height = geometry.size.height
            VStack(spacing: 20) {
                
                headerView(size: geometry.size)
                    .clipShape(RoundedRectangle(cornerRadius: 20))
                
                averageStepsView()
                    .frame(maxWidth: .infinity)
                    .frame(height: height * 0.5)
                    .clipShape(RoundedRectangle(cornerRadius: 20))
            }
            .padding(.horizontal)
            
        }
        .onAppear {
            viewModel.action(.fetchAllData)
        }
        
    }
    
    private func headerView(size: CGSize) -> some View {
        let width = size.width
        let height = size.height
        
        return VStack(alignment: .leading) {
            Text("Today Steps")
                .appFont(.listTitleBold20)
            Divider()
            HStack {
                Text("4668")
                    .appFont(.titleBold24)
                Text("/ 8000 Steps")
                    .appFont(.bodyLargeRegular18)
            }
            
            HStack {
                Text("155 kcal")
                    .appFont(.bodyLargeRegular18)
                Divider()
                Text("42 min")
                    .appFont(.bodyLargeRegular18)
                Divider()
                Text(" 2.80 km")
                    .appFont(.bodyLargeRegular18)
            }
            .frame(height: 44)
            
            HStack {
                ZStack(alignment: .leading) {
                    RoundedRectangle(cornerRadius: 100)
                        .fill(Color.gray.opacity(0.2))
                        .frame(height: 20)
                        .frame(width: width * 0.7)
                    RoundedRectangle(cornerRadius: 100)
                        .fill(.blue)
                        .frame(height: 20)
                        .frame(width: width * 0.7 * 0.7)
                }
                
                Circle()
                    .frame(height: height * 0.08)
            }
            
            
            Divider()
            
            HStack(spacing: 20) {
                ForEach(WeekDay.allCases, id: \.self) { item in
                    ZStack {
                        Circle()
                            .fill(.white)
                            .stroke(.gray,
                                    style: StrokeStyle(lineWidth: 2,
                                                       lineCap: .round))
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
    
    private func averageStepsView() -> some View {
        GeometryReader { geometry in
            let width = geometry.size.width
            let height = geometry.size.height
            let barHeight = height * 0.6
            
            VStack(alignment: .leading, spacing: 8) {
                Text("Stpes Average")
                    .appFont(.listTitleBold20)
                Text("이번주 하루 평균 걸음 수는 7,139 걸음입니다")
                    .appFont(.emphasisSemiBold16)
                Divider()
                
                ZStack(alignment: .bottom) {
                    HStack(alignment: .bottom) {
                        Spacer()
                        ForEach(viewModel.stepsChartDataList) { step in
                            Spacer()
                            chartGraph(percent: step.percent,
                                       text: step.text,
                                       isHighlighted: step.isToday,
                                       maxBarHeight: barHeight,
                                       color: .steps)
                        }
                        Spacer()
                        
                    }
                    .padding()
                    
                    VStack(alignment: .leading) {
                        Text("Average")
                        RoundedRectangle(cornerRadius: 20)
                            .frame(maxWidth: .infinity)
                            .frame(maxHeight: 8)
                        HStack {
                            Text("7,104")
                                .appFont(.titleBold24)
                            Text("Steps")
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
    
    func chartGraph(percent: CGFloat,
                    text: String,
                    isHighlighted: Bool = false,
                    maxBarHeight: CGFloat,
                    color: Color) -> some View {
        let barHeight = maxBarHeight * CGFloat(percent)
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
            
        }.onAppear {
            viewModel.action(.animationOn)
        }
    }
}

#Preview {
    //    StepsDetailCardView()
    HealthView()
}
