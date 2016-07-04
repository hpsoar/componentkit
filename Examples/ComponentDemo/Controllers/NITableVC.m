//
//  NITableVC.m
//  ComponentDemo
//
//  Created by HuangPeng on 7/4/16.
//  Copyright © 2016 Beacon. All rights reserved.
//

#import "NITableVC.h"

@implementation NITableVC
@synthesize tableViewModel = _tableViewModel;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView.dataSource = self.tableViewModel;
}

- (void)setTableViewModel:(NITableViewModel *)tableViewModel {
    if (_tableViewModel != tableViewModel) {
        _tableViewModel = tableViewModel;
        
        [self didChangeTableViewModel];
    }
}

- (void)didChangeTableViewModel {
    if (self.tableView.dataSource != nil) {
        self.tableView.dataSource = self.tableViewModel;
    }
    
    if (_modelViewUpdater != nil) {
        _modelViewUpdater.mutableTableViewModel = self.mutableTableViewModel;
    }
}

- (NITableViewModel *)tableViewModel {
    if (_tableViewModel == nil) {
        _tableViewModel = [[NIMutableTableViewModel alloc] initWithDelegate:self.cellFactory];
    }
    return _tableViewModel;
}

- (NIMutableTableViewModel *)mutableTableViewModel {
    if ([self.tableViewModel isKindOfClass:[NIMutableTableViewModel class]]) {
        return (NIMutableTableViewModel *)self.tableViewModel;
    }
    return nil;
}

- (NICellFactory *)cellFactory {
    if (_cellFactory == nil) {
        _cellFactory = [NICellFactory new];
    }
    return _cellFactory;
}

- (NITableViewActions *)tableViewActions {
    if (_tableViewActions == nil) {
        _tableViewActions = [[NITableViewActions alloc] initWithTarget:self];
        [_tableViewActions forwardingTo:self];
        self.tableView.delegate = _tableViewActions;
    }
    return _tableViewActions;
}

- (NIModelUpdater *)modelViewUpdater {
    if (_modelViewUpdater == nil) {
        TableUpdater *updater = [TableUpdater newWithTableView:self.tableView];
        _modelViewUpdater = [NIModelUpdater newWithTableViewModel:self.mutableTableViewModel updater:updater];                        
    }
    return _modelViewUpdater;
}

@end

#pragma mark - NIModelTableVC

@implementation NIModelTableVC

- (ModelRefresher *)modelRefresher {
    if (_modelRefresher == nil) {
        _modelRefresher = [[ModelRefresher alloc] initWithRefreshController:self.refreshController];
        _modelRefresher.delegate = self;
    }
    return _modelRefresher;
}

- (void)setRefreshController:(RefreshController *)refreshController {
    if (self.refreshController != refreshController) {
        [super setRefreshController:refreshController];
        
        if (_modelRefresher != nil) {
            _modelRefresher.refreshController = refreshController;
        }
    }
}

@end
