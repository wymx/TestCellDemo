//
//  NumberPopView.h
//  CollectionViewTest
//
//  Created by WEI on 16/6/15.
//  Copyright © 2016年 WEI. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NumberPopView : UIView
typedef void(^removeBlock)();
typedef void(^sureBlock)();
@property(nonatomic,copy) removeBlock removeBlock;
@property(nonatomic,copy) sureBlock sureBlock;

+(instancetype)loadFromNib;
-(void)showViewAndWithRemove:(removeBlock)removeBlock;

@end
