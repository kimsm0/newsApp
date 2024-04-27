//
//  File.swift
//  
//
//  Created by kimsoomin_mac2022 on 4/26/24.
//

import Foundation
@testable import NewsMain
import NewsRepository

final class NewsMainInteractorDependencyMock: NewsMainInteractorDependency {
    var newsRepository: NewsRepository = NewsRepositoryImpMock()
}
