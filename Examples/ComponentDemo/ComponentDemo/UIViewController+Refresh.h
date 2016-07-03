//
//  UIViewController+Refresh.h
//  ComponentDemo
//
//  Created by HuangPeng on 7/3/16.
//  Copyright © 2016 Beacon. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HeaderFooterRefreshProtocol.h"

@interface UIViewController (Refresh) <HeaderFooterRefreshProtocol>

- (UIScrollView *)mj_scrollView;

@end
