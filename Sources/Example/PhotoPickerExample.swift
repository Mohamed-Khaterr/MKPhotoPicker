//
//  PhotoPickerExample.swift
//
//
//  Created by Mohamed Khater on 06/07/2024.
//

import SwiftUI
import PhotosUI

struct PhotoPickerExample: View {
    @State var isPhotoPickerAppear = false
    @State var uiImages: [UIImage] = []
    @State var images: [Image] = []
    @State var urlStrings: [String] = []
    @State var uiImage: UIImage?
    @State var image: Image?
    @State var imageData: Data?
    
    let configuration: PHPickerConfiguration = {
        var config = PHPickerConfiguration()
        config.selectionLimit = 0
        config.filter = .playbackStyle(.image)
        return config
    }()
    
    var body: some View {
        List {
            Section("uiImages: [UIImage]") {
                VStack(spacing: 36) {
                    ForEach(uiImages, id: \.self) { uiImage in
                        Image(uiImage: uiImage)
                            .resizable()
                            .scaledToFill()
                            .frame(width: 200, height: 200)
                            .clipped()
                    }
                }
                .frame(maxWidth: .infinity)
            }
            
            Section("images: [Image]") {
                VStack(spacing: 36) {
                    ForEach(images.indices, id: \.self) { i in
                        images[i]
                            .resizable()
                            .scaledToFill()
                            .frame(width: 100, height: 100)
                            .clipped()
                    }
                }
                .frame(maxWidth: .infinity)
            }
            
            Section("urlStrings: [String]") {
                VStack(spacing: 36) {
                    ForEach(urlStrings, id: \.self) { urlString in
                        Text(urlString)
                    }
                }
                .padding(.horizontal)
                .frame(maxWidth: .infinity)
            }
            
            Section("uiImage: UIImage?") {
                if let imageData = imageData, let uiImage = UIImage(data: imageData) {
                    Image(uiImage: uiImage)
                        .resizable()
                        .scaledToFill()
                        .frame(width: 200, height: 200)
                        .clipped()
                        .background(.red)
                }
            }
            
            Section("image: Image?") {
                if let image = image {
                    image
                        .resizable()
                        .scaledToFill()
                        .frame(width: 200, height: 200)
                        .clipped()
                }
            }
        }
        .overlay(alignment: .bottom) {
            Button("Pick Photo") {
                isPhotoPickerAppear.toggle()
            }
            .buttonStyle(.borderedProminent)
            .padding()
        }
        .sheet(isPresented: $isPhotoPickerAppear, content: {
            MKPhotoPicker($uiImages, expectedResult: .uiImages, configuration: configuration)
//            MKPhotoPicker($images, expectedResult: .images, configuration: configuration)
//            MKPhotoPicker($urlStrings, expectedResult: .urlStrings, configuration: configuration)
            
//            MKPhotoPicker(Binding(get: { [] }, set: { uiImage = $0.first }), expectedResult: .uiImages, configuration: configuration)
//            MKPhotoPicker(Binding(get: { [] }, set: { image = $0.first }), expectedResult: .images, configuration: configuration)
//            MKPhotoPicker(Binding(get: { [] }, set: { imageData = $0.first }), expectedResult: .data(of: .movie), configuration: configuration)
        })
    }
}
