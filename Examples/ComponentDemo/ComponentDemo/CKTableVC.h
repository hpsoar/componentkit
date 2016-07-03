//
//  CKTableVC.h
//  ComponentDemo
//
//  Created by HuangPeng on 7/3/16.
//  Copyright © 2016 Beacon. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AAComponentExt.h"
#import <CKToolbox/CKTableViewTransactionalDataSource.h>
#import <CKToolbox/CKTableViewSupplementaryDataSource.h>
#import <CKToolbox/CKTableViewTransactionalDataSourceCellConfiguration.h>
#import "RefreshController.h"

@interface CKTableVC : UIViewController <CKTableViewSupplementaryDataSource, UITableViewDelegate, RefreshControllerDelegate>

- (void)addSection;
- (void)clearSection;
- (void)addModels:(NSArray *)models atIndex:(NSInteger)index;

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) CKTableViewTransactionalDataSource *dataSource;
@property (nonatomic, strong) CKTableViewTransactionalDataSourceCellConfiguration *cellConfiguration;
@property (nonatomic, strong) RefreshController *refreshController;

@end
