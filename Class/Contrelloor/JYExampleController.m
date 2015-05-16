
#import "JYExampleController.h"
#import "JYCars.h"
#import "JYCarsGroup.h"
#import "JYTableViewSection.h"

@interface JYExampleController ()<UITableViewDelegate , UITableViewDataSource>

@property(strong, nonatomic) NSArray *CarsGrop;

@property(weak , nonatomic) JYTableViewSection *section ;

@end

@implementation JYExampleController

- (void)viewDidLoad {
  [super viewDidLoad];
    
}

#pragma mark - 加载plist 数据并进行模型转换
- (NSArray *)CarsGrop {
  if (_CarsGrop == nil) {

    NSBundle *bundle = [NSBundle mainBundle];
    NSString *path = [bundle pathForResource:@"cars_total" ofType:@"plist"];
    NSArray *array1 = [NSArray arrayWithContentsOfFile:path];
    NSMutableArray *arraymodel = [NSMutableArray array];
    for (NSDictionary *obj in array1) {
      [arraymodel addObject:[JYCarsGroup CarsWithPlistDic:obj]];
    }
    _CarsGrop = arraymodel;
  }

  return _CarsGrop;
}



- (void)viewDidAppear:(BOOL)animated
{
  self.section = [JYTableViewSection sectionWithTableView:self.tableView AndSections:[self.CarsGrop valueForKey: @"title" ]] ;
}

- (void) viewWillDisappear:(BOOL)animated
{
    [self.section removeFromSuperview];
}


#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
  return self.CarsGrop.count;
}

- (NSInteger)tableView:(UITableView *)tableView
    numberOfRowsInSection:(NSInteger)section {
  return [[self.CarsGrop[section] cars] count ];
}

- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath {
 static NSString *idCar = @"car";

  UITableViewCell *cell =
      [tableView dequeueReusableHeaderFooterViewWithIdentifier:idCar];

  if (cell == nil) {
      
    cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault
                                    reuseIdentifier:idCar];
  }

  JYCarsGroup *carsGroup = self.CarsGrop[indexPath.section];

  // 根据组模型找到对应的行模型数据
  JYCars *car = carsGroup.cars[indexPath.row];

  // 设置对应组行的图片和文字
  cell.imageView.image = [UIImage imageNamed:car.icon];
  cell.textLabel.text = car.name;
  cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;

  return cell;
}

// 设置每组数据头的显示文字
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    // 获取每组数据组头显示文字
    return [ self.CarsGrop[section] title ] ;
}



- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    UIViewController *co = [[UIViewController alloc] init ];
    co.view.frame = [UIScreen mainScreen].bounds ;
    co.view.backgroundColor =[UIColor redColor] ;
    [self.navigationController pushViewController:co animated:YES];

}


@end
