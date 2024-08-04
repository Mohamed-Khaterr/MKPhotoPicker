//
//  PhotoPickerDataMapper.swift
//
//
//  Created by Mohamed Khater on 06/07/2024.
//

import PhotosUI

public struct PhotoPickerDataMapper: MKPhotoPickerMapper {
    let type: UTType
    
    public init(type: UTType) {
        self.type = type
    }
    
    public func convert(_ result: PHPickerResult, completion: @escaping (Data?) -> Void) {
        guard result.itemProvider.hasItemConformingToTypeIdentifier(type.identifier) else { return }
        result.itemProvider.loadDataRepresentation(forTypeIdentifier: type.identifier) { data, error in
            MKPhotoPickerLogger.logger.error("\(error)")
            completion(data)
        }
    }
}

public extension MKPhotoPickerMapper where Self == PhotoPickerDataMapper {
    static func data(of type: UTType) -> PhotoPickerDataMapper { PhotoPickerDataMapper(type: type) }
}

