//
//  MenuView.m
//  PopMenuTableView
//
//  Created by 孔繁武 on 16/8/1.
//  Copyright © 2016年 KongPro. All rights reserved.
//

#import "MenuView.h"
#import "MenuModel.h"
#import "MenuTableViewCell.h"
#define MENU_TAG 99999
#define BACKVIEW_TAG 88888

@interface MenuView () <UITableViewDataSource,UITableViewDelegate>

@property (nonatomic,strong) UITableView * tableView;
@property (nonatomic,strong) UIView * backView;
@property (nonatomic,assign) CGRect rect;
@property (nonatomic,strong) NSArray * dataArray;
@property (nonatomic,strong) UIViewController * target;

@end

@implementation MenuView
#pragma mark -- setDataArray
- (void)setDataArray:(NSArray *)dataArray{
    
    NSMutableArray *tempMutableArr = [NSMutableArray array];
    for (NSDictionary *dict in dataArray) {
        MenuModel *model = [MenuModel MenuModelWithDict:dict];
        [tempMutableArr addObject:model];
    }
    _dataArray = tempMutableArr;
}

#pragma mark -- initMenu
- (void)setUpUIWithFrame:(CGRect)frame{
    
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:self.bounds];
    imageView.image = [UIImage imageNamed:@"pop_black_backGround"];
    
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 12, frame.size.width, frame.size.height - 12)];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.bounces = NO;
    self.tableView.backgroundColor = [UIColor clearColor];
    self.tableView.rowHeight = 40;
    [self.tableView registerClass:[MenuTableViewCell class] forCellReuseIdentifier:@"cell"];
    
    UIView *backView = [[UIView alloc] initWithFrame:CGRectMake(0, 64, self.target.view.bounds.size.width, self.target.view.bounds.size.height)];
    backView.backgroundColor = [UIColor blackColor];
    backView.alpha = 0.0;
    backView.userInteractionEnabled = YES;
    backView.tag = BACKVIEW_TAG;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tap:)];
    [backView addGestureRecognizer:tap];
    self.backView = backView;
    
    [self.target.view addSubview:backView];
    [self addSubview:imageView];
    [self addSubview:self.tableView];
}


#pragma mark -- UITableViewDataSource,UITableViewDelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArray.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    MenuModel *model = self.dataArray[indexPath.row];
    MenuTableViewCell *cell = (MenuTableViewCell *)[tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    cell.menuModel = model;
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    MenuModel *model = self.dataArray[indexPath.row];
    NSInteger tag = indexPath.row + 1;
    if (self.itemsClickBlock) {
        self.itemsClickBlock(model.itemName,tag);
    }
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
}


#pragma mark -- UITapGestureRecognizer
- (void)tap:(UITapGestureRecognizer *)sender{
    [MenuView showMenuWithAnimation:NO];
    if (self.backViewTapBlock) {
        self.backViewTapBlock();
    }
}


#pragma mark -- Create Menu
+ (MenuView *)createMenuWithFrame:(CGRect)frame target:(UIViewController *)target dataArray:(NSArray *)dataArray itemsClickBlock:(void (^)(NSString *, NSInteger))itemsClickBlock backViewTap:(void (^)())backViewTapBlock{
    
    frame = CGRectMake(frame.origin.x, frame.origin.y, frame.size.width, frame.size.height + 12);
    MenuView *menuView = [[MenuView alloc] initWithFrame:frame];
    menuView.tag = MENU_TAG;
    menuView.rect = frame;
    menuView.target = target;
    menuView.dataArray = dataArray;
    menuView.itemsClickBlock = itemsClickBlock;
    menuView.backViewTapBlock = backViewTapBlock;
    [menuView setUpUIWithFrame:frame];
    menuView.layer.anchorPoint = CGPointMake(1, 0);
    //    menuView.layer.position = CGPointMake(frame.origin.x + frame.size.width, frame.origin.y);
    menuView.layer.position = CGPointMake(frame.origin.x + frame.size.width, frame.origin.y);
    menuView.transform = CGAffineTransformMakeScale(0.01, 0.01);
    [target.view addSubview:menuView];
    return menuView;
}


#pragma mark -- Show With Animation
+ (void)showMenuWithAnimation:(BOOL)isShow{
    // 通过标示获取view
    MenuView *menuView = [[UIApplication sharedApplication].keyWindow viewWithTag:MENU_TAG];
    UIView *backView = [[UIApplication sharedApplication].keyWindow viewWithTag:BACKVIEW_TAG];
    [UIView animateWithDuration:0.25 animations:^{
        if (isShow) {
            menuView.alpha = 1;
            backView.alpha = 0.1;
            menuView.transform = CGAffineTransformMakeScale(1.0, 1.0);
        }else{
            menuView.alpha = 0;
            backView.alpha = 0;
            menuView.transform = CGAffineTransformMakeScale(0.01, 0.01);
        }
    }];
}


#pragma mark -- Hidden
+ (void)hidden{
    [MenuView showMenuWithAnimation:NO];
}

+ (void)clearMenu{
    [MenuView showMenuWithAnimation:NO];
    MenuView *menuView = [[UIApplication sharedApplication].keyWindow viewWithTag:MENU_TAG];
    UIView *backView = [[UIApplication sharedApplication].keyWindow viewWithTag:BACKVIEW_TAG];
    [menuView removeFromSuperview];
    [backView removeFromSuperview];
}

@end










