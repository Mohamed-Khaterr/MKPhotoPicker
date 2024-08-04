//
//  PhotoPickerImageMapper.swift
//  
//
//  Created by Mohamed Khater on 06/07/2024.
//

import SwiftUI
import PhotosUI

public struct PhotoPickerImageMapper: MKPhotoPickerMapper {
    
    public init() {}
    
    public func convert(_ result: PHPickerResult, completion: @escaping (Image) -> Void) {
        guard result.itemProvider.canLoadObject(ofClass: UIImage.self) else { return }
        result.itemProvider.loadObject(ofClass: UIImage.self) { image, error in
            MKPhotoPickerLogger.logger.error("\(error)")
            guard let image = image as? UIImage else { return }
            completion(Image(uiImage: image))
        }
    }
}

public extension MKPhotoPickerMapper where Self == PhotoPickerImageMapper {
    static var images: PhotoPickerImageMapper { PhotoPickerImageMapper() }
}
