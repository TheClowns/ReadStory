//
//  CJLTableViewController.m
//  ReadStory
//
//  Created by 这是C先生 on 2016/12/8.
//  Copyright © 2016年 这是C先生. All rights reserved.
//

#import "CJLTableViewController.h"
#import "CJLViewController.h"
@interface CJLTableViewController ()
@property (nonatomic,strong) NSMutableArray * afterfileNameArray;
@property (nonatomic,strong) NSMutableArray * beforefileNameArray;
@end

@implementation CJLTableViewController
- (NSMutableArray *)afterfileNameArray{
    if (!_afterfileNameArray) {
        _afterfileNameArray = [NSMutableArray array];
    }
    return _afterfileNameArray;
}
- (NSMutableArray *)beforefileNameArray{
    if (!_beforefileNameArray) {
        _beforefileNameArray = [NSMutableArray array];
    }
    return _beforefileNameArray;
}


- (void) loadView{
    [super loadView];
    [self loadData];
}
- (void) loadData{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *docDir = [paths objectAtIndex:0];
    NSString *path = [docDir stringByAppendingString:@"/"];
    
    //    NSString *path=@"System/Library/"; // 要列出来的目录
    
    NSFileManager *myFileManager=[NSFileManager defaultManager];
    
    NSDirectoryEnumerator *myDirectoryEnumerator;
    
    myDirectoryEnumerator=[myFileManager enumeratorAtPath:path];
    
    //列举目录内容，可以遍历子目录
    
    NSLog(@"用enumeratorAtPath:显示目录%@的内容：",path);
    
    while((path=[myDirectoryEnumerator nextObject])!=nil)
        
    {
        
        [self.beforefileNameArray addObject:path];
        //删除文件扩展名
        NSString *fileName = [path stringByDeletingPathExtension];

        
        NSLog(@"%@",[path stringByDeletingPathExtension]);
        [self.afterfileNameArray addObject:fileName];
        
    }
    [self.tableView reloadData];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
    self.tableView.tableFooterView = [UIView new];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.afterfileNameArray.count;
}
- (UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.textLabel.text = self.afterfileNameArray[indexPath.row];
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSString *s = self.beforefileNameArray[indexPath.row];
    CJLViewController *vc = [[CJLViewController alloc]init];
    vc.fileName = s;
//    [self.navigationController pushViewController:vc animated:YES];
    [self.navigationController presentViewController:vc animated:NO completion:nil];
    
}



@end
