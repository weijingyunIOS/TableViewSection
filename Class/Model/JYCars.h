

#import <Foundation/Foundation.h>

@interface JYCars : NSObject

@property ( nonatomic , copy ) NSString *icon ;
@property ( nonatomic , copy ) NSString *name ;

- (instancetype)initWithCarsDic : (NSDictionary*) carsdic ;
+ (instancetype)CarsWithDic:(NSDictionary *)carsdic;

@end
