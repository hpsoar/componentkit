//
//  AATableVC.m
//  ComponentDemo
//
//  Created by HuangPeng on 7/3/16.
//  Copyright © 2016 Beacon. All rights reserved.
//

#import "AATableVC.h"

@implementation AATableVC

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self.view addSubview:self.tableView];
}

- (UITableView *)tableView {
    if (_tableView == nil) {
        _tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.delegate = self;
    }
    return _tableView;
}

#pragma mark - support for refresh

- (RefreshController *)refreshController {
    if (_refreshController == nil) {
        _refreshController = [[RefreshController alloc] initWithScrollView:self.tableView delegate:self];
    }
    return _refreshController;
}

@end
