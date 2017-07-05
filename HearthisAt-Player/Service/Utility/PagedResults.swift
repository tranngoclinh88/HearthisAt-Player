//
//  PagedResults.swift
//  HearthisAt-Player
//
//  Created by Merrick Sapsford on 05/07/2017.
//  Copyright © 2017 Merrick Sapsford. All rights reserved.
//

import Foundation

class PagedResults<T> {
    
    // MARK: Types
    
    typealias PageIndex = Int
    
    // MARK: Properties
    
    private var pages: [PageIndex : [T]] = [:]
    
    var count: Int {
        return allItems.count
    }
    
    var allItems: [T] {
        var allItems = [T]()
        pages.forEach { (pageIndex, items) in
            allItems.append(contentsOf: items)
        }
        return allItems
    }
    
    func append(page: [T]) {
        let nextIndex = pages.count
        pages[nextIndex] = page
    }
    
    func page(at index: PageIndex) -> [T]? {
        guard pages.count < index else { return nil }
        return pages[index]
    }
}
