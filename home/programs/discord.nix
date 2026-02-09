{
  pkgs,
  ...
}:

{
  services.arrpc.enable = true;

  home.packages = with pkgs; [
    discord-ptb # Used for completing Discord quests
  ];

  programs.nixcord = {
    enable = true;
    # discord.enable = false;

    # discord.equicord.enable = true;
    equibop.enable = true;

    # vesktop.enable = true;
    # vesktop.useSystemVencord = false;

    config = {
      themeLinks = [
        #        "https://raw.githubusercontent.com/refact0r/system24/refs/heads/main/theme/system24.theme.css"
        "https://catppuccin.github.io/discord/dist/catppuccin-mocha.theme.css"
        #        "https://catppuccin.github.io/discord/dist/catppuccin-mocha-lavender.theme.css"
      ];
      frameless = true;
      disableMinSize = true;
      plugins = {
        accountPanelServerProfile.enable = true; # right click self in bottom left to show own server profile
        alwaysExpandRoles.enable = true; # shows all user roles instead of hiding behind "show more"
        alwaysTrust.enable = true; # removes "are you sure" style screens, e.g. opening external link
        anonymiseFileNames.enable = true; # makes uploading file names randomized
        betterGifAltText.enable = true; # shows gif tags / filename in alt text
        betterGifPicker.enable = true; # gif picker opens to favorites menu
        betterNotesBox.enable = true; # hide notes OR disable spellcheck in notes
        betterRoleContext.enable = true; # adds right click menu on roles on user's profile
        # betterRoleDot.enable = true; # allows usage of colored names and role dot next to name
        betterSessions.enable = true; # gives timestamps, notifications, and custom names about discord sessions
        betterSettings.enable = true; # enhances settings menu with categories and faster loading
        betterUploadButton.enable = true; # upload files with a single click, right click for menu
        biggerStreamPreview.enable = true; # allows enlarging stream previews
        BlurNSFW.enable = true; # blurs attachments in NSFW channels until hovered
        callTimer = {
          enable = true; # adds call timers for all users in voice channels
          format = "human"; # human = "30d 23h 00m 42s", stopwatch = "30:23:00:42"
        };
        ClearURLs.enable = true; # removes tracking elements from URLs sent
        colorSighted.enable = true; # removes colorblind-friendly icons from statuses
        consoleJanitor.enable = true; # disables annoying messages/errors in console
        consoleShortcuts.enable = true; # adds aliases for many console actions. Run `shortcutList` for a list
        # contentWarning = {
        #   enable = true;
        #   flagged = {  }; # attribute set of blurred words
        #   onClick = false; # reveals on click instead of hover
        # };
        copyEmojiMarkdown.enable = true; # copies unicode character instead of discord name for emojis
        copyFileContents.enable = true; # adds button to copy text file contents
        CopyUserURLs.enable = true; # adds context option to copy URL to user
        CustomRPC = {
          enable = false; # TODO
        };
        dearrow.enable = true; # makes youtube embed titles and images less clickbaity
        # decor.enable = true; # create and use your own avatar decorations with external site
        disableCallIdle.enable = true; # disables getting kicked from DM voice calls for inactivity
        dontRoundMyTimestamps.enable = true; # rounds timestamps down instead of up
        experiments = {
          enable = true; # allows enabling development experiements in settings
          toolbarDevMenu = true; # changes the help menu in top right corner to a dev menu
        };
        # f8Break.enable = true; # pause client when pressing F8 with devtools and breakpoints
        fakeProfileThemes.enable = true; # allows profile themeing by using invisible encoding in bio
        favoriteEmojiFirst.enable = true; # moves favorite emojis first in autocomplete
        favoriteGifSearch.enable = true; # adds search bar to favorite gifs
        fixCodeblockGap.enable = true; # removes gap between codeblocks and text below it
        fixImagesQuality.enable = true; # loads images at their original resolution
        fixSpotifyEmbeds.enable = true; # allows customizing volume of spotify embeds
        fixYoutubeEmbeds.enable = true; # bypasses youtube videos that are blocked from playing in discord
        forceOwnerCrown.enable = true; # places owner crown next to owner's username
        friendInvites.enable = true; # adds slash commands for friend invites
        friendsSince.enable = true; # shows date in popout that users became friends
        fullSearchContext.enable = true; # adds more options in message context menu searching
        gameActivityToggle.enable = true; # adds toggle in bottom left for game activity
        gifPaste.enable = true; # picking a gif inserts a link in messages instead of instantly sending
        greetStickerPicker.enable = true; # can right click "Wave to say hi" button to choose greet sticker
        iLoveSpam.enable = true; # do not hide messages from "likely spammers"
        imageLink.enable = true; # never hide image links in chat
        imageZoom = {
          enable = true; # allows zooming in/out on images and gifs
          nearestNeighbour = true;
        };
        # implicitRelationships.enable = true; # shows implicit relationships on friends tab
        keepCurrentChannel.enable = true; # try to re-open previous channel when loading discord
        memberCount.enable = true; # shows online / total members on servers
        mentionAvatars.enable = true; # shows avatars inside mentions
        messageClickActions.enable = true; # adds actions for single, double, triple clicks on messages with optional modifies
        messageLatency = {
          enable = true; # shows indicator when message took longer than x seconds to send
          latency = 4; # number of seconds
        };
        messageLinkEmbeds.enable = true; # adds preview to messages linking to another message
        messageLogger.enable = true; # temporarily logs deleted and edited messages
        messageTags.enable = true; # allows saving messages and using them with a command
        # MutualGroupDMs.enable = true; # shows mutual group DMs on profile
        newGuildSettings = {
          enable = true; # applies notification settings on new server joins
          # Values: 0 = All messages, 1 = Only @mentions, 2 = Nothing, 3 = Server default'';
          messages = 1;
          role = false; # supress role @mentions
        };
        noBlockedMessages.enable = true; # hide blocked / ignored messages from chat
        noDevtoolsWarning.enable = true; # disables "HOLD UP" message in console
        noF1.enable = true; # disables F1 help bind
        noMosaic.enable = true; # removes image mosaic
        noOnboardingDelay.enable = true; # skips the delay on omboarding page
        noPendingCount.enable = true; # removes ping count of friend requests and message requests
        noTypingAnimation.enable = true; # disables typing dots animations
        noUnblockToJump.enable = true; # allows jumping to blocked users' messages without unblocking
        normalizeMessageLinks.enable = true; # strip canary / ptb from message links
        openInApp.enable = true; # opens links in their apps instead of browser
        overrideForumDefaults.enable = true; # allows overriding forum layout / sorting
        permissionFreeWill.enable = true; # disables client-side restrictions for channel permission management
        permissionsViewer.enable = true; # view permissions a user or channel has
        petpet.enable = true; # adds command to create headpet gifs from images
        pictureInPicture.enable = true; # adds PIP to videos
        PinDMs.enable = true; # allows pinning private channels to top of DMs
        platformIndicators.enable = true; # adds indicators for user on mobile / desktop / web
        previewMessage.enable = true; # allows previewing messages
        quickMention.enable = true; # adds quick mention button on message hover
        quickReply.enable = true; # reply to / edit messages with keybionds
        reactErrorDecoder.enable = true; # shows actual react errors instead of abstraction
        readAllNotificationsButton.enable = true; # marks all server notifications as read with button
        relationshipNotifier.enable = true; # notifies when a friend, group chat, or server removes you
        # replaceGoogleSearch.enable = true; # replace google search with another engine
        replyTimestamp.enable = true; # shows timestamp on replied message previews
        revealAllSpoilers.enable = true; # reveals all spoilers by control clicking one, or control shift click for all
        reverseImageSearch.enable = true; # adds image searching to context menu of images
        roleColorEverywhere.enable = true; # adds top role color everywhere possible
        summaries.enable = true; # enables experimental AI chat summaries on servers
        sendTimestamps.enable = true; # adds button to send timestamps in chat
        serverInfo.enable = true; # displays extra info about servers
        shikiCodeblocks = {
          enable = true; # enables vscode-style codeblocks
          # Themes for code blocks
          theme = "https://raw.githubusercontent.com/shikijs/textmate-grammars-themes/2d87559c7601a928b9f7e0f0dda243d2fb6d4499/packages/tm-themes/themes/catppuccin-mocha.json";
          # theme = "https://raw.githubusercontent.com/shikijs/textmate-grammars-themes/2d87559c7601a928b9f7e0f0dda243d2fb6d4499/packages/tm-themes/themes/catppuccin-macchiato.json";
          # theme = "https://raw.githubusercontent.com/shikijs/textmate-grammars-themes/2d87559c7601a928b9f7e0f0dda243d2fb6d4499/packages/tm-themes/themes/catppuccin-frappe.json";
          # theme = "https://raw.githubusercontent.com/shikijs/textmate-grammars-themes/2d87559c7601a928b9f7e0f0dda243d2fb6d4499/packages/tm-themes/themes/catppuccin-latte.json";
          useDevIcon = "COLOR"; # sets language icon to be colored or not, options "DISABLED" "GREYSCALE" "COLOR"
        };
        showAllMessageButtons.enable = true; # show all message actions if holding shift or not
        showConnections.enable = true; # show user's connected accounts in popouts
        showHiddenChannels = {
          enable = true; # show channels that you are missing permission to view
          # Values: 0 = Lock Icon replacing channel icon, 2 = Eye icon on the right, 1 = Lock icon on the right
          showMode = 0;
        };
        showHiddenThings.enable = true; # show various hidden / moderator only things in servers
        showTimeoutDuration.enable = true; # shows length of a user's timeout remaining
        silentMessageToggle.enable = true; # adds button to send a silent message
        sortFriendRequests.enable = true; # sort friend requests by order received
        # spotifyControls.enable = true;
        spotifyCrack.enable = true; # free listen along
        # spotifyShareCommands.enable = true; # adds commands for sharing track, album, artist
        startupTimings.enable = true; # aadds startup timings to the settings menu
        streamerModeOnStream.enable = true; # automatically enables streamer mode on streaming in discord
        themeAttributes.enable = true; # adds attributes on elements for better theming
        translate.enable = true; # adds action to translate messages in chaat
        typingIndicator.enable = true; # adds indicator when someone is typing in a channel
        typingTweaks.enable = true; # shows avatars and role colors in the typing indicator
        unindent.enable = true; # trims leading indentation from codeblocks
        unlockedAvatarZoom.enable = true; # allows further zooming in the crop tool for changing avatars
        unsuppressEmbeds.enable = true; # allows unsupressing embeds in messages
        userMessagesPronouns.enable = true; # adds pronouns from bio to user chat messages
        userVoiceShow.enable = true; # shows indicator when user is in voice channel
        validReply.enable = true; # fixes "Message could not be loaded" upon hjovering over replies
        validUser.enable = true; # fixes mentions for unknown users showing up as "@unknown-user"
        voiceChatDoubleClick.enable = true; # joins voice chats with a double click instead of single click
        # vencordToolbox.enable = true;
        viewIcons.enable = true; # makes avatars and banners clickable
        viewRaw.enable = true; # copy and view the raw data of any message
        voiceDownload.enable = true; # adds download button for voice messages
        voiceMessages.enable = true; # allows sending voice messages like on mobile
        volumeBooster.enable = true; # allows setting the user and stream volumes above the default maximum
        webKeybinds.enable = true; # adds keybinds from web discord
        webRichPresence.enable = true; # arRPC client plugin for rich presencce
        webScreenShareFixes.enable = true; # removes the bitrate cap on clients
        youtubeAdblock.enable = true; # blocks ads in youtube embeds and watch together
      };
    };

    equibopConfig = {
      plugins = {
        anammox.enable = true; # hides various nitro / store features
        equicordToolbox.enable = true; # adds button at top right that houses equicord quick actions
        # invisibleChat.enable = true; # encrypt messages in non-suspicious way
        questify.enable = true; # hide quests, complete in background, etc.
        moreCommands.enable = true; # adds many fun commands
        # moreKaomoji.enable = true; # adds more Kaomojis (table flip style, etc.)
        moreUserTags.enable = true; # adds tags labeling apps, webhooks, mods, admins, etc.
        youtubeDescription.enable = true; # adds description to embedded youtube videos
      };
    };

  };
}
