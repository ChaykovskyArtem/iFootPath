//
//  ACDataManager.m
//  IFootPathApp
//
//  Created by Artem Chaykovsky on 10.08.15.
//
//

#import "ACDataManager.h"

@implementation ACDataManager



+ (ACDataManager*) sharedManager {
    
    static ACDataManager* manager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[ACDataManager alloc] init];
    });
    return manager;
}


-(instancetype)init{
    
    self = [super init];
    if (self)
    {
        
        self.walksArray = [NSMutableArray array];
        NSError *error;
        NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
        NSString *documentsDirectory = [paths objectAtIndex:0];
        NSString *path = [documentsDirectory stringByAppendingPathComponent:@"walks.plist"];
        self.plistPath = path;
        
        NSFileManager *fileManager = [NSFileManager defaultManager];
        
        if (![fileManager fileExistsAtPath: path])
        {
            NSString *bundle = [[NSBundle mainBundle] pathForResource:@"walks" ofType:@"plist"];
            
            [fileManager copyItemAtPath:bundle toPath: path error:&error];
        }
    }
    
return self;
    
}


-(void) deleteAllWalksFromPlist {
    
    NSMutableArray* plist = [[NSMutableArray alloc] initWithContentsOfFile:self.plistPath];
    [plist removeAllObjects];
    [plist writeToFile:self.plistPath atomically:YES];
}


-(NSArray*) loadFromPlist {
    
    NSMutableArray* array = [[NSMutableArray alloc] initWithContentsOfFile:self.plistPath];
    
    [self.walksArray removeAllObjects];
    
    for (id obj in array) {
        ACWalk* walk = [NSKeyedUnarchiver unarchiveObjectWithData:obj];
        
        [self.walksArray addObject:walk];
    }
    NSArray* plistArray = self.walksArray;
    
    [[NSNotificationCenter defaultCenter] postNotificationName: @"loadFromPlistArray" object:plistArray];
    
    return self.walksArray;
}


-(void)saveToPlist:(ACWalk *)walk {
  
    NSMutableArray* walksDictionary = [[NSMutableArray alloc] initWithContentsOfFile:self.plistPath];
    
    NSData* data = [NSKeyedArchiver archivedDataWithRootObject:walk];
    
    [walksDictionary addObject:data];
    
    [walksDictionary writeToFile:self.plistPath atomically:YES];
    
}
    

-(void)deleteWalkFromPlist:(ACWalk *)walk {

    [self.walksArray removeObject:walk];
    
    NSMutableArray* tempArray = [NSMutableArray array];
    
    for (id obj in self.walksArray) {
        NSData* data = [NSKeyedArchiver archivedDataWithRootObject:obj];
        
        [tempArray addObject:data];
    }

    [tempArray writeToFile:self.plistPath atomically:YES];
    
    [self loadFromPlist];
}


-(void) changeValueOfObject:(ACWalk*)walkObject withText:(NSString*)text forKey:(NSString*)key {
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0) , ^{
       
    [walkObject setValue:text forKey:key];
    
    NSMutableArray* tempArray = [NSMutableArray array];
    
    for (id obj in self.walksArray) {
         NSData* data = [NSKeyedArchiver archivedDataWithRootObject:obj];
        [tempArray addObject:data];
    }
    [tempArray writeToFile:self.plistPath atomically:YES];
    
    [[NSNotificationCenter defaultCenter] postNotificationName: @"loadFromPlistArray" object:self.walksArray];
        
    });
 
}


@end
