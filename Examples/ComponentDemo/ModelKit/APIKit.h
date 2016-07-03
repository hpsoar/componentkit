//
//  APIKit.h
//  ComponentDemo
//
//  Created by HuangPeng on 7/3/16.
//  Copyright © 2016 Beacon. All rights reserved.
//

#import <Foundation/Foundation.h>

@class APIOptions;
@class APIResult;

/**
 *  the object response for network request
 */
@protocol APIKit<NSObject>

- (instancetype)request:(APIOptions *)options
             parameters:(NSDictionary *)parameters
               callback:(void (^)(APIResult *result))callback;

@end

@interface APIResult : NSObject

@property (nonatomic, strong) NSData *data;
@property (nonatomic, strong) NSDictionary *JSON;
@property (nonatomic, strong) NSError *error;
@property (nonatomic, strong) NSHTTPURLResponse *response;

@end

/**
 *  model api options
 */

@interface APIOptions : NSObject

+ (instancetype)newWithAPI:(NSString *)API;
+ (instancetype)newWithAPI:(NSString *)API
                    method:(NSString *)method
                   timeout:(NSTimeInterval)timeout;

@property(nonatomic, copy) NSString *API;
@property(nonatomic, copy) NSString *method;
@property(nonatomic) NSTimeInterval timeout;

@end
