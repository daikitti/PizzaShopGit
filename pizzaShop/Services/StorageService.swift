//
//  StorageService.swift
//  pizzaShop
//
//  Created by Have Dope on 03.04.2023.
//

import Foundation
import FirebaseStorage
import Firebase

class StorageService {
    static let shared  = StorageService()
    
    private init() {}
    
    private let storage = Storage.storage().reference()
    private var productsRef: StorageReference {  storage.child("products")    }
    
    func upload(id: String, image: Data, comletion: @escaping (Result<String, Error>) -> () ) {
        let metadata = StorageMetadata()
        metadata.contentType = "image/jpg"
        productsRef.child(id).putData(image, metadata: metadata) { metadata, error in
            
            guard let metadata = metadata else {
                if let error = error {
                    comletion(.failure(error))
                }
                return
            }
            comletion(.success("Размер полученного изображениея: \(metadata.size)"))
        }
    }
    func downloadProductImage(id: String,comletion: @escaping (Result<Data, Error>) -> () ) {
        productsRef.child(id).getData(maxSize: 2 * 1024 * 1024) { data, error in
            guard let data = data else {
                if let error = error {
                    comletion(.failure(error))
                }
                
                return
            }
            comletion(.success(data))
        }
    }
}
