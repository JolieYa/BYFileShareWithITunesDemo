//
//  ViewController.m
//  BYFileShareWithITunesDemo
//
//  Created by gongairong on 2017/12/12.
//  Copyright © 2017年 xinghaiwulian. All rights reserved.
//

#import "ViewController.h"

@implementation FileModel
@end

@interface ViewController ()<UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, strong) NSMutableArray *dataSource;
@end

@implementation ViewController

- (NSMutableArray *)dataSource {
    if (!_dataSource) {
        _dataSource = [[NSMutableArray alloc] init];
    }
    return _dataSource;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    UITableView *tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
    tableView.delegate = self;
    tableView.dataSource = self;
    tableView.backgroundColor = [UIColor whiteColor];
    tableView.tableFooterView = [UIView new];
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    tableView.showsVerticalScrollIndicator = false;
    [self.view addSubview:tableView];
    
    [self logFilePathInDocumentsDir];
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"电脑分享到手机" style:UIBarButtonItemStylePlain target:self action:@selector(logFilePathInDocumentsDir)];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"手机分享到电脑" style:UIBarButtonItemStylePlain target:self action:@selector(createImageFieldToDocuments)];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *ID = @"onLineCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:ID];
    }
    FileModel *model = self.dataSource[indexPath.row];
    cell.textLabel.text = model.fileName;
    cell.detailTextLabel.text = model.filePath;
    
    return cell;
}


// 对应第一个按钮 , 输出Documents路径下的所有文件名到控制台
- (void)logFilePathInDocumentsDir {
    
    NSString *docsDir = [NSHomeDirectory() stringByAppendingPathComponent:  @"Documents"];
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSDirectoryEnumerator *dirEnum = [fileManager enumeratorAtPath:docsDir];
    NSString *fileName;
    
    while (fileName = [dirEnum nextObject]) {
        NSLog(@"FielName : %@" , fileName);
        NSLog(@"FileFullPath : %@" , [docsDir stringByAppendingPathComponent:fileName]) ;
        
        FileModel *model = [[FileModel alloc] init];
        model.fileName = fileName;
        model.filePath = [docsDir stringByAppendingPathComponent:fileName];
        [self.dataSource addObject:model];
    }
}

// 对应第二个按钮 向Documents目录保存文件的功能（即共享文件到iTunes）
- (void)createImageFieldToDocuments {
    NSFileManager *fileManager=[[NSFileManager alloc] init];
    NSString *docsDir = [NSHomeDirectory() stringByAppendingPathComponent: @"Documents"];
    NSString *imageFileName = [docsDir stringByAppendingPathComponent:@"myImage.png"] ;
    
    UIImage *image = [UIImage imageNamed:@"default"]; // [self generateImage];
    
    [fileManager createFileAtPath:imageFileName contents:UIImagePNGRepresentation(image) attributes:nil] ;
}

// 创建一个简单的UIImage对象并作为图片文件内容
- (UIImage*)generateImage {
    UIGraphicsBeginImageContextWithOptions(CGSizeMake(320, 200), NO, 0.0) ;
    CGContextRef ctx = UIGraphicsGetCurrentContext() ;
    CGRect imageRect = CGRectMake(0.0, 0.0, 320, 200) ;
    [[UIColor redColor] setFill] ;
    CGContextFillRect(ctx, imageRect) ;
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext() ;
    UIGraphicsEndImageContext() ;
    return image ;
}

@end
