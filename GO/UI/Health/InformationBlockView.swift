//
//  InformationBlockView.swift
//  GO
//
//  Created by 최승범 on 4/14/25.
//

import SwiftUI

struct InformationBlockView: View {
    var body: some View {
        GeometryReader { geometry in
            let width = geometry.size.width
            let height = geometry.size.height
            let horizontalPadding: CGFloat = 20
            let spacing: CGFloat = 20
            
            HStack(spacing: spacing) {
                VStack(spacing: 8) {
                    ForEach(0..<4) { _ in
                        ZStack {
                            RoundedRectangle(cornerRadius: 12)
                                .fill(.back)
                                .frame(width: width * 0.2)
                            cardView()
                            
                        }
                    }
                }
                graphView(height: height - 24)
                
            }
            .padding(.horizontal, horizontalPadding)
            
        }
    }
    
    func cardView() -> some View {
        HStack {
            Image("heartRate")
                .resizable()
                .frame(width: 40, height: 40)
                .padding(.bottom, 8)
            
            Text("120")
                .appFont(.listTitleBold20)
            Text("BPM")
                .appFont(.primaryButtonSemiBold16)
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
        .background(.back)
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
    InformationBlockView()
}
