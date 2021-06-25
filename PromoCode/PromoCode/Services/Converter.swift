//
//  Converter.swift
//  PromoCode
//
//  Created by Дарья on 25.06.2021.
//

import Foundation
import FirebaseFirestore

final class PromocodesConverter {

    static func promocode(from dict: [String : Any]) -> PromoCode? {
        var res = PromoCode()
        guard let id = dict[PromoCodeKey.id.rawValue] as? String,
              let service = dict[PromoCodeKey.service.rawValue] as? String,
              let promocode = dict[PromoCodeKey.promocode.rawValue] as? String else {
            return nil
        }
        res.id = id
        res.service = service
        res.promocode = promocode
        if let description = dict[PromoCodeKey.description.rawValue] as? String {
            res.description = description
        }
        if let timestamp = dict[PromoCodeKey.date.rawValue] as? Timestamp {
            res.date = timestamp.dateValue()
        }
        return res
    }
}
