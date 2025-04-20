//
//  ProgressPhotosAlbumView.swift
//  GO
//
//  Created by 최승범 on 4/20/25.
//

import SwiftUI

struct ProgressPhotosAlbumView: View {
    @Environment(\.dismiss) private var dismiss
    let photos: [ProgressPhotosUIData]
    
    var body: some View {
        GeometryReader { geometry in
            let width = geometry.size.width
            let height = geometry.size.height
            VStack {
                    HStack {
                        Button {
                            dismiss()
                        } label: {
                            Image(systemName: "chevron.left")
                                .font(.title2)
                        }
                        .padding(.horizontal)
                        .padding(.top)
                        Spacer()
                    }
                    .padding(.horizontal)
                
                ScrollView {
                    LazyVStack(spacing: 32) {
                        ForEach(photos, id: \.date) { photo in
                            VStack(spacing: 12) {
                                Text(photo.date)
                                    .appFont(.listTitleBold20)
                                    .padding()
                                
                                HStack(spacing: 20) {
                                    imageCard(photo.frontProgressPhoto, label: "Front", width: width)
                                    imageCard(photo.sideProgressPhoto, label: "Side", width: width)
                                    imageCard(photo.poseProgressPhoto, label: "Pose", width: width)
                                }
                                .padding()
                            }
                            .padding()
                        }
                    }
                    .padding()
                }
                .frame(maxWidth: width * 0.95)
                .frame(maxHeight: height * 0.98)
            }
            .background(.white)
            .clipShape(RoundedRectangle(cornerRadius: 20))
        }
        .background(.back)
        .navigationBarBackButtonHidden()
        
    }
    
    private func imageCard(_ image: Image?, label: String, width: CGFloat) -> some View {
        VStack(spacing: 4) {
            if let image = image {
                image
                    .resizable()
                    .scaledToFill()
                    .frame(width: width * 0.25,
                           height: width * 0.3)
                    .clipped()
                    .clipShape(RoundedRectangle(cornerRadius: 12))
            } else {
                RoundedRectangle(cornerRadius: 12)
                    .fill(Color.gray.opacity(0.2))
                    .frame(width: width * 0.25,
                           height: width * 0.3)
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
