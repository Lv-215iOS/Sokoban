//
//  Level+CoreDataProperties.h
//  Sokoban
//
//  Created by pasik_01 on 20.01.17.
//
//

#import "Level+CoreDataClass.h"


NS_ASSUME_NONNULL_BEGIN

@interface Level (CoreDataProperties)

+ (NSFetchRequest<Level *> *)fetchRequest;

@property (nullable, nonatomic, copy) NSString *name;
@property (nullable, nonatomic, copy) NSNumber *order;
@property (nullable, nonatomic, retain) Scene *scene;

@end

NS_ASSUME_NONNULL_END
