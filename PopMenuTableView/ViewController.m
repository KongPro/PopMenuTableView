//
//  ViewController.m
//  PopMenuTableView
//
//  Created by 孔繁武 on 16/8/1.
//  Copyright © 2016年 KongPro. All rights reserved.
//

#import "ViewController.h"
#import "MenuView.h"

@interface ViewController ()

@property (nonatomic,assign) BOOL flag;
@property (weak, nonatomic) IBOutlet UILabel *numberLabel;
@property (nonatomic,assign) int itemCount;

@end

@implementation ViewController {
    NSArray *_dataArray;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    /**
     *  rightBarButton的点击标记，每次点击更改flag值。
     *  如果您用普通的button就不需要设置flag，通过按钮的seleted属性来控制即可
     */
    self.flag = YES;
    
    /**
     *  这些数据是菜单显示的图片和文字，写在这里，不知合不合理，请各位大牛指教，如果有更好的方法：
     *  e-mail : KongPro@163.com
     *  喜欢请砸github上点颗星星，多谢！
     */
    NSDictionary *dict1 = @{@"imageName" : @"icon_button_affirm",
                             @"itemName" : @"撤回"
                            };
    NSDictionary *dict2 = @{@"imageName" : @"icon_button_recall",
                             @"itemName" : @"确认"
                            };
    NSDictionary *dict3 = @{@"imageName" : @"icon_button_record",
                             @"itemName" : @"记录"
                            };
    NSArray *dataArray = @[dict1,dict2,dict3];
    _dataArray = dataArray;
    
    // 计算菜单frame
    CGFloat x = self.view.bounds.size.width / 3 * 2;
    CGFloat y = 64 - 12;
//    CGFloat width = self.view.bounds.size.width * 0.3;
//    CGFloat height = dataArray.count * 40;  // 40 -> tableView's RowHeight
    __weak __typeof(&*self)weakSelf = self;
    /**
     *  创建menu
     */
    [MenuView createMenuWithFrame:CGRectMake(x, y, 0, 0) target:self.navigationController dataArray:dataArray itemsClickBlock:^(NSString *str, NSInteger tag) {
        // do something
        [weakSelf doSomething:(NSString *)str tag:(NSInteger)tag];
        
    } backViewTap:^{
        // 点击背景遮罩view后的block，可自定义事件
        // 这里的目的是，让rightButton点击，可再次pop出menu
        weakSelf.flag = YES;
    }];
}

- (IBAction)popMenu:(id)sender {    
    if (self.flag) {
        [MenuView showMenuWithAnimation:self.flag];
        self.flag = NO;
    }else{
        [MenuView showMenuWithAnimation:self.flag];
        self.flag = YES;
    }
}

- (void)doSomething:(NSString *)str tag:(NSInteger)tag{
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:str message:[NSString stringWithFormat:@"点击了第%ld个菜单项",tag] preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *action = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
    }];
    [alertController addAction:action];
    [self presentViewController:alertController animated:YES completion:nil];
    
    [MenuView hidden];  // 隐藏菜单
    self.flag = YES;
}

#pragma mark  -- 增加一个菜单项
- (IBAction)addMenuItem:(id)sender {
    
    NSDictionary *addDict = @{@"imageName" : @"icon_button_recall",
                              @"itemName" : [NSString stringWithFormat:@"新增项%d",self.itemCount + 1]
                              };
    NSArray *newItemArray = @[addDict];
    
    /**
     *  更新菜单
     */
    [MenuView appendMenuItemsWith:newItemArray];
    
    self.itemCount ++;
    self.numberLabel.text = [NSString stringWithFormat:@"累计增加  %d  项", self.itemCount];
}

#pragma mark -- 恢复菜单项
- (IBAction)removeMenuItem:(id)sender {
    [MenuView updateMenuItemsWith:_dataArray];
    
    self.itemCount = 0;
    self.numberLabel.text = [NSString stringWithFormat:@"累计增加 %d 项", self.itemCount];
}


- (void)dealloc{
    [MenuView clearMenu];   // 移除菜单
}

@end
