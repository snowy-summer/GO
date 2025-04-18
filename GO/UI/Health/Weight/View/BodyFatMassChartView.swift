//
//  BodyFatMassChartView.swift
//  GO
//
//  Created by 최승범 on 4/18/25.
//

import SwiftUI
import Charts

struct BodyFatMassChartView: View {
    
    @StateObject private var viewModel = MuscleMassChartViewModel()
    
    var body: some View {
        GeometryReader { geometry in
            VStack {
                // 상단 이름
                HStack {
                    Image(systemName: "scalemass.fill")
                        .resizable()
                        .foregroundStyle(.black)
                        .frame(width: 17, height: 23)
                    Text("Body fat mass Graph")
                        .appFont(.listTitleBold20)
                    
                    Text(viewModel.duration)
                        .appFont(.tagSemiBold12)
                        .foregroundStyle(.sub)
                        .padding(.horizontal)
                    Spacer()
                    
                }
                .padding(20)
                
                
                HStack(alignment: .center) {
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
                                Text("\(viewModel.recentMuscleMass, specifier: "%.1f")")
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
                                Text("\(viewModel.goalMuscleMass, specifier: "%.1f")")
                                    .appFont(.listTitleBold20)
                                Text("kg")
                                    .appFont(.tagSemiBold12)
                            }
                            .padding(.horizontal)
                        }
                        
                        
                    }
                    .frame(width: geometry.size.width * 0.15)
                    
                    
                    let maxBarHeight = geometry.size.height
                    Chart(viewModel.weightList) { record in
                        LineMark(
                            x: .value("day", record.date),
                            y: .value("weight", record.muscleMass)
                        )
                        .interpolationMethod(.catmullRom)
                        .foregroundStyle(.weight)
                        
                        PointMark(
                            x: .value("day", record.date),
                            y: .value("weight", record.muscleMess)
                        )
                        .symbolSize(maxBarHeight * 0.5)
                        .foregroundStyle(.weight)
                        .annotation(position: .automatic,
                                    alignment: .center,
                                    spacing: 8,
                                    content: {
                            Text("\(record.muscleMess, specifier: "%.1f")")
                                .appFont(.tagSemiBold12)
                                       .foregroundColor(.gray)
                        })
                        
                        RuleMark(y: .value("Goal", viewModel.goalMuscleMass))
                                .lineStyle(StrokeStyle(lineWidth: 1, dash: [5]))
                                .foregroundStyle(.green)
                                .annotation(position: .top, alignment: .leading) {
                                    Text("🎯 Goal: \(viewModel.goalMuscleMass, specifier: "%.1f") kg")
                                        .appFont(.tagSemiBold12)
                                        .foregroundColor(.gray)
                                }
                       
                    }
                    .chartYScale(domain: viewModel.minWeight...viewModel.maxWeight)
                    
                    .frame(maxHeight: .infinity)
                    .frame(maxWidth: .infinity)
                    .padding(.trailing)
                    
                }
                .padding(.bottom)
                
            }
            
        }
        .onAppear {
            viewModel.action(.fetchMuscleMass)
        }
    }
}

#Preview {
    BodyFatMassChartView()
}
