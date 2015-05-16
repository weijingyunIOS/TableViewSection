

#import "JYCars.h"

@implementation JYCars

- (instancetype)initWithCarsDic:(NSDictionary *)carsdic {
  if (self = [super init]) {
    [self setValuesForKeysWithDictionary:carsdic];
  }

  return self;
}

+ (instancetype)CarsWithDic:(NSDictionary *)carsdic {
  return [[JYCars alloc] initWithCarsDic:carsdic];
}

@end
