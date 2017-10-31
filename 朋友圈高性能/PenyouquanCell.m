//
//  PenyouquanCell.m
//  朋友圈高性能
//
//  Created by Binbin Mu on 2017/10/27.
//  Copyright © 2017年 Binbin Mu. All rights reserved.
//

#import "PenyouquanCell.h"
#import <YYLabel.h>
#import <Masonry.h>
#import <UIButton+YYWebImage.h>
#import <UIImageView+YYWebImage.h>
#import <UIImage+YYAdd.h>
#define UIScreenWidth   [UIScreen mainScreen].bounds.size.width
#define UIScreenHeight  [UIScreen mainScreen].bounds.size.height
@interface PenyouquanCell ()
@property(nonatomic ,strong)UIImageView *iconImageView;
@property(nonatomic ,strong)YYLabel *iconName;
@property(nonatomic ,strong)YYLabel *TitleName;
@property(nonatomic ,strong)ImagesView *images;

@end
static CGFloat margin = 10.f;
@implementation PenyouquanCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}


-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self == [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        [self SetUpUI];
    }
  
    return self;
}

-(void)SetUpUI
{
    [self.contentView addSubview:self.iconName];
 
    [self.contentView addSubview:self.TitleName];
    
    [self.contentView addSubview:self.iconImageView];
    
    [self.contentView addSubview:self.images];
    
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    
    [self.iconImageView mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.top.left.mas_equalTo(margin);
        
        make.width.height.mas_equalTo(30);
        
    }];
    
    [self.iconName mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.mas_equalTo(self.iconImageView.mas_right).offset(margin);
        
        make.centerY.mas_equalTo(self.iconImageView);

    }];
    
    [self.TitleName mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.top.mas_equalTo(self.iconImageView.mas_bottom).offset(margin);
        
        make.left.mas_equalTo(self.iconName);
        
        make.height.mas_equalTo(0).priorityLow();
        
    }];
    
    [self.images mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.top.mas_equalTo(self.TitleName.mas_bottom).offset(margin);
        
        make.left.mas_equalTo(self.iconImageView.mas_right).offset(margin);
        
        make.right.mas_equalTo(self.contentView).offset(-margin);
        
        make.height.mas_equalTo(0).priorityLow();
        
        make.bottom.mas_equalTo(self.contentView).offset(-margin).priorityLow();
        
    }];
    
  
    
}


-(void)setModal:(PenyouquanModal *)modal
{
    _modal = modal;
    
    
    __weak typeof(self) weakSelf = self;
    
    [self.iconImageView setImageWithURL:[NSURL URLWithString:modal.iconImage] placeholder:[UIImage imageNamed:@"AppIcon512x512"] options:YYWebImageOptionSetImageWithFadeAnimation manager:[YYWebImageManager sharedManager] progress:nil transform:^UIImage * _Nullable(UIImage * _Nonnull image, NSURL * _Nonnull url) {
        
        return [image imageByRoundCornerRadius:100];
        
     }  completion:^(UIImage * _Nullable image, NSURL * _Nonnull url, YYWebImageFromType from, YYWebImageStage stage, NSError * _Nullable error) {
          UIImage *newimage = [image imageByRoundCornerRadius:100];
         
         weakSelf.iconImageView.image = newimage;
    }];
    
    if (modal.images.count == 0) {
        
        [self.images mas_updateConstraints:^(MASConstraintMaker *make) {
            
            make.height.mas_equalTo(0).priorityMedium();
            
            make.bottom.mas_equalTo(self.contentView).priorityMedium();
            
        }];
    }
    
   self.images.imagesArray = [NSMutableArray arrayWithArray:modal.images];
    
    YYTextContainer *container = [YYTextContainer containerWithSize:CGSizeMake(UIScreenWidth - 60, CGFLOAT_MAX)];
    
    NSAttributedString *attributeString = [[NSAttributedString alloc]initWithString:modal.iconName];
    
    YYTextLayout *layout = [YYTextLayout layoutWithContainer:container text:attributeString];
    
    self.iconName.textLayout = layout;
    
    
    YYTextContainer *container2 = [YYTextContainer containerWithSize:CGSizeMake(UIScreenWidth - 60, CGFLOAT_MAX)];
    
    NSAttributedString *attributeString2 = [[NSAttributedString alloc]initWithString:modal.TitleName];
    
    YYTextLayout *layout2 = [YYTextLayout layoutWithContainer:container2 text:attributeString2];
    
    self.TitleName.textLayout = layout2;
    
    [self.TitleName mas_updateConstraints:^(MASConstraintMaker *make) {
       
        make.height.mas_equalTo(layout2.textBoundingSize.height);
    }];
    
    
    
    self.iconName.text = modal.iconName;
    
    self.TitleName.text = modal.TitleName;
    
 
    
}

