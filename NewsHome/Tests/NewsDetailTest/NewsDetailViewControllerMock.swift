//
//  File.swift
//  
//
//  Created by kimsoomin_mac2022 on 4/27/24.
//
@testable import NewsDetail
import Combine
import ModernRIBs
import UIKit
import SnapKit
import Then
import Extensions
import NewsDataModel
import CustomUI
import Common

final class NewsDetailViewControllerMock: UIViewController, NewsDetailPresentable, NewsDetailViewControllable {
    
    weak var listener: NewsDetailPresentableListener?
    
    private var totalEntity: ArticleTotalEntity?
    private var indexSubject = CurrentValueSubject<Int?, Never>(nil)
    private var subscriptions = Set<AnyCancellable>()
    
    private let moveButtonView = MoveButtonView()
    
    
    public var index: Int?
    
    public var totalEntityCount: Int {
        totalEntity?.articles.count ?? 0
    }
    
    init(){
        super.init(nibName: nil, bundle: nil)
        bind()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func bind(){
        moveButtonView.nextButton.throttleTapPublisher()
            .receive(on: DispatchQueue.main)
            .sink {[weak self] _  in
                if let self, let index = self.indexSubject.value {
                    if let totalEntity = self.totalEntity, totalEntity.articles.count - 1 == index
                    {
                        listener?.loadMoreFromDetail()
                    }else {
                        self.indexSubject.send(index + 1)
                    }
                }
            }.store(in: &subscriptions)
        
        moveButtonView.preButton.throttleTapPublisher()
            .receive(on: DispatchQueue.main)
            .sink {[weak self] _  in
                if let self, let index = self.indexSubject.value {
                    self.indexSubject.send(index - 1)
                }
            }.store(in: &subscriptions)
        
        indexSubject.sink {[weak self] index in
            guard let weakSelf = self, let index = index else { return }
            weakSelf.index = index
            
            weakSelf.moveButtonView.nextButton.isEnabled = (index < (weakSelf.totalEntity?.totalResults ?? 0) - 1)
            weakSelf.moveButtonView.preButton.isEnabled = (index != 0)
            
            if let article = weakSelf.totalEntity?.articles[safe: index]{
                weakSelf.config(article: article)
            } else {
                weakSelf.reset()
            }
        }.store(in: &subscriptions)
    }
    
    public var updateCallCount = 0
    func update(total: ArticleTotalEntity, startPageIndex: Int) {
        updateCallCount += 1
        totalEntity = total
        if let index = indexSubject.value {
            indexSubject.send(index + 1)
        }else {
            indexSubject.send(startPageIndex)
        }
    }
    
    public var configCallCount = 0
    func config(article: ArticleEntity){
        configCallCount += 1
    }
    
    public var resetCallCount = 0
    func reset(){
        resetCallCount += 1
    }
    
    public var showAlertCallCount = 0
    func showAlert(message: String) {
        showAlertCallCount += 1
    }
    
    public var didTapBackButtonCallCount = 0
    @objc
    private func didTapBackButton() {
        didTapBackButtonCallCount += 1
        listener?.didTapBackButton(index: indexSubject.value ?? 0)
    }
}
