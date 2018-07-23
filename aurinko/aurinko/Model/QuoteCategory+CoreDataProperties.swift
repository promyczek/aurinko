//
//  QuoteCategory+CoreDataProperties.swift
//  aurinko
//
//  Created by Ania on 22/07/2018.
//  Copyright © 2018 Ania. All rights reserved.
//
//

import Foundation
import CoreData


extension QuoteCategory {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<QuoteCategory> {
        return NSFetchRequest<QuoteCategory>(entityName: "QuoteCategory")
    }

    @NSManaged public var id: Int16
    @NSManaged public var name: String?
    @NSManaged public var quotes: NSSet?

}

// MARK: Generated accessors for quotes
extension QuoteCategory {

    @objc(addQuotesObject:)
    @NSManaged public func addToQuotes(_ value: Quote)

    @objc(removeQuotesObject:)
    @NSManaged public func removeFromQuotes(_ value: Quote)

    @objc(addQuotes:)
    @NSManaged public func addToQuotes(_ values: NSSet)

    @objc(removeQuotes:)
    @NSManaged public func removeFromQuotes(_ values: NSSet)

}
