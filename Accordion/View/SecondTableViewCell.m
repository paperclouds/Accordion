//
//  SecondTableViewCell.m
//  Accordion
//
//  Created by paperclouds on 2018/4/24.
//  Copyright © 2018年 neisha. All rights reserved.
//

#import "SecondTableViewCell.h"

#define screenWidth [UIScreen mainScreen].bounds.size.width
#define titleLeftSpace 40
#define titleHeight 20
#define cellHeight 50
#define arrowRightSpace 50
#define arrowWidth 8
#define arrowHeight 12

@implementation SecondTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self.contentView addSubview:self.titleLbl];
        [self.contentView addSubview:self.arrowImageView];
        [self.contentView addSubview:self.line];
    }
    return self;
}

- (UILabel *)titleLbl{
    if (_titleLbl == nil) {
        self.titleLbl = [[UILabel alloc]initWithFrame:CGRectMake(titleLeftSpace, (cellHeight-titleHeight)/2, screenWidth-titleLeftSpace*2, titleHeight)];
    }
    return _titleLbl;
}

- (UIImageView *)arrowImageView{
    if (_arrowImageView == nil) {
        self.arrowImageView = [[UIImageView alloc]initWithFrame:CGRectMake([UIScreen mainScreen].bounds.size.width-arrowRightSpace, (cellHeight-arrowHeight)/2, arrowWidth, arrowHeight)];
        [self.arrowImageView setImage:[UIImage imageNamed:@"arrow"]];
    }
    return _arrowImageView;
}

-(UIView *)line{
    if (_line == nil) {
        self.line = [[UIView alloc]initWithFrame:CGRectMake(0, 49.5, [UIScreen mainScreen].bounds.size.width, 0.5)];
        [self.line setBackgroundColor:[UIColor colorWithWhite:0.9 alpha:1]];
    }
    return _line;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
