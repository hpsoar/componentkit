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

- (void)beginHeaderRefreshing {
    [self refresh:ModelRefreshTypeTop];
}

- (void)beginFooterRefreshing {
    [self refresh:ModelRefreshTypeBottom];
}

- (void)refresh:(ModelRefreshType)type {
    if ([self.modelOptions canLoad] && [self shouldBeginLoadModel:type]) {

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
    self.modelOptions.loadingStatus = AAModelLoadingStatusLoading;

    [self.modelController fetch:self.modelOptions
                       callback:^(AAModelResult *result) {
                           self.modelOptions.loadingStatus =
                               result.error ? AAModelLoadingStatusFailed
                                            : AAModelLoadingStatusSucceed;

                           if (callback) {
                               callback(result);
                           }
                       }];
}

@end
