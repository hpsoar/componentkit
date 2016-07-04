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
#import "NIModelUpdater.h"

#pragma mark - ni table vc

@interface NITableVC : AATableVC

@property (nonatomic, strong) NITableViewModel *tableViewModel;
@property (nonatomic, readonly) NIMutableTableViewModel *mutableTableViewModel;
@property (nonatomic, strong) NICellFactory *cellFactory;
@property (nonatomic, strong) NITableViewActions *tableViewActions;
@property (nonatomic, strong) NIModelUpdater *tableViewUpdater;

@end

#pragma mark - ni table with model refresher

@interface NIModelTableVC : NITableVC <ModelRefresherDelegate>

/**
 *  if you set you changed your refreshController, you need to recreate modelRefresher
 */
@property (nonatomic, strong) ModelRefresher *modelRefresher;

@end

