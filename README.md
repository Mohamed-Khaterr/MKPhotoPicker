# MKPhotoPicker
An easy way to get images or videos from PhotoLibrary in `SwiftUI`.

<!-- Project Settings -->
![Swift: Version](https://img.shields.io/badge/Swift-5.9-lightgray?logo=Swift)
![iOS: Version](https://img.shields.io/badge/iOS-14.0+-lightgray)
[![License](https://img.shields.io/badge/license-MIT-blue.svg)](LICENSE)

## Installation

### Swift Package Manager
To integrate your package into an Xcode project, open the project and select `File` > `Add Packages...`. Enter the package repository URL in the search bar.

Alternatively, you can add it to your `Package.swift` file:
```swift
dependencies: [
    .package(url: "https://github.com/Mohamed-Khaterr/MKPhotoPicker.git", from: "1.0.0")
]
```

## Usage
You need two steps to use MKPhotoPicker.

First, create a Mapper.
> Mapper will map the result from PHPhotoPicker to your expected result.

```swift
struct Mapper: MKPhotoPickerMapper {
    typealise ResourceType = UIImage

    func convert(_ result: PHPickerResult, completion: @escaping (UIImage) -> Void) {
        // Check if the result can be loaded as UIImage.
        guard result.itemProvider.canLoadObject(ofClass: UIImage.self) else { return }
        result.itemProvider.loadObject(ofClass: UIImage.self) { image, error in
            guard let image = image as? UIImage else { return }
            // return the image in completion
            completion(image)
        }
    }
}
```

Second, create an instance from MKPhotoPicker, and use the Mapper that was created.
```swift
struct MyView: View {
    @State var uiImages: [UIImages] = []
    @State var isPhotoLibraryAppear = false
    let mapper = Mapper()

    var body: some View {
        Button {
            isPhotoLibraryAppear.toggle()
        } label: {
            Text("Select Photos")
        }

        // Pass the instance of Mapper
        MKPhotoPicker($uiImages, mapper: mapper)
    }
}
```

