class ServerAPIEndpoints {
  static const String baseURL = '';
  static const String patchPublisherDetails = 'api/v1/publisher/';
  static const String signUpUrl = 'api/v1/users/signup';
  static const String notificationBaseURL = '';
  static const String logInUrl = 'api/v1/login';
  static const String googleUrl = 'api/v1/users/google';
  static const String googleConnect = 'api/v1/users/me/connect-google';
  static const String googleConnectPublisher =
      'api/v1/publisher/me/connect-google';
  static const String metaUrl = 'api/v1/users/meta';
  static const String metaConnectPublisher = 'api/v1/publisher/me/connect-meta';
  static const String verifyEmailUrl = 'api/v1/users/email-verification';
  static const String simpleHashUrl = 'https://api.simplehash.com/';
  static const String forgotPassword = 'api/v1/users/forget-password';
  static const String changeForgotPassowrd = 'api/v1/reset-password';
  static const String userWallets = 'api/v1/users/me/wallets';
  static const String addWallet = 'api/v1/users/me/add-wallet';
  static const String getUserDetails = 'api/v1/users/';
  static const String getUserMyDetails = 'api/v1/users/me/profile';
  static const String patchUserDetails = 'api/v1/users/me/update-profile';
  static const String getPreSignedS3 = 'api/v1/users/upload/get-presigned-url';
  static const String getPublicPreSignedS3 = 'api/v1/get-public-presigned-url';
  static const String getPublisherPreSignedS3 =
      'api/v1/publisher/upload/presigned-url';
  static const String getLaunchpadPreSignedS3 = 'api/v1/s3/pre-signed-urls';
  static const String resendVerifyEmailUrl =
      'api/v1/users/resend-email-verification';
  static const String checkResetUrl = 'api/v1/users/check-reset-otp';
  static const String profileMe = 'api/v1/users/me/profile';
  static const String twoFA = 'api/v1/users/me/enable-2fa';
  static const String logInUsingOtpUrl = 'api/v1/users/login-using-otp';
  static const String getKbaUrl = 'api/v1/user/kba/question/all';
  static const String postKbaUrl = 'api/v1/user/kba/question/';
  static const String updatePasswordUrl = 'api/v1/users/me/update-password';
  static const String setPasswordUrl = 'api/v1/users/me/set-password';
  static const String updatePublisherPasswordUrl =
      'api/v1/publisher/update-password';
  static const String setPublisherPasswordUrl =
      'api/v1/publisher/me/set-password';
  static const String disable2FaRequestUrl =
      'api/v1/users/me/disable-2fa-request';
  static const String disable2FaUrl = 'api/v1/users/me/disable-2fa';
  static const String notificationUpdateUrl =
      'api/v1/users/me/update-notification-settings';
  static const String notificationUrl =
      'api/v1/users/me/get-notification-settings';
  static const String notificationPublisherUrl =
      'api/v1/publisher/me/get-notification-settings';
  static const String notificationUpdatePublisherUrl =
      'api/v1/publisher/me/update-notification-settings';
  static const String getInterestedUrl = 'api/v1/interested-game/';
  static const String getUserInterestUrl = 'api/v1/user/interested-game/';
  static const String postUserInterestUrl = 'api/v1/user/interested-game/';
  static const String checkPassword =
      'api/v1/users/me/generate-update-email-request';
  static const String checkPublisherPassword =
      'api/v1/publisher/update-email-request';
  static const String updateEmail = 'api/v1/users/me/update-email';
  static const String updatePublisherEmail = 'api/v1/publisher/update-email';
  static const String feedbackUrl = 'api/v1/feedback';
  static const String notifications = 'api/v1/me/get-all-notifications';
  static const String notificationsPublisher =
      'api/v1/users/me/publisher/get-all-notifications';
  static const String unReadNotifications =
      'api/v1/me/get-unread-notifications';
  static const String follow = 'api/v1/me/follow-user';
  static const String unFollow = 'api/v1/me/unfollow-user';
  static const String getFollowers = 'api/v1/me/get-followers';
  static const String getFollowing = 'api/v1/me/get-followings';
  static const String checkFollowingUrl = 'api/v1/me/check-follow';
  static const String searchUser = 'api/v1/search-user';
  static const String publisherSignUp = 'api/v1/publisher/auth/signup';
  static const String publisherLogIn = 'api/v1/publisher/auth/login';
  static const String publisherSendVerifyOtp =
      'api/v1/publisher/auth/send-verfication-otp';
  static const String publisherVerifyEmail =
      'api/v1/publisher/auth/confirm-verfication-otp';
  static const String publisherProfile = 'api/v1/publisher/';
  static const String publisherApiKeys = 'api/v1/publisher/api-key/keys';
  static const String createPublisherApiKeys = 'api/v1/publisher/api-key';
  static const String editPublisherApiKeys =
      'api/v1/publisher/edit-api-key-name';
  static const String getCategories = 'api/v1/categories';
  static const String getGameList = 'api/v1/games/category';
  static const String publisherAssetDetails = 'api/v1/publisher/asset';
  static const String getPublisherGames = 'api/v1/pub/game/me';
  static const String getPublisherGameDetails = 'api/v1/publisher/game';
  static const String getPublisherAssetsByGameSlug = 'api/v1/publisher/asset';
  static const String getAttributesByGameSlug = 'api/v1/assets/attrs';
  static const String getGameDetails = 'api/v1/games-detail';
  static const String getGameScreenshots = 'api/v1/games';
  static const String getAssetsByGameSlug = 'api/v1/game/assets';
  static const String getAssetsByGameSlugV2 = 'api/v1/game/assets-v2';
  static const String getMyAssets = 'api/v1/user/asset/me';
  static const String getAssetDetails = 'api/v1/assets';
  static const String getAssetSolanaAuctionDetails = 'api/v1/listing';
  static const String createEnglishAuction = 'api/v1/listing/english';
  static const String bidEnglishAuction = 'api/v1/bid/english';
  static const String getEthNonce = 'api/v1/user-nonce';
  static const String getEthAuctionListings = 'api/v1/listing';
  static const String getEthAuctionOffers = 'api/v1/offer';
  static const String applyForLaunchpad = 'api/v1/launchpad/apply';
  static const String verifyLaunchpadUrl = 'api/v1/launchpad/verify';
  static const String cancelEthAuction = 'api/v1/listing/cancel';
  static const String getAssetOwnerByUserId = 'api/v1/asset/owners-profile';
  static const String createEthFixedPriceSale = 'api/v1/listing/sale';
  static const String buyEthFixedPriceSale = 'api/v1/bid/sale';
  static const String hideUserAssets = 'api/v1/user/asset/hide';
  static const String getPublisherLaunchpads = 'api/v1/launchpad/by-filter';
  static const String getAssetDetailsByTokenAddress = 'api/v1/asset/get';
  static const String createOfferEth = 'api/v1/offer';
  static const String acceptOfferEth = 'api/v1/offer/accept';
  static const String getLaunchpads = 'api/v1/launchpad/by-filter';
  static const String cancelEthOffer = 'api/v1/offer/cancel';
  static const String getContactUs = 'api/v1/contact_us';
  static const String getFaq = 'api/v1/faqs';
  static const String getTAndC = 'api/v1/terms-and-conditions';
  static const String postLike = 'api/v1/user/asset/like';
  static const String removeLike = 'api/v1/user/asset/like';
  static const String createDutchAuctionETH = 'api/v1/listing/dutch';
  static const String bidDutchAuctionETH = 'api/v1/bid/dutch';
  static const String createBulkListSaleEth = 'api/v1/listing/bulk';
  static const String bulkBuyCartItemsEth = 'api/v1/bid/cart';
  static const String simpleHashNftTradeHistory = 'api/v0/nfts/transfers';
  static const String xstrelaNftTradeHistory = 'api/v1/assets/trade';
  static const String simpleHashAssetCreators = 'api/v0/nfts';
  static const String discordConnect = 'api/v1/users/me/connect-discord';
  static const String instagramConnect =
      'api/v1/publisher/me/connect-instagram';
  static const String discordPublisherConnect =
      'api/v1/publisher/me/connect-discord';
  static const String instagramPublisherConnect =
      'api/v1/publisher/me/connect-instagram';
  static const String twitterPublisherConnect =
      'api/v1/publisher/me/connect-twitter';
  static const String userFollowing = 'api/v1/users/get-followings';
  static const String userActivity = 'api/v1/user/activity';
  static const String getOtherAsset = 'api/v1/player/asset';
  static const String createBundleListingETH = 'api/v1/listing/bundle';
  static const String searchGames = 'api/v1/search-games';
  static const String gamePublisherLink = 'api/v1/publisher';
  static const String followPublisher = 'api/v1/me/follow-publisher';
  static const String unFollowPublisher = 'api/v1/me/unfollow-publisher';
  static const String checkFollowPublisher = 'api/v1/me/check-follow-publisher';
  static const String postFeedBackUrl = 'api/v1/feedback';
  static const String updateReferralCode = 'api/v1/users/me/update-referral';
  static const String getReferralCode = 'api/v1/users/me/referral-code';
  static const String analyticsTrackingEvent = 'api/v1/track/event';
  static const String postReport = 'api/v1/issue-report';
  static const String gameOverView = 'api/v1/game-overview';
  static const String getUserQuests = 'api/v1/user/quests/status/me';
  static const String getQuests = 'api/v1/users/quests';
  static const String getQuestDetails = 'api/v1/users/quests/details';
  static const String getQuestMissions = 'api/v1/users/quest/missions';
  static const String getFavoriteGames = 'api/v1/users/favorite-game';
  static const String getSavedGames = 'api/v1/users/saved-game';
  static const String getSavedContent = 'api/v1/users/saved-content';
  static const String getFavoriteContent = 'api/v1/users/favorite-content';
  static const String followGame = 'api/v1/users/game/follow';
  static const String checkLikeFollowGame = 'api/v1/users/game/status';
  static const String favoriteSavedGame = 'api/v1/users/favorite-saved-game';
  static const String getRecentHistory = 'api/v1/users/user-recently-played/';
  static const String getMyFriends = 'api/v1/me/friends';
  static const String getFriendRequestList =
      'api/v1/me/friends/requests/pending/received';
  static const String acceptFriendRequest =
      'api/v1/me/friends/requests/{request_id}/accept';
  static const String rejectFriendRequest =
      'api/v1/me/friends/requests/{request_id}/reject';
}
