//
//  ImageSaver.swift
//  PokemonExplorer
//
//  Created by Alexandros Alexandrov on 3/10/24.
//

import SwiftUI

class ImageSaver {
    static let imageDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
    
    static func localImagePath(for name: String) -> URL {
        return imageDirectory.appendingPathComponent("\(name).jpg")
    }
    
    static func downloadAndSaveImage(for name: String, from url: String, completion: @escaping (UIImage?) -> Void) {
        let localPath = localImagePath(for: name)
        
        if FileManager.default.fileExists(atPath: localPath.path) {
            let image = UIImage(contentsOfFile: localPath.path)
            completion(image)
            return
        }
        
        guard let imageURL = URL(string: url) else {
            completion(nil)
            return
        }
        
        let task = URLSession.shared.dataTask(with: imageURL) { data, response, error in
            guard let data = data, let image = UIImage(data: data), error == nil else {
                completion(nil)
                return
            }
            
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
        
        if FileManager.default.fileExists(atPath: localPath.path) {
            return UIImage(contentsOfFile: localPath.path)
        } else {
            return nil
        }
    }
}
