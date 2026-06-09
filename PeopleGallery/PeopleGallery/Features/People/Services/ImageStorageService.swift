//
//  ImageStorageService.swift
//  PeopleGallery
//
//  Created by Karla E. Martins Fernandes on 09/06/26.
//

import UIKit

final class ImageStorageService {
    
    func save(image: UIImage) -> String? {

        let imageName = UUID().uuidString
        let imagePath = getDocumentsDirectory().appendingPathComponent(imageName)

        guard let jpegData = image.jpegData(compressionQuality: 0.8) else {
            return nil
        }

        do {
            try jpegData.write(to: imagePath)
            return imageName
        } catch {
            return nil
        }
    }
    
    private func getDocumentsDirectory() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return paths[0]
    }
    
    func loadImage(named imageName: String) -> UIImage? {

        let imagePath = getDocumentsDirectory().appendingPathComponent(imageName)

        return UIImage(contentsOfFile: imagePath.path)
    }
}
