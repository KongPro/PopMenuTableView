# PopMenuTableView
## Easy to use this menu，that like iPad.
`尴尬：图片抽搐了，下载运行看吧...`

![动态菜单](http://www.code4app.com/data/attachment/forum/201701/17/143035at0ftffqtt0tfctc.gif)

## 更新描述
* 自适应方向，自适应箭头指示位置。
* 新增追加菜单项：在原有菜单基础上，增加一个或者多个菜单按钮。
* 更新菜单项内容：在原有菜单基础上，更新所有的菜单项内容。(**_`也可以局部更新`_**)。
* 同样都是类方法实现，不需要显示的创建对象。
* ⚠️使用方法依旧只需要传递内容数组，无需其他多余步骤。
* **(⚠️注：所有的方法都是类方法，直接用类名调用即可,_`并留意文档最后的的参数说明`_)**

## 代码示例：
### 1. `类方法创建：`  

* 传递参数说明dataArray -- 由菜单文字内容及图片名称组成的**`字典数组`**  

   ```Objective-C
      __weak __typeof(&*self)weakSelf = self;
       /**
        *  创建menu
        */
       [CommonMenuView createMenuWithFrame : CGRectMake(x, y, width, height) 
                              target : self.navigationController 
                           dataArray : dataArray 
                     itemsClickBlock : ^(NSString *str, NSInteger tag) {  /* do something */  } 
                         backViewTap : ^{  /* 点击背景遮罩view后的block，可自定义事件 */  }];
   ``` 

### 2. `展示`
* **方法名称：**  

   ```Objective-C
      + (void)showMenuAtPoint:(CGPoint)point;
   ```  
* **说明：**  
   _根据菜单展示的位置，指示箭头默认适应点击坐标，高度超出屏幕，菜单自动翻转。_

* **调用示例：**  
   ```Objective-C
      // point，展示的坐标
      + (void)showMenuAtPoint:(CGPoint)point;
   ``` 
### 3. `追加菜单项：`
* **方法名称：**
   ```Objective-C
      [CommonMenuView showMenuAtPoint:point];
   ```  

* **说明：**  
   _在原有菜单项个数基础上，**`追加`**的菜单项（例如：原有菜单中有三项，需要**`增加第四，第五...项`**等），可以实现**`动态增加`**菜单项`_ 
   
* **调用示例：**
   ```Objective-C
       //拼接字典数组，这里可以使用 
       NSDictionary *addDict = @{@"imageName" : @"icon_button_recall",
                                 @"itemName" : @"新增项"
                                 };
       NSArray *newItemArray = @[addDict];

       // 调用：参数newItemArray :追加的菜单项字典拼接成的数组
      [CommonMenuView appendMenuItemsWith:newItemArray];
   ```  

### 4. `更新菜单项：`
* **方法名称：**  
   ```Objective-C  
      + (void)updateMenuItemsWith:(NSArray *)newItemsArray;
   ```  

* **说明：**  
   _**`更新修改所有`**菜单的内容，根据传入的**`字典数组`**内容，动态更新菜单项，只需要传递数组即可，其他无需多虑`_ 
   
* **调用示例：**
   ```Objective-C
      - (IBAction)removeMenuItem:(id)sender {
          /**
           *  更新菜单: _dataArray是控制器中全局字典数组，存的是菜单项图标和功能名称
           */
          [CommonMenuView updateMenuItemsWith:_dataArray];
      }
   ```  

### 5.`隐藏和移除：`
* **方法名称：**  
   ```Objective-C  
      /* 隐藏菜单 */
      + (void)hidden;

      /* 移除菜单 */
      + (void)clearMenu;
   ```  

* **说明：**  
   1 ._只要程序不退出,只要不执行**`clearMenu`**方法，创建的菜单对象就一直在内存中。若有在其他控制器利用类方法调用并展示，一旦菜单项不同，请调用**`updateMenuItemsWith:`**方法更新菜单项目。_
   
   2 ._隐藏：对菜单的size进行缩小，考虑到当控制器始终存在时，即用户**`没有进行push，或者退出app`**的操作(pop的情况下面会提到)时，就没必要移除菜单，避免需要菜单时的反复创建，此时应调用**`hidden方法`**_
   
   3 ._移除：从父试图remove掉，当用户进行**`pop`**，或者**`退出app`**的操作(控制器已经被销毁，就没必要保留菜单并占用内存空间了)时，应当调用**`clearMenu`**方法_
   
* **调用示例：**
   ```Objective-C
      [CommonMenuView hidden];  // 隐藏菜单
      [CommonMenuView clearMenu];   // 移除菜单
   ```
 
## `参数描述：`
* fame: 菜单坐标和宽高 **`(非必填，高度自适应，width默认120）`**
* target：菜单将要展示的所在控制器 **`(参数必填)`**
* dataArray：菜单项内容 **`(必填参数)`**
* itemsClickBlock：点击菜单的block回调,回调菜单文字和下标
* backViewTap：半透明背景点击回调

### `温馨提示：`
* demo在Nav展示时候，fram的origin是自己写死的，至今没有找到能获取nav上按钮所在point的方法，如果大神们有好方法，或者对这个demo有改进意见，请发邮件：KongPro@163.com，不胜感激～🙏🙏🙏
