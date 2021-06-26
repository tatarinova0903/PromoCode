//
//  CoreDataManager.swift
//  PromoCode
//
//  Created by Дарья on 25.06.2021.
//

import UIKit
import CoreData

protocol CoreDataManagerDescription {
    func getPromoCodes(delegate: FavoritesViewInput?) -> [FavPromoCode]
    func getPromocode(byIndexPath indexPath: IndexPath) -> FavPromoCode
    func addPromoCode(promocode: PromoCode)
    func deletePromoCode(promocode: PromoCode)
    func isInCoreDataBase(promocode: PromoCode) -> Bool
    func getNumberOfRowsInSection(_ section: Int) -> Int
    func getNumberOfSections() -> Int 
}

final class CoreDataManager: CoreDataManagerDescription {
    
    static let shared = CoreDataManager()
    
    private let context = (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer.viewContext
    private var fetchedResultsController: NSFetchedResultsController<FavPromoCode>?
    
    private init() { }
    
    // MARK: - Get
    
    func getPromoCodes(delegate: FavoritesViewInput?) -> [FavPromoCode] {
        if fetchedResultsController == nil {
            let request: NSFetchRequest<FavPromoCode> = FavPromoCode.fetchRequest()
            let sort = NSSortDescriptor(key: "date", ascending: false)
            request.sortDescriptors = [sort]
//            request.fetchBatchSize = 20
            guard let context = context else { return [] }
            fetchedResultsController = NSFetchedResultsController(fetchRequest: request, managedObjectContext: context, sectionNameKeyPath: nil, cacheName: nil)
            fetchedResultsController?.delegate = delegate
        }
        
        do {
            try fetchedResultsController?.performFetch()
            return fetchedResultsController?.fetchedObjects ?? []
        } catch {
            print("Fetch failed")
            return []
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
        request.predicate = NSPredicate(format: "id == %@", argumentArray: [id])
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
    
    func deletePromoCode(promocode: PromoCode) {
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
    
    // MARK: - Check
    
    func isInCoreDataBase(promocode: PromoCode) -> Bool {
        let request: NSFetchRequest<FavPromoCode> = FavPromoCode.fetchRequest()
        request.predicate = NSPredicate(format: "id == %@", argumentArray: [promocode.id])
        guard let promocodes = try? context?.fetch(request) else {
            return false
        }
        return promocodes.count == 0 ? false : true
    }

}
