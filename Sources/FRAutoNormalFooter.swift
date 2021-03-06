//
//  FRAutoNormalFooter.swift
//  FitRefresh
//
//  Created by Cyrill on 2016/12/28.
//  Copyright © 2016年 Cyrill. All rights reserved.
//

import UIKit

public class FRAutoNormalFooter: FRAutoStateFooter {
    
    // MARK: - public
    /// loading样式
    public var activityIndicatorViewStyle = UIActivityIndicatorView.Style.gray {
        didSet {
            self.activityView.style = activityIndicatorViewStyle
            self.setNeedsLayout()
        }
    }
    
    // MARK: - private
    // loading
    lazy var activityView: UIActivityIndicatorView = {
        [unowned self] in
        
        let activityView = UIActivityIndicatorView(style: self.activityIndicatorViewStyle)
        activityView.hidesWhenStopped = true
        self.addSubview(activityView)
        return activityView
        }()
    
    
    // MARK: 重写 rewrite
    override func placeSubvies() {
        super.placeSubvies()
        if self.activityView.constraints.count > 0 { return }
        // loading
        var activityViewCenterX = self.width * 0.5
        if !self.isRefreshingTitleHidden {
            activityViewCenterX -= self.stateLabel.fr_textWidth * 0.5 + labelLeftInset
        }
        let activityViewCenterY = self.height * 0.5
        self.activityView.center = CGPoint(x: activityViewCenterX, y: activityViewCenterY)
    }
    
    override var state: RefreshState {
        didSet {
            if oldValue == state { return }
            if state == RefreshState.noMoreData || state == RefreshState.idle {
                self.activityView.stopAnimating()
            } else if state == RefreshState.refreshing  {
                self.activityView.startAnimating()
            }
        }
    }
    
}
