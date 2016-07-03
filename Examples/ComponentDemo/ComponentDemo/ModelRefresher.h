//
//  ModelRefresher.h
//  ComponentDemo
//
//  Created by HuangPeng on 7/3/16.
//  Copyright © 2016 Beacon. All rights reserved.
//

#import "AAModelOptions.h"
#import "RefreshController.h"
#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger, ModelRefreshType) {
    ModelRefreshTypeTop,
    ModelRefreshTypeBottom,
};

BOOL isTopRefresh(ModelRefreshType type);

@class ModelRefresher;
@protocol ModelRefresherDelegate <NSObject>

@optional
- (BOOL)refresher:(ModelRefresher *)refresher
    shouldBeginLoadWithType:(ModelRefreshType)type;

- (void)refresher:(ModelRefresher *)refresher
    willBeginLoadWithType:(ModelRefreshType)type;

- (void)refresher:(ModelRefresher *)refresher
    didFinishLoadWithType:(ModelRefreshType)type
                   result:(AAModelResult *)result;

@end

@interface ModelRefresher : NSObject <RefreshControllerDelegate>

- (instancetype)initWithRefreshController:(RefreshController *)refreshController;

- (void)refresh:(ModelRefreshType)type;

- (BOOL)shouldBeginLoadModel:(ModelRefreshType)type;

- (void)willBeginRefresh:(ModelRefreshType)type;

- (void)loadModel:(void (^)(AAModelResult *result))callback;

- (void)didFinishLoadWithType:(ModelRefreshType)type
                       result:(AAModelResult *)result;

@property(nonatomic, strong) AAModelController *modelController;
@property(nonatomic, strong) AAModelOptions *modelOptions;
@property(nonatomic, strong) RefreshController *refreshController;

@property(nonatomic, weak) id<ModelRefresherDelegate> delegate;

@end
