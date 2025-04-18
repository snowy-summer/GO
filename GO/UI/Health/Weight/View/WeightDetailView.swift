//
//  WeightDetailView.swift
//  GO
//
//  Created by 최승범 on 4/17/25.
//

import SwiftUI

struct WeightDetailView: View {
    
    @State private var isExpanded: Bool = false
    
    var body: some View {
        GeometryReader { geometry in
            let width = geometry.size.width
            let height = geometry.size.height
            
            ScrollView {
                
                HStack {
                    VStack {
                        HStack {
                            Text("Today")
                            Text("2025.04.15")
                        }
                        RoundedRectangle(cornerRadius: 20)
                            .frame(maxWidth: width * 0.2)
                            .frame(height: height * 0.4)
                    }
                    
                    Spacer()
                    
                    RoundedRectangle(cornerRadius: 20)
                        .frame(maxWidth: width * 0.15)
                        .frame(maxHeight: width * 0.15)
                    
                    RoundedRectangle(cornerRadius: 20)
                        .frame(maxWidth: width * 0.15)
                        .frame(maxHeight: width * 0.15)
                    
                    RoundedRectangle(cornerRadius: 20)
                        .frame(maxWidth: width * 0.15)
                        .frame(maxHeight: width * 0.15)
                    
                    Spacer()
                    
                }
                WeightChartCardView()
                    .frame(maxWidth: .infinity)
                    .frame(height: geometry.size.height * 0.5)
                
                VStack(alignment: .leading, spacing: 12) {
                    DisclosureGroup(
                        isExpanded: $isExpanded,
                        content: {
                            VStack(alignment: .leading, spacing: 8) {
                                MuscleMessChartView()
                                    .frame(maxWidth: .infinity)
                                    .frame(height: geometry.size.height * 0.3)
                                
                                Text("체지방량 그래프 🔴")
                                    .font(.subheadline)
                                
                                WeightChartCardView()
                                    .frame(maxWidth: .infinity)
                                    .frame(height: geometry.size.height * 0.3)
                            }
                            .padding(.leading)
                        },
                        label: {
                            HStack {
                                Text("체성분 보기")
                                    .font(.headline)
                                Spacer()
                            }
                        }
                    )
                    .padding()
                    .background(Color.gray.opacity(0.1))
                    .clipShape(RoundedRectangle(cornerRadius: 12))
                }
                //                .padding()
                
                HStack {
                    Button {
                        
                    } label: {
                        Image(systemName: "chevron.backward")
                            .foregroundStyle(.black)
                    }
                    .padding()
                    
                    Text("25.04.15")
                        .appFont(.listTitleBold20)
                        .bold()
                    
                    Button {
                    } label: {
                        Image(systemName: "chevron.forward")
                            .foregroundStyle(.black)
                    }
                    .padding()
                }
                
                HStack(spacing: 20) {
                    RoundedRectangle(cornerRadius: 20)
                        .frame(maxWidth: width * 0.2)
                        .frame(height: width * 0.3)
                    
                    RoundedRectangle(cornerRadius: 20)
                        .frame(maxWidth: width * 0.2)
                        .frame(height: width * 0.3)
                    
                    RoundedRectangle(cornerRadius: 20)
                        .frame(maxWidth: width * 0.2)
                        .frame(height: width * 0.3)
                }
                
                HStack {
                    Text("show album")
                    
                    Spacer()
                    
                    Button {
                        
                    } label: {
                        Text("Album")
                    }
                    .buttonStyle(.borderedProminent)
                    
                }
            }
        }
    }
}

#Preview {
    WeightDetailView()
}
