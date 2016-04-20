//
//  YYMusicViewController.m
//  yunya
//
//  Created by WongSuechang on 16/3/30.
//  Copyright © 2016年 emi365. All rights reserved.
//

#import "YYMusicViewController.h"
#import "MusicFile.h"
#import "YYMusicViewModel.h"
#import "SCAudioTool.h"
#import "SCMusicData.h"
#import "SCCommon.h"

@interface YYMusicViewController ()<UITableViewDelegate,UITableViewDataSource>{
    
    MusicFile *currentMusic;//当前播放音乐
}
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UILabel *currentMusicNameLabel;
@property (weak, nonatomic) IBOutlet UISlider *progressSlider;
- (IBAction)preMusic:(UIButton *)sender;
- (IBAction)playOrPauseMusic:(UIButton *)sender;
- (IBAction)nextMusic:(UIButton *)sender;


@property (nonatomic, strong) NSArray *array;

@property (nonatomic, strong) YYMusicViewModel *viewModel;


@property (nonatomic, strong) SCMusicData *data;
@property (nonatomic,strong) NSTimer *timer;
@end

@implementation YYMusicViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"胎教音乐";
    self.data = [[SCMusicData alloc] init];
    self.viewModel = [[YYMusicViewModel alloc] initWithViewController:self];
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.tableFooterView = [[UIView alloc] init];
    UIImage *img = [UIImage imageNamed:@"slider"];
//    img.
    [self.progressSlider setThumbImage:img forState:UIControlStateNormal];
    [self getMusicList];
    
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithImageName:@"back" highImageName:@"back" target:self action:@selector(back:)];
}

- (void)back:(id)sender{
    //销毁计时器
    [self setTimerValid];
    
    //获取播放数据
    MusicFile *model = [self.data playingMusic];
    
    //停止播放的歌曲
    [SCAudioTool stopMusic:model];
    
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)getMusicList {
    
    __unsafe_unretained typeof(self) weakSelf = self;
    [self.viewModel setBlockWithReturnBlock:^(id returnValue) {
        if(returnValue){
            weakSelf.array = [NSArray arrayWithArray:returnValue];
            [weakSelf.tableView reloadData];
            
            if(weakSelf.array.count>0){
                
                [weakSelf showCurrentMusic];
            }
        }
    } WithErrorBlock:^(id errorCode) {
        
    } WithFailureBlock:^{
        
    }];
    
    [self.viewModel fetchMusic];
}

- (void)showCurrentMusic {
    
        //开始播放
    self.data.musics = [NSArray arrayWithArray:self.array];
    MusicFile *file = [self.data playingMusic];
    self.currentMusicNameLabel.text = file.name;
    [SCAudioTool playMusic:file];
    //开始计时器
    [self start];
}

/**
 *  开始计时器
 */
- (void)start {
    if (!_timer) {
        _timer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(updateProgress:) userInfo:nil repeats:YES];
    }
}
/**
 *  结束计时器
 */
- (void)setTimerValid {
    if ([_timer isValid]) {
        [_timer invalidate];
        _timer = nil;
    }
}
- (void)updateProgress:(NSTimer *)updatedTimer {
    
    //获取播放数据
    MusicFile *model = [self.data playingMusic];
    
    //获取播放器
    id player = [SCAudioTool getAudioPlayer:model];
    double progress;
    double duration;
    
    if ([player isKindOfClass:[AudioStreamer class]]) {
        //网络歌曲
        AudioStreamer *audioStreamer = (AudioStreamer *)player;
        progress = audioStreamer.progress;
        duration = audioStreamer.duration;
    } else if ([player isKindOfClass:[AVAudioPlayer class]]) {
        //本地歌曲
        AVAudioPlayer *audioPlayer = (AVAudioPlayer *)player;
        progress = audioPlayer.currentTime;
        duration = audioPlayer.duration;
    }
    
    self.currentMusicNameLabel.text = model.name;
    _progressSlider.value = progress/duration;
    
    if ((int)progress >= (int)duration - 1) {
        
        [self nextMusic:nil];
    }
}
#pragma mark - TableView
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.array.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 60;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
//    YYMusicTableViewCell *cell = [YYMusicTableViewCell cellWithTableView:tableView];
//    [cell setValue:self.array[indexPath.row]];
//    return cell;
    
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"YYMusicTableViewCell"];
    cell.textLabel.text = ((MusicFile *)(self.array[indexPath.row])).name;
    cell.imageView.image = [UIImage imageNamed:@"kit_music"];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    //TODO 单击播放音乐
    
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)preMusic:(UIButton *)sender {
    //获取当前播放数据
    MusicFile *model = [self.data playingMusic];
    
    //停止之前的播放器
    [SCAudioTool stopMusic:model];
    
    //设置数据为播放数据
    [self.data setPlayingMusic:[self.data previousMusic]];
    [self showCurrentMusic];
}

- (IBAction)playOrPauseMusic:(UIButton *)sender {
    //获取播放数据
    MusicFile *model = [self.data playingMusic];
    
    //获取播放器
    id player = [SCAudioTool getAudioPlayer:model];
    
    BOOL playing;
    if ([player isKindOfClass:[AudioStreamer class]]) {
        //网络歌曲
        AudioStreamer *audioStreamer = (AudioStreamer *)player;
        playing = audioStreamer.isPlaying;
    } else if ([player isKindOfClass:[AVAudioPlayer class]]) {
        //本地歌曲
        AVAudioPlayer *audioPlayer = (AVAudioPlayer *)player;
        playing = audioPlayer.isPlaying;
    }
    
    if (playing) {
        [sender setBackgroundImage:[UIImage imageNamed:@"player_btn_play_normal"] forState:UIControlStateNormal];
        [sender setBackgroundImage:[UIImage imageNamed:@"player_btn_play_highlight"] forState:UIControlStateHighlighted];
        
        //播放
        [SCAudioTool pauseMusic:model];
    } else {
        [sender setBackgroundImage:[UIImage imageNamed:@"player_btn_pause_normal"] forState:UIControlStateNormal];
        [sender setBackgroundImage:[UIImage imageNamed:@"player_btn_pause_highlight"] forState:UIControlStateHighlighted];
        
        //如果暂停,则播放
        [SCAudioTool playMusic:model];
    }
}

- (IBAction)nextMusic:(UIButton *)sender {
    //获取当前播放数据
    MusicFile *model = [self.data playingMusic];
    
    //停止之前的播放器
    [SCAudioTool stopMusic:model];
    
    //设置数据为播放数据
    [self.data setPlayingMusic:[self.data nextMusic]];
    
    //刷新界面显示
    [self showCurrentMusic];
}
@end
