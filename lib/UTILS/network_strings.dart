class NetworkStrings {



  /// Frontend Route /////////////////////////////////////////
  static const String SHARE_BASE_URL = "https://beta.syllo.co/";
  static const String frontendFeedView=SHARE_BASE_URL+"feed-view/";
//  static const String frontendFeedView="feed-view";
//  static const String frontendFeedView="feed-view";
  static const String frontendProfile=SHARE_BASE_URL+"profile";

  static const String SOCKET_CONNECTION = "wss://beta-api.syllo.co:8001/wss/";
  static const String API_BASE_URL = "https://beta-api.syllo.co/api/";
  static const String NOTIFICATION_BASE_URL = "https://notify-api.syllo.co/api/";
  static const String ACCEPT = 'application/json';
  static const String IsLogin = 'IsLogin';
  static const String onBoard = 'onboard';
  static const String role = 'role';
  static const String email = 'email';
  static const String profilePic = 'picture';
  static const String name = 'name';
  static const String token = 'token';
  static const String authKey = 'auth_key';
  static const String hashKey = 'iuavob2c78742n3o8423nxo876bn&^Bn2378c23b8746n239m23#\$%3^s&sfs*s662';

  static const int SUCCESS_CODE = 200;
  static const int BAD_REQUEST_CODE = 400;
  static const int UNAUTHORIZED_CODE = 401;
  static const int FORBIDDEN_CODE = 403;

  /// API MESSAGES /////////////////////////////////////////////////////////
  static const int API_SUCCESS_STATUS = 1;
  static const int EMAIL_UNVERIFIED = 0;
  static const int EMAIL_VERIFIED = 1;
  static const int PROFILE_INCOMPLETED = 0;
  static const int PROFILE_COMPLETED = 1;
  static const String NO_INTERNET_CONNECTION="No Internet Connection!";


  /// APIS END Points //////////////////////////////////////////////////////



  static const String userLogin = "account/auth";
  static const String userSignup = "account/auth/signup";
  static const String usernameVerify = "account/auth/username/verify?";
  static const String getMarketFeedsEntities = "market/feed/all?";
  static const String getReels = "market/feed/reels?";
  static const String getBookmarks = "collection/feed";
  static const String createPost="market/feed/post";
  static const String createPoll="market/feed/poll";
  static const String uploadFile="account/file/upload";
  static const String createNewsletter="market/feed/newsletter";
  static const String createReel='market/feed/reel';
  static const String channelList="channel/list";
  static const String generateTags="market/generate_tags";
  static const String getProfile="account/user/profile?user_code=";
  static const String bookmark="collection/feed";
  static const String likeEntity="market/feed/like";
  static const String entityDetail="market/feed/detail";
  static const String getNotifications="notification/get?offset=0&count=5&read=true";
  static const String newsPreference="account/user/preferences?";
  static const String getRole="account/master/roles";
  static const String getComments="market/feed/comment?";
  static const String getTags="account/master/tags?tag=";
  static const String savePreferences="account/user/preferences";
  static const String getUserTimeline="market/feed/all/personal?";
  static const String getTrendingTag="news/tags/trending";
  static const String getProfileChannel="channel/list/public?";
  static const String voteAPoll="market/feed/poll/vote";
  static const String getPersonalFeed="market/feed/all/personal?";
  static const String getMentorship="v1.0/mentorship?";
  static const String getMyHub="market/feed/myhub";
  static const String feedDelete="market/feed/delete?";
  static const String updateProfile="account/user/profile";



}
