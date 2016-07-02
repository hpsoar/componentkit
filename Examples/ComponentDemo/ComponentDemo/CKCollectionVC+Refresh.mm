//
//  CKCollectionVC+Refresh.m
//  ComponentDemo
//
//  Created by HuangPeng on 7/1/16.
//  Copyright © 2016 Beacon. All rights reserved.
//

#import "CKCollectionVC+Refresh.h"

@implementation CKCollectionVC (Refresh)

#pragma mark - header

- (void)enableHeaderRefresh {
    if (self.collectionView.mj_header) {
        return;
    }
    
    Class cls = [self headerRefreshViewClass];
    
    self.collectionView.mj_header = [cls headerWithRefreshingTarget:self refreshingAction:@selector(beginHeaderRefreshing)];
}

- (void)disableHeaderRefresh {
    self.collectionView.mj_header = nil;
}

- (void)beginHeaderRefreshing {
    
}

- (void)endHeaderRefreshing {
    [self.collectionView.mj_header endRefreshing];
}

#pragma mark - footer

- (void)enableFooterRefresh {
    if (self.collectionView.mj_footer) {
        return;
    }
    
    Class cls = [self footerRefreshViewClass];
    
    self.collectionView.mj_footer = [cls footerWithRefreshingTarget:self refreshingAction:@selector(beginFooterRefreshing)];
    self.collectionView.mj_footer.layer.zPosition = -1000;
}

- (void)disableFooterRefresh {
    self.collectionView.mj_footer = nil;
}

- (void)beginFooterRefreshing {
    
}

- (void)endFooterRefreshing {
    [self.collectionView.mj_footer endRefreshing];
}

#pragma mark - customization

- (Class)headerRefreshViewClass {
    return [MJRefreshNormalHeader class];
}

- (Class)footerRefreshViewClass {
    return [MJRefreshAutoNormalFooter class];
}

@end
