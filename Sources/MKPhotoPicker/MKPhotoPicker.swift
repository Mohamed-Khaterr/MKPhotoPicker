//
//  MKPhotoPicker.swift
//
//
//  Created by Mohamed Khater on 06/07/2024.
//

import SwiftUI
import PhotosUI
import os

internal enum MKPhotoPickerLogger {
    static var logger: Logger { Logger(subsystem: Bundle.main.bundleIdentifier!, category: "PhotoPicker.MappResult") }
}

/// Show Photo Picker Screen
public struct MKPhotoPicker<Resource, Mapper: MKPhotoPickerMapper> {
    
    /// Results from PhotoPicker
    @Binding var resources: [Resource]

    /// Mapper is to map the result from PhotoPicker to Resource Type
    let mapper: Mapper
        
    /// Configure what to present in the PhotoPicker Screen
    let configuration: PHPickerConfiguration

    /// - Parameter resources: Binding array of Resources
    /// - Parameter mapper: Map the PHPicker Result to Resource
    /// - Parameter configuration: The configuration of PHPickerViewController 
    public init(_ resources: Binding<[Resource]>, mapper: Mapper, configuration: PHPickerConfiguration) {
        self._resources = resources
        self.mapper = mapper
        self.configuration = configuration
    }
}

// MARK:- UIViewControllerRepresentable
extension MKPhotoPicker: UIViewControllerRepresentable {
    public func makeUIViewController(context: Context) -> PHPickerViewController {
        let picker = PHPickerViewController(configuration: configuration)
        picker.delegate = context.coordinator
        return picker
    }
    
    public func updateUIViewController(_ uiViewController: PHPickerViewController, context: Context) {}
    
    public func makeCoordinator() -> Coordinator { Coordinator(self) }
}


// MARK:- Coordinator
extension MKPhotoPicker {
    public class Coordinator: PHPickerViewControllerDelegate {
        let parent: MKPhotoPicker
        
        init(_ parent: MKPhotoPicker) {
            self.parent = parent
        }
        
        public func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
            picker.dismiss(animated: true)
            for result in results {
                parent.mapper.convert(result) { [weak self] mappedResult in
                    guard let self = self else { return }
                    
                    guard let mappedResult = mappedResult as? Resource else {
                        MKPhotoPickerLogger.logger.error("[PhotoPicker]: Can't convert type of result to type of Resources")
                        return
                    }
                    
                    DispatchQueue.main.async {
                        self?.parent.resources.append(mappedResult)
                    }
                }
            }
        }
    }
}
