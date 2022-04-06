//
//  AppDelegate.m
//  CoreData
//
//  Created by spurthi.eshwarappa on 01/04/22.
//

#import "AppDelegate.h"

@interface AppDelegate ()

@end

@implementation AppDelegate
@synthesize managedObjContext = _managedObjContext;
@synthesize mangedObjModel = _mangedObjModel;
@synthesize persistentStoreContainer = _persistentStoreContainer;

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    NSLog(@"Document Path: %@",[[[NSFileManager defaultManager]URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask]lastObject]);
    return YES;
}


#pragma mark - UISceneSession lifecycle


- (UISceneConfiguration *)application:(UIApplication *)application configurationForConnectingSceneSession:(UISceneSession *)connectingSceneSession options:(UISceneConnectionOptions *)options {
    // Called when a new scene session is being created.
    // Use this method to select a configuration to create the new scene with.
    return [[UISceneConfiguration alloc] initWithName:@"Default Configuration" sessionRole:connectingSceneSession.role];
}


- (void)application:(UIApplication *)application didDiscardSceneSessions:(NSSet<UISceneSession *> *)sceneSessions {
    // Called when the user discards a scene session.
    // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
    // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
}


#pragma mark - Core Data stack

@synthesize persistentContainer = _persistentContainer;

- (NSPersistentContainer *)persistentContainer {
    // The persistent container for the application. This implementation creates and returns a container, having loaded the store for the application to it.
    @synchronized (self) {
        if (_persistentContainer == nil) {
            _persistentContainer = [[NSPersistentContainer alloc] initWithName:@"CoreData"];
            [_persistentContainer loadPersistentStoresWithCompletionHandler:^(NSPersistentStoreDescription *storeDescription, NSError *error) {
                if (error != nil) {
                    // Replace this implementation with code to handle the error appropriately.
                    // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                    
                    /*
                     Typical reasons for an error here include:
                     * The parent directory does not exist, cannot be created, or disallows writing.
                     * The persistent store is not accessible, due to permissions or data protection when the device is locked.
                     * The device is out of space.
                     * The store could not be migrated to the current model version.
                     Check the error message to determine what the actual problem was.
                    */
                    NSLog(@"Unresolved error %@, %@", error, error.userInfo);
                    abort();
                }
            }];
        }
    }
    
    return _persistentContainer;
}
-(NSManagedObjectContext *)managedObjContext {
    if (_managedObjContext != nil) {
        return  _managedObjContext;
    }
    NSPersistentStoreCoordinator *coordinator = [self persistentStoreContainer];
    if (coordinator != nil) {
        _managedObjContext = [[NSManagedObjectContext alloc]init];
        [_managedObjContext setPersistentStoreCoordinator:coordinator];
    }
    return _managedObjContext;
}

- (NSManagedObjectModel *)mangedObjModel {
    if (_mangedObjModel != nil)
    {
        return _mangedObjModel;
    }
    NSURL *modelUrl = [[NSBundle mainBundle]URLForResource:@"CoreData" withExtension:@"momd"];
    _mangedObjModel = [[NSManagedObjectModel alloc]initWithContentsOfURL:modelUrl];
    return  _mangedObjModel;
}
-(NSURL *)applicationDocumentDirectory {
    return  [[[NSFileManager defaultManager]URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask]lastObject];
}
#pragma mark - Core Data Saving support

- (void)saveContext {
    NSManagedObjectContext *context = self.persistentContainer.viewContext;
    NSError *error = nil;
    if ([context hasChanges] && ![context save:&error]) {
        // Replace this implementation with code to handle the error appropriately.
        // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
        NSLog(@"Unresolved error %@, %@", error, error.userInfo);
        abort();
    }
}

@end
