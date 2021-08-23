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
    func addPromocode(promocode: PromoCode, sphere: Spheres, completion: @escaping (Result<PromoCode, СustomError>) -> Void)
    func searchPromocodes(query: String, sphere: Spheres, completion: @escaping (Result<PromoCode, СustomError>) -> Void)
}


final class NetworkManager: NetworkManagerDescription {
    
    static let shared = NetworkManager()
    
    private let database = Firestore.firestore()
    
    private let coreDataManager: CoreDataManagerDescription = CoreDataManager.shared
    
    private init() { }
    
    // MARK: - Get
    
    func getPromocodes(for sphere: Spheres, completion: @escaping (Result<[PromoCode], СustomError>) -> Void) {
        database.collection(sphere.rawValue).getDocuments { [weak self] (querySnapshot, error) in
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
                guard var promocode = PromocodesConverter.promocode(from: document.data()) else {
                    continue
                }
                promocode.isInFavorites = (self?.coreDataManager.isInCoreDataBase(promocode: promocode)) ?? false
                promocodes.append(promocode)
            }
            completion(.success(promocodes))
        }
    }
    
    // MARK: - Add
    
    func addPromocode(promocode: PromoCode, sphere: Spheres, completion: @escaping (Result<PromoCode, СustomError>) -> Void) {
        let ref = database.collection(sphere.rawValue).document()
        let docId = ref.documentID
        
        ref.setData([PromoCodeKey.id.rawValue : docId,
                     PromoCodeKey.service.rawValue : promocode.service,
                     PromoCodeKey.description.rawValue : promocode.description,
                     PromoCodeKey.promocode.rawValue : promocode.promocode,
                     PromoCodeKey.date.rawValue : Timestamp(date: promocode.date)]) { (error) in
            if error != nil {
                completion(.failure(СustomError.failedToAddPromocode))
            } else {
                completion(.success(promocode))
            }
        }
    }
    
    // MARK: - Search
    
    func searchPromocodes(query: String, sphere: Spheres, completion: @escaping (Result<PromoCode, СustomError>) -> Void) {
        let ref = database.collection(sphere.rawValue)
        ref.whereField(PromoCodeKey.service.rawValue, isEqualTo: query).getDocuments() { [weak self] (querySnapshot, err) in
            if let _ = err {
                completion(.failure(.failedFindingPromocodes))
                return
            }
            guard let querySnapshot = querySnapshot else {
                completion(.failure(.failedFindingPromocodes))
                return
            }
            if querySnapshot.documents.isEmpty {
                completion(.failure(.failedFindingPromocodes))
                return
            }
            for document in querySnapshot.documents {
                if var promocode = PromocodesConverter.promocode(from: document.data()) {
                    promocode.isInFavorites = (self?.coreDataManager.isInCoreDataBase(promocode: promocode)) ?? false
                    completion(.success(promocode))
                }
            }
            return
        }
    }
}

