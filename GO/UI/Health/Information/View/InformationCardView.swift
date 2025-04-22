//
//  InformationCardView.swift
//  GO
//
//  Created by 최승범 on 4/14/25.
//

import SwiftUI

struct InformationCardView: View {
    
    @StateObject var viewModel: InformationCardViewModel = InformationCardViewModel()
    
    var body: some View {
        GeometryReader { geometry in
            let width = geometry.size.width
            let height = geometry.size.height
            let spacing: CGFloat = 20
            
            HStack(spacing: spacing) {
                VStack(spacing: 8) {
                    heartCard(width: width)
                    sleepTimeCard(width: width)
                    waterCard(width: width)
                    stepsCard(width: width)
                }
                graphView(height: height - 24)
                    
                
            }
            
        }
        .onAppear {
            viewModel.action(.fetchAllData)
        }
    }
    
    func heartCard(width: CGFloat) -> some View {
//        let isMini = UIScreen.main.bounds.width <= 1140
//        let cardWidth = width * (isMini ? 0.25 : 0.2)
        let cardWidth = width * 0.25

        return ZStack {
            RoundedRectangle(cornerRadius: 12)
                .fill(.white)
                .frame(width: cardWidth)
            HStack {
                Image("heartRate")
                    .resizable()
                    .frame(width: width * 0.03, height: width * 0.03)
                    .padding(.bottom, 8)
                
                Text("\(viewModel.todayHeartRate)")
                    .appFont(.listTitleBold20)
                    .padding(.leading, 16)
                Text("BPM")
                    .appFont(.primaryButtonSemiBold16)
            }
            .padding(.leading, 20)
            .frame(maxWidth: cardWidth, alignment: .leading)
            
        }
        .onTapGesture {
            viewModel.action(.selectCard(.heartRate))
        }
    }
    
    func sleepTimeCard(width: CGFloat) -> some View {
//        let isMini = UIScreen.main.bounds.width <= 1140
//        let cardWidth = width * (isMini ? 0.25 : 0.2)
        let cardWidth = width * 0.25

        return ZStack {
            RoundedRectangle(cornerRadius: 12)
                .fill(.white)
                .frame(width: cardWidth)
            HStack {
                Image(systemName: "moon.zzz.fill")
                    .resizable()
                    .frame(width: width * 0.03, height: width * 0.04)
                    .symbolRenderingMode(.palette)
                    .foregroundStyle(.calories, .black)
                    .padding(.bottom, 8)
                
                Text("\(viewModel.todaySleepTime.hour)")
                    .appFont(.listTitleBold20)
                    .padding(.leading, 16)
                Text("h")
                    .appFont(.primaryButtonSemiBold16)
                Text("\(viewModel.todaySleepTime.minute)")
                    .appFont(.listTitleBold20)
                Text("m")
                    .appFont(.primaryButtonSemiBold16)
            }
            .padding(.leading, 20)
            .frame(maxWidth: cardWidth, alignment: .leading)
            
        }
        .onTapGesture {
            viewModel.action(.selectCard(.sleepTime))
        }
    }
    
    func waterCard(width: CGFloat) -> some View {
        let isMini = UIScreen.main.bounds.width <= 1140
//        let cardWidth = width * (isMini ? 0.25 : 0.2)
        let cardWidth = width * 0.25

        return ZStack {
            RoundedRectangle(cornerRadius: 12)
                .fill(.white)
                .frame(width: cardWidth)
            HStack {
                Image(systemName: "drop.fill")
                    .resizable()
                    .foregroundStyle(.water)
                    .frame(width: width * 0.03, height: width * 0.04)
                    .padding(.bottom, 8)
                
                Text(String(format: "%.2f", viewModel.todayWater))
                    .appFont(.listTitleBold20)
                    .padding(.leading, 20)
                Text("L")
                    .appFont(.primaryButtonSemiBold16)
            }
            .padding(.leading, 20)
            .frame(maxWidth: cardWidth, alignment: .leading)
            
            
        }
        .onTapGesture {
            viewModel.action(.selectCard(.water))
        }
    }
    
    func stepsCard(width: CGFloat) -> some View {
        
//        let isMini = UIScreen.main.bounds.width <= 1140
//        let cardWidth = width * (isMini ? 0.25 : 0.2)
        let cardWidth = width * 0.25

        
        return ZStack {
            RoundedRectangle(cornerRadius: 12)
                .fill(.white)
                .frame(maxWidth: cardWidth)
            HStack {
                Image(systemName: "shoe.fill")
                    .resizable()
                    .frame(width: width * 0.04, height: width * 0.03)
                    .padding(.bottom, 8)
                
                Text("\(viewModel.todaySteps)")
                    .appFont(.listTitleBold20)
                    .padding(.leading, 16)
                Text("Step")
                    .appFont(.primaryButtonSemiBold16)
            }
            .padding(.leading, 20)
            .frame(maxWidth: cardWidth, alignment: .leading)
            
        }
        .onTapGesture {
            viewModel.action(.selectCard(.steps))
        }
    }
    
    func graphView(height: CGFloat) -> some View {
        
        let maxBarHeight = height - 60
        return HStack(alignment: .bottom) {
            
            switch viewModel.selectedInformationCard {
            case .heartRate:
                ForEach(viewModel.heartRateChartDataList) { heartRate in
                        Spacer()
                        chartGraph(percent: heartRate.percent,
                                   text: heartRate.text,
                                   isHighlighted: heartRate.isToday,
                                   maxBarHeight: maxBarHeight,
                                   color: .heartRate)
                }
            case .sleepTime:
                ForEach(viewModel.sleepTimeChartDataList) { sleepTime in
                        Spacer()
                        chartGraph(percent: sleepTime.percent,
                                   text: sleepTime.text,
                                   isHighlighted: sleepTime.isToday,
                                   maxBarHeight: maxBarHeight,
                                   color: .sleepTime)
                }
            case .steps:
                ForEach(viewModel.stepsChartDataList) { step in
                        Spacer()
                        chartGraph(percent: step.percent,
                                   text: step.text,
                                   isHighlighted: step.isToday,
                                   maxBarHeight: maxBarHeight,
                                   color: .steps)
                }
            case .water:
                ForEach(viewModel.waterChartDataList) { water in
                        Spacer()
                        chartGraph(percent: water.percent,
                                   text: water.text,
                                   isHighlighted: water.isToday,
                                   maxBarHeight: maxBarHeight,
                                   color: .water)
                }
            }
            Spacer()
        }
        .overlay {
            VStack {
                HStack {
                    Text("13 - 19 April 2025")
                        .appFont(.tagSemiBold12)
                        .foregroundStyle(.sub)
                    Spacer()
                }
                Spacer()
            }
            .padding(20)
        }
        .padding(.bottom)
        .frame(height: height + 20)
        .frame(maxWidth: .infinity)
        .background(.white)
        .clipShape(RoundedRectangle(cornerRadius: 12))
        
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
    InformationCardView()
}
