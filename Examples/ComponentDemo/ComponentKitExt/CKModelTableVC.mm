//
//  ModelTableVC.m
//  ComponentDemo
//
//  Created by HuangPeng on 7/3/16.
//  Copyright © 2016 Beacon. All rights reserved.
//

#import "CKModelTableVC.h"

@implementation CKModelTableVC

- (ModelRefresher *)modelRefresher {
    if (_modelRefresher == nil) {
        _modelRefresher = [[ModelRefresher alloc] initWithRefreshController:self.refreshController];
        _modelRefresher.delegate = self;                
    }
    return _modelRefresher;
}

@end
