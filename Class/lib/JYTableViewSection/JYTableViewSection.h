/* 自定义索引说明
 1. 在控制器添加 索引属性
 @property(weak , nonatomic) JYTableViewSection *section ;

 2.在 viewDidAppear 建立索引
    2.1 使用默认设置
 - (void)viewDidAppear:(BOOL)animated
 {
 self.section = [JYTableViewSection sectionWithTableView:self.tableView
 AndSections:array] ;
 }

    2.2 自定义设置

 - (void)viewDidAppear:(BOOL)animated {
 self.section = [JYTableViewSection sectionWithTableView:self.tableView];

 // 索引字体
 self.section.font = [UIFont systemFontOfSize:8];

 // 索引字体颜色
 self.section.sectionColor = [UIColor redColor];

 // 放大框字体
 self.section.bigViewfont = [UIFont systemFontOfSize:8];

 // 索引背景色 建议设置Uiwindow的背景色
 self.section.backgroundColor = [UIColor whiteColor];

 // 最后执行 索引数组
 self.section.Section = array;
 }


 3. viewWillDisappear 必须释放索引，因为它添加在Uiwindow上
 - (void) viewWillDisappear:(BOOL)animated
 {
 [self.section removeFromSuperview];
 }

 */
#import <UIKit/UIKit.h>

@interface JYTableViewSection : UIView

// 索引数组
@property(strong, nonatomic) NSArray *Section;

// 索引字体
@property(strong, nonatomic) UIFont *font;

// 索引字体颜色
@property(strong, nonatomic) UIColor *sectionColor;

// 放大框字体
@property(strong, nonatomic) UIFont *bigViewfont;

+ (instancetype)sectionWithTableView:(UITableView *)tableView;

+ (instancetype)sectionWithTableView:(UITableView *)tableView
                         AndSections:(NSArray *)sections;
@end
