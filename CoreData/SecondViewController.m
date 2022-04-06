//
//  SecondViewController.m
//  CoreData
//
//  Created by spurthi.eshwarappa on 04/04/22.
//

#import "SecondViewController.h"

@interface SecondViewController ()

@end

@implementation SecondViewController
@synthesize contactDb;
- (void)viewDidLoad {
    [super viewDidLoad];
    if (self.contactDb) {
        [self.txtFullName setText:[self.contactDb valueForKey:@"fullname"]];//as per momdfile
        [self.txtEmail setText:[self.contactDb valueForKey:@"email"]];
        [self.txtPhone setText:[self.contactDb valueForKey:@"phone"]];
    }
    
    
}

-(NSManagedObjectContext *)managedObjcontext {
    NSManagedObjectContext *context = nil;
    _delegate = (AppDelegate *)[[UIApplication sharedApplication]delegate];
    if ([_delegate respondsToSelector:@selector(persistentContainer)]) {
        context = _delegate.persistentContainer.viewContext;
    }
    return  context;
}

- (IBAction)saveButtonAction:(UIButton *)sender {
    NSManagedObjectContext *context = [self managedObjcontext];
    if (self.contactDb) {
        //update existing Device
        [self.contactDb setValue:self.txtFullName.text forKey:@"fullname"];
        [self.contactDb setValue:self.txtEmail.text forKey:@"email"];
        [self.contactDb setValue:self.txtPhone.text forKey:@"phone"];
    } else {
        //create new device
        NSManagedObject *newDevice = [NSEntityDescription insertNewObjectForEntityForName:@"Contacts" inManagedObjectContext:context];
        [newDevice setValue:self.txtFullName.text forKey:@"fullname"];
        [newDevice setValue:self.txtEmail.text forKey:@"email"];
        [newDevice setValue:self.txtPhone.text forKey:@"phone"];
        
    }
    NSError *error = nil;
    if (![context save:&error]) {
        NSLog(@"can't Save %@ %@",error, [error localizedDescription]);
    }
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)backButton:(UIButton *)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}
@end
