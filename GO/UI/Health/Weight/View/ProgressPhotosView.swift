//
//  ProgressPhotosView.swift
//  GO
//
//  Created by 최승범 on 4/20/25.
//

import SwiftUI

struct ProgressPhotosView: View {
    
    let width: CGFloat
    
    var body: some View {
        VStack {
            HStack {
                Text("Progress Photos")
                    .appFont(.sectionTitleBold28)
                Spacer()
                Button {
                    
                } label: {
                    Text("Album")
                }
                .buttonStyle(.borderedProminent)
            }
            .padding()
            
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
                VStack {
                    RoundedRectangle(cornerRadius: 20)
                        .frame(maxWidth: width * 0.2)
                        .frame(height: width * 0.3)
                    Text("Start")
                        .appFont(.bodySmallRegular14)
                }
                VStack {
                    RoundedRectangle(cornerRadius: 20)
                        .frame(maxWidth: width * 0.2)
                        .frame(height: width * 0.3)
                    Text("Front")
                        .appFont(.bodySmallRegular14)
                }
                
                VStack {
                    RoundedRectangle(cornerRadius: 20)
                        .frame(maxWidth: width * 0.2)
                        .frame(height: width * 0.3)
                    Text("Side")
                        .appFont(.bodySmallRegular14)
                }
                VStack {
                    RoundedRectangle(cornerRadius: 20)
                        .frame(maxWidth: width * 0.2)
                        .frame(height: width * 0.3)
                    Text("Pose")
                        .appFont(.bodySmallRegular14)
                }
            }
        }
        .padding()
    }
}
