//
//  AATableVC.h
//  ComponentDemo
//
//  Created by HuangPeng on 7/3/16.
//  Copyright © 2016 Beacon. All rights reserved.
//

#import "RefreshController.h"
#import <UIKit/UIKit.h>

@interface AATableVC
    : UIViewController <UITableViewDelegate, RefreshControllerDelegate>

@property(nonatomic, strong) UITableView *tableView;
@property(nonatomic, strong) RefreshController *refreshController;

@end
