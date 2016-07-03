//
//  ModelTableVC.h
//  ComponentDemo
//
//  Created by HuangPeng on 7/3/16.
//  Copyright © 2016 Beacon. All rights reserved.
//

#import "CKTableVC.h"
#import "ModelRefresher.h"

@interface CKModelTableVC : CKTableVC <ModelRefresherDelegate>

@property (nonatomic, strong) ModelRefresher *modelRefresher;

@end
