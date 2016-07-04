//
//  CKCollectionVC.h
//  ComponentDemo
//
//  Created by HuangPeng on 7/1/16.
//  Copyright © 2016 Beacon. All rights reserved.
//

#import "AACollectionVC.h"
#import "AAComponentExt.h"
#import "NIModelUpdater.h"

/*
 *  1. create your Model & ModelController
 *  2. create your component
 *  3. Model implement ComponentModelProtocol
 *  4. inherit & implement CKCollectionVC
 *  5. create dataSource
 *  6. load data
 *  7. add to dataSource
 *  8. show
 */


@interface CKCollectionVC :  AACollectionVC

@property (nonatomic, strong) CKCollectionViewDataSource *dataSource;
@property (nonatomic, strong) NIModelUpdater *modelViewUpdater;

@end

@interface CKCollectionVC (Supplementary) <CKSupplementaryViewDataSource>

@end

BOOL scrolledToBottomWithBuffer(CGPoint contentOffset, CGSize contentSize, UIEdgeInsets contentInset, CGRect bounds);
