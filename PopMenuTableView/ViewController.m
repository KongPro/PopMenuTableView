//
//  ViewController.m
//  PopMenuTableView
//
//  Created by 孔繁武 on 16/8/1.
//  Copyright © 2016年 孔繁武. All rights reserved.
//

#import "ViewController.h"
#import "MenuView.h"

@interface ViewController ()

@property (nonatomic,strong) MenuView * menuView;
@property (nonatomic,assign) BOOL flag;

@end

@implementation ViewController

- (MenuView *)menuView{
    if (!_menuView) {
        
        /**
         *  这些数据是菜单显示的图片和文字，小弟写在这里，不知合不合理，请各位大牛指教
         *  e-mail : KongPro@163.com
         */
        NSDictionary *dict1 = @{@"imageName" : @"icon_button_affirm",
                                @"itemName" : @"撤回"
                                };
        NSDictionary *dict2 = @{@"imageName" : @"icon_button_recall",
                                @"itemName" : @"确认"
                                };
        //icon_button_record
        NSDictionary *dict3 = @{@"imageName" : @"icon_button_record",
                                @"itemName" : @"记录"
                                };
        NSArray *dataArray = @[dict1,dict2,dict3];
        
        CGFloat x = self.view.bounds.size.width / 3 * 2;
        CGFloat y = 64 - 10;
        CGFloat width = self.view.bounds.size.width * 0.3;
        CGFloat height = dataArray.count * 44;
        __weak __typeof(&*self)weakSelf = self;
        /**
         *  创建menu
         */
        _menuView = [MenuView createMenuWithFrame:CGRectMake(x, y, width, height) target:self.navigationController dataArray:dataArray itemsClickBlock:^(NSString *str, NSInteger tag) {
            
            // do something
            [weakSelf doSomething:(NSString *)str tag:(NSInteger)tag];
            
        } backViewTap:^{
            // 点击背景遮罩view后的block，可自定义事件
            // 这里的目的是，让rightButton点击，可再次pop出menu
            weakSelf.flag = YES;
            _menuView = nil;
            
        }];
    }
    return _menuView;
}


- (IBAction)popMenu:(id)sender {

    if (self.flag) {
        [self.menuView showMenuWithAnimation:YES];
        self.flag = NO;
    }else{
        [self.menuView showMenuWithAnimation:NO];
        self.flag = YES;
        self.menuView = nil;
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.flag = YES;
}

- (void)doSomething:(NSString *)str tag:(NSInteger)tag{
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:str message:[NSString stringWithFormat:@"点击了第%ld个菜单项",tag + 1] preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *action = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
    }];
    [alertController addAction:action];
    [self presentViewController:alertController animated:YES completion:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
