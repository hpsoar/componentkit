//
//  AAModelOptions.h
//  ComponentDemo
//
//  Created by HuangPeng on 7/1/16.
//  Copyright © 2016 Beacon. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger, AAModelLoadingStatus) {
    AAModelLoadingStatusNone,
    AAModelLoadingStatusLoading,
    AAModelLoadingStatusSucceed,
    AAModelLoadingStatusFailed,
};

@interface AAModelOptions : NSObject

- (void)reset;
- (BOOL)canLoad;
- (BOOL)failed;
- (BOOL)loaded;

- (Class)modelClass;

@property (atomic) AAModelLoadingStatus loadingStatus;

@end

@interface AAModelResult : NSObject

- (void)updateWithJSON:(id)JSON error:(NSError *)error modelClass:(Class)cls;

@property (nonatomic, strong) id JSON;
@property (nonatomic, strong) id model;
@property (nonatomic, strong) NSError *error;

@end

/**
 *  model data source
 *
 *  can be a server
 *  a mock server
 *  a local data sourc
 */

@protocol AAModelDataSource <NSObject>

- (void)fetch:(AAModelOptions *)options callback:(void (^)(id JSON, NSError *error))callback;

@end

@interface AAModelController : NSObject

- (instancetype)initWithDataSource:(id<AAModelDataSource>)dataSource;

- (void)fetch:(AAModelOptions *)options callback:(void(^)(AAModelResult *result))callback;

@end


@interface AAURLModelDataSource : NSObject <AAModelDataSource>

- (instancetype)initWithAPI:(NSString *)API;
- (instancetype)initWithAPI:(NSString *)API method:(NSString *)method timeout:(NSTimeInterval)timeout;

@property (nonatomic, copy) NSString *API;
@property (nonatomic, copy) NSString *method;
@property (nonatomic) NSTimeInterval timeout;

@end
