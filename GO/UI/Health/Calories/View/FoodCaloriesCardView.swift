//
//  FoodCaloriesCardView.swift
//  GO
//
//  Created by 최승범 on 4/14/25.
//

import SwiftUI

struct FoodCaloriesCardView: View {
    
    @State var percent: CGFloat = 0.2
    let lineWidth: CGFloat = 40
    
    var body: some View {
        VStack {
            HStack {
                Image(systemName: "carrot")
                
                Text("Food Calories")
                    .appFont(.listTitleBold20)
                Spacer()
                
            }
            .padding(20)
            ZStack {
                Circle()
                    .trim(from: 0.0, to: 0.5)
                    .stroke(.gray,
                            style: StrokeStyle(lineWidth: lineWidth,
                                               lineCap: .round))
                    .rotationEffect(.degrees(180))
                Circle()
                    .trim(from: 0.0, to: 0.2)
                    .stroke(.green,
                            style: StrokeStyle(lineWidth: lineWidth,
                                               lineCap: .round))
                    .rotationEffect(.degrees(180))
            }
            .offset(y: 40)
            
            HStack {
                Text("1249 / 1697")
                    .appFont(.listTitleBold20)
                Text("kcal")
                    .appFont(.tagSemiBold12)
            }
            .padding(20)
            
        }
    }
}

#Preview {
    FoodCaloriesCardView()
}
