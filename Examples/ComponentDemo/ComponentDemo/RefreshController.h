//
//  RefreshController.h
//  ComponentDemo
//
//  Created by HuangPeng on 7/3/16.
//  Copyright © 2016 Beacon. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol RefreshControllerDelegate <NSObject>

@optional
- (void)beginHeaderRefreshing;
- (void)beginFooterRefreshing;

@end

@interface RefreshController : NSObject

- (instancetype)initWithScrollView:(UIScrollView *)scrollView
                          delegate:(id<RefreshControllerDelegate>)delegate;

- (void)enableHeaderRefresh;
- (void)disableHeaderRefresh;
- (void)endHeaderRefreshing;

- (void)enableFooterRefresh;
- (void)disableFooterRefresh;
- (void)endFooterRefreshing;

@property(nonatomic, weak) id<RefreshControllerDelegate> delegate;

@end
