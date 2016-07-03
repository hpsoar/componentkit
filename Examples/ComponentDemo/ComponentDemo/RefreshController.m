//
//  RefreshController.m
//  ComponentDemo
//
//  Created by HuangPeng on 7/3/16.
//  Copyright © 2016 Beacon. All rights reserved.
//

#import "RefreshController.h"
#import "RefreshController_SubClass.h"
#import <MJRefresh.h>

@interface RefreshController ()

@property(nonatomic, strong) UIScrollView *scrollView;

@end

@implementation RefreshController {
}

- (instancetype)initWithScrollView:(UIScrollView *)scrollView
                          delegate:(id<RefreshControllerDelegate>)delegate {
    self = [super init];
    if (self) {
        self.scrollView = scrollView;
        self.delegate = delegate;
    }
    return self;
}

#pragma mark - header

- (void)enableHeaderRefresh {
    if (self.scrollView.mj_header) {
        return;
    }

    self.scrollView.mj_header = [self headerView];
}

- (void)disableHeaderRefresh {
    self.scrollView.mj_header = nil;
}

- (void)endHeaderRefreshing {
    [self.scrollView.mj_header endRefreshing];
}

#pragma mark - footer

- (void)enableFooterRefresh {
    if (self.scrollView.mj_footer) {
        return;
    }

    self.scrollView.mj_footer = [self footerView];
}

- (void)disableFooterRefresh {
    self.scrollView.mj_footer = nil;
}

- (void)endFooterRefreshing {
    [self.scrollView.mj_footer endRefreshing];
}

#pragma mark - create

- (MJRefreshFooter *)footerView {
    NSAssert(self.delegate, @"please set delegate first");
    MJRefreshFooter *footer = [MJRefreshAutoNormalFooter
        footerWithRefreshingTarget:self.delegate
                  refreshingAction:@selector(beginFooterRefreshing)];
    footer.layer.zPosition = -1000;
    return footer;
}

- (MJRefreshHeader *)headerView {
    NSAssert(self.delegate, @"please set delegate first");
    return [MJRefreshNormalHeader
        headerWithRefreshingTarget:self.delegate
                  refreshingAction:@selector(beginHeaderRefreshing)];
}

@end
