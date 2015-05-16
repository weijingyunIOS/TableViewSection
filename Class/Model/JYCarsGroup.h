

#import <Foundation/Foundation.h>

@interface JYCarsGroup : NSObject

@property ( nonatomic , copy ) NSString *title ;
// 数组里面存储了多个字典，将字典转换为模型再传入
@property ( nonatomic , strong ) NSArray *cars ;

- (instancetype)initWithCarsPlistDic : (NSDictionary*) dic ;
+ (instancetype) CarsWithPlistDic:(NSDictionary *)dic;

@end
