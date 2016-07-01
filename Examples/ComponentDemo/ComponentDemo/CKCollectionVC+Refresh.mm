//
//  CKCollectionVC+Refresh.m
//  ComponentDemo
//
//  Created by HuangPeng on 7/1/16.
//  Copyright © 2016 Beacon. All rights reserved.
//

#import "CKCollectionVC+Refresh.h"

@implementation CKCollectionVC (Refresh)

- (void)enableHeaderRefresh {
    [self disableHeaderRefresh];
    
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

#pragma mark -

- (void)enableFooterRefresh {
    [self disableFooterRefresh];
    
    Class cls = [self footerRefreshViewClass];
    
    self.collectionView.mj_footer = [cls footerWithRefreshingTarget:self refreshingAction:@selector(beginFooterRefreshing)];
}

- (void)disableFooterRefresh {
    self.collectionView.mj_footer = nil;
}

- (void)beginFooterRefreshing {
    
}

- (void)endFooterRefreshing {
    [self.collectionView.mj_footer endRefreshing];
}

- (Class)headerRefreshViewClass {
    return [MJRefreshNormalHeader class];
}

- (Class)footerRefreshViewClass {
    return [MJRefreshBackNormalFooter class];
}

@end
