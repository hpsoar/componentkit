//
//  ModelRefresher.m
//  ComponentDemo
//
//  Created by HuangPeng on 7/3/16.
//  Copyright © 2016 Beacon. All rights reserved.
//

#import "ModelRefresher.h"

BOOL isTopRefresh(ModelRefreshType type) { return type == ModelRefreshTypeTop; }

@implementation ModelRefresher

- (instancetype)initWithRefreshController:(RefreshController *)refreshController {
    self = [super init];
    if (self) {
        self.refreshController = refreshController;
        [refreshController forwardingTo:self];
    }
    return self;
}

- (void)beginHeaderRefreshing {
    [self refresh:ModelRefreshTypeTop];
}

- (void)beginFooterRefreshing {
    [self refresh:ModelRefreshTypeBottom];
}

- (void)refresh:(ModelRefreshType)type {
    if ([self.modelController canLoad] && [self shouldBeginLoadModel:type]) {
        
        if (isTopRefresh(type)) {
            [self.modelOptions reset];
        }

        [self willBeginRefresh:type];

        [self loadModel:^(AAModelResult *result) {
            if (isTopRefresh(type)) {
                [self.refreshController endHeaderRefreshing];
            } else {
                [self.refreshController endFooterRefreshing];
            }

            [self didFinishLoadWithType:type result:result];
        }];
    }
}

#pragma mark - events

- (BOOL)shouldBeginLoadModel:(ModelRefreshType)type {
    if ([self.delegate
            respondsToSelector:@selector(refresher:shouldBeginLoadWithType:)]) {
        return [self.delegate refresher:self shouldBeginLoadWithType:type];
    }
    return YES;
}

- (void)willBeginRefresh:(ModelRefreshType)type {
    if ([self.delegate
            respondsToSelector:@selector(refresher:willBeginLoadWithType:)]) {
        [self.delegate refresher:self willBeginLoadWithType:type];
    }
}

- (void)didFinishLoadWithType:(ModelRefreshType)type
                       result:(AAModelResult *)result {
    if ([self.delegate respondsToSelector:@selector(refresher:
                                              didFinishLoadWithType:
                                                             result:)]) {
        [self.delegate refresher:self didFinishLoadWithType:type result:result];
    }
}

- (void)loadModel:(void (^)(AAModelResult *result))callback {
    [self.modelController fetch:self.modelOptions
                       callback:callback];
}

@end
