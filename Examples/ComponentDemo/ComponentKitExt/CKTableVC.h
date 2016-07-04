//
//  CKTableVC.h
//  ComponentDemo
//
//  Created by HuangPeng on 7/3/16.
//  Copyright © 2016 Beacon. All rights reserved.
//

#import "AATableVC.h"
#import "AAComponentExt.h"
#import <CKToolbox/CKTableViewTransactionalDataSource.h>
#import <CKToolbox/CKTableViewSupplementaryDataSource.h>
#import <CKToolbox/CKTableViewTransactionalDataSourceCellConfiguration.h>
#import "NIModelUpdater.h"

@interface CKTableVC : AATableVC <CKTableViewSupplementaryDataSource>

@property (nonatomic, strong) CKTableViewTransactionalDataSource *dataSource;
@property (nonatomic, strong) CKTableViewTransactionalDataSourceCellConfiguration *cellConfiguration;
@property (nonatomic, strong) NIModelUpdater *modelViewUpdater;

@end
