//
//  NextViewController.m
//  YQTableViewPlaceholder
//
//  Created by easylink on 2018/1/2.
//  Copyright © 2018年 YuQi. All rights reserved.
//

#import "NextViewController.h"
#import "UITableView+PlaceholerView.h"


@interface NextViewController () <UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, weak) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray * groups;

@property (nonatomic, strong) NSTimer * timer;
@end

@implementation NextViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.title = @"二";
    
    
    
    UITableView *tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
    tableView.dataSource = self;
    tableView.delegate = self;
    [self.view addSubview:tableView];
    self.tableView = tableView;
    
    UIView *placeholderV = [[UIView alloc] init];
    placeholderV.frame = self.view.bounds;
    placeholderV.backgroundColor = [UIColor yellowColor];
    tableView.array = self.groups;
    tableView.placeholerView = placeholderV;
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"add" style:UIBarButtonItemStyleDone target:self action:@selector(add)];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"remove" style:UIBarButtonItemStyleDone target:self action:@selector(remove)];
}

- (void)add
{
    [self.groups addObjectsFromArray:@[@"aaa", @"dsss", @"asdf"]];
    [self.tableView yq_reloadData];
}

- (void)remove
{
    [self.groups removeAllObjects];
    [self.tableView yq_reloadData];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.groups.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"cell"];
    }
    cell.textLabel.text = self.groups[indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NextViewController *next = [[NextViewController alloc] init];
    [self.navigationController pushViewController:next animated:YES];
}

- (NSMutableArray *)groups
{
    if (!_groups) {
        _groups = [NSMutableArray array];
    }
    return _groups;
}
@end
