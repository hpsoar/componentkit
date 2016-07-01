//
//  CKCollectionVC+Refresh.h
//  ComponentDemo
//
//  Created by HuangPeng on 7/1/16.
//  Copyright © 2016 Beacon. All rights reserved.
//

#import "CKCollectionVC.h"
#import <MJRefresh.h>

@interface CKCollectionVC (Refresh)

- (void)enableHeaderRefresh;
- (void)disableHeaderRefresh;
- (void)beginHeaderRefreshing;
- (void)endHeaderRefreshing;

- (void)enableFooterRefresh;
- (void)disableFooterRefresh;
- (void)beginFooterRefreshing;
- (void)endFooterRefreshing;

- (Class)headerRefreshViewClass;
- (Class)footerRefreshViewClass;

@end
