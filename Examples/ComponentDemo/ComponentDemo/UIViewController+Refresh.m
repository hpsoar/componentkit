//
//  UIViewController+Refresh.m
//  ComponentDemo
//
//  Created by HuangPeng on 7/3/16.
//  Copyright © 2016 Beacon. All rights reserved.
//

#import "UIViewController+Refresh.h"
#import <MJRefresh.h>

@implementation UIViewController (Refresh)

- (UIScrollView *)mj_scrollView {
    return nil;
}

#pragma mark - header

- (void)enableHeaderRefresh {
    if (self.mj_scrollView.mj_header) {
        return;
    }
    
    Class cls = [self headerRefreshViewClass];
    
    self.mj_scrollView.mj_header = [cls headerWithRefreshingTarget:self refreshingAction:@selector(beginHeaderRefreshing)];
}

- (void)disableHeaderRefresh {
    self.mj_scrollView.mj_header = nil;
}

- (void)beginHeaderRefreshing {
    
}

- (void)endHeaderRefreshing {
    [self.mj_scrollView.mj_header endRefreshing];
}

#pragma mark - footer

- (void)enableFooterRefresh {
    if (self.mj_scrollView.mj_footer) {
        return;
    }
    
    Class cls = [self footerRefreshViewClass];
    
    self.mj_scrollView.mj_footer = [cls footerWithRefreshingTarget:self refreshingAction:@selector(beginFooterRefreshing)];
    self.mj_scrollView.mj_footer.layer.zPosition = -1000;
}

- (void)disableFooterRefresh {
    self.mj_scrollView.mj_footer = nil;
}

- (void)beginFooterRefreshing {
    
}

- (void)endFooterRefreshing {
    [self.mj_scrollView.mj_footer endRefreshing];
}

#pragma mark - customization

- (Class)headerRefreshViewClass {
    return [MJRefreshNormalHeader class];
}

- (Class)footerRefreshViewClass {
    return [MJRefreshAutoNormalFooter class];
}

@end
