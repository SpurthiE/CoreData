//
//  ViewController.h
//  CoreData
//
//  Created by spurthi.eshwarappa on 01/04/22.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"
@interface ViewController : UIViewController<UITableViewDelegate,UITableViewDataSource>
@property (strong, nonatomic) IBOutlet UITableView *tableView;
@property (strong) NSMutableArray *contactArray;
@property (strong,nonatomic)AppDelegate *delegate;

@end

