//
//  ModelCollectionVC.m
//  ComponentDemo
//
//  Created by HuangPeng on 7/1/16.
//  Copyright © 2016 Beacon. All rights reserved.
//

#import "CKModelCollectionVC.h"

@implementation CKModelCollectionVC

- (ModelRefresher *)modelRefresher {
    if (_modelRefresher == nil) {
        _modelRefresher = [[ModelRefresher alloc] initWithRefreshController:self.refreshController];
        _modelRefresher.delegate = self;                
    }
    return _modelRefresher;
}

@end
