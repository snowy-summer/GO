//
//  StepsDetailCardView.swift
//  GO
//
//  Created by 최승범 on 4/22/25.
//

import SwiftUI

struct StepsDetailCardView: View {
    var body: some View {
        GeometryReader { geometry in
            let width = geometry.size.width
            let height = geometry.size.height
            VStack(spacing: 20) {
                headerView(width: width)
                .frame(height: height * 0.3)
                .clipShape(RoundedRectangle(cornerRadius: 20))
                
                averageStepsView()
                    .frame(height: height * 0.3)
                    .clipShape(RoundedRectangle(cornerRadius: 20))
            }
            .padding(.horizontal)
            
        }
        
    }
    
    private func headerView(width: CGFloat) -> some View {
        VStack(alignment: .leading) {
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
            
        }
        .padding()
        .background(.white)
    }
    
    private func averageStepsView() -> some View {
        VStack(alignment: .leading, spacing: 8) {
            Text("Stpes Average")
                .appFont(.listTitleBold20)
            Text("지난 7일간 하루 평균 걸음 수는 7,139 걸음입니다")
                .appFont(.emphasisSemiBold16)
            Rectangle()
        }
        .padding()
        .background(.white)
    }
}

#Preview {
    //    StepsDetailCardView()
    HealthView()
}
