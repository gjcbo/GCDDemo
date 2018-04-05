//
//  GCDTableViewController.m
//  MultiThreadLearn
//
//  Created by RaoBo on 2018/4/5.
//  Copyright © 2018年 关键词. All rights reserved.
//

#import "GCDTableViewController.h"
#import "GCDDemoViewController.h"


@interface GCDTableViewController ()
/**数据源*/
@property(nonatomic, strong) NSArray *dataArr;

@end

@implementation GCDTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"GCD相关操作";
    
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"GCDCellId"];
    
    self.dataArr = @[@{@"title":@"队列",
                       @"children":@[
  @{@"title":@"串行队列",@"selector":@"testSerialqueue"},
  @{@"title":@"并发队列",@"selector":@"testConcurrentqueue"},
  @{@"title":@"主队列",@"selector":@"textMainqueue"}
  ]},
                     @{@"title":@"任务",
                       @"children":@[
  @{@"title":@"同步任务",@"selector":@"testSync"},
  @{@"title":@"异步任务",@"selector":@"textAsync"}
  ]}
                     ];
    
}

#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.dataArr.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSDictionary *dic = self.dataArr[section];
    NSArray *rowArr = dic[@"children"];
    
    return rowArr.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"GCDCellId" forIndexPath:indexPath];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:(UITableViewCellStyleValue1) reuseIdentifier:@"GCDCellId"];
    }
    
    NSDictionary *dic = self.dataArr[indexPath.section];
    NSArray *rowArr = dic[@"children"];
    NSDictionary *detailDic = rowArr[indexPath.row];
    
    cell.textLabel.font = [UIFont systemFontOfSize:14.0];
    cell.textLabel.text = detailDic[@"title"];
    
    return cell;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    NSDictionary *dic = self.dataArr[section];
    return dic[kTitle];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    NSDictionary *dic = self.dataArr[indexPath.section][kChildren][indexPath.row];
    
    
    GCDDemoViewController *gcdDemoVC = [[GCDDemoViewController alloc] init];
    gcdDemoVC.selString = dic[kSelector];
    
    [self.navigationController pushViewController:gcdDemoVC animated:YES];
}

@end
