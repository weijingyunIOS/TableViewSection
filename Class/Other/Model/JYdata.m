
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
    }

  ];

  NSMutableArray *array = [NSMutableArray array];
  for (NSDictionary *obj in temparray) {
    [array addObject:[[self alloc] initWithDic:obj]];
  }
  return array;
}

@end
