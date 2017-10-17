//
//  MenuModel.h
//  PopMenuTableView
//
//  Created by 孔繁武 on 16/8/2.
//  Copyright © 2016年 KongPro. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MenuModel : NSObject

@property (nonatomic,copy) NSString *imageName;
@property (nonatomic,copy) NSString *itemName;

+ (instancetype)MenuModelWithDict:(NSDictionary *)dict;

@end
