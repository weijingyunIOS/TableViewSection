

#import "JYTableViewCell.h"
#import "JYdata.h"

@implementation JYTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

+ (instancetype) tableViewCellWithTableView : (UITableView *) tableView
{
    return [tableView dequeueReusableCellWithIdentifier:@"JYCELL"] ;
}

- (void)setData:(JYdata *)data
{
    _data = data ;
    self.textLabel.text = self.data.title ;
}


@end
