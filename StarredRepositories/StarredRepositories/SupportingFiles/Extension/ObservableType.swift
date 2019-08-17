//
//  ObservableType.swift
//  StarredRepositories
//
//  Created by Gustavo Tiago on 16/08/19.
//  Copyright © 2019 Tiago. All rights reserved.
//

import RxSwift

extension ObservableType {
    func compactMap<R>(_ transform: @escaping (Self.E) throws -> R?) -> RxSwift.Observable<R> {
        return self.map { try? transform($0) }.filter { $0 != nil }.map { $0! }
    }
}
