//
//  ViewController.m
//  MultiThreadLearn
//
//  Created by RaoBo on 2018/4/5.
//  Copyright © 2018年 关键词. All rights reserved.
//

#import "ViewController.h"
#import "GCDTableViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    UIButton *gcdBtn = [UIButton rb_buttonWithFrame:CGRectMake(50, 200, kScreen_W-100, 50) target:self action:@selector(clickGCDAction:) title:@"GCD相关"];
    [self.view addSubview:gcdBtn];
}


- (void)clickGCDAction:(UIButton *)btn
{
    GCDTableViewController *gcdVC = [[GCDTableViewController alloc] init];
    [self.navigationController pushViewController:gcdVC animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
