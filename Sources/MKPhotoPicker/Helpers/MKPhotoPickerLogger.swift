import os

internal enum MKPhotoPickerLogger {
    static var logger: Logger { Logger(subsystem: Bundle.main.bundleIdentifier!, category: "PhotoPicker.MappResult") }
}
