//
//  PhotoPickerUIImageMapper.swift
//
//
//  Created by Mohamed Khater on 06/07/2024.
//

import PhotosUI

public struct PhotoPickerUIImageMapper: MKPhotoPickerMapper {
    
    public init() {}
    
    public func convert(_ result: PHPickerResult, completion: @escaping (UIImage) -> Void) {
        guard result.itemProvider.canLoadObject(ofClass: UIImage.self) else { return }
        result.itemProvider.loadObject(ofClass: UIImage.self) { image, error in
            MKPhotoPicker<Any>.logger.error("\(error)")
            guard let image = image as? UIImage else { return }
            completion(image)
        }
    }
}

public extension MKPhotoPickerMapper where Self == PhotoPickerUIImageMapper {
    static var uiImages: PhotoPickerUIImageMapper { PhotoPickerUIImageMapper() }
}
