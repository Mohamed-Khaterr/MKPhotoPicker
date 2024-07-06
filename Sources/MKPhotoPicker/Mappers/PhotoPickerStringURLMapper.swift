//
//  PhotoPickerStringURLMapper.swift
//
//
//  Created by Mohamed Khater on 06/07/2024.
//

import PhotosUI

public struct PhotoPickerStringURLMapper: MKPhotoPickerMapper {
    
    public init() {}
    
    public func convert(_ result: PHPickerResult, completion: @escaping (String) -> Void) {
        let identifier = UTType.movie.identifier
        guard result.itemProvider.hasItemConformingToTypeIdentifier(identifier) else { return }
        result.itemProvider.loadItem(forTypeIdentifier: identifier) { videoURL, error in
            MKPhotoPicker<Any>.logger.error("\(error)")
            if let videoURL = videoURL as? URL {
                completion(videoURL.absoluteString)
            }
        }
    }
}

public extension MKPhotoPickerMapper where Self == PhotoPickerStringURLMapper {
    static var urlStrings: PhotoPickerStringURLMapper { PhotoPickerStringURLMapper() }
}
