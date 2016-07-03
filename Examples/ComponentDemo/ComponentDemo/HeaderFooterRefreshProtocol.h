//
//  HeaderFooterRefreshProtocol.h
//  ComponentDemo
//
//  Created by HuangPeng on 7/3/16.
//  Copyright © 2016 Beacon. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol HeaderFooterRefreshProtocol <NSObject>

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
