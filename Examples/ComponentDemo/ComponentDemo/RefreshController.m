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
@property(nonatomic, strong) NSMutableSet *delegates;

@end

@implementation RefreshController {
}

- (instancetype)initWithScrollView:(UIScrollView *)scrollView
                          delegate:(id<RefreshControllerDelegate>)delegate {
    self = [super init];
    if (self) {
        self.scrollView = scrollView;
        self.delegates = (__bridge_transfer NSMutableSet *)CFSetCreateMutable(nil, 0, nil);
        [self forwardingTo:delegate];
    }
    return self;
}

- (void)forwardingTo:(id<RefreshControllerDelegate>)delegate {
    if (delegate) {
        [self.delegates addObject:delegate];
    }
}

- (void)removeForwarding:(id<RefreshControllerDelegate>)delegate {
    [self.delegates removeObject:delegate];
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
    if (self.scrollView.mj_header) {
        [self.scrollView.mj_header endRefreshing];
    }
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
    if (self.scrollView.mj_footer) {
        [self.scrollView.mj_footer endRefreshing];
    }
}

#pragma mark - create

- (MJRefreshFooter *)footerView {
    
    MJRefreshFooter *footer = [MJRefreshAutoNormalFooter
        footerWithRefreshingTarget:self
                  refreshingAction:@selector(beginFooterRefreshing)];
    footer.layer.zPosition = -1000;
    return footer;
}

- (MJRefreshHeader *)headerView {
    return [MJRefreshNormalHeader
        headerWithRefreshingTarget:self
                  refreshingAction:@selector(beginHeaderRefreshing)];
}

- (void)beginHeaderRefreshing {
    for (id delegate in self.delegates) {
        if ([delegate respondsToSelector:@selector(beginHeaderRefreshing)]) {
            [delegate beginHeaderRefreshing];
        }
    }
}

- (void)beginFooterRefreshing {
    for (id delegate in self.delegates) {
        if ([delegate respondsToSelector:@selector(beginFooterRefreshing)]) {
            [delegate beginFooterRefreshing];
        }
    }
}

@end
