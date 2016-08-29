# PopMenuTableView
## Easy to use this menu，that like iPad
![KKPopMenu.gif](http://code.cocoachina.com/uploads/attachments/20160824/132680/4473f6c28de38821220582c1b503b33e.gif)

#代码示例：类方法
    __weak __typeof(&*self)weakSelf = self;
    /**
     *  创建menu
     */
    [MenuView createMenuWithFrame:CGRectMake(x, y, width, height) target:self.navigationController dataArray:dataArray itemsClickBlock:^(NSString *str, NSInteger tag) {
        // do something
        [weakSelf doSomething:(NSString *)str tag:(NSInteger)tag];
        
    } backViewTap:^{
        // 点击背景遮罩view后的block，可自定义事件
        // 这里的目的是，让rightButton点击，可再次pop出menu
        weakSelf.flag = YES;
    }];
        
### 参数描述
     fame:pop的菜单坐标，宽高
     target：菜单将要展示的所在控制器
     dataArray：菜单项内容
     itemsClickBlock：点击菜单的block回调,回调菜单文字和下标
     backViewTap：半透明背景点击回到
    （注：此菜单并非只能加在控制器的view上，有种特殊的需求就是，菜单背景图片的“小尖尖”要与navigationBar相交，此时target需要传递self.navigationController即可）
  
