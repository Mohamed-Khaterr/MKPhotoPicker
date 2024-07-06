//
//  MKPhotoPicker.swift
//
//
//  Created by Mohamed Khater on 06/07/2024.
//

import SwiftUI
import PhotosUI
import os

/// Show Photo Picker Screen
public struct MKPhotoPicker<Resource>: UIViewControllerRepresentable {
    static var logger: Logger { Logger(subsystem: Bundle.main.bundleIdentifier!, category: "PhotoPicker.MappResult") }
    
    /// Results from PhotoPicker
    @Binding var resources: [Resource]
        
    /// Configure what to present in PhotoPicker Screen
    let configuration: PHPickerConfiguration
    
    /// Mapper is to map the result from PhotoPicker to Resource Type
    let mapper: any MKPhotoPickerMapper
    
    public init(_ resources: Binding<[Resource]>, expectedResult mapper: any MKPhotoPickerMapper, configuration: PHPickerConfiguration) {
        self._resources = resources
        self.configuration = configuration
        self.mapper = mapper
    }
    
    public func makeUIViewController(context: Context) -> PHPickerViewController {
        let picker = PHPickerViewController(configuration: configuration)
        picker.delegate = context.coordinator
        return picker
    }
    
    public func updateUIViewController(_ uiViewController: PHPickerViewController, context: Context) {}
    
    public func makeCoordinator() -> Coordinator { Coordinator(self) }
    
    public class Coordinator: PHPickerViewControllerDelegate {
        let parent: MKPhotoPicker
        
        init(_ parent: MKPhotoPicker) {
            self.parent = parent
        }
        
        public func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
            picker.dismiss(animated: true)
            for result in results {
                parent.mapper.convert(result) { [weak self] mappedResult in
                    guard let strongSelf = self else { return }
                    
                    guard let mappedResult = mappedResult as? Resource else {
                        MKPhotoPicker.logger.warning("[PhotoPicker]: Can't map on Resource type, change map value")
                        return
                    }
                    
                    DispatchQueue.main.async { [weak strongSelf] in
                        strongSelf?.parent.resources.append(mappedResult)
                    }
                }
            }
        }
    }
}
