
#import <UIKit/UIKit.h>

@class JYdata ;

@interface JYTableViewCell : UITableViewCell

@property (nonatomic , strong) JYdata * data ;

+ (instancetype) tableViewCellWithTableView : (UITableView *) tableView ;

@end
