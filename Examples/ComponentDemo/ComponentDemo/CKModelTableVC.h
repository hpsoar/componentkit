//
//  ModelTableVC.h
//  ComponentDemo
//
//  Created by HuangPeng on 7/3/16.
//  Copyright © 2016 Beacon. All rights reserved.
//

#import "CKTableVC.h"
#import "AAModelOptions.h"

@interface CKModelTableVC : CKTableVC

@property (nonatomic, strong) AAModelController *modelController;
@property (nonatomic, strong) AAModelOptions *modelOptions;

- (void)loadModel:(dispatch_block_t)callback;
- (void)didLoadModel:(AAModelResult *)result;

@end
