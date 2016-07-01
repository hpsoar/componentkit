//
//  ViewController.m
//  ComponentDemo
//
//  Created by HuangPeng on 6/30/16.
//  Copyright © 2016 Beacon. All rights reserved.
//

#import "ViewController.h"
#import "HostViewVC.h"
#import "DoctorListVC.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(10, 100, 120, 30)];
    [btn setTitle:@"HostingView" forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [self.view addSubview:btn];
    [btn addTarget:self action:@selector(hostViewDemo:) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton *btn2 = [[UIButton alloc] initWithFrame:CGRectMake(10, 150, 120, 30)];
    [btn2 setTitle:@"collection view" forState:UIControlStateNormal];
    [btn2 setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [self.view addSubview:btn2];
    [btn2 addTarget:self action:@selector(collectionViewDemo:) forControlEvents:UIControlEventTouchUpInside];
}

- (void)hostViewDemo:(id)sender {
    HostViewVC *vc = [HostViewVC new];
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)collectionViewDemo:(id)sender {
    DoctorListVC *vc = [DoctorListVC new];
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
