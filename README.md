# PopMenuTableView
## Easy to use this menu，that like iPad
![KKPopMenu.gif](http://code.cocoachina.com/uploads/attachments/20160824/132680/4473f6c28de38821220582c1b503b33e.gif)

# 更新描述
* 新增追加菜单项：在原有菜单基础上，增加一个或者多个菜单按钮。
* 更新菜单项内容：在原有菜单基础上，更新所有的菜单项内容，(也可以局部更新).
* 同样都是类方法实现，不需要显示的创建对象。
* 增加一个maxValueForItemCount属性，防止菜单选项无限增加，导致过长超出屏幕范围。(默认值为6，即：菜单长度最长显示6个项，大雨6个则需要滚动查看菜单项)。
* 代码进行了进一步封装，避免重复代码冗余。
* 使用方法依旧只需要传递内容数组，无需其他多余步骤，更精简、更独立。

# 代码示例：类方法
## `创建`：
* 传递参数说明dataArray -- 由菜单文字内容及图片名称组成的`字典数组`
```Objective-C
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
```
## `追加菜单项目`
* 方法名称：
``` Objective-C
   + (void)appendMenuItemsWith:(NSArray *)appendItemsArray;
```
* 调用方法：
```Objective-C
    NSDictionary *addDict = @{@"imageName" : @"icon_button_recall",
                              @"itemName" : @"新增项"
                              };
    NSArray *newItemArray = @[addDict];
   [MenuView appendMenuItemsWith:newItemArray]; 
   // newItemArray :在原有菜单项个数基础上，追加的菜单项（例如：在菜单中有三项，需要增加第四，第五...项等）
```
    
 
# 参数描述
* fame:pop的菜单坐标和宽高
* target：菜单将要展示的所在控制器 
* dataArray：菜单项内容
* itemsClickBlock：点击菜单的block回调,回调菜单文字和下标
* backViewTap：半透明背景点击回调

`(注：此菜单并非只能加在控制器的view上，有种特殊的需求就是，菜单背景图片的“小尖尖”要与navigationBar相交，此时target需要传递self.navigationController即可)`
  
