

#import "JYTableViewSection.h"

@interface JYTableViewSection ()

@property(weak, nonatomic) UIWindow *superWindow;
@property(weak, nonatomic) UITableView *tableView;
@property(strong, nonatomic) NSMutableArray *rectArray;

// 放大显示
@property(weak, nonatomic) UILabel *bigLabel;

@end

@implementation JYTableViewSection

+ (instancetype)sectionWithTableView:(UITableView *)tableView {
  JYTableViewSection *sharedSection = [[self alloc] init];
  sharedSection.backgroundColor = tableView.backgroundColor;
  sharedSection.tableView = tableView;
  sharedSection.superWindow = tableView.window;

  [sharedSection.superWindow addSubview:sharedSection];

  [sharedSection.superWindow bringSubviewToFront:sharedSection];

  sharedSection.tableView.showsVerticalScrollIndicator = NO;

  sharedSection.window.backgroundColor = [UIColor whiteColor];
  sharedSection.backgroundColor = [UIColor clearColor];

  return sharedSection;
}

+ (instancetype)sectionWithTableView:(UITableView *)tableView
                         AndSections:(NSArray *)sections {
  JYTableViewSection *sharedSection = [self sectionWithTableView:tableView];
  sharedSection.Section = sections;
  return sharedSection;
}

#pragma mark - 如果不设置索引默认16，设置字体必须在设置索引数组之前
// 索引的字体大小
- (UIFont *)font {
  if (_font == nil) {
    _font = [UIFont systemFontOfSize:8];
  }
  return _font;
}

// 放大框的字体大小
- (UIFont *)bigViewfont {
  if (_bigViewfont == nil) {
    _bigViewfont = [UIFont systemFontOfSize:25];
  }
  return _bigViewfont;
}

#pragma mark - 如果颜色不设置使用默认索引颜色
- (UIColor *)sectionColor {
  if (_sectionColor == nil) {
    _sectionColor = [UIColor blackColor];
  }
  return _sectionColor;
}

#pragma make - 计算添加索引的lable
- (void)setSection:(NSArray *)Section {
  _Section = Section;

  // 1.计算大小 以及位置
  __block CGFloat WH = [self lablesizeWithFont:self.font];

  // 根据大小 修改tableview的宽度，在右边预留索引位置
  CGRect Trect = self.tableView.frame;
  Trect.size.width -= WH;
  self.tableView.frame = Trect;

  CGFloat LX = [UIScreen mainScreen].bounds.size.width - WH;
  self.frame = CGRectMake(LX, Trect.origin.y, WH, Trect.size.height);

  self.rectArray = [NSMutableArray array];
  __block CGFloat LY = (self.frame.size.height - self.Section.count * WH) * 0.5;

  // 2.添加索引lable
  [self.Section
      enumerateObjectsUsingBlock:^(NSString *str, NSUInteger idx, BOOL *stop) {

          // 计算rect 并存入数组
          CGFloat LLY = LY + idx * WH;
          CGRect rect = CGRectMake(0, LLY, WH, WH);

          // 设置索引lable
          UILabel *label = [[UILabel alloc] initWithFrame:rect];
          label.text = str;
          label.font = self.font;
          label.textAlignment = NSTextAlignmentCenter;
          label.textColor = self.sectionColor;

          [self addSubview:label];
          [self.rectArray addObject:label];

      }];
}

#pragma 更具字体计算大小
- (CGFloat)lablesizeWithFont:(UIFont *)SSfont {
  NSDictionary *attr = @{NSFontAttributeName : SSfont};

  CGSize size = [self.Section[0]
                    boundingRectWithSize:CGSizeMake(MAXFLOAT, MAXFLOAT)
                                 options:NSStringDrawingUsesLineFragmentOrigin
                              attributes:attr
                                 context:nil].size;

  return (size.height > size.width) ? size.height : size.width;
}

#pragma mark -触发事件 更具触摸点显示相应索引
- (void)sectionWithtouch:(NSSet *)touches AndEvent:(UIEvent *)event {
  //返回与当前接收者有关的所有的触摸对象
  NSSet *allTouches = [event allTouches];

  //随机取出一个对象
  UITouch *touch = [allTouches anyObject];

  //返回触摸点
  __block CGPoint point = [touch locationInView:[touch view]];

  // 遍历 rect 数组 查找触摸点所在的 索引
  [self.rectArray
      enumerateObjectsUsingBlock:^(UILabel *label, NSUInteger idx, BOOL *stop) {

          if (CGRectContainsPoint(label.frame, point)) {

            // 滚动到对应组的顶部
            NSIndexPath *path = [NSIndexPath indexPathForRow:0 inSection:idx];
            [self.tableView scrollToRowAtIndexPath:path
                                  atScrollPosition:UITableViewScrollPositionTop
                                          animated:YES];

            // 添加对应索引的放大视图 tag 以 200 + idx
            label.tag = idx;
            [self moveWithLabel:label];

            // 结束循环
            *stop = YES;
          }

      }];
}

#pragma 添加 放大框
- (UILabel *)bigLabel {
  if (!_bigLabel) {
    UILabel *label = [[UILabel alloc] init];
    [self.superWindow addSubview:label];
    label.textAlignment = NSTextAlignmentCenter;
    label.textColor = [UIColor blackColor];
    label.font = self.bigViewfont;
    label.backgroundColor = [UIColor clearColor];
    _bigLabel = label;
  }
  return _bigLabel;
}

// 更具 label 修改位置和内容
- (void)moveWithLabel:(UILabel *)label {

  UILabel *bigView = self.bigLabel;

  // 显示文字
  bigView.text = label.text;

  // frame 计算
  CGFloat BWH = [self lablesizeWithFont:bigView.font] + 20;

  CGFloat BY = label.frame.origin.y + label.frame.size.height * 0.5 -
               BWH * 0.5 + self.frame.origin.y;
  CGFloat BX = self.frame.origin.x - 10 - BWH;
  bigView.frame = CGRectMake(BX, BY, BWH, BWH);
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
  [self sectionWithtouch:touches AndEvent:event];
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
  [self sectionWithtouch:touches AndEvent:event];
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
  [self.bigLabel removeFromSuperview];
}

//- (void)dealloc {
//  NSLog(@"已经释放");
//}


@end
