//
//  FirstTableViewCell.m
//  Accordion
//
//  Created by paperclouds on 2018/4/24.
//  Copyright © 2018年 neisha. All rights reserved.
//

#import "FirstTableViewCell.h"

#define screenWidth [UIScreen mainScreen].bounds.size.width

#define Marin 20
#define Height 70
#define iconSize 40

@implementation FirstTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self.contentView addSubview:self.backImageView];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self.contentView addSubview:self.titleLbl];
        [self.contentView addSubview:self.iconImageView];
    }
    return self;
}

-(UIImageView *)backImageView{
    if (_backImageView == nil) {
        self.backImageView = [[UIImageView alloc]initWithFrame:CGRectMake(Marin, 0, [UIScreen mainScreen].bounds.size.width-Marin*2, Height)];
        self.backImageView.layer.cornerRadius = 2;
        self.backImageView.layer.masksToBounds = YES;
        self.backImageView.backgroundColor = [UIColor colorWithWhite:0.95 alpha:1];
    }
    return _backImageView;
}

-(UILabel *)titleLbl{
    if (_titleLbl == nil) {
        self.titleLbl = [[UILabel alloc]initWithFrame:CGRectMake(Marin*2, 0, screenWidth-Marin*2, Height)];
    }
    return _titleLbl;
}

-(UIImageView *)iconImageView{
    if (_iconImageView == nil) {
        self.iconImageView = [[UIImageView alloc]initWithFrame:CGRectMake(screenWidth-iconSize*2, (Height-iconSize)/2, iconSize, iconSize)];
    }
    return _iconImageView;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
