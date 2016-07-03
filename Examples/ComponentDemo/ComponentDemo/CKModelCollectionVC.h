//
//  ModelCollectionVC.h
//  ComponentDemo
//
//  Created by HuangPeng on 7/1/16.
//  Copyright © 2016 Beacon. All rights reserved.
//

#import "CKCollectionVC.h"
#import "ModelRefresher.h"

@interface CKModelCollectionVC : CKCollectionVC <ModelRefresherDelegate>

@property (nonatomic, strong) ModelRefresher *modelRefresher;

@end
