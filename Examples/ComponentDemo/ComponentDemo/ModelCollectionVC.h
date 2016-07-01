//
//  ModelCollectionVC.h
//  ComponentDemo
//
//  Created by HuangPeng on 7/1/16.
//  Copyright © 2016 Beacon. All rights reserved.
//

#import "CKCollectionVC+Refresh.h"
#import "AAModelOptions.h"

@interface ModelCollectionVC : CKCollectionVC

@property (nonatomic, strong) AAModelController *modelController;
@property (nonatomic, strong) AAModelOptions *modelOptions;

- (void)loadModel:(dispatch_block_t)callback;
- (void)didLoadModel:(AAModelResult *)result;

@end
