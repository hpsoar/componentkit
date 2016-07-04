//
//  NITableVC.h
//  ComponentDemo
//
//  Created by HuangPeng on 7/4/16.
//  Copyright © 2016 Beacon. All rights reserved.
//

#import "AATableVC.h"
#import <NimbusModels.h>
#import "ModelRefresher.h"

#pragma mark - ni table vc

@interface NITableVC : AATableVC

@property (nonatomic, strong) NITableViewModel *tableViewModel;
@property (nonatomic, readonly) NIMutableTableViewModel *mutableTableViewModel;
@property (nonatomic, strong) NICellFactory *cellFactory;
@property (nonatomic, strong) NITableViewActions *tableViewActions;

@end

#pragma mark - ni table with model refresher

@interface NIModelTableVC : NITableVC <ModelRefresherDelegate>

@property (nonatomic, strong) ModelRefresher *modelRefresher;

@end

#pragma mark - util

@interface NITableVC (Util) <AATableVCUtil>

@end

