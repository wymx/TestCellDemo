//
//  NumberPopView.m
//  CollectionViewTest
//
//  Created by WEI on 16/6/15.
//  Copyright © 2016年 WEI. All rights reserved.
//

#import "NumberPopView.h"

#define MainHight [UIScreen mainScreen].bounds.size.height
#define MainWidth [UIScreen mainScreen].bounds.size.width

@interface NumberPopView ()<UITextFieldDelegate>
@property (strong, nonatomic) IBOutlet UITextField *numberText;

@end

@implementation NumberPopView

- (IBAction)decreaseButtonAction:(UIButton *)sender {//减少按钮
	if ([self.numberText.text intValue] == 0) {
		NSLog(@"数量是0了！");
	}else{
		self.numberText.text = [NSString stringWithFormat:@"%d",[self.numberText.text intValue]-1];
	}
	
}
- (IBAction)addButtonAction:(UIButton *)sender {//增加按钮
	self.numberText.text = [NSString stringWithFormat:@"%d",[self.numberText.text intValue]+1];
}

+(instancetype)loadFromNib{

	NumberPopView *reserveView=[[[NSBundle mainBundle] loadNibNamed:@"NumberPopView" owner:nil options:nil] lastObject];
	reserveView.frame = CGRectMake(0,0,MainWidth,MainHight);
	reserveView.backgroundColor = [UIColor colorWithWhite:0.687 alpha:0.500];
	return reserveView;
}
-(void)makeUI{
	
	self.numberText.delegate = self;
	UITapGestureRecognizer * tapGesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(coverClick)];
	
	 [self addGestureRecognizer:tapGesture];
}

-(void)showViewAndWithRemove:(removeBlock)removeBlock{
	[self makeUI];
	if (removeBlock) {
		self.removeBlock = removeBlock;
	}
}
-(void)coverClick{
	NSLog(@"背景点击");
	self.removeBlock();
	
}

@end
