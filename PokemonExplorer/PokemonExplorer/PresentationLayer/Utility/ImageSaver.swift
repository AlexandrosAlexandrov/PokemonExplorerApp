//
//  ImageSaver.swift
//  PokemonExplorer
//
//  Created by Alexandros Alexandrov on 3/10/24.
//

import SwiftUI

class ImageSaver {
    // Directory for storing downloaded images
    static let imageDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!

    // Function to get the local file path using the Pokemon's name
    static func localImagePath(for name: String) -> URL {
        return imageDirectory.appendingPathComponent("\(name).jpg")
    }

    // Function to save the image from a URL locally using the Pokemon name
    static func downloadAndSaveImage(for name: String, from url: String, completion: @escaping (UIImage?) -> Void) {
        let localPath = localImagePath(for: name)

        // Check if the image already exists locally
        if FileManager.default.fileExists(atPath: localPath.path) {
            // Load the image from local storage
            let image = UIImage(contentsOfFile: localPath.path)
            completion(image)
            return
        }

        // If image is not present locally, download it
        guard let imageURL = URL(string: url) else {
            completion(nil)
            return
        }

        let task = URLSession.shared.dataTask(with: imageURL) { data, response, error in
            guard let data = data, let image = UIImage(data: data), error == nil else {
                completion(nil)
                return
            }

            // Save the image locally using the Pokemon's name
            do {
                try data.write(to: localPath)
                completion(image)
            } catch {
                print("Failed to save image: \(error)")
                completion(nil)
            }
        }
        task.resume()
    }
    
    static func getSavedImage(for name: String) -> UIImage? {
        let localPath = localImagePath(for: name)

        // Check if the image exists locally
        if FileManager.default.fileExists(atPath: localPath.path) {
            // Load and return the image from local storage
            return UIImage(contentsOfFile: localPath.path)
        } else {
            // Return nil if image doesn't exist locally
            return nil
        }
    }
}
