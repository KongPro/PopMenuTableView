//
//  MenuView.h
//  PopMenuTableView
//
//  Created by 孔繁武 on 16/8/1.
//  Copyright © 2016年 KongPro. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void(^ItemsClickBlock)(NSString *str, NSInteger tag);
typedef void(^BackViewTapBlock)();

@interface MenuView : UIView

@property (nonatomic,copy) ItemsClickBlock itemsClickBlock;
@property (nonatomic,copy) BackViewTapBlock backViewTapBlock;

@property (nonatomic,assign) NSInteger maxValueForItemCount;  // 最多菜单项个数，默认值：6;

/**
 *  menu
 *
 *  @param frame            菜单frame
 *  @param target           将在在何控制器弹出
 *  @param dataArray        菜单项内容
 *  @param itemsClickBlock  点击某个菜单项的blick
 *  @param backViewTapBlock 点击背景遮罩的block
 *
 *  @return 返回创建对象
 */
+ (MenuView *)createMenuWithFrame:(CGRect)frame target:(UIViewController *)target dataArray:(NSArray *)dataArray itemsClickBlock:(void(^)(NSString *str, NSInteger tag))itemsClickBlock backViewTap:(void(^)())backViewTapBlock;

/**
 *  展示菜单
 *
 *  @param isShow YES:展示  NO:隐藏
 */
+ (void)showMenuWithAnimation:(BOOL)isShow;

/* 隐藏菜单 */
+ (void)hidden;

/**移除菜单  */
+ (void)clearMenu;

/**
 *  追加菜单项
 *
 *  @param itemsArray 需要追加的菜单项内容数组
 */
+ (void)appendMenuItemsWith:(NSArray *)appendItemsArray;

/**
 *  更新菜单项
 *
 *  @param itemsArray 需要更新的菜单项内容数组
 */
+ (void)updateMenuItemsWith:(NSArray *)newItemsArray;
@end
