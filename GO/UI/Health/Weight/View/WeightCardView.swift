//
//  WeightCardView.swift
//  GO
//
//  Created by 최승범 on 4/17/25.
//

import SwiftUI
import Charts

struct WeightCardView: View {
    
    @StateObject private var viewModel = BurnCaloriesCardViewModel(caloriesUseCase: BurnCaloriesCalculatorUseCase())
    
    let weightRecords: [WeightChartData]
    
    var body: some View {
        GeometryReader { geometry in
            VStack {
                // 상단 이름
                HStack {
                    Image(systemName: "scalemass.fill")
                        .resizable()
                        .foregroundStyle(.black)
                        .frame(width: 17, height: 23)
                    Text("Weight")
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
                        VStack {
                            HStack {
                                Text("Recent")
                                    .appFont(.subHeadLineMedium15)
                                Spacer()
                            }
                            .padding(.leading, 20)
                            HStack {
                                Spacer()
                                Text("\(viewModel.todayCalories)")
                                    .appFont(.listTitleBold20)
                                Text("kg")
                                    .appFont(.tagSemiBold12)
                            }
                            .padding(.horizontal)
                        }
                        
                        VStack {
                            HStack {
                                Text("Goal")
                                    .appFont(.subHeadLineMedium15)
                                Spacer()
                            }
                            .padding(.leading, 20)
                            HStack {
                                Spacer()
                                Text("\(viewModel.averageCalories)")
                                    .appFont(.listTitleBold20)
                                Text("kg")
                                    .appFont(.tagSemiBold12)
                            }
                            .padding(.horizontal)
                        }
                        
                        
                    }
                    .frame(width: geometry.size.width * 0.2)
                    
                    // 그래프
                    GeometryReader { geometry in
                        let maxBarHeight = geometry.size.height
                        Chart(weightRecords) { record in
                            LineMark(
                                x: .value("day", record.date),
                                y: .value("weight", record.weight)
                            )
                            .interpolationMethod(.catmullRom)
                            .foregroundStyle(.blue)
                            
                            PointMark(
                                x: .value("day", record.date),
                                y: .value("weight", record.weight)
                            )
                            .symbolSize(maxBarHeight * 0.5)
                            .foregroundStyle(.green)
                            .annotation(position: .automatic,
                                        alignment: .center,
                                        spacing: 8,
                                        content: {
                                Text("\(record.weight, specifier: "%.1f")")
                                    .appFont(.tagSemiBold12)
                                           .foregroundColor(.gray)
                            })
                           
                        }
                        .padding(.bottom)
                        .frame(height: maxBarHeight)
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
}

#Preview {
    WeightCardView(weightRecords: [
        WeightChartData(date: "11/11", weight: 29.8),
        WeightChartData(date: "11/12", weight: 70.2),
        WeightChartData(date: "11/13", weight: 52.3)
    ])
}

let mock = [
    WeightChartData(date: "11/11", weight: 29.8),
    WeightChartData(date: "11/12", weight: 70.2),
    WeightChartData(date: "11/13", weight: 52.3),
    WeightChartData(date: "11/14", weight: 29.8),
    WeightChartData(date: "11/15", weight: 70.2),
    WeightChartData(date: "11/16", weight: 52.3),
    WeightChartData(date: "11/17", weight: 29.8),
    WeightChartData(date: "11/18", weight: 70.2)
]
