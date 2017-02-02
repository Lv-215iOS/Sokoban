//
//  Scene+CoreDataProperties.h
//  Sokoban
//
//  Created by pasik_01 on 20.01.17.
//
//

#import "Scene+CoreDataClass.h"


NS_ASSUME_NONNULL_BEGIN

@interface Scene (CoreDataProperties)

+ (NSFetchRequest<Scene *> *)fetchRequest;

@property (nullable, nonatomic, copy) NSNumber *height;
@property (nullable, nonatomic, copy) NSString *matrix;
@property (nullable, nonatomic, copy) NSNumber *width;
@property (nullable, nonatomic, retain) Level *level;

@end

/*
 
 matrix field example
 
 ##########
 #--#--#--#
 #---&-#--#
 #-*------##
 ######-x--#
      ######
 
 */

NS_ASSUME_NONNULL_END
