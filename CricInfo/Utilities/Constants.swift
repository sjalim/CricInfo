//
//  Constants.swift
//  CricInfo
//
//  Created by bjit on 8/2/23.
//

import Foundation


class Constants{
    
    static let shared = Constants()
    
    private init(){}
    
    let universalNullInt = -1
    let universalNullDouble = 0.0
    let universalNullStr = ""
    let universalNA = "N/A"
    
    let leagueIdT20I = 3
    let leagueIdBBL = 5
    let leagueIdT20C = 10
    
    let termsCondition = """
    
1 Use of the App
1.1 The App is intended to provide users with access to cricket-related content, news, and updates.
1.2 You must be at least 18 years old to download or use the App.
1.3 You are responsible for ensuring that your device meets the minimum system requirements necessary to use the App.
1.4 You are responsible for all activities that occur under your account.
1.5 You must not use the App in any way that may damage, disable, overburden, or impair our servers or networks, or interfere with any other user's use of the App.
1.6 We reserve the right to modify, suspend, or discontinue the App at any time, with or without notice.

2. User Content
2.1 The App may allow users to post or upload content, including text, images, videos, and other materials ("User Content").
2.2 You retain all rights to your User Content, but by posting or uploading User Content to the App, you grant us a non-exclusive, transferable, sub-licensable, royalty-free, worldwide license to use, modify, reproduce, distribute, and display your User Content in connection with the App and our business.
2.3 You represent and warrant that you own or have the necessary licenses, rights, consents, and permissions to use and authorize us to use your User Content as described in these Terms.

3. Intellectual Property
3.1 The App and its entire contents, features, and functionality (including but not limited to all information, software, text, displays, images, video, and audio) are owned by us or our licensors and are protected by copyright, trademark, and other intellectual property laws.
3.2 You may not copy, modify, distribute, sell, or lease any part of the App or its contents without our prior written consent.

4. Disclaimer of Warranties
4.1 The App is provided on an "as is" and "as available" basis, without any warranties of any kind, either express or implied, including but not limited to warranties of merchantability, fitness for a particular purpose, or non-infringement.
4.2 We do not warrant that the App will be uninterrupted, error-free, or free from viruses or other harmful components.
4.3 We are not responsible for any content, services, or products provided by third parties through the App.

5. Limitation of Liability
5.1 To the maximum extent permitted by law, we shall not be liable for any indirect, incidental, special, consequential, or punitive damages, or any loss of profits or revenue, arising out of or in connection with your use of the App.
5.2 Our total liability for any and all claims arising out of or in connection with these Terms shall not exceed the amount paid by you (if any) to us for your use of the App.

Indemnification
You agree to indemnify, defend, and hold us and our affiliates, officers, directors, agents, and employees harmless from any and all claims, damages, losses, liabilities, costs, and expenses (including reasonable attorneys' fees) arising out of or in connection with your use of the App or your User Content.

Termination
We may terminate your access to the App at any time, with or without cause or notice, without liability to you.

Governing Law and Jurisdiction
These Terms
"""
    
    let FAQ = """

1. What is the Cricket mobile application?
The Cricket mobile application is a mobile app that provides users with access to cricket-related content, news, and updates.

2. Is the Cricket mobile application free?
Yes, the Cricket mobile application is free to download and use.

3. What devices is the Cricket mobile application compatible with?
The Cricket mobile application is compatible with iOS and Android devices.

4. How do I download the Cricket mobile application?
You can download the Cricket mobile application from the App Store (for iOS devices) or Google Play Store (for Android devices).

5. Do I need to create an account to use the Cricket mobile application?
No, you do not need to create an account to use the Cricket mobile application, but creating an account will allow you to personalize your experience and access additional features.

6. What kind of content can I find on the Cricket mobile application?
You can find cricket-related news, updates, scores, highlights, and other content on the Cricket mobile application.

5. Can I customize my news feed on the Cricket mobile application?
Yes, you can customize your news feed on the Cricket mobile application by selecting your favorite teams, players, and leagues.

6. Can I watch live cricket matches on the Cricket mobile application?
No, you cannot watch live cricket matches on the Cricket mobile application, but you can get updates and scores in real-time.

7. Can I share content from the Cricket mobile application on social media?
Yes, you can share content from the Cricket mobile application on social media platforms such as Facebook and Twitter.

8. How do I contact customer support for the Cricket mobile application?
You can contact customer support for the Cricket mobile application by sending an email to support@cricketapp.com.
"""
    
