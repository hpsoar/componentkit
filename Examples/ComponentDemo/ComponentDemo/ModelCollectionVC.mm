//
//  ModelCollectionVC.m
//  ComponentDemo
//
//  Created by HuangPeng on 7/1/16.
//  Copyright © 2016 Beacon. All rights reserved.
//

#import "ModelCollectionVC.h"

@implementation ModelCollectionVC

- (void)viewDidLoad {
    [super viewDidLoad];        
}

- (void)beginHeaderRefreshing {
    if ([self.modelOptions canLoad]) {
        [self.modelOptions reset];
        
        [self loadModel:^{
            [self endHeaderRefreshing];
        }];
    }
}

- (void)beginFooterRefreshing {
    [self loadModel:^{
        [self endFooterRefreshing];
    }];
}

- (void)loadModel:(dispatch_block_t)callback {
    self.modelOptions.loadingStatus = AAModelLoadingStatusLoading;
    
    [self.modelController fetch:self.modelOptions callback:^(AAModelResult *result) {
        if (callback) {
            callback();
        }
        
        [self didLoadModel:result];
    }];
}

- (void)didLoadModel:(AAModelResult *)result {
    
}

@end
