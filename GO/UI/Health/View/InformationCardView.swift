//
//  InformationCardView.swift
//  GO
//
//  Created by 최승범 on 4/14/25.
//

import SwiftUI

struct InformationCardView: View {
    var body: some View {
        GeometryReader { geometry in
            let width = geometry.size.width
            let height = geometry.size.height
            let spacing: CGFloat = 20
            
            HStack(spacing: spacing) {
                VStack(spacing: 8) {
                    heartCard(width: width)
                    sleepCard(width: width)
                    waterCard(width: width)
                    stepsCard(width: width)
                }
                graphView(height: height - 24)
                
            }
            
        }
    }
    
    func heartCard(width: CGFloat) -> some View {
        let isMini = UIScreen.main.bounds.width <= 1140
        let cardWidth = width * (isMini ? 0.25 : 0.2)

        return ZStack {
            RoundedRectangle(cornerRadius: 12)
                .fill(.white)
                .frame(width: cardWidth)
            HStack {
                Image("heartRate")
                    .resizable()
                    .frame(width: width * 0.03, height: width * 0.03)
                    .padding(.bottom, 8)
                
                Text("120")
                    .appFont(.listTitleBold20)
                    .padding(.leading, 16)
                Text("BPM")
                    .appFont(.primaryButtonSemiBold16)
            }
            .padding(.leading, 20)
            .frame(maxWidth: cardWidth, alignment: .leading)
            
        }
    }
    
    func sleepCard(width: CGFloat) -> some View {
        let isMini = UIScreen.main.bounds.width <= 1140
        let cardWidth = width * (isMini ? 0.25 : 0.2)

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
                
                Text("7")
                    .appFont(.listTitleBold20)
                    .padding(.leading, 16)
                Text("h")
                    .appFont(.primaryButtonSemiBold16)
                Text("28")
                    .appFont(.listTitleBold20)
                Text("m")
                    .appFont(.primaryButtonSemiBold16)
            }
            .padding(.leading, 20)
            .frame(maxWidth: cardWidth, alignment: .leading)
            
        }
    }
    
    func waterCard(width: CGFloat) -> some View {
        let isMini = UIScreen.main.bounds.width <= 1140
        let cardWidth = width * (isMini ? 0.25 : 0.2)

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
                
                Text("1.5")
                    .appFont(.listTitleBold20)
                    .padding(.leading, 26)
                Text("L")
                    .appFont(.primaryButtonSemiBold16)
            }
            .padding(.leading, 20)
            .frame(maxWidth: cardWidth, alignment: .leading)
            
            
        }
    }
    
    func stepsCard(width: CGFloat) -> some View {
        
        let isMini = UIScreen.main.bounds.width <= 1140
        let cardWidth = width * (isMini ? 0.25 : 0.2)

        
        return ZStack {
            RoundedRectangle(cornerRadius: 12)
                .fill(.white)
                .frame(maxWidth: cardWidth)
            HStack {
                Image(systemName: "shoe.fill")
                    .resizable()
                    .frame(width: width * 0.04, height: width * 0.03)
                    .padding(.bottom, 8)
                
                Text("8374")
                    .appFont(.listTitleBold20)
                    .padding(.leading, 16)
                Text("Step")
                    .appFont(.primaryButtonSemiBold16)
            }
            .padding(.leading, 20)
            .frame(maxWidth: cardWidth, alignment: .leading)
            
        }
    }
    
    func graphView(height: CGFloat) -> some View {
        
        let maxBarHeight = height - 60
        return HStack(alignment: .bottom) {
            Spacer()
            chartGraph(percent: 0.68,
                       text: "S",
                       maxBarHeight: maxBarHeight)
            
            Spacer()
            chartGraph(percent: 0.78,
                       text: "M",
                       maxBarHeight: maxBarHeight)
            
            Spacer()
            chartGraph(percent: 0.78,
                       text: "T",
                       maxBarHeight: maxBarHeight)
            
            Spacer()
            chartGraph(percent: 0.12,
                       text: "W",
                       maxBarHeight: maxBarHeight)
            
            Spacer()
            chartGraph(percent: 0.5,
                       text: "T",
                       maxBarHeight: maxBarHeight)
            
            Spacer()
            chartGraph(percent: 0.84,
                       text: "F",
                       isHighlighted: true,
                       maxBarHeight: maxBarHeight)
            
            Spacer()
            chartGraph(percent: 1,
                       text: "S",
                       maxBarHeight: maxBarHeight)
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
    
    func chartGraph(percent: Float,
                    text: String,
                    isHighlighted: Bool = false,
                    maxBarHeight: CGFloat) -> some View {
        let barHeight = maxBarHeight * CGFloat(percent)
        let barColor = isHighlighted ? Color.water : Color.gray.opacity(0.3)
        
        return VStack(spacing: 4) {
            Spacer()
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
    InformationCardView()
}
