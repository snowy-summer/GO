//
//  HealthView.swift
//  GO
//
//  Created by 최승범 on 4/14/25.
//

import SwiftUI

struct HealthView: View {
    var body: some View {
        HStack {
            VStack(spacing: 20) {
                RoundedRectangle(cornerRadius: 12)
                    .frame(width: 48, height: 48)
                
                RoundedRectangle(cornerRadius: 12)
                    .frame(width: 48, height: 48)
                Spacer()
            }
            .padding(.horizontal)
            
            Rectangle()
                .fill(.black)
                .frame(width: 2)
                .ignoresSafeArea()
            Spacer()
            
            VStack {
                HStack {
                    Circle()
                        .frame(width: 60, height: 60)
                        .padding(.leading, 16)
                    Text("Mela")
                        .appFont(.titleBold24)
                    Spacer()
                    HStack(spacing: 16) {
                        Circle()
                            .fill(.white)
                            .overlay {
                                Image(systemName: "bell")
                            }
                            .frame(width: 40)
                        Circle()
                            .fill(.white)
                            .overlay {
                                Image(systemName: "gearshape")
                            }
                            .frame(width: 40)
                    }
                    .padding(.horizontal)
                }
                HStack {
                    List(HealthViewCategoryListType.allCases, id: \.self) { type in
                        ImageText(imageTextData: type.data)
                            .appFont(.bodyRegular16)
                            .listRowBackground(Color.clear)
                            .listRowSeparator(.hidden)
                            
                    }
                    .listStyle(.plain)
                    .frame(width: 200)
                    .frame(maxHeight: .infinity)
                    
                    GeometryReader { geometry in
                        let width = geometry.size.width
                        let height = geometry.size.height
                        let horizontalPadding: CGFloat = 20
                        let spacing: CGFloat = 20
//                        ScrollView {
//                            VStack(spacing: spacing) {
//                                HStack(spacing: spacing) {
//                                    BurnCaloriesCardView()
//                                        .background(.white)
//                                        .clipShape(RoundedRectangle(cornerRadius: 20))
//                                        .frame(width: width * 0.65,
//                                               height: height * 0.35)
//                                    FoodCaloriesCardView()
//                                        .background(.white)
//                                        .clipShape(RoundedRectangle(cornerRadius: 20))
//                                        .frame(maxWidth: .infinity)
//                                        .frame( height: height * 0.35)
//                                    
//                                }
//                                
//                                InformationCardView()
//                                    .frame(height: height * 0.4)
//                                
//                                WeightChartCardView()
//                                    .background(.white)
//                                    .clipShape(RoundedRectangle(cornerRadius: 20))
//                                    .frame(maxWidth: .infinity)
//                                    .frame(height: height * 0.5)
//                                    
//                                
//                            }
//                            .padding(.horizontal, horizontalPadding)
//                            .frame(maxWidth: .infinity,
//                                   maxHeight: .infinity)
//                            
//                        }
                        WeightDetailView()
                    }
                }
            }
        }
        .background(.back)
        
    }
}

struct PreviewWrapper_previews: PreviewProvider {
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
