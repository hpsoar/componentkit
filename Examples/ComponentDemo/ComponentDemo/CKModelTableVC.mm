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
        _modelRefresher = [ModelRefresher new];
        _modelRefresher.delegate = self;
        
        self.refreshController.delegate = _modelRefresher;
    }
    return _modelRefresher;
}

@end
