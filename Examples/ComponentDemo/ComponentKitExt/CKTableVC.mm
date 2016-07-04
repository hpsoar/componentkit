//
//  CKTableVC.m
//  ComponentDemo
//
//  Created by HuangPeng on 7/3/16.
//  Copyright © 2016 Beacon. All rights reserved.
//

#import "CKTableVC.h"
#import "CKTableViewUpdater.h"

@interface CKTableVC () <CKComponentProvider>
@end

@implementation CKTableVC {

}
@synthesize dataSource = _dataSource;

- (CKTableViewTransactionalDataSource *)dataSource {
    if (_dataSource == nil) {
        _dataSource = [[CKTableViewTransactionalDataSource alloc]
                           initWithTableView:self.tableView
                           supplementaryDataSource:self
                           configuration:self.configuration
                           defaultCellConfiguration:self.cellConfiguration];
    }
    return _dataSource;
}

- (CKTransactionalComponentDataSourceConfiguration*)configuration
{
    CKComponentFlexibleSizeRangeProvider *provider = [CKComponentFlexibleSizeRangeProvider providerWithFlexibility:
                                                      CKComponentSizeRangeFlexibleHeight];
    CKSizeRange sizeRange = [provider sizeRangeForBoundingSize:self.tableView.bounds.size];
    return [[CKTransactionalComponentDataSourceConfiguration alloc]
            initWithComponentProvider:[self class]
            context:nil
            sizeRange:sizeRange];
}

- (NIModelUpdater *)tableViewUpdater {
    if (_tableViewUpdater == nil) {
        CKTableViewUpdater *updater = [CKTableViewUpdater newWithDataSource:self.dataSource];
        _tableViewUpdater = [NIModelUpdater newWithTableViewModel:nil updater:updater];
    }
    return _tableViewUpdater;
}

#pragma mark - Component Provider

+ (CKComponent *)componentForModel:(id<NSObject>)model context:(id<NSObject>)context {
    if ([model conformsToProtocol:@protocol(ComponentModelProtocol)]) {
        id<ComponentModelProtocol> componentModel = (id<ComponentModelProtocol>)model;
        if ([componentModel respondsToSelector:@selector(componentWithContext:)]) {
            return [componentModel componentWithContext:context];
        }
    }
    return nil;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return [self.dataSource sizeForItemAtIndexPath:indexPath].height;
}

#pragma mark Rotation

- (void)willTransitionToTraitCollection:(UITraitCollection *)newCollection
              withTransitionCoordinator:(id<UIViewControllerTransitionCoordinator>)coordinator
{
    NSArray *indexPaths = self.tableView.indexPathsForVisibleRows;
    [coordinator animateAlongsideTransition:^(id<UIViewControllerTransitionCoordinatorContext>  _Nonnull context) {
        [self.dataSource updateConfiguration:self.configuration
                                        mode:CKUpdateModeAsynchronous
                                    userInfo:nil];
    } completion:^(id<UIViewControllerTransitionCoordinatorContext>  _Nonnull context) {
        [self.tableView scrollToRowAtIndexPath:indexPaths[indexPaths.count / 2]
                              atScrollPosition:UITableViewScrollPositionMiddle
                                      animated:YES];
    }];
}

@end
