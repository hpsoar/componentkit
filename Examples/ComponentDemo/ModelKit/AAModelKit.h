//
//  AAModelOptions.h
//  ComponentDemo
//
//  Created by HuangPeng on 7/1/16.
//  Copyright © 2016 Beacon. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 *  Loading status
 */
typedef NS_ENUM(NSInteger, AAModelLoadingStatus) {
    /**
     *  None
     */
    AAModelLoadingStatusNone,
    /**
     *  Loading
     */
    AAModelLoadingStatusLoading,
    /**
     *  Succeed
     */
    AAModelLoadingStatusSucceed,
    /**
     *  Failed
     */
    AAModelLoadingStatusFailed,
};

/**
 *  Base class for model option
 *  each API should have a model option
 */

@interface AAModelOptions : NSObject

- (void)reset;
- (BOOL)canLoad;
- (BOOL)failed;
- (BOOL)loaded;

// the model class used to parse raw data
- (Class)modelClass;

// loading status
@property (atomic) AAModelLoadingStatus loadingStatus;

@end

/**
 *  result for Model request
 */

@interface AAModelResult : NSObject

+ (instancetype)newWithJSON:(id)JSON model:(id)model error:(NSError *)error;

// json data
@property (nonatomic, strong) id JSON;

// json -> model (object/[object])
@property (nonatomic, strong) id model;

// error
@property (nonatomic, strong) NSError *error;

@end

/**
 *  model data source
 *
 *  eg.
 *  a server API
 *  a mock server API
 *  a local data base
 *
 *  for simplicity, each server API is treated as a independent data source
 *
 *  you can also use a data source for multiple API, in which case you need to provide API & method, etc. in request option
 *
 *  data source return raw data: currently only JSON is supported
 *
 */

@protocol AAModelDataSource <NSObject>

- (void)fetch:(AAModelOptions *)options callback:(void (^)(id JSON, NSError *error))callback;

@end

/**
 * dataSource --(raw data)--> AAModelController --(model object(s))-->
 * why AAModelController? 
 * you may have many kind of data sources, usually you have only one mapper from raw data to model
 * even if you have more than one, decouple mapper from data source is better
 */
@interface AAModelController : NSObject

+ (instancetype)newWithDataSource:(id<AAModelDataSource>)dataSource;

- (instancetype)initWithDataSource:(id<AAModelDataSource>)dataSource;

- (void)fetch:(AAModelOptions *)options callback:(void(^)(AAModelResult *result))callback;

@end

/**
 *  model api options
 */

@interface AAModelAPIOptions : NSObject

+ (instancetype)newWithAPI:(NSString *)API;
+ (instancetype)newWithAPI:(NSString *)API method:(NSString *)method timeout:(NSTimeInterval)timeout;

@property (nonatomic, copy) NSString *API;
@property (nonatomic, copy) NSString *method;
@property (nonatomic) NSTimeInterval timeout;

@end

/**
 *  remote API model options
 */

@interface AAURLModelOptions : AAModelOptions

@property (nonatomic, strong) AAModelAPIOptions *apiOptions;;

@end


/**
 * remote API data source
 *
 * if you pass a AAURLModelOptions with apiOptions setup, then this apiOptions is used
 * by doing this, you can use an url data source for multiple API
 *
 * however, we recommend you use a url data source for each API
 */
@interface AAURLModelDataSource : NSObject <AAModelDataSource>

+ (instancetype)newWithAPI:(NSString *)API;
+ (instancetype)newWithAPI:(NSString *)API method:(NSString *)method;
+ (instancetype)newWithOptions:(AAModelAPIOptions *)apiOptions;

@property (nonatomic, strong) AAModelAPIOptions *apiOptions;

@end
