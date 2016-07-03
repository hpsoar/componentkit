//
//  ModelTableVC.m
//  ComponentDemo
//
//  Created by HuangPeng on 7/3/16.
//  Copyright © 2016 Beacon. All rights reserved.
//

#import "CKModelTableVC.h"

@implementation CKModelTableVC

- (void)beginHeaderRefreshing {
    if ([self.modelOptions canLoad]) {
        [self.modelOptions reset];
        
        [self loadModel:^{
            [self endHeaderRefreshing];
        }];
    }
}

- (void)beginFooterRefreshing {
    if ([self.modelOptions canLoad]) {
        [self loadModel:^{
            [self endFooterRefreshing];
        }];
    }
}

- (void)loadModel:(dispatch_block_t)callback {
    self.modelOptions.loadingStatus = AAModelLoadingStatusLoading;
    
    [self.modelController fetch:self.modelOptions callback:^(AAModelResult *result) {
        self.modelOptions.loadingStatus = result.error ? AAModelLoadingStatusFailed : AAModelLoadingStatusSucceed;
        if (callback) {
            callback();
        }
        
        [self didLoadModel:result];
    }];
}

- (void)didLoadModel:(AAModelResult *)result {
    
}

@end
