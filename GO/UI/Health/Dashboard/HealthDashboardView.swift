//
//  HealthDashboardView.swift
//  GO
//
//  Created by 최승범 on 4/20/25.
//

import SwiftUI

struct HealthDashboardView: View {
    var body: some View {
        GeometryReader { geometry in
            let width = geometry.size.width
            let height = geometry.size.height
            let horizontalPadding: CGFloat = 20
            let spacing: CGFloat = 20
            ScrollView {
                VStack(spacing: spacing) {
                    HStack(spacing: spacing) {
                        BurnCaloriesCardView()
                            .background(.white)
                            .clipShape(RoundedRectangle(cornerRadius: 20))
                            .frame(width: width * 0.65,
                                   height: height * 0.35)
                        FoodCaloriesCardView()
                            .background(.white)
                            .clipShape(RoundedRectangle(cornerRadius: 20))
                            .frame(maxWidth: .infinity)
                            .frame( height: height * 0.35)
                        
                    }
                    
                    VitalInformationCardView()
                        .frame(height: height * 0.4)
                    
                    WeightChartCardView()
                        .background(.white)
                        .clipShape(RoundedRectangle(cornerRadius: 20))
                        .frame(maxWidth: .infinity)
                        .frame(height: height * 0.5)
                    
                    
                }
                .padding(.horizontal, horizontalPadding)
                .frame(maxWidth: .infinity,
                       maxHeight: .infinity)
                
            }
        }
    }
    
}

#Preview {
    HealthDashboardView()
}
