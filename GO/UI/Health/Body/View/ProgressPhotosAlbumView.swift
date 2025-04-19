//
//  ProgressPhotosAlbumView.swift
//  GO
//
//  Created by 최승범 on 4/20/25.
//

import SwiftUI

struct ProgressPhotosAlbumView: View {
    @Environment(\.dismiss) private var dismiss
    let width: CGFloat
    let photos: [ProgressPhotosUIData]
    
    var body: some View {
        ScrollView {
            LazyVStack(spacing: 32) {
                ForEach(photos, id: \.date) { photo in
                    VStack(spacing: 12) {
                        // 날짜 텍스트
                        Text(photo.date)
                            .appFont(.listTitleBold20)
                            .padding()
                        
                        // 사진 3개
                        HStack(spacing: 20) {
                            imageCard(photo.frontProgressPhoto, label: "Front")
                            imageCard(photo.sideProgressPhoto, label: "Side")
                            imageCard(photo.poseProgressPhoto, label: "Pose")
                        }
                        .frame(height: width * 0.25)
                        .padding()
                    }
                    .padding()
                    .background(.white)
                    .clipShape(RoundedRectangle(cornerRadius: 20))
                }
            }
            .padding(.top)
            
        }
        .overlay{
            // 조금 위치가 애매함
            VStack {
                HStack {
                    Button {
                        dismiss()
                    } label: {
                        Image(systemName: "chevron.left")
                            .font(.title2)
                    }
                    Spacer()
                }
                Spacer()
            }
        }
        .background(.back)
        .navigationBarBackButtonHidden()
        
    }
    
    private func imageCard(_ image: Image?, label: String) -> some View {
        VStack(spacing: 4) {
            if let image = image {
                image
                    .resizable()
                    .scaledToFill()
                    .frame(width: width * 0.25, height: width * 0.25)
                    .clipped()
                    .clipShape(RoundedRectangle(cornerRadius: 12))
            } else {
                RoundedRectangle(cornerRadius: 12)
                    .fill(Color.gray.opacity(0.2))
                    .frame(width: width * 0.25, height: width * 0.25)
            }
            Text(label)
                .appFont(.tagSemiBold12)
                .foregroundColor(.gray)
        }
    }
}

#Preview {
    HealthView()
}
