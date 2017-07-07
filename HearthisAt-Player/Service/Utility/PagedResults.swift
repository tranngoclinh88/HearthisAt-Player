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
    
    var count: Int {
        return allItems.count
    }
    
    var currentPage: PageIndex {
        guard elements.count > 0 else {
            return 0
        }
        return elements.count - 1
    }
    var nextPage: PageIndex {
        return elements.count
    }
    
    let pageSize: Int
    
    var allItems: [T] {
        var allItems = [T]()
        
        let indexes = elements.keys.sorted()
        indexes.forEach { (pageIndex) in
            allItems.append(contentsOf: elements[pageIndex]!.items)
        }
        return allItems
    }
    
    var isEmpty: Bool {
        return elements.count == 0
    }
    
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
    
    func append(page: [T]) {
        let nextIndex = elements.count
        elements[nextIndex] = ResultsPage<T>(with: page)
    }
    
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
