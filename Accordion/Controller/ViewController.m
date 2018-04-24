//
//  ViewController.m
//  Accordion
//
//  Created by paperclouds on 2018/4/19.
//  Copyright © 2018年 neisha. All rights reserved.
//

#import "ViewController.h"
#import "FirstTableViewCell.h"
#import "SecondTableViewCell.h"
#import <UIImageView+WebCache.h>

static NSString *FirstCellIdentifier = @"FirstCellIdentifier";
static NSString *SecondCellIdentifier = @"SecondCellIdentifier";

#define firstCellHeight 80
#define secondCellHeight 50

@interface ViewController ()<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSArray *dataArray;
@property (nonatomic, assign) BOOL isOpen;
@property (nonatomic, strong) NSIndexPath *selectIndex;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [self.view addSubview:self.tableView];
}

-(NSArray *)dataArray{
    if (_dataArray == nil) {
        NSString *plistPath = [[NSBundle mainBundle]pathForResource:@"CategoryData" ofType:@"plist"];
        _dataArray = [NSArray arrayWithContentsOfFile:plistPath];
    }
    return _dataArray;
}

-(UITableView *)tableView{
    if (_tableView == nil) {
        _tableView = [[UITableView alloc]initWithFrame:[UIScreen mainScreen].bounds style:UITableViewStylePlain];
        _tableView.dataSource = self;
        _tableView.delegate = self;
        _tableView.showsVerticalScrollIndicator = NO;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        [_tableView registerClass:[FirstTableViewCell class] forCellReuseIdentifier:FirstCellIdentifier];
        [_tableView registerClass:[SecondTableViewCell class] forCellReuseIdentifier:SecondCellIdentifier];
    }
    return _tableView;
}

#pragma mark - UITableViewDataSource
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.dataArray.count;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (_isOpen && _selectIndex.section == section ){
        NSArray *secondArray = self.dataArray[section][@"tags"];
        return secondArray.count+1;
    }
        return 1;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (_isOpen && indexPath.row !=0) {
            SecondTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:SecondCellIdentifier forIndexPath:indexPath];
            NSArray *secondArray = self.dataArray[indexPath.section][@"tags"];
            NSString *str = secondArray[indexPath.row-1][@"t"];
            cell.titleLbl.text = str;
            return cell;
    }else{
        FirstTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:FirstCellIdentifier forIndexPath:indexPath];
        NSString *str = self.dataArray[indexPath.section][@"name"];
        cell.titleLbl.text = str;
        [cell.iconImageView sd_setImageWithURL:[NSURL URLWithString:self.dataArray[indexPath.section][@"icon_f"]]];
        return cell;
    }
}

#pragma mark - UITableViewDelegate

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 0) {
        return firstCellHeight;
    }
    return secondCellHeight;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 0) {
        if ([indexPath isEqual:_selectIndex]) {
            _isOpen = NO;
            [self didSelectCellRowFirstDo:NO nextDo:NO];
            _selectIndex = nil;
        }else{
            if (!_selectIndex) {
                _selectIndex = indexPath;
                //  获取选中行数据
                [self didSelectCellRowFirstDo:YES nextDo:NO];
            }else{
                [self didSelectCellRowFirstDo:NO nextDo:YES];
            }
        }
    }
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (void)didSelectCellRowFirstDo:(BOOL)firstDoInsert nextDo:(BOOL)nextDoInsert
{
    _isOpen = firstDoInsert;
    
    NSMutableArray *rowToInsert = [[NSMutableArray alloc]init];
    for (int i = 0; i < [_dataArray[_selectIndex.section][@"tags"] count]; i++) {
        NSIndexPath *indexPathToInsert = [NSIndexPath indexPathForRow:i+1 inSection:_selectIndex.section];
        [rowToInsert addObject:indexPathToInsert];
    }
    
    [self.tableView beginUpdates];
    if (firstDoInsert) {
        [self.tableView insertRowsAtIndexPaths:rowToInsert withRowAnimation:UITableViewRowAnimationTop];
    }else{
        [self.tableView deleteRowsAtIndexPaths:rowToInsert withRowAnimation:UITableViewRowAnimationTop];
    }
    [self.tableView endUpdates];
    
    if (nextDoInsert) {
        _isOpen = YES;
        _selectIndex = [self.tableView indexPathForSelectedRow];
        [self didSelectCellRowFirstDo:YES nextDo:NO];
    }
    
    if (_isOpen){
        [self.tableView scrollToRowAtIndexPath:_selectIndex atScrollPosition:UITableViewScrollPositionTop animated:YES];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
