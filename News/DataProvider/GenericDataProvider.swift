//
//  GenericDataProvider.swift
//  News
//
//  Created by Pedro Franco on 28/06/23.
//

import Foundation

protocol GenericDataProvider {
    func sucessData(model: Any)
    func errorData(_ provide: GenericDataProvider?, error: Error)
}

class DataProviderManager<T, S> {
    var delegate: T? 
    var model: S?
}

