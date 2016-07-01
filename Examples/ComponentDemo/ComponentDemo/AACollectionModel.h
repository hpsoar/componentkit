//
//  CYCollectionModel.h
//  ComponentDemo
//
//  Created by HuangPeng on 7/1/16.
//  Copyright © 2016 Beacon. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <ComponentKit/ComponentKit.h>

@protocol ComponentModelProtocol <NSObject>

- (CKComponent *)componentWithContext:(id<NSObject>)context;

@end