    let rootAPI = "https://cricket.sportmonks.com/api/v2.0/fixtures"
    
    let apiToken = "qgcaTr1JcWOsR9trRy8ScGLyoGLnnVZDMo31Ax2EB52W74FYxCQ3EPjBGsr0"
//    let apiToken3 = "xF2O1HrMDwHSzbF49uNV3mN77M6vKeiZmxOnxCNHmk2ntm3ToZXOoqBlLc00"
//    let apiToken1 = "RH6ltRSihWDXEAyFhBIs4Rctw8caQbx6vWtGTRcYpquYTzIbQpJg0hoiNTWm"
    
//        let apiToken2 = "tdtaZVTbIvHe9oPdcAVQrAlT1RS50mmDElBoKxewdBWM3EvGnpqJbYalIY6Y"
    
//    let apiTokenp2 = "aGypft0iQPFUBpefG6U1QInmd9OvUDsadwYyMFJZQSGud9rb80dmNlruCfuL"
    
    
    
    let fieldsForMatches = "league_id,season_id,round,localteam_id,visitorteam_id,starting_at,type,status,note,venue_id,toss_won_team_id,winner_team_id,first_umpire_id,second_umpire_id,tv_umpire_id,referee_id,man_of_match_id,man_of_series_id,total_overs_played,elected"
    
    let includeForMatches = "runs,lineup,bowling,batting,league,visitorteam,localteam,venue"
    
    let ScoreCollectionViewCell = "ScoreCollectionViewCell"
    
    let MatchInfoUpcomingCollectionViewCell = "MatchInfoUpcomingCollectionViewCell"
    
    let ScoreCardTableViewCell = "ScoreCardTableViewCell"
    
    let BattingSummeryTableViewCell = "BattingSummeryTableViewCell"
    
    let BowlingSummeryTableViewCell = "BowlingSummeryTableViewCell"
    
    let BattingSummeryTableHeaderView = "BattingSummeryTableHeaderView"
    
    let ScoreCardTableHeaderView = "ScoreCardTableHeaderView"
    
    let BowlingSummeryTableHeaderView = "BowlingSummeryTableHeaderView"
    
    let SquadTableViewCell = "SquadTableViewCell"
    
    let SquadTableHeaderView = "SquadTableHeaderView"
    
    let MatchDetailViewController = "MatchDetailViewController"
    
    let PlayerDetailInfoTableViewCell = "PlayerDetailInfoTableViewCell"
    
    let CommonTableViewHeaderFooterView = "CommonTableViewHeaderFooterView"
    
    let PlayerDetailInfoViewController = "PlayerDetailInfoViewController"
    
    let PlayerDetailViewController = "PlayerDetailViewController"
    
    let PlayerDetailBattingTableViewCell = "PlayerDetailBattingTableViewCell"
    
    let PlayerDetailBowlingTableViewCell = "PlayerDetailBowlingTableViewCell"
    
    let WinPercentageTableViewCell = "WinPercentageTableViewCell"
    
    let LeagueCollectionViewCell = "LeagueCollectionViewCell"
    
    let FixtureTableViewCell = "FixtureTableViewCell"
    
    
    let PlayersTableViewCell = "PlayersTableViewCell"
    
    let RankTableViewCell = "RankTableViewCell"
    
    let RankTableViewHeaderFooterView = "RankTableViewHeaderFooterView"
    
    let CommonCollectionViewCell = "CommonCollectionViewCell"
    
    
    let PlayerDetailStatsTableViewCell = "PlayerDetailStatsTableViewCell"
    
    let CustomAlertViewController = "CustomAlertViewController"
    
    let SettingTableViewCell = "SettingTableViewCell"
    
    let DarkMode = "DarkMode"
    
    let SettingsDetailViewController = "SettingsDetailViewController"
}
