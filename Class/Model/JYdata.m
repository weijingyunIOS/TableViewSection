
#import "JYdata.h"

@implementation JYdata

- (instancetype)initWithDic:obj {
  if (self = [super init]) {
    [self setValuesForKeysWithDictionary:obj];
  }
  return self;
}

+ (NSArray *)datatitle {
  NSArray *temparray = @[
    // 0 - 4
    @{
      @"title" : @"左侧放大显示"
    },
    @{
      @"title" : @"绘制矩形 CGContextAddRect"
    },
    @{
      @"title" : @"绘制椭圆 圆"
    },
    @{
      @"title" : @"线段头尾转折点样式"
    },
    @{
      @"title" : @"画圆弧"
    }

  ];

  NSMutableArray *array = [NSMutableArray array];
  for (NSDictionary *obj in temparray) {
    [array addObject:[[self alloc] initWithDic:obj]];
  }
  return array;
}

@end
