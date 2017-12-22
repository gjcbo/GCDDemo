//
//  ViewController.m
//  GCD
//
//  Created by RaoBo on 2017/12/22.
//  Copyright © 2017年 RaoBo. All rights reserved.
//

#import "ViewController.h"
#import "SemaphoreViewController.h" // 一信号量

typedef NS_ENUM(NSInteger , GCDDemoType){
    GCDDemoSemaphoreType = 0 // 信号量
} ;

@interface ViewController ()<UITableViewDelegate,UITableViewDataSource>

/**1.tableView*/
@property(nonatomic, strong) UITableView *tableView;
/**2.数据源*/
@property(nonatomic, strong) NSArray *dataArr;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.dataArr = @[@"一semaphore信号量"];
    
    [self setupTableView];
}

- (void)setupTableView
{
    // 你光说这是没用的
    self.tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:(UITableViewStylePlain)];
    [self.view addSubview:self.tableView];
    
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.tableFooterView = [[UIView alloc] init];
    
}

#pragma mark - UITableViewDelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArr.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *cellID = @"cellID";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:(UITableViewCellStyleValue1) reuseIdentifier:cellID];
    }
    
    cell.textLabel.text = self.dataArr[indexPath.row];
    
    return  cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{

    switch (indexPath.row) {
        case GCDDemoSemaphoreType:
        {
            SemaphoreViewController *semaphoreVC = [[SemaphoreViewController alloc] init];
            [self.navigationController pushViewController:semaphoreVC animated:YES];
        }
            break;
            
        default:
            break;
    }
}
@end
