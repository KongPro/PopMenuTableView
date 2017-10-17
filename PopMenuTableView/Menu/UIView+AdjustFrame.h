//
//  UIView+AdjustFrame.h
//
//
//  Created by apple on 14-12-7.
//  Copyright (c) 2014年. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (AdjustFrame)

@property (assign, nonatomic) CGFloat x;
@property (assign, nonatomic) CGFloat y;
@property (nonatomic,assign) CGFloat max_X;
@property (nonatomic,assign) CGFloat max_Y;
@property (nonatomic, assign) CGFloat centerX;
@property (nonatomic, assign) CGFloat centerY;
@property (assign, nonatomic) CGFloat width;
@property (assign, nonatomic) CGFloat height;
@property (assign, nonatomic) CGSize size;
@property (assign, nonatomic) CGPoint origin;

@end
