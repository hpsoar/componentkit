//
//  CKTableVC.m
//  ComponentDemo
//
//  Created by HuangPeng on 7/3/16.
//  Copyright © 2016 Beacon. All rights reserved.
//

#import "CKTableVC.h"

@interface CKTableVC () <CKComponentProvider>
@end

@implementation CKTableVC {

}

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

#pragma mark - data source

- (void)addSection {
    CKTransactionalComponentDataSourceChangesetBuilder *builder = [CKTransactionalComponentDataSourceChangesetBuilder new];
    [builder withInsertedSections:[NSIndexSet indexSetWithIndex:0]];
    [self.dataSource applyChangeset:builder.build mode:CKUpdateModeSynchronous userInfo:nil];
}

- (void)clearSection {
    CKTransactionalComponentDataSourceChangesetBuilder *builder = [CKTransactionalComponentDataSourceChangesetBuilder new];
    [builder withRemovedSections:[NSIndexSet indexSetWithIndex:0]];
    [self.dataSource applyChangeset:builder.build mode:CKUpdateModeSynchronous userInfo:nil];
}

- (void)addModels:(NSArray *)models atIndex:(NSInteger)index {
    NSMutableDictionary <NSIndexPath *, id> *dictionary = [NSMutableDictionary dictionary];
    for (NSUInteger i = 0; i < models.count; ++i) {
        dictionary[[NSIndexPath indexPathForItem:i + index inSection:0]] = models[i];
    }
    CKTransactionalComponentDataSourceChangesetBuilder *builder = [CKTransactionalComponentDataSourceChangesetBuilder new];
//    [builder withInsertedSections:[NSIndexSet indexSetWithIndex:0]];
    [builder withInsertedItems:dictionary];
    [self.dataSource applyChangeset:builder.build mode:CKUpdateModeSynchronous userInfo:nil];
}

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
