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
    
    private var elements: [PageIndex : ResultsPage<T>] = [:]
    
    /// The number of pages in the results.
    var count: Int {
        return allItems.count
    }
    
    /// The current page of the results.
    var currentPage: PageIndex {
        guard elements.count > 0 else {
            return 0
        }
        return elements.count - 1
    }
    
    /// The next page in the results.
    var nextPage: PageIndex {
        return elements.count
    }
    
    /// The size of each page.
    let pageSize: Int
    
    /// All the items in the results.
    var allItems: [T] {
        var allItems = [T]()
        
        let indexes = elements.keys.sorted()
        indexes.forEach { (pageIndex) in
            allItems.append(contentsOf: elements[pageIndex]!.items)
        }
        return allItems
    }
    
    /// Whether the results are empty.
    var isEmpty: Bool {
        return elements.count == 0
    }
    
    /// Whether the results can be paged further.
    var canPageFurther: Bool {
        return elements[self.currentPage]?.items.count == pageSize
    }
    
    // MARK: Init
    
    init(with pageSize: Int) {
        self.pageSize = pageSize
    }
    
    // MARK: Data fetch
    
    func page(at index: PageIndex) -> [T]? {
        guard elements.count < index else { return nil }
        return elements[index]?.items
    }
    
    // MARK: Mutation
    
    /// Add a page to the results.
    ///
    /// - Parameter page: The page to add.
    func append(page: [T]) {
        let nextIndex = elements.count
        elements[nextIndex] = ResultsPage<T>(with: page)
    }
    
    /// Insert a page at an index.
    ///
    /// - Parameters:
    ///   - page: The page to insert.
    ///   - index: The index to insert the page at.
    func insert(page: [T],
                at index: PageIndex) {
        
        let index = min(index, elements.count)
        elements[index] = ResultsPage<T>(with: page)

        // invalidate later page indexes
        let validElements = self.elements.filter({ $0.key <= index})
        self.elements.removeAll()
        validElements.forEach { (index, page) in
            self.elements[index] = page
        }
    }
}

fileprivate extension PagedResults {
    
    class ResultsPage<T> {
        
        let items: [T]
        
        private(set) var isValid: Bool = true
        
        init(with items: [T]) {
            self.items = items
        }
        
        func invalidate() {
            isValid = false
        }
    }
}
