//
//  UITableView+PlaceholerView.h
//  YQTableViewPlaceholder
//
//  Created by easylink on 2018/1/2.
//  Copyright © 2018年 YuQi. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^ReloadButtonClickBlock)(void);

@interface UITableView (PlaceholerView)
@property (nonatomic, strong) UIView * placeholerView;
@property (nonatomic, strong) NSArray * array;
@property (nonatomic, copy) ReloadButtonClickBlock reloadButtonClickBlock;

- (void)yq_reloadData;
@end
