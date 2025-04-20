//
//  ProgressPhotosView.swift
//  GO
//
//  Created by 최승범 on 4/20/25.
//

import SwiftUI

struct ProgressPhotosView: View {
    let width: CGFloat
    
    @StateObject var viewModel: ProgressPhotosViewModel = ProgressPhotosViewModel()
    
    var body: some View {
        VStack {
            header
            dateNavigator
            photoScrollView
        }
        .onAppear {
            viewModel.action(.fetchPhotos)
        }
        .padding()
    }
    
    private var header: some View {
        HStack {
            Text("Progress Photos")
                .appFont(.sectionTitleBold28)
            Spacer()
            NavigationLink {
                ProgressPhotosAlbumView(photos: viewModel.photos)
                
            } label: {
                Text("Album")
                        .padding(.vertical, 8)
                        .padding(.horizontal, 16)
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .clipShape(RoundedRectangle(cornerRadius: 8))
            }
            
        }
        .padding(.horizontal)
        
        
    }
    
    private var dateNavigator: some View {
        HStack {
            Button {
                viewModel.action(.previousPage)
            } label: {
                Image(systemName: "chevron.backward")
                    .foregroundStyle(.black)
            }
            
            Text(viewModel.day)
                .appFont(.listTitleBold20)
            
            Button {
                viewModel.action(.nextPage)
            } label: {
                Image(systemName: "chevron.forward")
                    .foregroundStyle(.black)
            }
        }
        .padding()
    }
    
    private var photoScrollView: some View {
        TabView(selection: $viewModel.selectedIndex) {
            ForEach(viewModel.photos.indices, id: \.self) { index in
                let photo = viewModel.photos[index]
                
                HStack(spacing: 20) {
                    photoSlot(viewModel.firstPhoto, label: "start")
                    photoSlot(photo.frontProgressPhoto, label: "Front")
                    photoSlot(photo.sideProgressPhoto, label: "Side")
                    photoSlot(photo.poseProgressPhoto, label: "Pose")
                }
                .tag(index)
            }
        }
        .tabViewStyle(.page(indexDisplayMode: .never))
        .frame(height: width * 0.35)
        .animation(.easeInOut, value: viewModel.selectedIndex)
    }
    
    private func photoSlot(_ image: Image?,
                           label: String) -> some View {
        VStack {
            if let image = image {
                image
                    .resizable()
                    .scaledToFill()
                    .frame(maxWidth: width * 0.2, maxHeight: width * 0.3)
                    .clipShape(RoundedRectangle(cornerRadius: 20))
            } else {
                RoundedRectangle(cornerRadius: 20)
                    .fill(Color.gray.opacity(0.2))
                    .frame(maxWidth: width * 0.2, maxHeight: width * 0.3)
            }
            
            Text(label)
                .appFont(.bodySmallRegular14)
        }
    }
}

#Preview {
//    ProgressPhotosView(width: 740)
    HealthView()
}
