//
//  ContactListCell.m
//  WeChat
//
//  Created by admin on 2018/1/18.
//  Copyright © 2018年 zjw. All rights reserved.
//

#import "ContactListCell.h"
#import "ContactModel.h"

@implementation ContactListCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setModel:(ContactModel *)model
{
    _model = model;
    
    _nameLabel.text = [NSString stringWithFormat:@"%@",model.name];
    _headImage.image = [UIImage imageNamed:model.imageName];
}

@end
