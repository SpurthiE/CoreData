//
//  ViewController.m
//  CoreData
//
//  Created by spurthi.eshwarappa on 01/04/22.
//

#import "ViewController.h"
#import "SecondViewController.h"
@interface ViewController ()

@end

@implementation ViewController

-(NSManagedObjectContext *)managedObjcontext {
    NSManagedObjectContext *context = nil;
    _delegate = (AppDelegate *)[[UIApplication sharedApplication]delegate];
    if ([_delegate respondsToSelector:@selector(persistentContainer)]) {
        context = _delegate.persistentContainer.viewContext;
    }
    return  context;
}
- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    //Fetch the data from persistent data store
    NSManagedObjectContext *managedObjContext = [self managedObjcontext];
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc]initWithEntityName:@"Contacts"];
    self.contactArray = [[managedObjContext executeFetchRequest:fetchRequest error:nil]mutableCopy];
    [self.tableView reloadData];
}
- (void)viewDidLoad {
    [super viewDidLoad];
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return  1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.contactArray.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    NSManagedObject *device = [self.contactArray objectAtIndex:indexPath.row];
    [cell.textLabel setText:[device valueForKey:@"fullname"]];
    [cell.detailTextLabel setText:[device valueForKey:@"phone"]];
    return  cell;
}
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    return  YES;
}
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    NSManagedObjectContext *context = [self managedObjcontext];
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        //delete obj from data base
        [context deleteObject:[self.contactArray objectAtIndex:indexPath.row]];
        NSError *error = nil;
        if (![context save:&error]) {
            NSLog(@"cant delete %@ %@",error, [error localizedDescription]);
            return;
        }
        //remove device from database
        [self.contactArray removeObjectAtIndex:indexPath.row];
        [self.tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
        
    }
}
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([[segue identifier]isEqualToString:@"updateContact"]) {
        NSManagedObject *selectedDevice = [self.contactArray objectAtIndex:[[self.tableView indexPathForSelectedRow]row]];
        SecondViewController *destination = segue.destinationViewController;
        destination.contactDb = selectedDevice;
    }
}
@end
