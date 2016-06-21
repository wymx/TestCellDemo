iOS8之后使用系统所带的方法为cell左滑添加更多事件
iOS8之前可使用三方库实现

系统方法：
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

