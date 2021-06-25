//
//  FavPromoCode+CoreDataProperties.swift
//  PromoCode
//
//  Created by Дарья on 25.06.2021.
//
//

import Foundation
import CoreData


extension FavPromoCode {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<FavPromoCode> {
        return NSFetchRequest<FavPromoCode>(entityName: "FavPromoCode")
    }

    @NSManaged public var id: String
    @NSManaged public var service: String
    @NSManaged public var promocode: String
    @NSManaged public var describe: String?
    @NSManaged public var date: Date?

}

extension FavPromoCode : Identifiable {

}
