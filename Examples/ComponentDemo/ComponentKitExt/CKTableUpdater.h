//
//  CKModelTableUpdater.h
//  ComponentDemo
//
//  Created by HuangPeng on 7/4/16.
//  Copyright © 2016 Beacon. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AAComponentExt.h"
#import "ModelTableUpdater.h"
#import <CKToolbox/CKTableViewTransactionalDataSource.h>

@interface CKTableUpdater : NSObject <TableUpdater>

+ (instancetype)newWithDataSource:(CKTableViewTransactionalDataSource *)dataSource;

@property (nonatomic, strong) CKTableViewTransactionalDataSource *dataSource;
@property (nonatomic) CKUpdateMode updateMode;
@property (nonatomic) NSDictionary *userInfo;

@end
