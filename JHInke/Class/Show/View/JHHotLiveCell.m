//
//  JHHotLiveCell.m
//  JHInke
//
//  Created by 佳豪 on 2017/2/25.
//  Copyright © 2017年 佳豪. All rights reserved.
//

#import "JHHotLiveCell.h"
#import "UIImageView+SDWebImage.h"
#import "JHLive.h"

@interface JHHotLiveCell ()
@property (weak, nonatomic) IBOutlet UIImageView *headImgV;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *cityLabel;
@property (weak, nonatomic) IBOutlet UILabel *onlineLabel;
@property (weak, nonatomic) IBOutlet UIImageView *portraitImgV;


@end

@implementation JHHotLiveCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
//    self.headImgV.layer.cornerRadius = 25;
//    self.headImgV.layer.masksToBounds = YES;
}

- (void)setLive:(JHLive *)live{
    _live = live;
    [self.headImgV downloadImage:live.creator.portrait placeholder:@"login_ico_weibo"];
    self.nameLabel.text = live.creator.nick;
    NSString * cityStr = nil;
    // = 的优先级大于三目运算符
    ![live.city isEqualToString:@""] ? (cityStr = [NSString stringWithFormat:@"%@>",live.city]) : (cityStr = @"可能在火星>");
    self.cityLabel.text = cityStr;
    self.onlineLabel.text = [@(live.onlineUsers) stringValue];
    [self.portraitImgV downloadImage:live.creator.portrait placeholder:@"login_ico_weibo"];
}

@end
