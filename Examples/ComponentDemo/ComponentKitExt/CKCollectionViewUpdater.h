//
//  CKCollectionViewUpdater.h
//  ComponentDemo
//
//  Created by HuangPeng on 7/4/16.
//  Copyright © 2016 Beacon. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AAComponentExt.h"
#import "ModelTableUpdater.h"

@interface CKCollectionViewUpdater : NSObject <TableUpdater>

+ (instancetype)newWithDataSource:(CKCollectionViewDataSource *)dataSource;
    
@property (nonatomic, strong) CKCollectionViewDataSource *dataSource;
@property (nonatomic) CKUpdateMode updateMode;
@property (nonatomic) CKSizeRange contrainedSize;

@end
