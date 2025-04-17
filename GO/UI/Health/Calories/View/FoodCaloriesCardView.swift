//
//  FoodCaloriesCardView.swift
//  GO
//
//  Created by 최승범 on 4/14/25.
//

import SwiftUI

struct FoodCaloriesCardView: View {
    
    @StateObject private var viewModel: FoodCaloriesCardViewModel = FoodCaloriesCardViewModel()
    @State private var animatedPercent: CGFloat = 0
    
    var body: some View {
        
        GeometryReader { geometry in
            let lineWidth: CGFloat = geometry.size.width * 0.1
            VStack {
                HStack {
                    Image(systemName: "carrot")
                    
                    Text("Food Calories")
                        .appFont(.listTitleBold20)
                    Spacer()
                    
                }
                .padding(.horizontal, 20)
                .padding(.top, 20)
                ZStack {
                    Circle()
                        .trim(from: 0.0, to: 0.5)
                        .stroke(.gray,
                                style: StrokeStyle(lineWidth: lineWidth,
                                                   lineCap: .round))
                        .rotationEffect(.degrees(180))
                    
                    Circle()
                        .trim(from: 0.0, to: viewModel.percent)
                        .stroke(.foodCalories,
                                style: StrokeStyle(lineWidth: lineWidth,
                                                   lineCap: .round))
                        .animation(.easeOut(duration: 0.8), value: viewModel.percent)
                        .rotationEffect(.degrees(180))
                }
                .offset(y: 40)
                HStack {
                    Text("\(viewModel.calories.rawValue) / \(viewModel.calories.goal)")
                        .appFont(.listTitleBold20)
                    Text("kcal")
                        .appFont(.tagSemiBold12)
                }
                .padding(20)
                
            }
            .onAppear {
                viewModel.action(.fetchCalories)
            }
        }
        
    }
}

struct Preview_previews: PreviewProvider {
    static let devices = ["iPad Pro 13-inch (M4)",
                          "iPad Pro 11-inch (M4)",
                          "iPad mini (A17 Pro)"]

    static var previews: some View {
        ForEach(devices, id: \.self) { device in
            HealthView()
                .previewDevice(PreviewDevice(rawValue: device)) // 프리뷰 디바이스 설정
                .previewDisplayName(device) // 프리뷰 이름 설정
        }
    }
}
