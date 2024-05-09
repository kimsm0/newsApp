//
//  File.swift
//  
//
//  Created by kimsoomin_mac2022 on 5/9/24.
//

import UIKit

public class CustomImageView: UIImageView {
    
    private let hasLoading: Bool
    private let loadingView = UIActivityIndicatorView(style: .medium)
    
    public var isDownloaded: Bool = false {
        didSet{
            if isDownloaded {
                loadingView.stopAnimating()
            }else {
                loadingView.startAnimating()
            }
        }
    }
    
    public init(hasLoading: Bool, 
                accessibilityIdentifier: String,
                mode: ContentMode
    ){
        self.hasLoading = hasLoading
        super.init(frame: .zero)
        self.accessibilityIdentifier = accessibilityIdentifier
        //self.contentMode = mode
        attribute()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func attribute(){
        if hasLoading {
            self.addSubview(loadingView)
            loadingView.snp.makeConstraints{
                $0.edges.equalToSuperview()
            }
            loadingView.startAnimating()
            loadingView.color = .red
        }
        
        self.contentMode = .scaleAspectFill
        self.clipsToBounds = true
        self.layer.cornerRadius = 8
    }

}
