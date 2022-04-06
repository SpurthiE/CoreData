//
//  AppDelegate.h
//  CoreData
//
//  Created by spurthi.eshwarappa on 01/04/22.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (readonly, strong) NSPersistentContainer *persistentContainer;
@property (readonly, strong, nonatomic) NSManagedObjectContext *managedObjContext;
@property (readonly, strong, nonatomic) NSManagedObjectModel *mangedObjModel;
@property (readonly, strong, nonatomic) NSPersistentStoreCoordinator *persistentStoreContainer;

- (void)saveContext;
-(NSURL *)applicationDocumentDirectory;

@end

