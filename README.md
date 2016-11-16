# PopMenuTableView
## Easy to use this menu，that like iPad. 
![KKPopMenu.gif](http://code.cocoachina.com/uploads/attachments/20160824/132680/4473f6c28de38821220582c1b503b33e.gif)

## 更新描述
* 新增追加菜单项：在原有菜单基础上，增加一个或者多个菜单按钮。
* 更新菜单项内容：在原有菜单基础上，更新所有的菜单项内容，(也可以局部更新).
* 同样都是类方法实现，不需要显示的创建对象。
* 增加一个maxValueForItemCount属性，防止菜单选项无限增加，导致过长超出屏幕范围。(默认值为6，即：菜单长度最长显示6项，大于6个则需要滚动方式查看菜单项)。
* 代码进行了进一步封装，避免重复代码冗余。
* 使用方法依旧只需要传递内容数组，无需其他多余步骤，更精简、更独立。
* **(⚠️注：所有的方法都是类方法，直接用类名调用即可,`并留意文档最后的的参数说明`)**

## 代码示例：
### 1. `类方法创建：`  

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
### 2. `展示`
* **方法名称：**
   ```Objective-C
      + (void)showMenuWithAnimation:(BOOL)isShow;
   ```  
* **说明：**  
   _自带**`动画缩放效果`**的pop展示，参数**`isSHow`**控制展示或不展示，(也可以通过**`hidden`**方法来控制隐藏，后续有说明)_

* **方法调用：**
   ```Objective-C
   // self.flag : YES - 展示，NO - 不展示
   [MenuView showMenuWithAnimation:self.flag];  
   ``` 
### 3. `追加菜单项目：`
* **方法名称：**
   ```Objective-C
      + (void)appendMenuItemsWith:(NSArray *)appendItemsArray;
   ```  

* **说明：**  
   `在原有菜单项个数基础上，追加的菜单项（例如：在菜单中有三项，需要增加第四，第五...项等），可以实现动态增加菜单项`  
   
* **方法调用：**
   ```Objective-C
       //拼接字典数组，这里可以使用 
       NSDictionary *addDict = @{@"imageName" : @"icon_button_recall",
                                 @"itemName" : @"新增项"
                                 };
       NSArray *newItemArray = @[addDict];

       // 调用：参数newItemArray :追加的菜单项字典拼接成的数组
      [MenuView appendMenuItemsWith:newItemArray];
   ```  

### 4. `更新菜单项：`
* **方法名称：**  
   ```Objective-C  
      + (void)updateMenuItemsWith:(NSArray *)newItemsArray;
   ```  

* **说明：**  
   `更新修改所有菜单的内容，根据传入的字典数组内容，动态更新菜单项，只需要传递数组即可，其他无需多虑`  
   
* **方法调用：**
   ```Objective-C
      - (IBAction)removeMenuItem:(id)sender {
          /**
           *  更新菜单: _dataArray是控制器中全局字典数组，存的是菜单项图标和功能名称
           */
          [MenuView updateMenuItemsWith:_dataArray];
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

   * _隐藏：对菜单的size进行缩小，考虑到当控制器始终存在时，即用户**`没有进行push，或者退出app`**的操作(pop的情况下面会提到)时，就没必要移除菜单，避免需要菜单时的反复创建，此时应调用**`hidden方法`**_
   * _移除：从父试图remove掉，当用户进行**`pop`**，或者**`退出app`**的操作(控制器已经被销毁，就没必要保留菜单并占用内存空间了)时，应当调用**`clearMenu`**方法_
   
* **方法调用：**
   ```Objective-C
      [MenuView hidden];  // 隐藏菜单
      [MenuView clearMenu];   // 移除菜单
   ```
 
## `参数描述：`
* fame: 菜单坐标和宽高 **`(非必填，取默认值）`**
* target：菜单将要展示的所在控制器 **`(参数必填)`**
* dataArray：菜单项内容 **`(必填参数)`**
* itemsClickBlock：点击菜单的block回调,回调菜单文字和下标
* backViewTap：半透明背景点击回调
* **(注：此菜单并非只能加在控制器的view上，有种特殊的需求就是，菜单背景图片的`“小尖尖”`要与navigationBar相交，此时target需要传递self.navigationController即可)**
### `温馨提示：`
* demo中的target传递的是_`self.navigationController`_，frame参数的默认值也是相对navigationBar来取值。如果菜单要加在控制器的view上，则按需传frame，位置可能需要细细调整，效果才最好。
  
