//
//  SecondViewController.h
//  CoreData
//
//  Created by spurthi.eshwarappa on 04/04/22.
//

#import <UIKit/UIKit.h>
#import "CoreData/CoreData.h"
#import "AppDelegate.h"

@interface SecondViewController : UIViewController
@property (strong, nonatomic) IBOutlet UITextField *txtFullName;
@property (strong, nonatomic) IBOutlet UITextField *txtEmail;
@property (strong, nonatomic) IBOutlet UITextField *txtPhone;
@property (strong,nonatomic) AppDelegate *delegate;
- (IBAction)backButton:(UIButton *)sender;
- (IBAction)saveButtonAction:(UIButton *)sender;
@property (strong)NSManagedObject *contactDb;

@end

