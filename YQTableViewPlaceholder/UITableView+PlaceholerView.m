//
//  UITableView+PlaceholerView.m
//  YQTableViewPlaceholder
//
//  Created by easylink on 2018/1/2.
//  Copyright © 2018年 YuQi. All rights reserved.
//

#import "UITableView+PlaceholerView.h"
#import <objc/runtime.h>

static const char * kplaceholerViewKey = "kplaceholerViewKey";
static const char * kArrayKey = "kArrayKey";
static const char * kBlockKey = "kBlockKey";

@implementation UITableView (PlaceholerView)

// reloadData
- (void)yq_reloadData
{
    if (!self.array) { // 未传array
        [self reloadData];
        return;
    }
    
    if (self.array.count == 0) { // 需要展位图
        
        if (!self.placeholerView) { // 未传展位图
            
            UIView *placeholderView = [[UIView alloc] initWithFrame:self.bounds];
            placeholderView.backgroundColor = [UIColor whiteColor];
            
            UILabel *remindLabel = [[UILabel alloc] init];
            remindLabel.text = @"没有获取到数据，再刷新试试";
            remindLabel.textAlignment = NSTextAlignmentCenter;
            remindLabel.font = [UIFont systemFontOfSize:18];
            remindLabel.textColor = [UIColor grayColor];
            remindLabel.frame = CGRectMake(0, placeholderView.frame.size.height * 0.4, placeholderView.frame.size.width, 40);
            [placeholderView addSubview:remindLabel];
            
            UIButton *reloadBtn = [[UIButton alloc] init];
            [reloadBtn setTitle:@"再次刷新" forState:UIControlStateNormal];
            reloadBtn.layer.cornerRadius = 20;
            reloadBtn.layer.borderColor = [UIColor grayColor].CGColor;
            reloadBtn.layer.borderWidth = 1.f;
            reloadBtn.titleLabel.font = [UIFont systemFontOfSize:15];
            [reloadBtn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
            reloadBtn.frame = CGRectMake(placeholderView.frame.size.width/2 - 150/2, placeholderView.frame.size.height * 0.55, 150, 40);
            [placeholderView addSubview:reloadBtn];
            [reloadBtn addTarget:self action:@selector(reloadBtnClick) forControlEvents:UIControlEventTouchUpInside];
            
            self.placeholerView = placeholderView;
        }
        
        [self addSubview:self.placeholerView];
        [self reloadData];
    } else { // 有数据
        [self.placeholerView removeFromSuperview];
        [self reloadData];
    }
}

- (void)reloadBtnClick
{
    if (self.reloadButtonClickBlock) {
        self.reloadButtonClickBlock();
    }
}

#pragma mark - setter & getter
- (void)setPlaceholerView:(UIView *)placeholerView
{
    objc_setAssociatedObject(self, &kplaceholerViewKey, placeholerView, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (UIView *)placeholerView
{
    return objc_getAssociatedObject(self, &kplaceholerViewKey);
}

- (void)setArray:(NSArray *)array
{
    objc_setAssociatedObject(self, &kArrayKey, array, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (NSArray *)array
{
    return objc_getAssociatedObject(self, &kArrayKey);
}

- (void)setReloadButtonClickBlock:(ReloadButtonClickBlock)reloadButtonClickBlock
{
    objc_setAssociatedObject(self, &kBlockKey, reloadButtonClickBlock, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

- (ReloadButtonClickBlock)reloadButtonClickBlock
{
    return objc_getAssociatedObject(self, &kBlockKey);
}
@end
