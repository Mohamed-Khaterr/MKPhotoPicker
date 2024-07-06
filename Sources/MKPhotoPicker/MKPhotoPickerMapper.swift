//
//  MKPhotoPickerMapper.swift
//
//
//  Created by Mohamed Khater on 06/07/2024.
//

import PhotosUI

public protocol MKPhotoPickerMapper {
    associatedtype ResourceType
    func convert(_ result: PHPickerResult, completion: @escaping (ResourceType) -> Void)
}
