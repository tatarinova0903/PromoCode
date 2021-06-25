//
//  NetworkManager.swift
//  PromoCode
//
//  Created by Дарья on 25.06.2021.
//

import Foundation
import FirebaseFirestore

protocol NetworkManagerDescription {
    func getPromocodes(for sphere: Spheres, completion: @escaping (Result<[PromoCode], СustomError>) -> Void)
}


class NetworkManager: NetworkManagerDescription {
    
    static let shared = NetworkManager()
    
    private let database = Firestore.firestore()
    
    private init() { }
    
    func getPromocodes(for sphere: Spheres, completion: @escaping (Result<[PromoCode], СustomError>) -> Void) {
        database.collection(sphere.rawValue).getDocuments { (querySnapshot, error) in
            if error != nil {
                completion(.failure(СustomError.error))
                return
            }
            
            guard let documents = querySnapshot?.documents else {
                completion(.failure(СustomError.unexpected))
                return
            }
            var promocodes = [PromoCode]()
            for document in documents {
                guard let promocode = PromocodesConverter.promocode(from: document.data()) else {
                    continue
                }
                promocodes.append(promocode)
            }
            completion(.success(promocodes))
        }
    }
}

