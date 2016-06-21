//
//  ViewController.m
//  TestCellDemo
//
//  Created by WEI on 16/6/15.
//  Copyright © 2016年 WEI. All rights reserved.
//

#import "ViewController.h"
#import "POP.h"
#import "NumberPopView.h"

@interface ViewController ()<UITableViewDelegate,UITableViewDataSource>
{
	UITableView *table;
}
@property(nonatomic,strong) NSMutableArray *arrayTest;

@end

@implementation ViewController

- (void)viewDidLoad {
	[super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
	
	self.arrayTest = [NSMutableArray arrayWithArray:@[@"这是第一行",@"这是第2行",@"这是第3行",@"这是第4行",@"这是第5行",@"这是第6行",@"这是第7行",@"这是第8行",@"这是第9行"]];
	[self makUI];
	
}

- (void)makUI{
	
	table = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height) style:UITableViewStylePlain];
	
	table.delegate = self;
	table.dataSource = self;
	
	[self.view addSubview:table];
	
	
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
	return self.arrayTest.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
	//创建cell
	static NSString *ID = @"wu";
	UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
	if (cell ==nil) {
		cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
	}
	cell.textLabel.text = self.arrayTest[indexPath.row];
	return cell;
}
-(NSArray<UITableViewRowAction *> *)tableView:(UITableView *)tableView editActionsForRowAtIndexPath:(NSIndexPath *)indexPath{
	
	UITableViewRowAction *deleteRowAction = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleDestructive title:@"删除" handler:^(UITableViewRowAction * _Nonnull action, NSIndexPath * _Nonnull indexPath) {
		[self.arrayTest removeObjectAtIndex:indexPath.row];
		[table deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
	}];
	UITableViewRowAction *topRowAction = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleDefault title:@"置顶" handler:^(UITableViewRowAction * _Nonnull action, NSIndexPath * _Nonnull indexPath) {
		[self.arrayTest exchangeObjectAtIndex:indexPath.row withObjectAtIndex:0];
		NSIndexPath *firstIndexPath = [NSIndexPath indexPathForRow:0 inSection:indexPath.section];
		[tableView moveRowAtIndexPath:indexPath toIndexPath:firstIndexPath];
	}];
	topRowAction.backgroundColor = [UIColor blueColor];
	UITableViewRowAction *moreRowAction = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleNormal title:@"更多" handler:^(UITableViewRowAction * _Nonnull action, NSIndexPath * _Nonnull indexPath) {
		
		//点击更多添加选择数量
		
		NumberPopView *numberView = [NumberPopView loadFromNib];
		[numberView showViewAndWithRemove:^{
			[numberView removeFromSuperview];
		}];
		[self.view addSubview:numberView];
		
	}];
	return @[deleteRowAction,topRowAction,moreRowAction];
}

-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath{
	
	//自定义cell加载时动画
	
//	CABasicAnimation *scaleAnimation = [CABasicAnimation animationWithKeyPath:@"transform"];
//	
//	scaleAnimation.fromValue = [NSValue valueWithCATransform3D:CATransform3DMakeScale(0.8, 0.8, 1)];
//	
//	scaleAnimation.toValue  = [NSValue valueWithCATransform3D:CATransform3DMakeScale(1, 1, 1)];
//	
//	scaleAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn];
//	
//	[cell.layer addAnimation:scaleAnimation forKey:@"transform"];
	
	
	
	// 从锚点位置出发，逆时针绕 Y 和 Z 坐标轴旋转90度
//	CATransform3D transform3D = CATransform3DMakeRotation(M_PI_2, 0.0, 1.0, 1.0);
//	// 定义 cell 的初始状态
//	cell.alpha = 0.0;
//	cell.layer.transform = transform3D;
//	cell.layer.anchorPoint = CGPointMake(0.0, 0.5);
//	
//	[UIView animateWithDuration:0.5 animations:^{
//		cell.alpha = 1.0;
//		cell.layer.transform = CATransform3DIdentity;
//		CGRect rect = cell.frame;
//		rect.origin.x = 0.0;
//		cell.frame = rect;
//	}];
//	
//	cell.backgroundColor = [UIColor redColor];
	
	
	cell.layer.transform = CATransform3DMakeScale(0.1, 0.1, 1);
	[UIView animateWithDuration:1 animations:^{
		cell.layer.transform = CATransform3DMakeScale(1, 1, 1);
	}];
	
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
	// kPOPLayerPositionY 向下
	// kPOPLayerPositionX 向右
	
	UITableViewCell *cell = [table cellForRowAtIndexPath:indexPath];
	
	
	POPSpringAnimation *anim = [POPSpringAnimation animationWithPropertyNamed:kPOPLayerPositionY];
	// 移动距离
	anim.toValue = [[NSNumber alloc] initWithFloat:cell.center.y + 20];
	// 从当前 + 1s后开始
	anim.beginTime = CACurrentMediaTime() + 0.5f;
	// 弹力--晃动的幅度 (springSpeed速度)
	anim.springBounciness = 15.0f;
	[cell pop_addAnimation:anim forKey:@"position"];
	POPSpringAnimation *anim1 = [POPSpringAnimation animationWithPropertyNamed:kPOPLayerBounds];
	CGRect cellFrame = cell.frame;
	anim1.toValue = [NSValue valueWithCGRect:cellFrame];
	[cell pop_addAnimation:anim1 forKey:@"size"];
}




@end
