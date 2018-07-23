//
//  Quote+CoreDataProperties.swift
//  aurinko
//
//  Created by Ania on 22/07/2018.
//  Copyright © 2018 Ania. All rights reserved.
//
//

import Foundation
import CoreData


extension Quote {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Quote> {
        return NSFetchRequest<Quote>(entityName: "Quote")
    }

    @NSManaged public var text: String?
    @NSManaged public var id: Int16
    @NSManaged public var category: QuoteCategory?

}
