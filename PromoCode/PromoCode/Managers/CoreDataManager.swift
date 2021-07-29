//
//  CoreDataManager.swift
//  PromoCode
//
//  Created by Дарья on 25.06.2021.
//

import UIKit
import CoreData

protocol CoreDataManagerDescription {
    func setupFetchedResultsController(delegate: FavoritesViewInput?)
    func getPromocode(byIndexPath indexPath: IndexPath) -> FavPromoCode
    func addPromoCode(promocode: PromoCode)
    func delete(promocode: PromoCode)
    func delete(promocode: FavPromoCode)
    func isInCoreDataBase(promocode: PromoCode) -> Bool
    func getNumberOfRowsInSection(_ section: Int) -> Int
    func getNumberOfSections() -> Int
    func search(query: String) -> [FavPromoCode]
}

final class CoreDataManager: CoreDataManagerDescription {
    
    static let shared = CoreDataManager()
    
    private let context = (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer.viewContext
    private var fetchedResultsController: NSFetchedResultsController<FavPromoCode>?
    
    private init() { }
    
    // MARK: - Get
    
    func setupFetchedResultsController(delegate: FavoritesViewInput?) {
        if fetchedResultsController == nil {
            let request: NSFetchRequest<FavPromoCode> = FavPromoCode.fetchRequest()
            let sort = NSSortDescriptor(key: "date", ascending: false)
            request.sortDescriptors = [sort]
//            request.fetchBatchSize = 20
            guard let context = context else { return }
            fetchedResultsController = NSFetchedResultsController(fetchRequest: request, managedObjectContext: context, sectionNameKeyPath: nil, cacheName: nil)
            fetchedResultsController?.delegate = delegate
        }
        
        do {
            try fetchedResultsController?.performFetch()
        } catch {
            print("Fetch failed")
        }
    }
    
    func getNumberOfRowsInSection(_ section: Int) -> Int {
        let sectionInfo = fetchedResultsController?.sections?[section]
        return sectionInfo?.numberOfObjects ?? 0
    }
    
    func getNumberOfSections() -> Int {
        fetchedResultsController?.sections?.count ?? 0
    }
    
    func getPromocode(byId id: String) -> FavPromoCode? {
        let request: NSFetchRequest<FavPromoCode> = FavPromoCode.fetchRequest()
        request.predicate = NSPredicate(format: "id == %@", id)
        let promocodes = try? context?.fetch(request)
        return promocodes?.first
    }
    
    func getPromocode(byIndexPath indexPath: IndexPath) -> FavPromoCode {
        fetchedResultsController?.object(at: indexPath) ?? FavPromoCode()
    }
    
    // MARK: - Add
    
    func addPromoCode(promocode: PromoCode) {
        guard let context = context else { return }
        let newPromoCode = FavPromoCode(context: context)
        newPromoCode.id = promocode.id
        newPromoCode.service = promocode.service
        newPromoCode.promocode = promocode.promocode
        newPromoCode.date = promocode.date
        newPromoCode.describe = promocode.description
        
        do {
            try context.save()
        } catch let err {
            print(err.localizedDescription)
        }
    }
    
    // MARK: - Delete
    
    func delete(promocode: PromoCode) {
        guard let context = context else { return }
        let newPromoCode = getPromocode(byId: promocode.id)
        guard let saveNewPromoCode = newPromoCode else {
            return
        }
        context.delete(saveNewPromoCode)
        do {
            try context.save()
        } catch let err {
            print(err.localizedDescription)
        }
    }
    
    func delete(promocode: FavPromoCode) {
        guard let context = context else { return }
        context.delete(promocode)
        do {
            try context.save()
        } catch let err {
            print(err.localizedDescription)
        }
    }
    
    // MARK: - Check
    
    func isInCoreDataBase(promocode: PromoCode) -> Bool {
        let request: NSFetchRequest<FavPromoCode> = FavPromoCode.fetchRequest()
        request.predicate = NSPredicate(format: "id == %@", argumentArray: [promocode.id])
        guard let promocodes = try? context?.fetch(request) else {
            return false
        }
        return promocodes.count == 0 ? false : true
    }
    
    // MARK: - Search
    
    func search(query: String) -> [FavPromoCode] {
        let request: NSFetchRequest<FavPromoCode> = FavPromoCode.fetchRequest()
        let predicate = NSPredicate(format: "\(PromoCodeKey.service.rawValue) contains[c] %@", query)
        request.predicate = predicate
        do {
            let fetchResult = try context?.fetch(request)
            guard let promocodes = fetchResult else {
                return []
            }
            return promocodes
        } catch {
            print("Fetch failed")
            return []
        }
    }
}