#pragma mark - Getter

- (UIImageView *)iconImageView
{
    if(!_iconImageView){
        _iconImageView = [[UIImageView alloc] init];
    }
    return _iconImageView;
}

-(ImagesView *)images
{
    if (!_images) {
        _images = [[ImagesView alloc] init];
    }
    return _images;
}


-(YYLabel *)iconName
{
    if (_iconName == nil) {
        _iconName = [YYLabel new];
        _iconName.textVerticalAlignment = YYTextVerticalAlignmentCenter;
        _iconName.displaysAsynchronously = YES;
        _iconName.ignoreCommonProperties = YES;
        _iconName.fadeOnHighlight = NO;
        _iconName.fadeOnAsynchronouslyDisplay = NO;
        _iconName.highlightTapAction = ^(UIView *containerView, NSAttributedString *text, NSRange range, CGRect rect){
        
        };
    }

    return _iconName;
}

-(YYLabel *)TitleName
{
    if (_TitleName == nil) {
        _TitleName = [YYLabel new];
        _TitleName.textVerticalAlignment = YYTextVerticalAlignmentCenter;
        _TitleName.displaysAsynchronously = YES;
        _TitleName.ignoreCommonProperties = YES;
        _TitleName.font = [UIFont systemFontOfSize:13];
        _TitleName.fadeOnHighlight = NO;
        _TitleName.fadeOnAsynchronouslyDisplay = NO;
        _TitleName.numberOfLines = 0;
        _TitleName.preferredMaxLayoutWidth = UIScreenWidth -50;
        _TitleName.highlightTapAction = ^(UIView *containerView, NSAttributedString *text, NSRange range, CGRect rect){
            
        };
    }
    
    return _TitleName;
}


@end


@interface ImagesView ()
@property(nonatomic ,strong)NSMutableArray *ButtonArray;
@end

#define ButtonW   (UIScreenWidth - 60-1/2*margin)/3.f
@implementation ImagesView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self SetUpUI];
    }
    return self;
}

-(void)SetUpUI
{
   
    
//    NSInteger line = self.imagesArray.count%3;
    
    for (int i = 0; i <9; i++) {
        
        NSInteger row1 = i/3;
        
        NSInteger line2 = i%3;
        
        
        UIButton *button = [[UIButton alloc]init];
        
        button.frame = CGRectMake((margin/2 + ButtonW)*line2, (margin/2 + ButtonW)*row1, ButtonW, ButtonW);
        
        button.hidden = YES;
        
        [self.ButtonArray addObject:button];
        
        [self addSubview:button];
    }
    

    

}

-(void)setImagesArray:(NSMutableArray *)imagesArray
{
    _imagesArray = imagesArray;
    
     NSInteger count = (imagesArray.count -1)/3  +1;
    
    NSLog(@"%ld,%f" ,imagesArray.count,(margin/2 + ButtonW)*count);
    
    [self.ButtonArray enumerateObjectsUsingBlock:^(UIButton *  _Nonnull button, NSUInteger idx, BOOL * _Nonnull stop) {
        
        if (idx<self.imagesArray.count) {
            
            [button setImageWithURL:[NSURL URLWithString:self.imagesArray[idx]] forState:UIControlStateNormal placeholder:[UIImage imageNamed:@"7dbc6809fee7f1424ac45c8cdda0cc8f"] options:YYWebImageOptionShowNetworkActivity completion:nil];
            
            button.hidden = NO;
            
        }else{
        
            button.hidden = YES;
        }

        
    }];
    
    
    
    
    
    if (imagesArray.count == 0) {
        
        [self mas_updateConstraints:^(MASConstraintMaker *make) {
            
            make.height.mas_equalTo(0).priorityMedium();
        }];
    }else{
        [self mas_updateConstraints:^(MASConstraintMaker *make) {
            
            make.height.mas_equalTo((margin/2 + ButtonW)*count).priorityMedium();
            
        }];
    }
    
}

#pragma mark - Getter

- (NSMutableArray *)ButtonArray
{
    if(!_ButtonArray){
        _ButtonArray = [[NSMutableArray alloc] init];
    }
    return _ButtonArray;
}


@end
