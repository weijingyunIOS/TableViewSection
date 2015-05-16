

#import "JYCarsGroup.h"
#import "JYCars.h"

@implementation JYCarsGroup

- (instancetype)initWithCarsPlistDic:(NSDictionary *)dic
{
    if ( self = [ super init ] ) {
        // 需要将字典内的数组转换为数据模型存储 故而不能使用KVC
        self.title = dic[@"title"] ;
        
        // 将字典内数组转换为数据模型再存入数组
        NSMutableArray *tempArray = [ NSMutableArray array ] ;
        for ( NSDictionary *obj in dic[@"cars"]) {
            JYCars *car = [ JYCars CarsWithDic: obj ] ;
            [ tempArray addObject: car ] ;
        }
        self.cars = tempArray ;
    }
    return self ;
}

+ (instancetype) CarsWithPlistDic:(NSDictionary *)dic
{
    return [ [ JYCarsGroup alloc ] initWithCarsPlistDic: dic ] ;
}

@end
