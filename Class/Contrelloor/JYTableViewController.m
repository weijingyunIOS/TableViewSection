

#import "JYTableViewController.h"
#import "JYTableViewCell.h"
#import "JYdata.h"

@interface JYTableViewController () <UITableViewDataSource>

@property(nonatomic, strong) NSArray *dataArray;

@end

@implementation JYTableViewController

- (void)viewDidLoad {
  [super viewDidLoad];
   
}

- (void)didReceiveMemoryWarning {
  [super didReceiveMemoryWarning];
  // Dispose of any resources that can be recreated.
}

- (NSArray *)dataArray {
  if (!_dataArray) {
    _dataArray = [JYdata datatitle];
  }
  return _dataArray;
}

- (NSInteger)tableView:(UITableView *)tableView
    numberOfRowsInSection:(NSInteger)section {
  // Return the number of rows in the section.
  return self.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath {
  JYTableViewCell *cell =
      [JYTableViewCell tableViewCellWithTableView:tableView];

  cell.data = self.dataArray[indexPath.row];

  return cell;
}






@end
