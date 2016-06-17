Template.post_form.events

  'click .delete-post-btn': (e,t)->
    e.preventDefault()
    doc =
      $set: content: ''
    Meteor.call 'updatePost', doc, @_id
    currently_editing = SessionAmplify.get('currently_editing')
    currently_editing.splice currently_editing.indexOf(@_id), 1
    SessionAmplify.set 'currently_editing', currently_editing

  'click .cancel-post-btn': (e,t)->
    e.preventDefault()
    if not @content
      doc =
        $set: content: @content
      Meteor.call 'updatePost', doc, @_id
    currently_editing = SessionAmplify.get('currently_editing')
    currently_editing.splice currently_editing.indexOf(@_id), 1
    SessionAmplify.set 'currently_editing', currently_editing

Template.post_form.helpers

  rows: ->
    post = Posts.findOne(
      {_id: @_id}, {reactive: false}).content?.split('\n')?.length
    if post
      return post
    return 1

Template.post_form.rendered =->
  $('textarea').autogrow()

  emojiStrategy =
    'grinning':
      'unicode': '1f600'
      'shortname': ':grinning:'
      'aliases': ''
      'keywords': 'grinning face happy joy smile grin smiling smiley person'
    'grimacing':
      'unicode': '1f62c'
      'shortname': ':grimacing:'
      'aliases': ''
      'keywords': 'grimacing face teeth grimace disapprove pain person'
    'grin':
      'unicode': '1f601'
      'shortname': ':grin:'
      'aliases': ''
      'keywords': 'grinning face with smiling eyes happy joy smile grin smiley eye person'
    'joy':
      'unicode': '1f602'
      'shortname': ':joy:'
      'aliases': ''
      'keywords': 'face with tears of joy cry haha happy weep person tear'
    'smiley':
      'unicode': '1f603'
      'shortname': ':smiley:'
      'aliases': ''
      'keywords': 'smiling face with open mouth haha happy joy smile smiley person'
    'smile':
      'unicode': '1f604'
      'shortname': ':smile:'
      'aliases': ''
      'keywords': 'smiling face with open mouth and smiling eyes funny haha happy joy laugh smile smiley eye person'
    'sweat_smile':
      'unicode': '1f605'
      'shortname': ':sweat_smile:'
      'aliases': ''
      'keywords': 'smiling face with open mouth and cold sweat happy hot perspiration smile person'
    'laughing':
      'unicode': '1f606'
      'shortname': ':laughing:'
      'aliases': ':satisfied:'
      'keywords': 'smiling face with open mouth and tightly-closed eyes happy joy lol laughing laugh person satisfied smile'
    'innocent':
      'unicode': '1f607'
      'shortname': ':innocent:'
      'aliases': ''
      'keywords': 'smiling face with halo angel innocent ring circle heaven fairy tale fantasy person smile'
    'wink':
      'unicode': '1f609'
      'shortname': ':wink:'
      'aliases': ''
      'keywords': 'winking face happy mischievous secret wink friendly joke person'
    'blush':
      'unicode': '1f60a'
      'shortname': ':blush:'
      'aliases': ''
      'keywords': 'smiling face with smiling eyes crush embarrassed flushed happy shy smile smiley blush eye person'
    'slight_smile':
      'unicode': '1f642'
      'shortname': ':slight_smile:'
      'aliases': ':slightly_smiling_face:'
      'keywords': 'slightly smiling face slight smile happy person'
    'upside_down':
      'unicode': '1f643'
      'shortname': ':upside_down:'
      'aliases': ':upside_down_face:'
      'keywords': 'upside-down face'
    'relaxed':
      'unicode': '263a'
      'shortname': ':relaxed:'
      'aliases': ''
      'keywords': 'white smiling face blush happiness massage smile relaxed outlined person'
    'yum':
      'unicode': '1f60b'
      'shortname': ':yum:'
      'aliases': ''
      'keywords': 'face savouring delicious food happy joy smile tongue eat yummy yum tasty savory person um'
    'relieved':
      'unicode': '1f60c'
      'shortname': ':relieved:'
      'aliases': ''
      'keywords': 'relieved face happiness massage relaxed satisfied phew relief person'
    'heart_eyes':
      'unicode': '1f60d'
      'shortname': ':heart_eyes:'
      'aliases': ''
      'keywords': 'smiling face with heart-shaped eyes affection crush infatuation like valentines heart lovestruck love flirt smile eye person'
    'kissing_heart':
      'unicode': '1f618'
      'shortname': ':kissing_heart:'
      'aliases': ''
      'keywords': 'face throwing a kiss affection infatuation blowing kiss heart lips like love valentines person'
    'kissing':
      'unicode': '1f617'
      'shortname': ':kissing:'
      'aliases': ''
      'keywords': 'kissing face 3 infatuation like love valentines kiss pucker lips smooch person'
    'kissing_smiling_eyes':
      'unicode': '1f619'
      'shortname': ':kissing_smiling_eyes:'
      'aliases': ''
      'keywords': 'kissing face with smiling eyes affection infatuation valentines kiss smile pucker lips smooch eye person'
    'kissing_closed_eyes':
      'unicode': '1f61a'
      'shortname': ':kissing_closed_eyes:'
      'aliases': ''
      'keywords': 'kissing face with closed eyes affection infatuation like love valentines kiss passion puckered heart smooch eye person'
    'stuck_out_tongue_winking_eye':
      'unicode': '1f61c'
      'shortname': ':stuck_out_tongue_winking_eye:'
      'aliases': ''
      'keywords': 'face with stuck-out tongue and winking eye childish mischievous playful prank wink kidding silly playful crazy joke person'
    'stuck_out_tongue_closed_eyes':
      'unicode': '1f61d'
      'shortname': ':stuck_out_tongue_closed_eyes:'
      'aliases': ''
      'keywords': 'face with stuck-out tongue and tightly-closed eyes mischievous playful prank kidding silly playful ecstatic eye horrible person taste'
    'stuck_out_tongue':
      'unicode': '1f61b'
      'shortname': ':stuck_out_tongue:'
      'aliases': ''
      'keywords': 'face with stuck-out tongue childish mischievous playful prank silly playful cheeky person'
    'money_mouth':
      'unicode': '1f911'
      'shortname': ':money_mouth:'
      'aliases': ':money_mouth_face:'
      'keywords': 'money-mouth face'
    'nerd':
      'unicode': '1f913'
      'shortname': ':nerd:'
      'aliases': ':nerd_face:'
      'keywords': 'nerd face'
    'sunglasses':
      'unicode': '1f576'
      'shortname': ':sunglasses:'
      'aliases': ':dark_sunglasses:'
      'keywords': 'dark sunglasses shades eyes eye eyewear glasses object'
    'hugging':
      'unicode': '1f917'
      'shortname': ':hugging:'
      'aliases': ':hugging_face:'
      'keywords': 'hugging face'
    'smirk':
      'unicode': '1f60f'
      'shortname': ':smirk:'
      'aliases': ''
      'keywords': 'smirking face mean prank smile smug smirk half-smile conceited person'
    'no_mouth':
      'unicode': '1f636'
      'shortname': ':no_mouth:'
      'aliases': ''
      'keywords': 'face without mouth hellokitty silent vapid person quiet'
    'neutral_face':
      'unicode': '1f610'
      'shortname': ':neutral_face:'
      'aliases': ''
      'keywords': 'neutral face indifference objective impartial blank deadpan person'
    'expressionless':
      'unicode': '1f611'
      'shortname': ':expressionless:'
      'aliases': ''
      'keywords': 'expressionless face blank void vapid without expression indifferent inexpressive person unexpressive'
    'unamused':
      'unicode': '1f612'
      'shortname': ':unamused:'
      'aliases': ''
      'keywords': 'unamused face bored indifference serious straight face not amused depressed unhappy disapprove lame person'
    'rolling_eyes':
      'unicode': '1f644'
      'shortname': ':rolling_eyes:'
      'aliases': ':face_with_rolling_eyes:'
      'keywords': 'face with rolling eyes'
    'thinking':
      'unicode': '1f914'
      'shortname': ':thinking:'
      'aliases': ':thinking_face:'
      'keywords': 'thinking face'
    'flushed':
      'unicode': '1f633'
      'shortname': ':flushed:'
      'aliases': ''
      'keywords': 'flushed face blush flattered flush blush red pink cheeks shy dazed person'
    'disappointed':
      'unicode': '1f61e'
      'shortname': ':disappointed:'
      'aliases': ''
      'keywords': 'disappointed face disappoint frown depressed discouraged sad upset person'
    'worried':
      'unicode': '1f61f'
      'shortname': ':worried:'
      'aliases': ''
      'keywords': 'worried face concern anxious distressed nervous tense person'
    'angry':
      'unicode': '1f620'
      'shortname': ':angry:'
      'aliases': ''
      'keywords': 'angry face livid mad vexed irritated annoyed frustrated person'
    'rage':
      'unicode': '1f621'
      'shortname': ':rage:'
      'aliases': ''
      'keywords': 'pouting face angry despise hate mad pout anger rage irate person red'
    'pensive':
      'unicode': '1f614'
      'shortname': ':pensive:'
      'aliases': ''
      'keywords': 'pensive face okay sad thoughtful think reflective wistful meditate serious dejected person'
    'confused':
      'unicode': '1f615'
      'shortname': ':confused:'
      'aliases': ''
      'keywords': 'confused face daze perplex puzzle indifference skeptical undecided uneasy hesitant person'
    'slight_frown':
      'unicode': '1f641'
      'shortname': ':slight_frown:'
      'aliases': ':slightly_frowning_face:'
      'keywords': 'slightly frowning face slight frown unhappy disappointed person'
    'frowning2':
      'unicode': '2639'
      'shortname': ':frowning2:'
      'aliases': ':white_frowning_face:'
      'keywords': 'white frowning face frown person'
    'persevere':
      'unicode': '1f623'
      'shortname': ':persevere:'
      'aliases': ''
      'keywords': 'persevering face endure persevere no sick upset person'
    'confounded':
      'unicode': '1f616'
      'shortname': ':confounded:'
      'aliases': ''
      'keywords': 'confounded face confused sick unwell amaze perplex puzzle mystify person'
    'tired_face':
      'unicode': '1f62b'
      'shortname': ':tired_face:'
      'aliases': ''
      'keywords': 'tired face frustrated sick upset whine exhausted sleepy person'
    'weary':
      'unicode': '1f629'
      'shortname': ':weary:'
      'aliases': ''
      'keywords': 'weary face frustrated sad sleepy tired tiredness study finals school exhausted person'
    'triumph':
      'unicode': '1f624'
      'shortname': ':triumph:'
      'aliases': ''
      'keywords': 'face with look of triumph gas phew steam breath person won'
    'open_mouth':
      'unicode': '1f62e'
      'shortname': ':open_mouth:'
      'aliases': ''
      'keywords': 'face with open mouth impressed jaw gapping surprise wow person sympathy'
    'scream':
      'unicode': '1f631'
      'shortname': ':scream:'
      'aliases': ''
      'keywords': 'face screaming in fear munch scream painting artist alien fearful person scared'
    'fearful':
      'unicode': '1f628'
      'shortname': ':fearful:'
      'aliases': ''
      'keywords': 'fearful face nervous oops scared terrified fear frightened horrified person'
    'cold_sweat':
      'unicode': '1f630'
      'shortname': ':cold_sweat:'
      'aliases': ''
      'keywords': 'face with open mouth and cold sweat nervous exasperated frustrated blue person rushed'
    'hushed':
      'unicode': '1f62f'
      'shortname': ':hushed:'
      'aliases': ''
      'keywords': 'hushed face woo quiet hush whisper silent person stunned surprised'
    'frowning':
      'unicode': '1f626'
      'shortname': ':frowning:'
      'aliases': ''
      'keywords': 'frowning face with open mouth aw frown sad pout sulk glower person'
    'anguished':
      'unicode': '1f627'
      'shortname': ':anguished:'
      'aliases': ''
      'keywords': 'anguished face nervous stunned pain anguish ouch misery distress grief person'
    'cry':
      'unicode': '1f622'
      'shortname': ':cry:'
      'aliases': ''
      'keywords': 'crying face sad cry tear weep person'
    'disappointed_relieved':
      'unicode': '1f625'
      'shortname': ':disappointed_relieved:'
      'aliases': ''
      'keywords': 'disappointed but relieved face nervous phew sweat relief person whew'
    'sleepy':
      'unicode': '1f62a'
      'shortname': ':sleepy:'
      'aliases': ''
      'keywords': 'sleepy face rest tired exhausted person sleep'
    'sweat':
      'unicode': '1f613'
      'shortname': ':sweat:'
      'aliases': ''
      'keywords': 'face with cold sweat sick anxious worried clammy diaphoresis hot person'
    'sob':
      'unicode': '1f62d'
      'shortname': ':sob:'
      'aliases': ''
      'keywords': 'loudly crying face cry sad tears upset sob melancholy morn somber hurt person tear'
    'dizzy_face':
      'unicode': '1f635'
      'shortname': ':dizzy_face:'
      'aliases': ''
      'keywords': 'dizzy face drunk inebriated spent unconscious xox buzzed person'
    'astonished':
      'unicode': '1f632'
      'shortname': ':astonished:'
      'aliases': ''
      'keywords': 'astonished face xox shocked surprise person totally'
    'zipper_mouth':
      'unicode': '1f910'
      'shortname': ':zipper_mouth:'
      'aliases': ':zipper_mouth_face:'
      'keywords': 'zipper-mouth face'
    'mask':
      'unicode': '1f637'
      'shortname': ':mask:'
      'aliases': ''
      'keywords': 'face with medical mask ill sick virus flu cold doctor medicine person'
    'thermometer_face':
      'unicode': '1f912'
      'shortname': ':thermometer_face:'
      'aliases': ':face_with_thermometer:'
      'keywords': 'face with thermometer'
    'head_bandage':
      'unicode': '1f915'
      'shortname': ':head_bandage:'
      'aliases': ':face_with_head_bandage:'
      'keywords': 'face with head-bandage'
    'sleeping':
      'unicode': '1f634'
      'shortname': ':sleeping:'
      'aliases': ''
      'keywords': 'sleeping face sleepy tired sleep sleepy snore person zzz'
    'zzz':
      'unicode': '1f4a4'
      'shortname': ':zzz:'
      'aliases': ''
      'keywords': 'sleeping symbol sleepy tired snooze comic emotion person sleep word zzz'
    'poop':
      'unicode': '1f4a9'
      'shortname': ':poop:'
      'aliases': ':shit: :hankey: :poo:'
      'keywords': 'pile of poo poop shit shitface turd comic dung face monster nature object'
    'smiling_imp':
      'unicode': '1f608'
      'shortname': ':smiling_imp:'
      'aliases': ''
      'keywords': 'smiling face with horns devil impish trouble imp fairy tale fantasy person smile'
    'imp':
      'unicode': '1f47f'
      'shortname': ':imp:'
      'aliases': ''
      'keywords': 'imp angry devil evil horns cute face fairy tale fantasy person'
    'japanese_ogre':
      'unicode': '1f479'
      'shortname': ':japanese_ogre:'
      'aliases': ''
      'keywords': 'japanese ogre monster oni demon troll folklore monster devil mask theater horns teeth creature face fairy tale fantasy person'
    'japanese_goblin':
      'unicode': '1f47a'
      'shortname': ':japanese_goblin:'
      'aliases': ''
      'keywords': 'japanese goblin evil mask red tengu supernatural avian demon mask theater nose frown mustache anger frustration creature face fairy tale fantasy monster person'
    'skull':
      'unicode': '1f480'
      'shortname': ':skull:'
      'aliases': ':skeleton:'
      'keywords': 'skull dead skeleton dying death body face fairy tale monster person'
    'ghost':
      'unicode': '1f47b'
      'shortname': ':ghost:'
      'aliases': ''
      'keywords': 'ghost halloween creature face fairy tale fantasy monster person'
    'alien':
      'unicode': '1f47d'
      'shortname': ':alien:'
      'aliases': ''
      'keywords': 'extraterrestrial alien UFO paul ufo creature face fairy tale fantasy monster nature person space'
    'robot':
      'unicode': '1f916'
      'shortname': ':robot:'
      'aliases': ':robot_face:'
      'keywords': 'robot face'
    'smiley_cat':
      'unicode': '1f63a'
      'shortname': ':smiley_cat:'
      'aliases': ''
      'keywords': 'smiling cat face with open mouth animal cats happy smile smiley nature'
    'smile_cat':
      'unicode': '1f638'
      'shortname': ':smile_cat:'
      'aliases': ''
      'keywords': 'grinning cat face with smiling eyes animal cats smile grin eye nature'
    'joy_cat':
      'unicode': '1f639'
      'shortname': ':joy_cat:'
      'aliases': ''
      'keywords': 'cat face with tears of joy animal cats haha happy tears happy tears cry joy nature tear'
    'heart_eyes_cat':
      'unicode': '1f63b'
      'shortname': ':heart_eyes_cat:'
      'aliases': ''
      'keywords': 'smiling cat face with heart-shaped eyes affection animal cats like love valentines lovestruck love heart eye nature smile'
    'smirk_cat':
      'unicode': '1f63c'
      'shortname': ':smirk_cat:'
      'aliases': ''
      'keywords': 'cat face with wry smile animal cats smirk smirking confident confidence ironic nature'
    'kissing_cat':
      'unicode': '1f63d'
      'shortname': ':kissing_cat:'
      'aliases': ''
      'keywords': 'kissing cat face with closed eyes animal cats passion kiss puckered heart love eye nature'
    'scream_cat':
      'unicode': '1f640'
      'shortname': ':scream_cat:'
      'aliases': ''
      'keywords': 'weary cat face animal cats munch sleepy tired tiredness study finals school exhausted scream painting artist nature oh surprised'
    'crying_cat_face':
      'unicode': '1f63f'
      'shortname': ':crying_cat_face:'
      'aliases': ''
      'keywords': 'crying cat face animal cats sad tears weep cry sob tears sad melancholy morn somber hurt nature tear'
    'pouting_cat':
      'unicode': '1f63e'
      'shortname': ':pouting_cat:'
      'aliases': ''
      'keywords': 'pouting cat face animal cats pout annoyed miffed glower frown nature'
    'raised_hands':
      'unicode': '1f64c'
      'shortname': ':raised_hands:'
      'aliases': ''
      'keywords': 'person raising both hands in celebration gesture hooray winning woot yay banzai raised body hand'
    'clap':
      'unicode': '1f44f'
      'shortname': ':clap:'
      'aliases': ''
      'keywords': 'clapping hands sign applause congrats praise clap appreciation approval sound encouragement enthusiasm body hand person'
    'wave':
      'unicode': '1f44b'
      'shortname': ':wave:'
      'aliases': ''
      'keywords': 'waving hand sign farewell gesture goodbye solong hi wave body person'
    'thumbsup':
      'unicode': '1f44d'
      'shortname': ':thumbsup:'
      'aliases': ':+1:'
      'keywords': 'thumbs up sign cool hand like yes +1 body person thumb thumbs up'
    'thumbsdown':
      'unicode': '1f44e'
      'shortname': ':thumbsdown:'
      'aliases': ':-1:'
      'keywords': 'thumbs down sign hand no -1 body person thumb thumbs down'
    'punch':
      'unicode': '1f44a'
      'shortname': ':punch:'
      'aliases': ''
      'keywords': 'fisted hand sign fist punch body clenched person'
    'fist':
      'unicode': '270a'
      'shortname': ':fist:'
      'aliases': ''
      'keywords': 'raised fist fingers grasp hand body clenched person punch'
    'v':
      'unicode': '270c'
      'shortname': ':v:'
      'aliases': ''
      'keywords': 'victory hand fingers ohyeah peace two v body person'
    'ok_hand':
      'unicode': '1f44c'
      'shortname': ':ok_hand:'
      'aliases': ''
      'keywords': 'ok hand sign fingers limbs perfect okay smoke smoking marijuana joint pot 420 body person'
    'raised_hand':
      'unicode': '270b'
      'shortname': ':raised_hand:'
      'aliases': ''
      'keywords': 'raised hand female girl woman body person'
    'open_hands':
      'unicode': '1f450'
      'shortname': ':open_hands:'
      'aliases': ''
      'keywords': 'open hands sign butterfly fingers body hand person'
    'muscle':
      'unicode': '1f4aa'
      'shortname': ':muscle:'
      'aliases': ''
      'keywords': 'flexed biceps arm flex hand strong muscle bicep body comic person'
    'pray':
      'unicode': '1f64f'
      'shortname': ':pray:'
      'aliases': ''
      'keywords': 'person with folded hands highfive hope namaste please wish pray high five sorrow regret sorry ask body bow gesture hand thanks'
    'point_up':
      'unicode': '261d'
      'shortname': ':point_up:'
      'aliases': ''
      'keywords': 'white up pointing index direction finger hand one body person point'
    'point_up_2':
      'unicode': '1f446'
      'shortname': ':point_up_2:'
      'aliases': ''
      'keywords': 'white up pointing backhand index direction finger hand one body person point'
    'point_down':
      'unicode': '1f447'
      'shortname': ':point_down:'
      'aliases': ''
      'keywords': 'white down pointing backhand index direction finger hand body person point'
    'point_left':
      'unicode': '1f448'
      'shortname': ':point_left:'
      'aliases': ''
      'keywords': 'white left pointing backhand index direction finger hand body person point'
    'point_right':
      'unicode': '1f449'
      'shortname': ':point_right:'
      'aliases': ''
      'keywords': 'white right pointing backhand index direction finger hand body person point'
    'middle_finger':
      'unicode': '1f595'
      'shortname': ':middle_finger:'
      'aliases': ':reversed_hand_with_middle_finger_extended:'
      'keywords': 'reversed hand with middle finger extended fu body middle finger person'
    'hand_splayed':
      'unicode': '1f590'
      'shortname': ':hand_splayed:'
      'aliases': ':raised_hand_with_fingers_splayed:'
      'keywords': 'raised hand with fingers splayed hi five stop halt body finger person'
    'metal':
      'unicode': '1f918'
      'shortname': ':metal:'
      'aliases': ':sign_of_the_horns:'
      'keywords': 'sign of the horns band concert fingers rocknroll'
    'vulcan':
      'unicode': '1f596'
      'shortname': ':vulcan:'
      'aliases': ':raised_hand_with_part_between_middle_and_ring_fingers:'
      'keywords': 'raised hand with part between middle and ring fingers vulcan spock leonard nimoy star trek live long body finger person'
    'writing_hand':
      'unicode': '270d'
      'shortname': ':writing_hand:'
      'aliases': ''
      'keywords': 'writing hand write sign signature draw body education person'
    'nail_care':
      'unicode': '1f485'
      'shortname': ':nail_care:'
      'aliases': ''
      'keywords': 'nail polish beauty manicure body care cosmetics person'
    'lips':
      'unicode': '1f444'
      'shortname': ':lips:'
      'aliases': ''
      'keywords': 'mouth kiss mouth lips body person'
    'tongue':
      'unicode': '1f445'
      'shortname': ':tongue:'
      'aliases': ''
      'keywords': 'tongue mouth playful taste buds food silly playful tease kiss french kiss lick tasty playfulness silliness intimacy body person'
    'ear':
      'unicode': '1f442'
      'shortname': ':ear:'
      'aliases': ''
      'keywords': 'ear hear listen sound body person'
    'nose':
      'unicode': '1f443'
      'shortname': ':nose:'
      'aliases': ''
      'keywords': 'nose smell sniff body person'
    'eye':
      'unicode': '1f441'
      'shortname': ':eye:'
      'aliases': ''
      'keywords': 'eye look peek watch body person'
    'eyes':
      'unicode': '1f440'
      'shortname': ':eyes:'
      'aliases': ''
      'keywords': 'eyes look peek stalk watch body eye face person'
    'bust_in_silhouette':
      'unicode': '1f464'
      'shortname': ':bust_in_silhouette:'
      'aliases': ''
      'keywords': 'bust in silhouette human man person user member account guest icon avatar profile me myself i'
    'busts_in_silhouette':
      'unicode': '1f465'
      'shortname': ':busts_in_silhouette:'
      'aliases': ''
      'keywords': 'busts in silhouette group human man person team user people members accounts relationship shadow bust'
    'speaking_head':
      'unicode': '1f5e3'
      'shortname': ':speaking_head:'
      'aliases': ':speaking_head_in_silhouette:'
      'keywords': 'speaking head in silhouette talk face person speak'
    'baby':
      'unicode': '1f476'
      'shortname': ':baby:'
      'aliases': ''
      'keywords': 'baby child infant toddler person'
    'boy':
      'unicode': '1f466'
      'shortname': ':boy:'
      'aliases': ''
      'keywords': 'boy male kid child person'
    'girl':
      'unicode': '1f467'
      'shortname': ':girl:'
      'aliases': ''
      'keywords': 'girl female kid child maiden person virgin virgo zodiac'
    'man':
      'unicode': '1f468'
      'shortname': ':man:'
      'aliases': ''
      'keywords': 'man classy dad father guy mustache person'
    'woman':
      'unicode': '1f469'
      'shortname': ':woman:'
      'aliases': ''
      'keywords': 'woman female girl lady person'
    'person_with_blond_hair':
      'unicode': '1f471'
      'shortname': ':person_with_blond_hair:'
      'aliases': ''
      'keywords': 'person with blond hair male man blonde young western westerner occidental'
    'older_man':
      'unicode': '1f474'
      'shortname': ':older_man:'
      'aliases': ''
      'keywords': 'older man male men grandpa grandfather old person'
    'older_woman':
      'unicode': '1f475'
      'shortname': ':older_woman:'
      'aliases': ':grandma:'
      'keywords': 'older woman female women lady grandma grandmother old person'
    'man_with_gua_pi_mao':
      'unicode': '1f472'
      'shortname': ':man_with_gua_pi_mao:'
      'aliases': ''
      'keywords': 'man with gua pi mao boy male skullcap chinese asian qing gua pi mao hat person'
    'man_with_turban':
      'unicode': '1f473'
      'shortname': ':man_with_turban:'
      'aliases': ''
      'keywords': 'man with turban male headdress headwear pagri india indian mummy wisdom peace person'
    'cop':
      'unicode': '1f46e'
      'shortname': ':cop:'
      'aliases': ''
      'keywords': 'police officer arrest enforcement law man cop person'
    'construction_worker':
      'unicode': '1f477'
      'shortname': ':construction_worker:'
      'aliases': ''
      'keywords': 'construction worker human male man wip hat person'
    'guardsman':
      'unicode': '1f482'
      'shortname': ':guardsman:'
      'aliases': ''
      'keywords': 'guardsman british gb male man uk guard bearskin hat british queen ceremonial military person'
    'spy':
      'unicode': '1f575'
      'shortname': ':spy:'
      'aliases': ':sleuth_or_spy:'
      'keywords': 'sleuth or spy pi undercover investigator person'
    'santa':
      'unicode': '1f385'
      'shortname': ':santa:'
      'aliases': ''
      'keywords': 'father christmas festival male man xmas santa saint nick jolly ho ho ho north pole presents gifts naughty nice sleigh holiday activity celebration fairy tale fantasy person'
    'angel':
      'unicode': '1f47c'
      'shortname': ':angel:'
      'aliases': ''
      'keywords': 'baby angel halo cupid heaven wings jesus face fairy tale fantasy person'
    'princess':
      'unicode': '1f478'
      'shortname': ':princess:'
      'aliases': ''
      'keywords': 'princess blond crown female girl woman royal royalty king queen daughter disney high-maintenance fairy tale fantasy person'
    'bride_with_veil':
      'unicode': '1f470'
      'shortname': ':bride_with_veil:'
      'aliases': ''
      'keywords': 'bride with veil couple marriage wedding wedding planning gown dress engagement white person'
    'walking':
      'unicode': '1f6b6'
      'shortname': ':walking:'
      'aliases': ''
      'keywords': 'pedestrian man walk stroll stride hiking hike person walking'
    'runner':
      'unicode': '1f3c3'
      'shortname': ':runner:'
      'aliases': ''
      'keywords': 'runner exercise man run jog sprint race dash marathon person running'
    'dancer':
      'unicode': '1f483'
      'shortname': ':dancer:'
      'aliases': ''
      'keywords': 'dancer female fun girl woman dress fancy boogy party celebrate ballet tango cha cha music person'
    'dancers':
      'unicode': '1f46f'
      'shortname': ':dancers:'
      'aliases': ''
      'keywords': 'woman with bunny ears female girls women dancing dancers showgirl playboy costume cancan dancer ear girl person'
    'couple':
      'unicode': '1f46b'
      'shortname': ':couple:'
      'aliases': ''
      'keywords': 'man and woman holding hands affection date dating human like love marriage people valentines couple hand hold person'
    'two_men_holding_hands':
      'unicode': '1f46c'
      'shortname': ':two_men_holding_hands:'
      'aliases': ''
      'keywords': 'two men holding hands bromance couple friends like love gay homosexual friends team unity gemini hand hold man person twins zodiac'
    'two_women_holding_hands':
      'unicode': '1f46d'
      'shortname': ':two_women_holding_hands:'
      'aliases': ''
      'keywords': 'two women holding hands couple female friends like love girlfriends friends sisters mother daughter gay homosexual couple unity hand hold person woman'
    'bow':
      'unicode': '1f647'
      'shortname': ':bow:'
      'aliases': ''
      'keywords': 'person bowing deeply boy male man sorry bow respect bend apology gesture'
    'information_desk_person':
      'unicode': '1f481'
      'shortname': ':information_desk_person:'
      'aliases': ''
      'keywords': 'information desk person female girl human woman help question answer sassy unimpressed attitude snarky hand'
    'no_good':
      'unicode': '1f645'
      'shortname': ':no_good:'
      'aliases': ''
      'keywords': 'face with no good gesture female girl woman stop nope don\'t not forbidden hand person prohibited'
    'ok_woman':
      'unicode': '1f646'
      'shortname': ':ok_woman:'
      'aliases': ''
      'keywords': 'face with ok gesture female girl human pink women yes okay accept hand person'
    'raising_hand':
      'unicode': '1f64b'
      'shortname': ':raising_hand:'
      'aliases': ''
      'keywords': 'happy person raising one hand female girl woman raise notice attention answer gesture raised'
    'person_with_pouting_face':
      'unicode': '1f64e'
      'shortname': ':person_with_pouting_face:'
      'aliases': ''
      'keywords': 'person with pouting face female girl woman pout sexy cute annoyed gesture'
    'person_frowning':
      'unicode': '1f64d'
      'shortname': ':person_frowning:'
      'aliases': ''
      'keywords': 'person frowning female girl woman dejected rejected sad frown gesture'
    'haircut':
      'unicode': '1f487'
      'shortname': ':haircut:'
      'aliases': ''
      'keywords': 'haircut female girl woman barber beauty parlor person'
    'massage':
      'unicode': '1f486'
      'shortname': ':massage:'
      'aliases': ''
      'keywords': 'face massage female girl woman person salon'
    'couple_with_heart':
      'unicode': '1f491'
      'shortname': ':couple_with_heart:'
      'aliases': ''
      'keywords': 'couple with heart affection dating human like love marriage valentines person romance'
    'couple_ww':
      'unicode': '1f469-2764-1f469'
      'shortname': ':couple_ww:'
      'aliases': ':couple_with_heart_ww:'
      'keywords': 'couple (woman,woman) affection dating human like love marriage valentines'
    'couple_mm':
      'unicode': '1f468-2764-1f468'
      'shortname': ':couple_mm:'
      'aliases': ':couple_with_heart_mm:'
      'keywords': 'couple (man,man) affection dating human like love marriage valentines'
    'couplekiss':
      'unicode': '1f48f'
      'shortname': ':couplekiss:'
      'aliases': ''
      'keywords': 'kiss dating like love marriage valentines couple person romance'
    'kiss_ww':
      'unicode': '1f469-2764-1f48b-1f469'
      'shortname': ':kiss_ww:'
      'aliases': ':couplekiss_ww:'
      'keywords': 'kiss (woman,woman) dating like love marriage valentines couple'
    'kiss_mm':
      'unicode': '1f468-2764-1f48b-1f468'
      'shortname': ':kiss_mm:'
      'aliases': ':couplekiss_mm:'
      'keywords': 'kiss (man,man) dating like love marriage valentines couple'
    'family':
      'unicode': '1f46a'
      'shortname': ':family:'
      'aliases': ''
      'keywords': 'family child dad father mom mother parents girl boy group unit man woman person'
    'family_mwg':
      'unicode': '1f468-1f469-1f467'
      'shortname': ':family_mwg:'
      'aliases': ''
      'keywords': 'family (man,woman,girl) child dad father mom mother parents girl boy group unit man woman'
    'family_mwgb':
      'unicode': '1f468-1f469-1f467-1f466'
      'shortname': ':family_mwgb:'
      'aliases': ''
      'keywords': 'family (man,woman,girl,boy) dad father mom mother parents children girl boy group unit man woman'
    'family_mwbb':
      'unicode': '1f468-1f469-1f466-1f466'
      'shortname': ':family_mwbb:'
      'aliases': ''
      'keywords': 'family (man,woman,boy,boy) dad father mom mother parents children boy group unit man woman'
    'family_mwgg':
      'unicode': '1f468-1f469-1f467-1f467'
      'shortname': ':family_mwgg:'
      'aliases': ''
      'keywords': 'family (man,woman,girl,girl) dad father mom mother parents children girl group unit man woman'
    'family_wwb':
      'unicode': '1f469-1f469-1f466'
      'shortname': ':family_wwb:'
      'aliases': ''
      'keywords': 'family (woman,woman,boy) mom mother parents child boy group unit gay lesbian homosexual woman'
    'family_wwg':
      'unicode': '1f469-1f469-1f467'
      'shortname': ':family_wwg:'
      'aliases': ''
      'keywords': 'family (woman,woman,girl) mom mother parents child woman girl group unit gay lesbian homosexual'
    'family_wwgb':
      'unicode': '1f469-1f469-1f467-1f466'
      'shortname': ':family_wwgb:'
      'aliases': ''
      'keywords': 'family (woman,woman,girl,boy) mom mother parents children group unit gay lesbian homosexual woman girl boy'
    'family_wwbb':
      'unicode': '1f469-1f469-1f466-1f466'
      'shortname': ':family_wwbb:'
      'aliases': ''
      'keywords': 'family (woman,woman,boy,boy) mom mother parents children group unit gay lesbian homosexual woman boy'
    'family_wwgg':
      'unicode': '1f469-1f469-1f467-1f467'
      'shortname': ':family_wwgg:'
      'aliases': ''
      'keywords': 'family (woman,woman,girl,girl) mom mother parents children group unit gay lesbian homosexual woman girl'
    'family_mmb':
      'unicode': '1f468-1f468-1f466'
      'shortname': ':family_mmb:'
      'aliases': ''
      'keywords': 'family (man,man,boy) child dad father parents group unit gay homosexual man boy'
    'family_mmg':
      'unicode': '1f468-1f468-1f467'
      'shortname': ':family_mmg:'
      'aliases': ''
      'keywords': 'family (man,man,girl) child dad father parents group unit gay homosexual man girl'
    'family_mmgb':
      'unicode': '1f468-1f468-1f467-1f466'
      'shortname': ':family_mmgb:'
      'aliases': ''
      'keywords': 'family (man,man,girl,boy) children dad father parents group unit gay homosexual man girl boy'
    'family_mmbb':
      'unicode': '1f468-1f468-1f466-1f466'
      'shortname': ':family_mmbb:'
      'aliases': ''
      'keywords': 'family (man,man,boy,boy) children dad father parents group unit gay homosexual man boy'
    'family_mmgg':
      'unicode': '1f468-1f468-1f467-1f467'
      'shortname': ':family_mmgg:'
      'aliases': ''
      'keywords': 'family (man,man,girl,girl) children dad father parents group unit gay homosexual man girl'
    'womans_clothes':
      'unicode': '1f45a'
      'shortname': ':womans_clothes:'
      'aliases': ''
      'keywords': 'womans clothes fashion clothing blouse shirt wardrobe breasts cleavage shopping shop dressing dressed object person woman'
    'shirt':
      'unicode': '1f455'
      'shortname': ':shirt:'
      'aliases': ''
      'keywords': 't-shirt cloth fashion shirt tee clothing object person tshirt'
    'jeans':
      'unicode': '1f456'
      'shortname': ':jeans:'
      'aliases': ''
      'keywords': 'jeans fashion shopping pants blue denim levi\'s levi designer work skinny clothing object person trousers'
    'necktie':
      'unicode': '1f454'
      'shortname': ':necktie:'
      'aliases': ''
      'keywords': 'necktie clothes fashion formal shirt tie clothing object person'
    'dress':
      'unicode': '1f457'
      'shortname': ':dress:'
      'aliases': ''
      'keywords': 'dress clothes fashion clothing object person'
    'bikini':
      'unicode': '1f459'
      'shortname': ':bikini:'
      'aliases': ''
      'keywords': 'bikini beach fashion female girl swimming woman clothing object person swim'
    'kimono':
      'unicode': '1f458'
      'shortname': ':kimono:'
      'aliases': ''
      'keywords': 'kimono dress fashion female japanese women clothing object person'
    'lipstick':
      'unicode': '1f484'
      'shortname': ':lipstick:'
      'aliases': ''
      'keywords': 'lipstick fashion female girl cosmetics makeup object person'
    'kiss':
      'unicode': '1f48b'
      'shortname': ':kiss:'
      'aliases': ''
      'keywords': 'kiss mark affection face like lips love valentines emotion heart person romance'
    'footprints':
      'unicode': '1f463'
      'shortname': ':footprints:'
      'aliases': ''
      'keywords': 'footprints feet body clothing footprint person print'
    'high_heel':
      'unicode': '1f460'
      'shortname': ':high_heel:'
      'aliases': ''
      'keywords': 'high-heeled shoe fashion female shoes clothing heel object person woman'
    'sandal':
      'unicode': '1f461'
      'shortname': ':sandal:'
      'aliases': ''
      'keywords': 'womans sandal fashion shoes female clothing object person shoe woman'
    'boot':
      'unicode': '1f462'
      'shortname': ':boot:'
      'aliases': ''
      'keywords': 'womans boots fashion shoes boot clothing object person shoe woman'
    'mans_shoe':
      'unicode': '1f45e'
      'shortname': ':mans_shoe:'
      'aliases': ''
      'keywords': 'mans shoe fashion male clothing man object person'
    'athletic_shoe':
      'unicode': '1f45f'
      'shortname': ':athletic_shoe:'
      'aliases': ''
      'keywords': 'athletic shoe sports sneaker clothing object person'
    'womans_hat':
      'unicode': '1f452'
      'shortname': ':womans_hat:'
      'aliases': ''
      'keywords': 'womans hat accessories fashion female clothing object person woman'
    'tophat':
      'unicode': '1f3a9'
      'shortname': ':tophat:'
      'aliases': ''
      'keywords': 'top hat classy gentleman magic cap beaver high tall stove pipe chimney topper london period piece magician activity clothing entertainment object person tophat'
    'helmet_with_cross':
      'unicode': '26d1'
      'shortname': ':helmet_with_cross:'
      'aliases': ':helmet_with_white_cross:'
      'keywords': 'helmet with white cross aid face hat person'
    'mortar_board':
      'unicode': '1f393'
      'shortname': ':mortar_board:'
      'aliases': ''
      'keywords': 'graduation cap cap college degree school university mortarboard academic education ceremony tassel activity celebration clothing hat object'
    'crown':
      'unicode': '1f451'
      'shortname': ':crown:'
      'aliases': ''
      'keywords': 'crown king kod leader royalty clothing object person queen'
    'school_satchel':
      'unicode': '1f392'
      'shortname': ':school_satchel:'
      'aliases': ''
      'keywords': 'school satchel bag education student backpack packing pack hike education adventure travel sightsee activity object'
    'pouch':
      'unicode': '1f45d'
      'shortname': ':pouch:'
      'aliases': ''
      'keywords': 'pouch accessories bag cosmetic packing grandma makeup clothing object person'
    'purse':
      'unicode': '1f45b'
      'shortname': ':purse:'
      'aliases': ''
      'keywords': 'purse accessories fashion money clutch bag handbag coin bag accessory ladies shopping clothing coin object person'
    'handbag':
      'unicode': '1f45c'
      'shortname': ':handbag:'
      'aliases': ''
      'keywords': 'handbag accessories accessory bag fashion clothing object person'
    'briefcase':
      'unicode': '1f4bc'
      'shortname': ':briefcase:'
      'aliases': ''
      'keywords': 'briefcase business documents work object office person'
    'eyeglasses':
      'unicode': '1f453'
      'shortname': ':eyeglasses:'
      'aliases': ''
      'keywords': 'eyeglasses accessories eyesight fashion spectacles eye sight nearsightedness myopia farsightedness hyperopia frames vision see blurry contacts clothing eyewear glasses object person'
    'ring':
      'unicode': '1f48d'
      'shortname': ':ring:'
      'aliases': ''
      'keywords': 'ring marriage propose valentines wedding gold diamond emotion object person romance'
    'closed_umbrella':
      'unicode': '1f302'
      'shortname': ':closed_umbrella:'
      'aliases': ''
      'keywords': 'closed umbrella drizzle rain weather moisture protection sun ultraviolet uv clothing nature person'
    'dog':
      'unicode': '1f436'
      'shortname': ':dog:'
      'aliases': ''
      'keywords': 'dog face animal friend nature pet puppy woof bark fido'
    'cat':
      'unicode': '1f431'
      'shortname': ':cat:'
      'aliases': ''
      'keywords': 'cat face animal meow pet kitten nature'
    'mouse':
      'unicode': '1f42d'
      'shortname': ':mouse:'
      'aliases': ''
      'keywords': 'mouse face animal nature rodent'
    'hamster':
      'unicode': '1f439'
      'shortname': ':hamster:'
      'aliases': ''
      'keywords': 'hamster face animal nature rodent pet'
    'rabbit':
      'unicode': '1f430'
      'shortname': ':rabbit:'
      'aliases': ''
      'keywords': 'rabbit face animal nature bunny easter reproduction prolific pet'
    'bear':
      'unicode': '1f43b'
      'shortname': ':bear:'
      'aliases': ''
      'keywords': 'bear face animal nature grizzly'
    'panda_face':
      'unicode': '1f43c'
      'shortname': ':panda_face:'
      'aliases': ''
      'keywords': 'panda face animal nature bear cub cute endearment friendship love bamboo china black white'
    'koala':
      'unicode': '1f428'
      'shortname': ':koala:'
      'aliases': ''
      'keywords': 'koala animal nature bear'
    'tiger':
      'unicode': '1f42f'
      'shortname': ':tiger:'
      'aliases': ''
      'keywords': 'tiger face animal nature cat striped tony tigger hobs'
    'lion_face':
      'unicode': '1f981'
      'shortname': ':lion_face:'
      'aliases': ':lion:'
      'keywords': 'lion face'
    'cow':
      'unicode': '1f42e'
      'shortname': ':cow:'
      'aliases': ''
      'keywords': 'cow face animal beef ox milk dairy nature'
    'pig':
      'unicode': '1f437'
      'shortname': ':pig:'
      'aliases': ''
      'keywords': 'pig face animal nature piggy pork ham hog bacon oink slop livestock greed greedy oink'
    'pig_nose':
      'unicode': '1f43d'
      'shortname': ':pig_nose:'
      'aliases': ''
      'keywords': 'pig nose animal oink snout food eat cute pink smell truffle face nature'
    'frog':
      'unicode': '1f438'
      'shortname': ':frog:'
      'aliases': ''
      'keywords': 'frog face animal nature'
    'octopus':
      'unicode': '1f419'
      'shortname': ':octopus:'
      'aliases': ''
      'keywords': 'octopus animal creature ocean sea nature'
    'monkey_face':
      'unicode': '1f435'
      'shortname': ':monkey_face:'
      'aliases': ''
      'keywords': 'monkey face animal nature'
    'see_no_evil':
      'unicode': '1f648'
      'shortname': ':see_no_evil:'
      'aliases': ''
      'keywords': 'see-no-evil monkey animal nature monkey see eyes vision sight mizaru evil face forbidden gesture no not prohibited'
    'hear_no_evil':
      'unicode': '1f649'
      'shortname': ':hear_no_evil:'
      'aliases': ''
      'keywords': 'hear-no-evil monkey animal ears hear sound kikazaru evil face forbidden gesture nature no not prohibited'
    'speak_no_evil':
      'unicode': '1f64a'
      'shortname': ':speak_no_evil:'
      'aliases': ''
      'keywords': 'speak-no-evil monkey animal mouth talk say words verbal verbalize oral iwazaru evil face forbidden gesture nature no not prohibited speak'
    'monkey':
      'unicode': '1f412'
      'shortname': ':monkey:'
      'aliases': ''
      'keywords': 'monkey animal nature primate banana silly'
    'chicken':
      'unicode': '1f414'
      'shortname': ':chicken:'
      'aliases': ''
      'keywords': 'chicken animal cluck hen poultry livestock nature'
    'penguin':
      'unicode': '1f427'
      'shortname': ':penguin:'
      'aliases': ''
      'keywords': 'penguin animal nature bird'
    'bird':
      'unicode': '1f426'
      'shortname': ':bird:'
      'aliases': ''
      'keywords': 'bird animal fly nature tweet'
    'baby_chick':
      'unicode': '1f424'
      'shortname': ':baby_chick:'
      'aliases': ''
      'keywords': 'baby chick animal chicken bird young woman cute nature'
    'hatching_chick':
      'unicode': '1f423'
      'shortname': ':hatching_chick:'
      'aliases': ''
      'keywords': 'hatching chick born chicken egg baby bird chicken young woman cute animal nature'
    'hatched_chick':
      'unicode': '1f425'
      'shortname': ':hatched_chick:'
      'aliases': ''
      'keywords': 'front-facing baby chick baby chicken chick baby bird chicken young woman cute animal nature'
    'wolf':
      'unicode': '1f43a'
      'shortname': ':wolf:'
      'aliases': ''
      'keywords': 'wolf face animal nature'
    'boar':
      'unicode': '1f417'
      'shortname': ':boar:'
      'aliases': ''
      'keywords': 'boar animal nature pig'
    'horse':
      'unicode': '1f434'
      'shortname': ':horse:'
      'aliases': ''
      'keywords': 'horse face animal powerful draft colt filly mare stallion gelding yearling thoroughbred pony nature'
    'unicorn':
      'unicode': '1f984'
      'shortname': ':unicorn:'
      'aliases': ':unicorn_face:'
      'keywords': 'unicorn face'
    'bee':
      'unicode': '1f41d'
      'shortname': ':bee:'
      'aliases': ''
      'keywords': 'honeybee insect bee queen buzz flower pollen sting honey hive bumble pollination animal nature'
    'bug':
      'unicode': '1f41b'
      'shortname': ':bug:'
      'aliases': ''
      'keywords': 'bug insect nature insect virus error animal'
    'snail':
      'unicode': '1f40c'
      'shortname': ':snail:'
      'aliases': ''
      'keywords': 'snail animal shell slow slow escargot french appetizer nature'
    'beetle':
      'unicode': '1f41e'
      'shortname': ':beetle:'
      'aliases': ''
      'keywords': 'lady beetle insect nature bug ladybug ladybird cow lady cow endearment animal lady beetle'
    'ant':
      'unicode': '1f41c'
      'shortname': ':ant:'
      'aliases': ''
      'keywords': 'ant insect queen insect team animal nature'
    'spider':
      'unicode': '1f577'
      'shortname': ':spider:'
      'aliases': ''
      'keywords': 'spider arachnid eight-legged animal insect object'
    'scorpion':
      'unicode': '1f982'
      'shortname': ':scorpion:'
      'aliases': ''
      'keywords': 'scorpion'
    'crab':
      'unicode': '1f980'
      'shortname': ':crab:'
      'aliases': ''
      'keywords': 'crab'
    'snake':
      'unicode': '1f40d'
      'shortname': ':snake:'
      'aliases': ''
      'keywords': 'snake animal evil bearer nature ophiuchus serpent zodiac'
    'turtle':
      'unicode': '1f422'
      'shortname': ':turtle:'
      'aliases': ''
      'keywords': 'turtle animal slow shell tortoise chelonian reptile slow snap steady nature'
    'tropical_fish':
      'unicode': '1f420'
      'shortname': ':tropical_fish:'
      'aliases': ''
      'keywords': 'tropical fish animal nature'
    'fish':
      'unicode': '1f41f'
      'shortname': ':fish:'
      'aliases': ''
      'keywords': 'fish animal food nature pisces zodiac'
    'blowfish':
      'unicode': '1f421'
      'shortname': ':blowfish:'
      'aliases': ''
      'keywords': 'blowfish food nature pufferfish puffer ballonfish toadfish fugu fish sushi animal fish'
    'dolphin':
      'unicode': '1f42c'
      'shortname': ':dolphin:'
      'aliases': ''
      'keywords': 'dolphin animal fins fish flipper nature ocean sea'
    'whale':
      'unicode': '1f433'
      'shortname': ':whale:'
      'aliases': ''
      'keywords': 'spouting whale animal nature ocean sea face'
    'whale2':
      'unicode': '1f40b'
      'shortname': ':whale2:'
      'aliases': ''
      'keywords': 'whale animal nature ocean sea blubber bloated fat large massive'
    'crocodile':
      'unicode': '1f40a'
      'shortname': ':crocodile:'
      'aliases': ''
      'keywords': 'crocodile animal nature croc alligator gator cranky'
    'leopard':
      'unicode': '1f406'
      'shortname': ':leopard:'
      'aliases': ''
      'keywords': 'leopard animal nature cat spot spotted sexy'
    'tiger2':
      'unicode': '1f405'
      'shortname': ':tiger2:'
      'aliases': ''
      'keywords': 'tiger animal nature cat striped tony tigger hobs'
    'water_buffalo':
      'unicode': '1f403'
      'shortname': ':water_buffalo:'
      'aliases': ''
      'keywords': 'water buffalo animal cow nature ox asia bovine'
    'ox':
      'unicode': '1f402'
      'shortname': ':ox:'
      'aliases': ''
      'keywords': 'ox animal beef cow bull nature taurus zodiac'
    'cow2':
      'unicode': '1f404'
      'shortname': ':cow2:'
      'aliases': ''
      'keywords': 'cow animal beef nature ox milk dairy beef bessie moo'
    'dromedary_camel':
      'unicode': '1f42a'
      'shortname': ':dromedary_camel:'
      'aliases': ''
      'keywords': 'dromedary camel animal desert hot hump middle east heat water hump day wednesday sex nature'
    'camel':
      'unicode': '1f42b'
      'shortname': ':camel:'
      'aliases': ''
      'keywords': 'bactrian camel animal hot nature hump desert central asia heat water hump day wednesday sex'
    'elephant':
      'unicode': '1f418'
      'shortname': ':elephant:'
      'aliases': ''
      'keywords': 'elephant animal nature nose thailand'
    'goat':
      'unicode': '1f410'
      'shortname': ':goat:'
      'aliases': ''
      'keywords': 'goat animal nature kid billy livestock capricorn zodiac'
    'ram':
      'unicode': '1f40f'
      'shortname': ':ram:'
      'aliases': ''
      'keywords': 'ram animal nature sheep male horns aries zodiac'
    'sheep':
      'unicode': '1f411'
      'shortname': ':sheep:'
      'aliases': ''
      'keywords': 'sheep animal nature wool flock follower ewe female lamb'
    'racehorse':
      'unicode': '1f40e'
      'shortname': ':racehorse:'
      'aliases': ''
      'keywords': 'horse animal gamble powerful draft calvary cowboy cowgirl mounted race ride gallop trot colt filly mare stallion gelding yearling thoroughbred pony nature place racehorse racing'
    'pig2':
      'unicode': '1f416'
      'shortname': ':pig2:'
      'aliases': ''
      'keywords': 'pig animal nature piggy pork ham hog bacon oink slop livestock greed greedy oink sow'
    'rat':
      'unicode': '1f400'
      'shortname': ':rat:'
      'aliases': ''
      'keywords': 'rat animal mouse rodent crooked snitch nature'
    'mouse2':
      'unicode': '1f401'
      'shortname': ':mouse2:'
      'aliases': ''
      'keywords': 'mouse animal nature mice rodent'
    'rooster':
      'unicode': '1f413'
      'shortname': ':rooster:'
      'aliases': ''
      'keywords': 'rooster animal chicken nature cockerel cock male cock-a-doodle-doo crowing'
    'turkey':
      'unicode': '1f983'
      'shortname': ':turkey:'
      'aliases': ''
      'keywords': 'turkey'
    'dove':
      'unicode': '1f54a'
      'shortname': ':dove:'
      'aliases': ':dove_of_peace:'
      'keywords': 'dove of peace symbol bird animal fly nature'
    'dog2':
      'unicode': '1f415'
      'shortname': ':dog2:'
      'aliases': ''
      'keywords': 'dog animal friend nature pet puppy woof bark fido'
    'poodle':
      'unicode': '1f429'
      'shortname': ':poodle:'
      'aliases': ''
      'keywords': 'poodle 101 animal dog nature showy sophisticated vain'
    'cat2':
      'unicode': '1f408'
      'shortname': ':cat2:'
      'aliases': ''
      'keywords': 'cat animal meow pet kitten nature'
    'rabbit2':
      'unicode': '1f407'
      'shortname': ':rabbit2:'
      'aliases': ''
      'keywords': 'rabbit animal nature bunny easter reproduction prolific pet'
    'chipmunk':
      'unicode': '1f43f'
      'shortname': ':chipmunk:'
      'aliases': ''
      'keywords': 'chipmunk animal nature'
    'feet':
      'unicode': '1f43e'
      'shortname': ':feet:'
      'aliases': ':paw_prints:'
      'keywords': 'paw prints animal pet tracking mark imprints footsteps lion bear dog cat raccoon critter feet nature print'
    'dragon':
      'unicode': '1f409'
      'shortname': ':dragon:'
      'aliases': ''
      'keywords': 'dragon chinese green myth nature dragon fire legendary myth animal fairy tale'
    'dragon_face':
      'unicode': '1f432'
      'shortname': ':dragon_face:'
      'aliases': ''
      'keywords': 'dragon face chinese green myth nature dragon head fire legendary myth animal fairy tale'
    'cactus':
      'unicode': '1f335'
      'shortname': ':cactus:'
      'aliases': ''
      'keywords': 'cactus nature plant vegetable desert drought spike poke'
    'christmas_tree':
      'unicode': '1f384'
      'shortname': ':christmas_tree:'
      'aliases': ''
      'keywords': 'christmas tree celebration december festival vacation xmas santa holiday winter evergreen ornaments jesus gifts presents activity entertainment object'
    'evergreen_tree':
      'unicode': '1f332'
      'shortname': ':evergreen_tree:'
      'aliases': ''
      'keywords': 'evergreen tree nature plant needles christmas'
    'deciduous_tree':
      'unicode': '1f333'
      'shortname': ':deciduous_tree:'
      'aliases': ''
      'keywords': 'deciduous tree nature plant leaves fall color shedding'
    'palm_tree':
      'unicode': '1f334'
      'shortname': ':palm_tree:'
      'aliases': ''
      'keywords': 'palm tree nature plant coconuts fronds warm tropical'
    'seedling':
      'unicode': '1f331'
      'shortname': ':seedling:'
      'aliases': ''
      'keywords': 'seedling grass lawn nature plant new start grow young'
    'herb':
      'unicode': '1f33f'
      'shortname': ':herb:'
      'aliases': ''
      'keywords': 'herb grass lawn medicine plant vegetable weed spice plant cook cooking leaf nature'
    'shamrock':
      'unicode': '2618'
      'shortname': ':shamrock:'
      'aliases': ''
      'keywords': 'shamrock nature plant'
    'four_leaf_clover':
      'unicode': '1f340'
      'shortname': ':four_leaf_clover:'
      'aliases': ''
      'keywords': 'four leaf clover lucky nature plant luck irish saint patrick green 4'
    'bamboo':
      'unicode': '1f38d'
      'shortname': ':bamboo:'
      'aliases': ''
      'keywords': 'pine decoration nature plant vegetable bamboo new years spirits harvest prosperity longevity fortune luck welcome farming agriculture activity celebration japanese object'
    'tanabata_tree':
      'unicode': '1f38b'
      'shortname': ':tanabata_tree:'
      'aliases': ''
      'keywords': 'tanabata tree nature plant festival star wish holiday activity banner celebration entertainment japanese object'
    'leaves':
      'unicode': '1f343'
      'shortname': ':leaves:'
      'aliases': ''
      'keywords': 'leaf fluttering in wind nature plant tree vegetable leaves float deciduous blow flutter'
    'fallen_leaf':
      'unicode': '1f342'
      'shortname': ':fallen_leaf:'
      'aliases': ''
      'keywords': 'fallen leaf leaves nature plant vegetable fall color deciduous autumn falling'
    'maple_leaf':
      'unicode': '1f341'
      'shortname': ':maple_leaf:'
      'aliases': ''
      'keywords': 'maple leaf canada nature plant syrup tree falling'
    'ear_of_rice':
      'unicode': '1f33e'
      'shortname': ':ear_of_rice:'
      'aliases': ''
      'keywords': 'ear of rice nature plant food seed'
    'hibiscus':
      'unicode': '1f33a'
      'shortname': ':hibiscus:'
      'aliases': ''
      'keywords': 'hibiscus plant hibiscus flower warm nature'
    'sunflower':
      'unicode': '1f33b'
      'shortname': ':sunflower:'
      'aliases': ''
      'keywords': 'sunflower nature plant sun flower seeds yellow'
    'rose':
      'unicode': '1f339'
      'shortname': ':rose:'
      'aliases': ''
      'keywords': 'rose love valentines fragrant flower thorns petals romance nature plant'
    'tulip':
      'unicode': '1f337'
      'shortname': ':tulip:'
      'aliases': ''
      'keywords': 'tulip nature plant flower bulb spring easter'
    'blossom':
      'unicode': '1f33c'
      'shortname': ':blossom:'
      'aliases': ''
      'keywords': 'blossom nature yellow daisy flower plant'
    'cherry_blossom':
      'unicode': '1f338'
      'shortname': ':cherry_blossom:'
      'aliases': ''
      'keywords': 'cherry blossom flower nature plant tree'
    'bouquet':
      'unicode': '1f490'
      'shortname': ':bouquet:'
      'aliases': ''
      'keywords': 'bouquet flowers nature flower object place plant romance'
    'mushroom':
      'unicode': '1f344'
      'shortname': ':mushroom:'
      'aliases': ''
      'keywords': 'mushroom plant vegetable fungi food fungus shroom nature'
    'chestnut':
      'unicode': '1f330'
      'shortname': ':chestnut:'
      'aliases': ''
      'keywords': 'chestnut food squirrel chestnut roasted tree nature plant'
    'jack_o_lantern':
      'unicode': '1f383'
      'shortname': ':jack_o_lantern:'
      'aliases': ''
      'keywords': 'jack-o-lantern halloween pumpkin holiday carve autumn fall october saints costume spooky horror scary scared dead activity celebration entertainment jack lantern object'
    'shell':
      'unicode': '1f41a'
      'shortname': ':shell:'
      'aliases': ''
      'keywords': 'spiral shell beach nature sea beach sand crab nautilus animal'
    'spider_web':
      'unicode': '1f578'
      'shortname': ':spider_web:'
      'aliases': ''
      'keywords': 'spider web cobweb animal object'
    'earth_americas':
      'unicode': '1f30e'
      'shortname': ':earth_americas:'
      'aliases': ''
      'keywords': 'earth globe americas USA globe international world space planet north south nature place'
    'earth_africa':
      'unicode': '1f30d'
      'shortname': ':earth_africa:'
      'aliases': ''
      'keywords': 'earth globe europe-africa globe international world space planet africa europe nature place'
    'earth_asia':
      'unicode': '1f30f'
      'shortname': ':earth_asia:'
      'aliases': ''
      'keywords': 'earth globe asia-australia east globe international world space planet australia asia nature place'
    'full_moon':
      'unicode': '1f315'
      'shortname': ':full_moon:'
      'aliases': ''
      'keywords': 'full moon symbol nature yellow sky night cheese phase spooky werewolves twilight place space time weather'
    'waning_gibbous_moon':
      'unicode': '1f316'
      'shortname': ':waning_gibbous_moon:'
      'aliases': ''
      'keywords': 'waning gibbous moon symbol nature sky night cheese phase place space time weather'
    'last_quarter_moon':
      'unicode': '1f317'
      'shortname': ':last_quarter_moon:'
      'aliases': ''
      'keywords': 'last quarter moon symbol nature sky night cheese phase place space time weather'
    'waning_crescent_moon':
      'unicode': '1f318'
      'shortname': ':waning_crescent_moon:'
      'aliases': ''
      'keywords': 'waning crescent moon symbol nature sky night cheese phase place space time weather'
    'new_moon':
      'unicode': '1f311'
      'shortname': ':new_moon:'
      'aliases': ''
      'keywords': 'new moon symbol nature sky night cheese phase dark place space time weather'
    'waxing_crescent_moon':
      'unicode': '1f312'
      'shortname': ':waxing_crescent_moon:'
      'aliases': ''
      'keywords': 'waxing crescent moon symbol nature sky night cheese phase place space time weather'
    'first_quarter_moon':
      'unicode': '1f313'
      'shortname': ':first_quarter_moon:'
      'aliases': ''
      'keywords': 'first quarter moon symbol nature sky night cheese phase place space time weather'
    'waxing_gibbous_moon':
      'unicode': '1f314'
      'shortname': ':waxing_gibbous_moon:'
      'aliases': ''
      'keywords': 'waxing gibbous moon symbol nature sky night cheese phase place space time weather'
    'new_moon_with_face':
      'unicode': '1f31a'
      'shortname': ':new_moon_with_face:'
      'aliases': ''
      'keywords': 'new moon with face nature anthropomorphic sky night cheese phase place space time weather'
    'full_moon_with_face':
      'unicode': '1f31d'
      'shortname': ':full_moon_with_face:'
      'aliases': ''
      'keywords': 'full moon with face night anthropomorphic sky night cheese phase spooky werewolves bright nature place space weather'
    'first_quarter_moon_with_face':
      'unicode': '1f31b'
      'shortname': ':first_quarter_moon_with_face:'
      'aliases': ''
      'keywords': 'first quarter moon with face nature anthropomorphic sky night cheese phase crescent place space weather'
    'last_quarter_moon_with_face':
      'unicode': '1f31c'
      'shortname': ':last_quarter_moon_with_face:'
      'aliases': ''
      'keywords': 'last quarter moon with face nature anthropomorphic sky night cheese phase crescent place space weather'
    'sun_with_face':
      'unicode': '1f31e'
      'shortname': ':sun_with_face:'
      'aliases': ''
      'keywords': 'sun with face morning anthropomorphic sky sunny bright nature place space weather'
    'crescent_moon':
      'unicode': '1f319'
      'shortname': ':crescent_moon:'
      'aliases': ''
      'keywords': 'crescent moon night waxing sky night cheese phase nature place space time weather'
    'star':
      'unicode': '2b50'
      'shortname': ':star:'
      'aliases': ''
      'keywords': 'white medium star night yellow nature place'
    'star2':
      'unicode': '1f31f'
      'shortname': ':star2:'
      'aliases': ''
      'keywords': 'glowing star night sparkle glow five points classic glittery object place shining'
    'dizzy':
      'unicode': '1f4ab'
      'shortname': ':dizzy:'
      'aliases': ''
      'keywords': 'dizzy symbol shoot sparkle star drunk sick intoxicated squeans starburst star comic emotion person'
    'sparkles':
      'unicode': '2728'
      'shortname': ':sparkles:'
      'aliases': ''
      'keywords': 'sparkles cool shine shiny stars emotion entertainment object sign sparkle star'
    'comet':
      'unicode': '2604'
      'shortname': ':comet:'
      'aliases': ''
      'keywords': 'comet object space'
    'sunny':
      'unicode': '2600'
      'shortname': ':sunny:'
      'aliases': ''
      'keywords': 'black sun with rays brightness weather sunny bright nature space'
    'white_sun_small_cloud':
      'unicode': '1f324'
      'shortname': ':white_sun_small_cloud:'
      'aliases': ':white_sun_with_small_cloud:'
      'keywords': 'white sun with small cloud nature weather'
    'partly_sunny':
      'unicode': '26c5'
      'shortname': ':partly_sunny:'
      'aliases': ''
      'keywords': 'sun behind cloud nature weather partly sunny'
    'white_sun_cloud':
      'unicode': '1f325'
      'shortname': ':white_sun_cloud:'
      'aliases': ':white_sun_behind_cloud:'
      'keywords': 'white sun behind cloud nature weather'
    'white_sun_rain_cloud':
      'unicode': '1f326'
      'shortname': ':white_sun_rain_cloud:'
      'aliases': ':white_sun_behind_cloud_with_rain:'
      'keywords': 'white sun behind cloud with rain nature weather'
    'cloud':
      'unicode': '2601'
      'shortname': ':cloud:'
      'aliases': ''
      'keywords': 'cloud sky weather overcast nature'
    'cloud_rain':
      'unicode': '1f327'
      'shortname': ':cloud_rain:'
      'aliases': ':cloud_with_rain:'
      'keywords': 'cloud with rain weather wet nature'
    'thunder_cloud_rain':
      'unicode': '26c8'
      'shortname': ':thunder_cloud_rain:'
      'aliases': ':thunder_cloud_and_rain:'
      'keywords': 'thunder cloud and rain nature weather'
    'cloud_lightning':
      'unicode': '1f329'
      'shortname': ':cloud_lightning:'
      'aliases': ':cloud_with_lightning:'
      'keywords': 'cloud with lightning weather thunder nature'
    'zap':
      'unicode': '26a1'
      'shortname': ':zap:'
      'aliases': ''
      'keywords': 'high voltage sign lightning bolt thunder weather zap danger electric electricity lightning nature symbol'
    'fire':
      'unicode': '1f525'
      'shortname': ':fire:'
      'aliases': ':flame:'
      'keywords': 'fire cook hot flame object tool'
    'boom':
      'unicode': '1f4a5'
      'shortname': ':boom:'
      'aliases': ''
      'keywords': 'collision symbol bomb explode explosion boom bang fire emphasis wow bam comic emotion person'
    'snowflake':
      'unicode': '2744'
      'shortname': ':snowflake:'
      'aliases': ''
      'keywords': 'snowflake christmas season weather winter xmas snow frozen droplet ice crystal cold chilly unique special below zero elsa nature'
    'cloud_snow':
      'unicode': '1f328'
      'shortname': ':cloud_snow:'
      'aliases': ':cloud_with_snow:'
      'keywords': 'cloud with snow weather cold nature'
    'snowman2':
      'unicode': '2603'
      'shortname': ':snowman2:'
      'aliases': ''
      'keywords': 'snowman cold nature snow weather'
    'snowman':
      'unicode': '26c4'
      'shortname': ':snowman:'
      'aliases': ''
      'keywords': 'snowman without snow christmas cold season weather winter xmas nature'
    'wind_blowing_face':
      'unicode': '1f32c'
      'shortname': ':wind_blowing_face:'
      'aliases': ''
      'keywords': 'wind blowing face mother nature blow cloud weather'
    'dash':
      'unicode': '1f4a8'
      'shortname': ':dash:'
      'aliases': ''
      'keywords': 'dash symbol air fast shoo wind comic emotion object person running'
    'cloud_tornado':
      'unicode': '1f32a'
      'shortname': ':cloud_tornado:'
      'aliases': ':cloud_with_tornado:'
      'keywords': 'cloud with tornado weather destruction funnel nature'
    'fog':
      'unicode': '1f32b'
      'shortname': ':fog:'
      'aliases': ''
      'keywords': 'fog weather damp cloud hazy nature'
    'umbrella2':
      'unicode': '2602'
      'shortname': ':umbrella2:'
      'aliases': ''
      'keywords': 'umbrella clothing nature rain weather'
    'umbrella':
      'unicode': '2614'
      'shortname': ':umbrella:'
      'aliases': ''
      'keywords': 'umbrella with rain drops rain weather clothing drop nature'
    'droplet':
      'unicode': '1f4a7'
      'shortname': ':droplet:'
      'aliases': ''
      'keywords': 'droplet drip faucet water drop h20 aqua tear sweat rain moisture wet moist spit cold comic emotion nature object person weather'
    'sweat_drops':
      'unicode': '1f4a6'
      'shortname': ':sweat_drops:'
      'aliases': ''
      'keywords': 'splashing sweat symbol water drops comic emotion object person'
    'ocean':
      'unicode': '1f30a'
      'shortname': ':ocean:'
      'aliases': ''
      'keywords': 'water wave sea ocean surf beach tide nature place weather'
    'green_apple':
      'unicode': '1f34f'
      'shortname': ':green_apple:'
      'aliases': ''
      'keywords': 'green apple fruit nature fruit pie granny smith core food object plant'
    'apple':
      'unicode': '1f34e'
      'shortname': ':apple:'
      'aliases': ''
      'keywords': 'red apple fruit mac electronics doctor teacher school core pie food nature object plant'
    'pear':
      'unicode': '1f350'
      'shortname': ':pear:'
      'aliases': ''
      'keywords': 'pear fruit nature shape food object plant'
    'tangerine':
      'unicode': '1f34a'
      'shortname': ':tangerine:'
      'aliases': ''
      'keywords': 'tangerine food fruit nature citrus orange object plant'
    'lemon':
      'unicode': '1f34b'
      'shortname': ':lemon:'
      'aliases': ''
      'keywords': 'lemon fruit nature yellow citrus food object plant'
    'banana':
      'unicode': '1f34c'
      'shortname': ':banana:'
      'aliases': ''
      'keywords': 'banana food fruit peel bunch nature object plant'
    'watermelon':
      'unicode': '1f349'
      'shortname': ':watermelon:'
      'aliases': ''
      'keywords': 'watermelon food fruit melon summer large nature object plant'
    'grapes':
      'unicode': '1f347'
      'shortname': ':grapes:'
      'aliases': ''
      'keywords': 'grapes food fruit wine vinegar vine grape nature object plant'
    'strawberry':
      'unicode': '1f353'
      'shortname': ':strawberry:'
      'aliases': ''
      'keywords': 'strawberry food fruit nature shortcake berry object plant'
    'melon':
      'unicode': '1f348'
      'shortname': ':melon:'
      'aliases': ''
      'keywords': 'melon food fruit nature cantaloupe honeydew object plant'
    'cherries':
      'unicode': '1f352'
      'shortname': ':cherries:'
      'aliases': ''
      'keywords': 'cherries food fruit cherry tree pit nature object plant'
    'peach':
      'unicode': '1f351'
      'shortname': ':peach:'
      'aliases': ''
      'keywords': 'peach food fruit nature juicy pit object plant'
    'pineapple':
      'unicode': '1f34d'
      'shortname': ':pineapple:'
      'aliases': ''
      'keywords': 'pineapple food fruit nature pina tropical flower object plant'
    'tomato':
      'unicode': '1f345'
      'shortname': ':tomato:'
      'aliases': ''
      'keywords': 'tomato food fruit nature vegetable sauce italian object plant'
    'eggplant':
      'unicode': '1f346'
      'shortname': ':eggplant:'
      'aliases': ''
      'keywords': 'aubergine food nature vegetable eggplant purple penis object plant'
    'hot_pepper':
      'unicode': '1f336'
      'shortname': ':hot_pepper:'
      'aliases': ''
      'keywords': 'hot pepper food nature spicy chili cayenne habanero jalapeno plant'
    'corn':
      'unicode': '1f33d'
      'shortname': ':corn:'
      'aliases': ''
      'keywords': 'ear of maize food plant vegetable corn iowa kernel popcorn husk yellow stalk cob maze nature object'
    'sweet_potato':
      'unicode': '1f360'
      'shortname': ':sweet_potato:'
      'aliases': ''
      'keywords': 'roasted sweet potato food nature potassium starch object restaurant'
    'honey_pot':
      'unicode': '1f36f'
      'shortname': ':honey_pot:'
      'aliases': ''
      'keywords': 'honey pot bees sweet pooh bear food honeypot nature object restaurant'
    'bread':
      'unicode': '1f35e'
      'shortname': ':bread:'
      'aliases': ''
      'keywords': 'bread food toast wheat loaf yeast nature object restaurant'
    'cheese':
      'unicode': '1f9c0'
      'shortname': ':cheese:'
      'aliases': ':cheese_wedge:'
      'keywords': 'cheese wedge'
    'poultry_leg':
      'unicode': '1f357'
      'shortname': ':poultry_leg:'
      'aliases': ''
      'keywords': 'poultry leg food meat chicken fried bone nature object restaurant'
    'meat_on_bone':
      'unicode': '1f356'
      'shortname': ':meat_on_bone:'
      'aliases': ''
      'keywords': 'meat on bone food animal cooked mutton nature object restaurant'
    'fried_shrimp':
      'unicode': '1f364'
      'shortname': ':fried_shrimp:'
      'aliases': ''
      'keywords': 'fried shrimp animal food seafood small fish nature object prawn restaurant tempura'
    'egg':
      'unicode': '1f373'
      'shortname': ':egg:'
      'aliases': ''
      'keywords': 'cooking breakfast food egg fry pan flat cook frying utensil nature object restaurant'
    'hamburger':
      'unicode': '1f354'
      'shortname': ':hamburger:'
      'aliases': ''
      'keywords': 'hamburger food meat burger cow beef angus nature object restaurant'
    'fries':
      'unicode': '1f35f'
      'shortname': ':fries:'
      'aliases': ''
      'keywords': 'french fries chips food potato fry russet idaho nature object restaurant'
    'hotdog':
      'unicode': '1f32d'
      'shortname': ':hotdog:'
      'aliases': ':hot_dog:'
      'keywords': 'hot dog'
    'pizza':
      'unicode': '1f355'
      'shortname': ':pizza:'
      'aliases': ''
      'keywords': 'slice of pizza food party pie new york italian italy pepperoni nature object restaurant'
    'spaghetti':
      'unicode': '1f35d'
      'shortname': ':spaghetti:'
      'aliases': ''
      'keywords': 'spaghetti food italian noodle noodles tomato sauce nature object pasta restaurant'
    'taco':
      'unicode': '1f32e'
      'shortname': ':taco:'
      'aliases': ''
      'keywords': 'taco'
    'burrito':
      'unicode': '1f32f'
      'shortname': ':burrito:'
      'aliases': ''
      'keywords': 'burrito'
    'ramen':
      'unicode': '1f35c'
      'shortname': ':ramen:'
      'aliases': ''
      'keywords': 'steaming bowl chopsticks food japanese noodle ramen noodles soup nature object restaurant'
    'stew':
      'unicode': '1f372'
      'shortname': ':stew:'
      'aliases': ''
      'keywords': 'pot of food meat stew hearty soup thick hot nature object restaurant'
    'fish_cake':
      'unicode': '1f365'
      'shortname': ':fish_cake:'
      'aliases': ''
      'keywords': 'fish cake with swirl design food kamboko ramen noodles naruto nature object pastry restaurant'
    'sushi':
      'unicode': '1f363'
      'shortname': ':sushi:'
      'aliases': ''
      'keywords': 'sushi food japanese fish raw nigiri nature object restaurant'
    'bento':
      'unicode': '1f371'
      'shortname': ':bento:'
      'aliases': ''
      'keywords': 'bento box food japanese rice meal obento convenient lunchbox nature object restaurant'
    'curry':
      'unicode': '1f35b'
      'shortname': ':curry:'
      'aliases': ''
      'keywords': 'curry and rice food hot indian spicy spice flavor meal nature object restaurant'
    'rice_ball':
      'unicode': '1f359'
      'shortname': ':rice_ball:'
      'aliases': ''
      'keywords': 'rice ball food japanese white nori seaweed nature object restaurant'
    'rice':
      'unicode': '1f35a'
      'shortname': ':rice:'
      'aliases': ''
      'keywords': 'cooked rice food white grain bowl nature object restaurant'
    'rice_cracker':
      'unicode': '1f358'
      'shortname': ':rice_cracker:'
      'aliases': ''
      'keywords': 'rice cracker food japanese seaweed nature object restaurant'
    'oden':
      'unicode': '1f362'
      'shortname': ':oden:'
      'aliases': ''
      'keywords': 'oden food japanese seafood casserole stew kebab nature object restaurant skewer stick'
    'dango':
      'unicode': '1f361'
      'shortname': ':dango:'
      'aliases': ''
      'keywords': 'dango food japanese dumpling mochi balls skewer dessert nature object restaurant stick sweet'
    'shaved_ice':
      'unicode': '1f367'
      'shortname': ':shaved_ice:'
      'aliases': ''
      'keywords': 'shaved ice desert dessert treat syrup flavoring food nature object restaurant sweet'
    'ice_cream':
      'unicode': '1f368'
      'shortname': ':ice_cream:'
      'aliases': ''
      'keywords': 'ice cream desert food icecream dairy dessert cold soft serve cone waffle nature object restaurant sweet'
    'icecream':
      'unicode': '1f366'
      'shortname': ':icecream:'
      'aliases': ''
      'keywords': 'soft ice cream desert food icecream dairy dessert cold serve cone yogurt nature object restaurant sweet'
    'cake':
      'unicode': '1f370'
      'shortname': ':cake:'
      'aliases': ''
      'keywords': 'shortcake desert food cake short dessert strawberry nature object pastry restaurant slice sweet'
    'birthday':
      'unicode': '1f382'
      'shortname': ':birthday:'
      'aliases': ''
      'keywords': 'birthday cake party birth dessert wish celebrate celebration food object pastry sweet'
    'custard':
      'unicode': '1f36e'
      'shortname': ':custard:'
      'aliases': ''
      'keywords': 'custard desert food cream rich butter dessert crème brûlée french nature object pudding restaurant sweet'
    'candy':
      'unicode': '1f36c'
      'shortname': ':candy:'
      'aliases': ''
      'keywords': 'candy dessert snack sugar sweet hard food nature object restaurant'
    'lollipop':
      'unicode': '1f36d'
      'shortname': ':lollipop:'
      'aliases': ''
      'keywords': 'lollipop candy food snack sweet stick lick sugar dessert nature object restaurant'
    'chocolate_bar':
      'unicode': '1f36b'
      'shortname': ':chocolate_bar:'
      'aliases': ''
      'keywords': 'chocolate bar dessert food snack candy coca hershey\'s nature object restaurant sweet'
    'popcorn':
      'unicode': '1f37f'
      'shortname': ':popcorn:'
      'aliases': ''
      'keywords': 'popcorn'
    'doughnut':
      'unicode': '1f369'
      'shortname': ':doughnut:'
      'aliases': ''
      'keywords': 'doughnut desert food snack sweet donut pastry fried dessert breakfast police homer sweet nature object restaurant'
    'cookie':
      'unicode': '1f36a'
      'shortname': ':cookie:'
      'aliases': ''
      'keywords': 'cookie chocolate food oreo snack dessert biscuit sweet chocolate nature object restaurant'
    'beer':
      'unicode': '1f37a'
      'shortname': ':beer:'
      'aliases': ''
      'keywords': 'beer mug beverage drink drunk party pub relax hops barley malt yeast portland oregon brewery micro pint boot bar nature object restaurant'
    'beers':
      'unicode': '1f37b'
      'shortname': ':beers:'
      'aliases': ''
      'keywords': 'clinking beer mugs beverage drink drunk party pub relax cheers toast celebrate bar jolly hops clink mug nature object restaurant'
    'wine_glass':
      'unicode': '1f377'
      'shortname': ':wine_glass:'
      'aliases': ''
      'keywords': 'wine glass alcohol beverage booze bottle drink drunk fermented grapes tasting winery bar nature object restaurant'
    'cocktail':
      'unicode': '1f378'
      'shortname': ':cocktail:'
      'aliases': ''
      'keywords': 'cocktail glass alcohol beverage drink drunk mixed martini bar nature object restaurant'
    'tropical_drink':
      'unicode': '1f379'
      'shortname': ':tropical_drink:'
      'aliases': ''
      'keywords': 'tropical drink beverage mixed pineapple coconut pina fruit umbrella bar nature object restaurant'
    'champagne':
      'unicode': '1f37e'
      'shortname': ':champagne:'
      'aliases': ':bottle_with_popping_cork:'
      'keywords': 'bottle with popping cork'
    'sake':
      'unicode': '1f376'
      'shortname': ':sake:'
      'aliases': ''
      'keywords': 'sake bottle and cup beverage drink drunk wine rice ferment alcohol japanese bar nature object restaurant'
    'tea':
      'unicode': '1f375'
      'shortname': ':tea:'
      'aliases': ''
      'keywords': 'teacup without handle bowl breakfast british drink green tea leaf hot beverage cup nature object'
    'coffee':
      'unicode': '2615'
      'shortname': ':coffee:'
      'aliases': ''
      'keywords': 'hot beverage beverage cafe drink espresso coffee nature object steaming tea'
    'baby_bottle':
      'unicode': '1f37c'
      'shortname': ':baby_bottle:'
      'aliases': ''
      'keywords': 'baby bottle container food milk mother nipple newborn formula drink nature object'
    'fork_and_knife':
      'unicode': '1f374'
      'shortname': ':fork_and_knife:'
      'aliases': ''
      'keywords': 'fork and knife cutlery kitchen restaurant meal food eat utensils cooking nature object'
    'fork_knife_plate':
      'unicode': '1f37d'
      'shortname': ':fork_knife_plate:'
      'aliases': ':fork_and_knife_with_plate:'
      'keywords': 'fork and knife with plate meal food breakfast lunch dinner utensils setting cooking object place restaurant'
    'soccer':
      'unicode': '26bd'
      'shortname': ':soccer:'
      'aliases': ''
      'keywords': 'soccer ball sport fifa football european object place'
    'basketball':
      'unicode': '1f3c0'
      'shortname': ':basketball:'
      'aliases': ''
      'keywords': 'basketball and hoop NBA ball sport bball dribble net swish rip city court object place'
    'football':
      'unicode': '1f3c8'
      'shortname': ':football:'
      'aliases': ''
      'keywords': 'american football NFL sport ball america object place'
    'baseball':
      'unicode': '26be'
      'shortname': ':baseball:'
      'aliases': ''
      'keywords': 'baseball MLB ball sport pitch object place'
    'tennis':
      'unicode': '1f3be'
      'shortname': ':tennis:'
      'aliases': ''
      'keywords': 'tennis racquet and ball ball green sport racket game net court love object place'
    'volleyball':
      'unicode': '1f3d0'
      'shortname': ':volleyball:'
      'aliases': ''
      'keywords': 'volleyball'
    'rugby_football':
      'unicode': '1f3c9'
      'shortname': ':rugby_football:'
      'aliases': ''
      'keywords': 'rugby football sports rugby football ball sport team england object place'
    '8ball':
      'unicode': '1f3b1'
      'shortname': ':8ball:'
      'aliases': ''
      'keywords': 'billiards pool eight ball pocket ball cue 8 8 ball ball billiard eight game object place sport'
    'golf':
      'unicode': '26f3'
      'shortname': ':golf:'
      'aliases': ''
      'keywords': 'flag in hole business sport golf object place travel'
    'golfer':
      'unicode': '1f3cc'
      'shortname': ':golfer:'
      'aliases': ''
      'keywords': 'golfer sport par birdie eagle mulligan ball golf person'
    'ping_pong':
      'unicode': '1f3d3'
      'shortname': ':ping_pong:'
      'aliases': ':table_tennis:'
      'keywords': 'table tennis paddle and ball'
    'badminton':
      'unicode': '1f3f8'
      'shortname': ':badminton:'
      'aliases': ''
      'keywords': 'badminton racquet'
    'hockey':
      'unicode': '1f3d2'
      'shortname': ':hockey:'
      'aliases': ''
      'keywords': 'ice hockey stick and puck'
    'field_hockey':
      'unicode': '1f3d1'
      'shortname': ':field_hockey:'
      'aliases': ''
      'keywords': 'field hockey stick and ball'
    'cricket':
      'unicode': '1f3cf'
      'shortname': ':cricket:'
      'aliases': ':cricket_bat_ball:'
      'keywords': 'cricket bat and ball'
    'ski':
      'unicode': '1f3bf'
      'shortname': ':ski:'
      'aliases': ''
      'keywords': 'ski and ski boot cold sport winter downhill cross-country poles snow mountain alpine powder slalom freestyle object'
    'skier':
      'unicode': '26f7'
      'shortname': ':skier:'
      'aliases': ''
      'keywords': 'skier person ski snow sport travel'
    'snowboarder':
      'unicode': '1f3c2'
      'shortname': ':snowboarder:'
      'aliases': ''
      'keywords': 'snowboarder sport winter snow boarding freestyle halfpipe board mountain alpine person ski snowboard'
    'ice_skate':
      'unicode': '26f8'
      'shortname': ':ice_skate:'
      'aliases': ''
      'keywords': 'ice skate place sport travel'
    'bow_and_arrow':
      'unicode': '1f3f9'
      'shortname': ':bow_and_arrow:'
      'aliases': ':archery:'
      'keywords': 'bow and arrow'
    'fishing_pole_and_fish':
      'unicode': '1f3a3'
      'shortname': ':fishing_pole_and_fish:'
      'aliases': ''
      'keywords': 'fishing pole and fish food hobby rod reel entertainment object place sport'
    'rowboat':
      'unicode': '1f6a3'
      'shortname': ':rowboat:'
      'aliases': ''
      'keywords': 'rowboat hobby ship water boat row oar paddle place travel vehicle'
    'swimmer':
      'unicode': '1f3ca'
      'shortname': ':swimmer:'
      'aliases': ''
      'keywords': 'swimmer sport swim water pool laps freestyle butterfly breaststroke backstroke person travel'
    'surfer':
      'unicode': '1f3c4'
      'shortname': ':surfer:'
      'aliases': ''
      'keywords': 'surfer ocean sea sport surf wave ocean ride swell person surfing'
    'bath':
      'unicode': '1f6c0'
      'shortname': ':bath:'
      'aliases': ''
      'keywords': 'bath shower tub basin wash bubble soak bathroom soap water clean shampoo lather bathtub object place travel'
    'basketball_player':
      'unicode': '26f9'
      'shortname': ':basketball_player:'
      'aliases': ':person_with_ball:'
      'keywords': 'person with ball sport travel'
    'lifter':
      'unicode': '1f3cb'
      'shortname': ':lifter:'
      'aliases': ':weight_lifter:'
      'keywords': 'weight lifter bench press squats deadlift person sport'
    'bicyclist':
      'unicode': '1f6b4'
      'shortname': ':bicyclist:'
      'aliases': ''
      'keywords': 'bicyclist bike exercise hipster sport road pedal bicycle transportation cyclist person place travel'
    'mountain_bicyclist':
      'unicode': '1f6b5'
      'shortname': ':mountain_bicyclist:'
      'aliases': ''
      'keywords': 'mountain bicyclist sport transportation bike pedal bicycle transportation cyclist person place travel'
    'horse_racing':
      'unicode': '1f3c7'
      'shortname': ':horse_racing:'
      'aliases': ''
      'keywords': 'horse racing animal betting competition race jockey triple crown person racehorse sport travel'
    'levitate':
      'unicode': '1f574'
      'shortname': ':levitate:'
      'aliases': ':man_in_business_suit_levitating:'
      'keywords': 'man in business suit levitating hover exclamation person'
    'trophy':
      'unicode': '1f3c6'
      'shortname': ':trophy:'
      'aliases': ''
      'keywords': 'trophy award ceremony contest ftw place win first show reward achievement medal object prize sport'
    'running_shirt_with_sash':
      'unicode': '1f3bd'
      'shortname': ':running_shirt_with_sash:'
      'aliases': ''
      'keywords': 'running shirt with sash pageant play run cloths compete sports person place sport'
    'medal':
      'unicode': '1f3c5'
      'shortname': ':medal:'
      'aliases': ':sports_medal:'
      'keywords': 'sports medal award ceremony contest ftw place win first show reward achievement object sport'
    'military_medal':
      'unicode': '1f396'
      'shortname': ':military_medal:'
      'aliases': ''
      'keywords': 'military medal honor acknowledgment purple heart heroism veteran celebration object'
    'reminder_ribbon':
      'unicode': '1f397'
      'shortname': ':reminder_ribbon:'
      'aliases': ''
      'keywords': 'reminder ribbon awareness celebration object'
    'rosette':
      'unicode': '1f3f5'
      'shortname': ':rosette:'
      'aliases': ''
      'keywords': 'rosette flower nature plant'
    'ticket':
      'unicode': '1f3ab'
      'shortname': ':ticket:'
      'aliases': ''
      'keywords': 'ticket concert event pass show entertainment stub admission proof purchase activity object place'
    'tickets':
      'unicode': '1f39f'
      'shortname': ':tickets:'
      'aliases': ':admission_tickets:'
      'keywords': 'admission tickets concert event pass show entertainment stub proof purchase object ticket'
    'performing_arts':
      'unicode': '1f3ad'
      'shortname': ':performing_arts:'
      'aliases': ''
      'keywords': 'performing arts acting drama theater performance entertainment story comedy tragedy masks activity art mask object place theatre'
    'art':
      'unicode': '1f3a8'
      'shortname': ':art:'
      'aliases': ''
      'keywords': 'artist palette design draw paint art colors brush pastels oils acrylic activity entertainment museum object painting'
    'circus_tent':
      'unicode': '1f3aa'
      'shortname': ':circus_tent:'
      'aliases': ''
      'keywords': 'circus tent carnival festival party event big top canvas activity entertainment place'
    'microphone':
      'unicode': '1f3a4'
      'shortname': ':microphone:'
      'aliases': ''
      'keywords': 'microphone PA music sound mic audio voice karaoke activity entertainment object'
    'headphones':
      'unicode': '1f3a7'
      'shortname': ':headphones:'
      'aliases': ''
      'keywords': 'headphone gadgets music score sound ears beats buds audio listen activity earbud entertainment object'
    'musical_score':
      'unicode': '1f3bc'
      'shortname': ':musical_score:'
      'aliases': ''
      'keywords': 'musical score clef treble music clef g-clef stave staff activity entertainment object sound'
    'musical_keyboard':
      'unicode': '1f3b9'
      'shortname': ':musical_keyboard:'
      'aliases': ''
      'keywords': 'musical keyboard instrument piano music organ electric keys activity entertainment object sound'
    'saxophone':
      'unicode': '1f3b7'
      'shortname': ':saxophone:'
      'aliases': ''
      'keywords': 'saxophone instrument music sax woodwind activity entertainment object sound'
    'trumpet':
      'unicode': '1f3ba'
      'shortname': ':trumpet:'
      'aliases': ''
      'keywords': 'trumpet brass music instrument activity entertainment object sound'
    'guitar':
      'unicode': '1f3b8'
      'shortname': ':guitar:'
      'aliases': ''
      'keywords': 'guitar instrument music string jam rock acoustic electric activity entertainment object sound'
    'violin':
      'unicode': '1f3bb'
      'shortname': ':violin:'
      'aliases': ''
      'keywords': 'violin instrument music fiddle string activity entertainment object sound'
    'clapper':
      'unicode': '1f3ac'
      'shortname': ':clapper:'
      'aliases': ''
      'keywords': 'clapper board film movie record clapboard take activity entertainment object'
    'video_game':
      'unicode': '1f3ae'
      'shortname': ':video_game:'
      'aliases': ''
      'keywords': 'video game PS4 console controller play nintendo xbox playstation entertainment object video game'
    'space_invader':
      'unicode': '1f47e'
      'shortname': ':space_invader:'
      'aliases': ''
      'keywords': 'alien monster arcade game space invader creature extraterrestrial face fairy tale fantasy nature person ufo'
    'dart':
      'unicode': '1f3af'
      'shortname': ':dart:'
      'aliases': ''
      'keywords': 'direct hit bar game bullseye dart archery fletching arrow sport activity bull entertainment eye object target'
    'game_die':
      'unicode': '1f3b2'
      'shortname': ':game_die:'
      'aliases': ''
      'keywords': 'game die dice craps gamble play entertainment object'
    'slot_machine':
      'unicode': '1f3b0'
      'shortname': ':slot_machine:'
      'aliases': ''
      'keywords': 'slot machine bet gamble vegas one-armed bandit slots luck activity game object place'
    'bowling':
      'unicode': '1f3b3'
      'shortname': ':bowling:'
      'aliases': ''
      'keywords': 'bowling fun play sports bowl ball pin strike spare game object place sport'
    'red_car':
      'unicode': '1f697'
      'shortname': ':red_car:'
      'aliases': ''
      'keywords': 'automobile transportation vehicle red car place travel'
    'taxi':
      'unicode': '1f695'
      'shortname': ':taxi:'
      'aliases': ''
      'keywords': 'taxi transportation uber vehicle car automobile city transport service cab place travel'
    'blue_car':
      'unicode': '1f699'
      'shortname': ':blue_car:'
      'aliases': ''
      'keywords': 'recreational vehicle car suv wagon automobile blue place rv travel'
    'bus':
      'unicode': '1f68c'
      'shortname': ':bus:'
      'aliases': ''
      'keywords': 'bus car transportation vehicle school city public place travel'
    'trolleybus':
      'unicode': '1f68e'
      'shortname': ':trolleybus:'
      'aliases': ''
      'keywords': 'trolleybus bart transportation vehicle bus city transport place tram travel trolley'
    'race_car':
      'unicode': '1f3ce'
      'shortname': ':race_car:'
      'aliases': ':racing_car:'
      'keywords': 'racing car formula 1 race stock nascar speed drive place sport travel'
    'police_car':
      'unicode': '1f693'
      'shortname': ':police_car:'
      'aliases': ''
      'keywords': 'police car cars enforcement law transportation vehicle police car emergency ticket citation crime help officer patrol place travel'
    'ambulance':
      'unicode': '1f691'
      'shortname': ':ambulance:'
      'aliases': ''
      'keywords': 'ambulance 911 health emergency medical help assistance place travel vehicle'
    'fire_engine':
      'unicode': '1f692'
      'shortname': ':fire_engine:'
      'aliases': ''
      'keywords': 'fire engine transportation vehicle fighter truck emergency place travel'
    'minibus':
      'unicode': '1f690'
      'shortname': ':minibus:'
      'aliases': ''
      'keywords': 'minibus transportation vehicle bus city transport place travel'
    'truck':
      'unicode': '1f69a'
      'shortname': ':truck:'
      'aliases': ''
      'keywords': 'delivery truck transportation truck delivery package place travel vehicle'
    'articulated_lorry':
      'unicode': '1f69b'
      'shortname': ':articulated_lorry:'
      'aliases': ''
      'keywords': 'articulated lorry transportation vehicle truck delivery semi place travel'
    'tractor':
      'unicode': '1f69c'
      'shortname': ':tractor:'
      'aliases': ''
      'keywords': 'tractor agriculture farming vehicle farm construction equipment place travel'
    'motorcycle':
      'unicode': '1f3cd'
      'shortname': ':motorcycle:'
      'aliases': ':racing_motorcycle:'
      'keywords': 'racing motorcycle bike speed person sport travel'
    'bike':
      'unicode': '1f6b2'
      'shortname': ':bike:'
      'aliases': ''
      'keywords': 'bicycle exercise hipster sports bike pedal transportation place sport travel vehicle'
    'rotating_light':
      'unicode': '1f6a8'
      'shortname': ':rotating_light:'
      'aliases': ''
      'keywords': 'police cars revolving light 911 ambulance emergency police light emergency beacon car place travel vehicle'
    'oncoming_police_car':
      'unicode': '1f694'
      'shortname': ':oncoming_police_car:'
      'aliases': ''
      'keywords': 'oncoming police car enforcement law vehicle emergency ticket citation crime help officer place travel'
    'oncoming_bus':
      'unicode': '1f68d'
      'shortname': ':oncoming_bus:'
      'aliases': ''
      'keywords': 'oncoming bus transportation vehicle bus school city public place travel'
    'oncoming_automobile':
      'unicode': '1f698'
      'shortname': ':oncoming_automobile:'
      'aliases': ''
      'keywords': 'oncoming automobile car transportation vehicle sedan car automobile place travel'
    'oncoming_taxi':
      'unicode': '1f696'
      'shortname': ':oncoming_taxi:'
      'aliases': ''
      'keywords': 'oncoming taxi uber vehicle car automobile city transport service cab place travel'
    'aerial_tramway':
      'unicode': '1f6a1'
      'shortname': ':aerial_tramway:'
      'aliases': ''
      'keywords': 'aerial tramway transportation vehicle tram cable transport car gondola place ropeway travel'
    'mountain_cableway':
      'unicode': '1f6a0'
      'shortname': ':mountain_cableway:'
      'aliases': ''
      'keywords': 'mountain cableway transportation vehicle cable gondola place travel'
    'suspension_railway':
      'unicode': '1f69f'
      'shortname': ':suspension_railway:'
      'aliases': ''
      'keywords': 'suspension railway transportation vehicle rail place travel'
    'railway_car':
      'unicode': '1f683'
      'shortname': ':railway_car:'
      'aliases': ''
      'keywords': 'railway car transportation vehicle streetcar trolley coach train electric place tram travel trolleybus'
    'train':
      'unicode': '1f68b'
      'shortname': ':train:'
      'aliases': ''
      'keywords': 'tram car rail train transit vehicle place travel trolleybus'
    'monorail':
      'unicode': '1f69d'
      'shortname': ':monorail:'
      'aliases': ''
      'keywords': 'monorail transportation train mono rail transit place travel vehicle'
    'bullettrain_side':
      'unicode': '1f684'
      'shortname': ':bullettrain_side:'
      'aliases': ''
      'keywords': 'high-speed train transportation train bullet rail fast transit place railway shinkansen speed travel vehicle'
    'bullettrain_front':
      'unicode': '1f685'
      'shortname': ':bullettrain_front:'
      'aliases': ''
      'keywords': 'high-speed train with bullet nose transportation train bullet rail fast transit place railway shinkansen speed travel vehicle'
    'light_rail':
      'unicode': '1f688'
      'shortname': ':light_rail:'
      'aliases': ''
      'keywords': 'light rail transportation train transit place railway travel vehicle'
    'mountain_railway':
      'unicode': '1f69e'
      'shortname': ':mountain_railway:'
      'aliases': ''
      'keywords': 'mountain railway transportation vehicle rail train transport car place travel'
    'steam_locomotive':
      'unicode': '1f682'
      'shortname': ':steam_locomotive:'
      'aliases': ''
      'keywords': 'steam locomotive train transportation engine choo-choo place railway travel vehicle'
    'train2':
      'unicode': '1f686'
      'shortname': ':train2:'
      'aliases': ''
      'keywords': 'train transportation locomotive rail transit vehicle place railway travel'
    'metro':
      'unicode': '1f687'
      'shortname': ':metro:'
      'aliases': ''
      'keywords': 'metro mrt transportation tube underground subway train railway transit place travel vehicle'
    'tram':
      'unicode': '1f68a'
      'shortname': ':tram:'
      'aliases': ''
      'keywords': 'tram transportation vehicle streetcar trolley transit place travel trolleybus'
    'station':
      'unicode': '1f689'
      'shortname': ':station:'
      'aliases': ''
      'keywords': 'station public transportation train subway transit place railway travel vehicle'
    'helicopter':
      'unicode': '1f681'
      'shortname': ':helicopter:'
      'aliases': ''
      'keywords': 'helicopter transportation vehicle heli gyro gyrocopter place travel'
    'airplane_small':
      'unicode': '1f6e9'
      'shortname': ':airplane_small:'
      'aliases': ':small_airplane:'
      'keywords': 'small airplane flight transportation vehicle plane airport travel airlines fly jet jumbo boeing airbus place'
    'airplane':
      'unicode': '2708'
      'shortname': ':airplane:'
      'aliases': ''
      'keywords': 'airplane flight transportation vehicle plane airport travel airlines fly jet jumbo boeing airbus place'
    'airplane_departure':
      'unicode': '1f6eb'
      'shortname': ':airplane_departure:'
      'aliases': ''
      'keywords': 'airplane departure flight transportation vehicle plane airport travel airlines fly jet jumbo boeing airbus leaving check-in departures place'
    'airplane_arriving':
      'unicode': '1f6ec'
      'shortname': ':airplane_arriving:'
      'aliases': ''
      'keywords': 'airplane arriving flight transportation vehicle plane airport travel airlines fly jet jumbo boeing airbus arrivals landing place'
    'sailboat':
      'unicode': '26f5'
      'shortname': ':sailboat:'
      'aliases': ''
      'keywords': 'sailboat transportation cutter catboat dinghy ketch schooner sloop yawl boat place resort sea travel vehicle yacht'
    'motorboat':
      'unicode': '1f6e5'
      'shortname': ':motorboat:'
      'aliases': ''
      'keywords': 'motorboat transportation vehicle boat speedboat powerboat place travel'
    'speedboat':
      'unicode': '1f6a4'
      'shortname': ':speedboat:'
      'aliases': ''
      'keywords': 'speedboat transportation vehicle motorboat powerboat boat place travel'
    'ferry':
      'unicode': '26f4'
      'shortname': ':ferry:'
      'aliases': ''
      'keywords': 'ferry boat place travel'
    'cruise_ship':
      'unicode': '1f6f3'
      'shortname': ':cruise_ship:'
      'aliases': ':passenger_ship:'
      'keywords': 'passenger ship titanic transportation boat place travel vehicle'
    'rocket':
      'unicode': '1f680'
      'shortname': ':rocket:'
      'aliases': ''
      'keywords': 'rocket launch ship staffmode space spacecraft astronaut cosmonaut place travel vehicle'
    'satellite_orbital':
      'unicode': '1f6f0'
      'shortname': ':satellite_orbital:'
      'aliases': ''
      'keywords': 'satellite communication orbital space place vehicle'
    'seat':
      'unicode': '1f4ba'
      'shortname': ':seat:'
      'aliases': ''
      'keywords': 'seat sit chair object office place travel'
    'anchor':
      'unicode': '2693'
      'shortname': ':anchor:'
      'aliases': ''
      'keywords': 'anchor ferry ship boat ocean harbor marina shipyard sailor tattoo place tool travel'
    'construction':
      'unicode': '1f6a7'
      'shortname': ':construction:'
      'aliases': ''
      'keywords': 'construction sign caution progress wip barrier place travel'
    'fuelpump':
      'unicode': '26fd'
      'shortname': ':fuelpump:'
      'aliases': ''
      'keywords': 'fuel pump gas station petroleum diesel fuelpump place travel'
    'busstop':
      'unicode': '1f68f'
      'shortname': ':busstop:'
      'aliases': ''
      'keywords': 'bus stop transportation city public busstop place travel'
    'vertical_traffic_light':
      'unicode': '1f6a6'
      'shortname': ':vertical_traffic_light:'
      'aliases': ''
      'keywords': 'vertical traffic light transportation stop go yield sign place signal travel'
    'traffic_light':
      'unicode': '1f6a5'
      'shortname': ':traffic_light:'
      'aliases': ''
      'keywords': 'horizontal traffic light transportation stop go yield sign place signal travel'
    'checkered_flag':
      'unicode': '1f3c1'
      'shortname': ':checkered_flag:'
      'aliases': ''
      'keywords': 'chequered flag contest finishline gokart checkered race flag finish complete end object place racing sport'
    'ship':
      'unicode': '1f6a2'
      'shortname': ':ship:'
      'aliases': ''
      'keywords': 'ship titanic transportation ferry boat yacht place travel vehicle'
    'ferris_wheel':
      'unicode': '1f3a1'
      'shortname': ':ferris_wheel:'
      'aliases': ''
      'keywords': 'ferris wheel carnival londoneye farris amusement park fair ride entertainment activity amusement park place'
    'roller_coaster':
      'unicode': '1f3a2'
      'shortname': ':roller_coaster:'
      'aliases': ''
      'keywords': 'roller coaster carnival fun playground amusement park fair ride entertainment activity amusement park place'
    'carousel_horse':
      'unicode': '1f3a0'
      'shortname': ':carousel_horse:'
      'aliases': ''
      'keywords': 'carousel horse carnival amusement park ride entertainment fair activity place'
    'construction_site':
      'unicode': '1f3d7'
      'shortname': ':construction_site:'
      'aliases': ':building_construction:'
      'keywords': 'building construction site work place'
    'foggy':
      'unicode': '1f301'
      'shortname': ':foggy:'
      'aliases': ''
      'keywords': 'foggy mountain bridge weather fog nature place'
    'tokyo_tower':
      'unicode': '1f5fc'
      'shortname': ':tokyo_tower:'
      'aliases': ''
      'keywords': 'tokyo tower japan place'
    'factory':
      'unicode': '1f3ed'
      'shortname': ':factory:'
      'aliases': ''
      'keywords': 'factory building production manufacturing place'
    'fountain':
      'unicode': '26f2'
      'shortname': ':fountain:'
      'aliases': ''
      'keywords': 'fountain water display art feature decor architecture object place'
    'rice_scene':
      'unicode': '1f391'
      'shortname': ':rice_scene:'
      'aliases': ''
      'keywords': 'moon viewing ceremony observing otsukimi tsukimi rice scene festival autumn activity celebration entertainment nature object'
    'mountain':
      'unicode': '26f0'
      'shortname': ':mountain:'
      'aliases': ''
      'keywords': 'mountain place'
    'mountain_snow':
      'unicode': '1f3d4'
      'shortname': ':mountain_snow:'
      'aliases': ':snow_capped_mountain:'
      'keywords': 'snow capped mountain cold elevation hiking peak nature place'
    'mount_fuji':
      'unicode': '1f5fb'
      'shortname': ':mount_fuji:'
      'aliases': ''
      'keywords': 'mount fuji japan mountain nature peak place'
    'volcano':
      'unicode': '1f30b'
      'shortname': ':volcano:'
      'aliases': ''
      'keywords': 'volcano nature volcano lava magma hot explode eruption mountain place weather'
    'japan':
      'unicode': '1f5fe'
      'shortname': ':japan:'
      'aliases': ''
      'keywords': 'silhouette of japan nation island map place'
    'camping':
      'unicode': '1f3d5'
      'shortname': ':camping:'
      'aliases': ''
      'keywords': 'camping outdoors nature wilderness roughing activity place'
    'tent':
      'unicode': '26fa'
      'shortname': ':tent:'
      'aliases': ''
      'keywords': 'tent camp outdoors pup camping object place'
    'park':
      'unicode': '1f3de'
      'shortname': ':park:'
      'aliases': ':national_park:'
      'keywords': 'national park woods nature wildlife forest wilderness national national park place'
    'motorway':
      'unicode': '1f6e3'
      'shortname': ':motorway:'
      'aliases': ''
      'keywords': 'motorway road highway freeway traffic travel place'
    'railway_track':
      'unicode': '1f6e4'
      'shortname': ':railway_track:'
      'aliases': ':railroad_track:'
      'keywords': 'railway track train trolley subway locomotive transit place travel'
    'sunrise':
      'unicode': '1f305'
      'shortname': ':sunrise:'
      'aliases': ''
      'keywords': 'sunrise morning vacation view sun morning color sky nature place time weather'
    'sunrise_over_mountains':
      'unicode': '1f304'
      'shortname': ':sunrise_over_mountains:'
      'aliases': ''
      'keywords': 'sunrise over mountains vacation view sun morning rural color sky mountain nature place time weather'
    'desert':
      'unicode': '1f3dc'
      'shortname': ':desert:'
      'aliases': ''
      'keywords': 'desert hot dry sandy cactus sunny barren nature place'
    'beach':
      'unicode': '1f3d6'
      'shortname': ':beach:'
      'aliases': ':beach_with_umbrella:'
      'keywords': 'beach with umbrella sand sun surf vacation relaxation tanning tan swimming nature place'
    'island':
      'unicode': '1f3dd'
      'shortname': ':island:'
      'aliases': ':desert_island:'
      'keywords': 'desert island land solitude alone nature place'
    'city_sunset':
      'unicode': '1f307'
      'shortname': ':city_sunset:'
      'aliases': ':city_sunrise:'
      'keywords': 'sunset over buildings city scape light metropolitan rise sun dusk evening building nature place time weather'
    'city_dusk':
      'unicode': '1f306'
      'shortname': ':city_dusk:'
      'aliases': ''
      'keywords': 'cityscape at dusk city scape sunset lights evening metropolitan night dark building landscape nature place sun time weather'
    'cityscape':
      'unicode': '1f3d9'
      'shortname': ':cityscape:'
      'aliases': ''
      'keywords': 'cityscape skyscraper city view lights buildings metropolis building place'
    'night_with_stars':
      'unicode': '1f303'
      'shortname': ':night_with_stars:'
      'aliases': ''
      'keywords': 'night with stars cloudless evening planets space sky nature place star weather'
    'bridge_at_night':
      'unicode': '1f309'
      'shortname': ':bridge_at_night:'
      'aliases': ''
      'keywords': 'bridge at night san francisco water road evening suspension golden nature place weather'
    'milky_way':
      'unicode': '1f30c'
      'shortname': ':milky_way:'
      'aliases': ''
      'keywords': 'milky way outer space galaxy stars planets sky milky way nature place weather'
    'stars':
      'unicode': '1f320'
      'shortname': ':stars:'
      'aliases': ''
      'keywords': 'shooting star night shoot sky comet meteoroid activity falling nature place space'
    'sparkler':
      'unicode': '1f387'
      'shortname': ':sparkler:'
      'aliases': ''
      'keywords': 'firework sparkler night shine stars activity celebration entertainment fireworks object sparkle'
    'fireworks':
      'unicode': '1f386'
      'shortname': ':fireworks:'
      'aliases': ''
      'keywords': 'fireworks carnival congratulations festival independence celebration explosion july 4th rocket sky idea excitement activity entertainment object'
    'rainbow':
      'unicode': '1f308'
      'shortname': ':rainbow:'
      'aliases': ''
      'keywords': 'rainbow happy nature sky unicorn color pride diversity spectrum refract leprechaun gold rain weather'
    'homes':
      'unicode': '1f3d8'
      'shortname': ':homes:'
      'aliases': ':house_buildings:'
      'keywords': 'house buildings home residence dwelling mansion bungalow ranch craftsman building place'
    'european_castle':
      'unicode': '1f3f0'
      'shortname': ':european_castle:'
      'aliases': ''
      'keywords': 'european castle building history residence royalty disneyland disney fort fortified moat tower princess prince lord king queen fortress nobel stronghold place'
    'japanese_castle':
      'unicode': '1f3ef'
      'shortname': ':japanese_castle:'
      'aliases': ''
      'keywords': 'japanese castle building residence royalty fort fortified fortress history place'
    'stadium':
      'unicode': '1f3df'
      'shortname': ':stadium:'
      'aliases': ''
      'keywords': 'stadium sport event concert convention game place'
    'statue_of_liberty':
      'unicode': '1f5fd'
      'shortname': ':statue_of_liberty:'
      'aliases': ''
      'keywords': 'statue of liberty american new york staten island place'
    'house':
      'unicode': '1f3e0'
      'shortname': ':house:'
      'aliases': ''
      'keywords': 'house building home residence dwelling mansion bungalow ranch craftsman place'
    'house_with_garden':
      'unicode': '1f3e1'
      'shortname': ':house_with_garden:'
      'aliases': ''
      'keywords': 'house with garden home nature plant yard residence dwelling mansion bungalow ranch craftsman building place'
    'house_abandoned':
      'unicode': '1f3da'
      'shortname': ':house_abandoned:'
      'aliases': ':derelict_house_building:'
      'keywords': 'derelict house building home residence dwelling mansion bungalow ranch craftsman boarded abandoned vacant run down shoddy place'
    'office':
      'unicode': '1f3e2'
      'shortname': ':office:'
      'aliases': ''
      'keywords': 'office building building bureau work place'
    'department_store':
      'unicode': '1f3ec'
      'shortname': ':department_store:'
      'aliases': ''
      'keywords': 'department store building mall shopping retail sale merchandise place'
    'post_office':
      'unicode': '1f3e3'
      'shortname': ':post_office:'
      'aliases': ''
      'keywords': 'japanese post office building letter shipping package mail place'
    'european_post_office':
      'unicode': '1f3e4'
      'shortname': ':european_post_office:'
      'aliases': ''
      'keywords': 'european post office building letter shipping package mail place'
    'hospital':
      'unicode': '1f3e5'
      'shortname': ':hospital:'
      'aliases': ''
      'keywords': 'hospital building doctor health surgery medicine place'
    'bank':
      'unicode': '1f3e6'
      'shortname': ':bank:'
      'aliases': ''
      'keywords': 'bank building money savings loan place'
    'hotel':
      'unicode': '1f3e8'
      'shortname': ':hotel:'
      'aliases': ''
      'keywords': 'hotel accomodation building checkin motel holiday inn place'
    'convenience_store':
      'unicode': '1f3ea'
      'shortname': ':convenience_store:'
      'aliases': ''
      'keywords': 'convenience store building bodega 7-eleven corner place'
    'school':
      'unicode': '1f3eb'
      'shortname': ':school:'
      'aliases': ''
      'keywords': 'school building university elementary middle high college teach education place'
    'love_hotel':
      'unicode': '1f3e9'
      'shortname': ':love_hotel:'
      'aliases': ''
      'keywords': 'love hotel affection dating like sex romance leisure adultery prostitution happy no-tell building place'
    'wedding':
      'unicode': '1f492'
      'shortname': ':wedding:'
      'aliases': ''
      'keywords': 'wedding affection bride couple groom like love marriage union activity chapel place romance'
    'classical_building':
      'unicode': '1f3db'
      'shortname': ':classical_building:'
      'aliases': ''
      'keywords': 'classical building government architecture history iconic genre place'
    'church':
      'unicode': '26ea'
      'shortname': ':church:'
      'aliases': ''
      'keywords': 'church building christ religion christian cross place'
    'mosque':
      'unicode': '1f54c'
      'shortname': ':mosque:'
      'aliases': ''
      'keywords': 'mosque'
    'synagogue':
      'unicode': '1f54d'
      'shortname': ':synagogue:'
      'aliases': ''
      'keywords': 'synagogue'
    'kaaba':
      'unicode': '1f54b'
      'shortname': ':kaaba:'
      'aliases': ''
      'keywords': 'kaaba'
    'shinto_shrine':
      'unicode': '26e9'
      'shortname': ':shinto_shrine:'
      'aliases': ''
      'keywords': 'shinto shrine religion symbol'
    'watch':
      'unicode': '231a'
      'shortname': ':watch:'
      'aliases': ''
      'keywords': 'watch accessories time gadget clock object'
    'iphone':
      'unicode': '1f4f1'
      'shortname': ':iphone:'
      'aliases': ''
      'keywords': 'mobile phone apple dial gadget technology iphone call cell communication object telephone'
    'calling':
      'unicode': '1f4f2'
      'shortname': ':calling:'
      'aliases': ''
      'keywords': 'mobile phone with rightwards arrow at left incoming iphone call cell communication object receive telephone'
    'computer':
      'unicode': '1f4bb'
      'shortname': ':computer:'
      'aliases': ''
      'keywords': 'personal computer laptop tech object office pc'
    'keyboard':
      'unicode': '2328'
      'shortname': ':keyboard:'
      'aliases': ''
      'keywords': 'keyboard typing keys input device computer object sign'
    'desktop':
      'unicode': '1f5a5'
      'shortname': ':desktop:'
      'aliases': ':desktop_computer:'
      'keywords': 'desktop computer cpu object office'
    'printer':
      'unicode': '1f5a8'
      'shortname': ':printer:'
      'aliases': ''
      'keywords': 'printer hardcopy paper inkjet laser computer object office'
    'mouse_three_button':
      'unicode': '1f5b1'
      'shortname': ':mouse_three_button:'
      'aliases': ':three_button_mouse:'
      'keywords': 'three button mouse 3 computer object office'
    'trackball':
      'unicode': '1f5b2'
      'shortname': ':trackball:'
      'aliases': ''
      'keywords': 'trackball input device gadget computer object office'
    'joystick':
      'unicode': '1f579'
      'shortname': ':joystick:'
      'aliases': ''
      'keywords': 'joystick games atari controller entertainment game object video game'
    'compression':
      'unicode': '1f5dc'
      'shortname': ':compression:'
      'aliases': ''
      'keywords': 'compression reduce object tool vice'
    'minidisc':
      'unicode': '1f4bd'
      'shortname': ':minidisc:'
      'aliases': ''
      'keywords': 'minidisc data disc disk record technology computer entertainment minidisk object office optical'
    'floppy_disk':
      'unicode': '1f4be'
      'shortname': ':floppy_disk:'
      'aliases': ''
      'keywords': 'floppy disk oldschool save technology storage information computer drive kilobyte object office'
    'cd':
      'unicode': '1f4bf'
      'shortname': ':cd:'
      'aliases': ''
      'keywords': 'optical disc disc disk dvd technology blu-ray cd computer object office'
    'dvd':
      'unicode': '1f4c0'
      'shortname': ':dvd:'
      'aliases': ''
      'keywords': 'dvd cd disc disk technology blu-ray computer entertainment object office optical'
    'vhs':
      'unicode': '1f4fc'
      'shortname': ':vhs:'
      'aliases': ''
      'keywords': 'videocassette oldschool record video entertainment object tape vhs'
    'camera':
      'unicode': '1f4f7'
      'shortname': ':camera:'
      'aliases': ''
      'keywords': 'camera gadget photo picture entertainment object video'
    'camera_with_flash':
      'unicode': '1f4f8'
      'shortname': ':camera_with_flash:'
      'aliases': ''
      'keywords': 'camera with flash photo picture object video'
    'video_camera':
      'unicode': '1f4f9'
      'shortname': ':video_camera:'
      'aliases': ''
      'keywords': 'video camera film record camcorder entertainment object'
    'movie_camera':
      'unicode': '1f3a5'
      'shortname': ':movie_camera:'
      'aliases': ''
      'keywords': 'movie camera film record video motion picture activity cinema entertainment object'
    'projector':
      'unicode': '1f4fd'
      'shortname': ':projector:'
      'aliases': ':film_projector:'
      'keywords': 'film projector movie video motion picture 8mm 16mm cinema entertainment object'
    'film_frames':
      'unicode': '1f39e'
      'shortname': ':film_frames:'
      'aliases': ''
      'keywords': 'film frames movie record 8mm 16mm reel celluloid cinema entertainment object'
    'telephone_receiver':
      'unicode': '1f4de'
      'shortname': ':telephone_receiver:'
      'aliases': ''
      'keywords': 'telephone receiver communication dial technology phone object sound'
    'telephone':
      'unicode': '260e'
      'shortname': ':telephone:'
      'aliases': ''
      'keywords': 'black telephone communication dial technology phone object office sound'
    'pager':
      'unicode': '1f4df'
      'shortname': ':pager:'
      'aliases': ''
      'keywords': 'pager bbcall oldschool communication object office'
    'fax':
      'unicode': '1f4e0'
      'shortname': ':fax:'
      'aliases': ''
      'keywords': 'fax machine communication technology object office'
    'tv':
      'unicode': '1f4fa'
      'shortname': ':tv:'
      'aliases': ''
      'keywords': 'television oldschool program show technology tv entertainment object video'
    'radio':
      'unicode': '1f4fb'
      'shortname': ':radio:'
      'aliases': ''
      'keywords': 'radio communication music podcast program entertainment object video'
    'microphone2':
      'unicode': '1f399'
      'shortname': ':microphone2:'
      'aliases': ':studio_microphone:'
      'keywords': 'studio microphone mic audio recording music object sound'
    'level_slider':
      'unicode': '1f39a'
      'shortname': ':level_slider:'
      'aliases': ''
      'keywords': 'level slider controls music object sound'
    'control_knobs':
      'unicode': '1f39b'
      'shortname': ':control_knobs:'
      'aliases': ''
      'keywords': 'control knobs dial music object sound'
    'stopwatch':
      'unicode': '23f1'
      'shortname': ':stopwatch:'
      'aliases': ''
      'keywords': 'stopwatch clock object time'
    'timer':
      'unicode': '23f2'
      'shortname': ':timer:'
      'aliases': ':timer_clock:'
      'keywords': 'timer clock object time'
    'alarm_clock':
      'unicode': '23f0'
      'shortname': ':alarm_clock:'
      'aliases': ''
      'keywords': 'alarm clock time wake object'
    'clock':
      'unicode': '1f570'
      'shortname': ':clock:'
      'aliases': ':mantlepiece_clock:'
      'keywords': 'mantlepiece clock time object'
    'hourglass_flowing_sand':
      'unicode': '23f3'
      'shortname': ':hourglass_flowing_sand:'
      'aliases': ''
      'keywords': 'hourglass with flowing sand countdown oldschool time object timer'
    'hourglass':
      'unicode': '231b'
      'shortname': ':hourglass:'
      'aliases': ''
      'keywords': 'hourglass clock oldschool time object sand timer'
    'satellite':
      'unicode': '1f4e1'
      'shortname': ':satellite:'
      'aliases': ''
      'keywords': 'satellite antenna communication dish object office'
    'battery':
      'unicode': '1f50b'
      'shortname': ':battery:'
      'aliases': ''
      'keywords': 'battery energy power sustain object'
    'electric_plug':
      'unicode': '1f50c'
      'shortname': ':electric_plug:'
      'aliases': ''
      'keywords': 'electric plug charger power electricity object'
    'bulb':
      'unicode': '1f4a1'
      'shortname': ':bulb:'
      'aliases': ''
      'keywords': 'electric light bulb electricity idea comic object'
    'flashlight':
      'unicode': '1f526'
      'shortname': ':flashlight:'
      'aliases': ''
      'keywords': 'electric torch dark flashlight light object tool'
    'candle':
      'unicode': '1f56f'
      'shortname': ':candle:'
      'aliases': ''
      'keywords': 'candle light wax object'
    'wastebasket':
      'unicode': '1f5d1'
      'shortname': ':wastebasket:'
      'aliases': ''
      'keywords': 'wastebasket trash garbage dispose object office'
    'oil':
      'unicode': '1f6e2'
      'shortname': ':oil:'
      'aliases': ':oil_drum:'
      'keywords': 'oil drum petroleum object'
    'money_with_wings':
      'unicode': '1f4b8'
      'shortname': ':money_with_wings:'
      'aliases': ''
      'keywords': 'money with wings bills dollar payment spend work lost blown burned gift cash dollar bank banknote bill fly note object office'
    'dollar':
      'unicode': '1f4b5'
      'shortname': ':dollar:'
      'aliases': ''
      'keywords': 'banknote with dollar sign bill currency money united states canada australia paper cash bank note object office'
    'yen':
      'unicode': '1f4b4'
      'shortname': ':yen:'
      'aliases': ''
      'keywords': 'banknote with yen sign currency dollar japanese money japan paper cash bill bank note object office'
    'euro':
      'unicode': '1f4b6'
      'shortname': ':euro:'
      'aliases': ''
      'keywords': 'banknote with euro sign currency dollar money europe paper cash bill bank note object office'
    'pound':
      'unicode': '1f4b7'
      'shortname': ':pound:'
      'aliases': ''
      'keywords': 'banknote with pound sign bill british currency england money sterling uk britain paper cash bank note object office'
    'moneybag':
      'unicode': '1f4b0'
      'shortname': ':moneybag:'
      'aliases': ''
      'keywords': 'money bag coins dollar payment cash loot moneybag object office'
    'credit_card':
      'unicode': '1f4b3'
      'shortname': ':credit_card:'
      'aliases': ''
      'keywords': 'credit card bill dollar money pay payment loan purchase shopping mastercard visa american express wallet signature bank object office'
    'gem':
      'unicode': '1f48e'
      'shortname': ':gem:'
      'aliases': ''
      'keywords': 'gem stone blue ruby precious diamond emotion jewel object person romance'
    'scales':
      'unicode': '2696'
      'shortname': ':scales:'
      'aliases': ''
      'keywords': 'scales balance justice libra object tool weight zodiac'
    'wrench':
      'unicode': '1f527'
      'shortname': ':wrench:'
      'aliases': ''
      'keywords': 'wrench diy ikea tools object tool'
    'hammer':
      'unicode': '1f528'
      'shortname': ':hammer:'
      'aliases': ''
      'keywords': 'hammer done judge law ruling tools verdict object tool'
    'hammer_pick':
      'unicode': '2692'
      'shortname': ':hammer_pick:'
      'aliases': ':hammer_and_pick:'
      'keywords': 'hammer and pick object tool'
    'tools':
      'unicode': '1f6e0'
      'shortname': ':tools:'
      'aliases': ':hammer_and_wrench:'
      'keywords': 'hammer and wrench tools object tool'
    'pick':
      'unicode': '26cf'
      'shortname': ':pick:'
      'aliases': ''
      'keywords': 'pick mining object tool'
    'nut_and_bolt':
      'unicode': '1f529'
      'shortname': ':nut_and_bolt:'
      'aliases': ''
      'keywords': 'nut and bolt tools object tool'
    'gear':
      'unicode': '2699'
      'shortname': ':gear:'
      'aliases': ''
      'keywords': 'gear object tool'
    'chains':
      'unicode': '26d3'
      'shortname': ':chains:'
      'aliases': ''
      'keywords': 'chains chain object'
    'gun':
      'unicode': '1f52b'
      'shortname': ':gun:'
      'aliases': ''
      'keywords': 'pistol violence weapon gun object revolver tool'
    'bomb':
      'unicode': '1f4a3'
      'shortname': ':bomb:'
      'aliases': ''
      'keywords': 'bomb boom explode comic object'
    'knife':
      'unicode': '1f52a'
      'shortname': ':knife:'
      'aliases': ''
      'keywords': 'hocho blade cooking knife object tool weapon'
    'dagger':
      'unicode': '1f5e1'
      'shortname': ':dagger:'
      'aliases': ':dagger_knife:'
      'keywords': 'dagger knife blade knife object weapon'
    'crossed_swords':
      'unicode': '2694'
      'shortname': ':crossed_swords:'
      'aliases': ''
      'keywords': 'crossed swords object weapon'
    'shield':
      'unicode': '1f6e1'
      'shortname': ':shield:'
      'aliases': ''
      'keywords': 'shield interstate route sign highway interstate object weapon'
    'smoking':
      'unicode': '1f6ac'
      'shortname': ':smoking:'
      'aliases': ''
      'keywords': 'smoking symbol cigarette kills tobacco smoke cancer lungs inhale tar nicotine activity object'
    'skull_crossbones':
      'unicode': '2620'
      'shortname': ':skull_crossbones:'
      'aliases': ':skull_and_crossbones:'
      'keywords': 'skull and crossbones body death face monster person'
    'coffin':
      'unicode': '26b0'
      'shortname': ':coffin:'
      'aliases': ''
      'keywords': 'coffin death object'
    'urn':
      'unicode': '26b1'
      'shortname': ':urn:'
      'aliases': ':funeral_urn:'
      'keywords': 'funeral urn death object'
    'amphora':
      'unicode': '1f3fa'
      'shortname': ':amphora:'
      'aliases': ''
      'keywords': 'amphora'
    'crystal_ball':
      'unicode': '1f52e'
      'shortname': ':crystal_ball:'
      'aliases': ''
      'keywords': 'crystal ball fortune future reading fairy tale fantasy object tool'
    'prayer_beads':
      'unicode': '1f4ff'
      'shortname': ':prayer_beads:'
      'aliases': ''
      'keywords': 'prayer beads'
    'barber':
      'unicode': '1f488'
      'shortname': ':barber:'
      'aliases': ''
      'keywords': 'barber pole salon style haircut trim place'
    'alembic':
      'unicode': '2697'
      'shortname': ':alembic:'
      'aliases': ''
      'keywords': 'alembic chemistry object tool'
    'telescope':
      'unicode': '1f52d'
      'shortname': ':telescope:'
      'aliases': ''
      'keywords': 'telescope space stars object tool'
    'microscope':
      'unicode': '1f52c'
      'shortname': ':microscope:'
      'aliases': ''
      'keywords': 'microscope experiment laboratory zoomin object tool'
    'hole':
      'unicode': '1f573'
      'shortname': ':hole:'
      'aliases': ''
      'keywords': 'hole pit well symbol'
    'pill':
      'unicode': '1f48a'
      'shortname': ':pill:'
      'aliases': ''
      'keywords': 'pill health medicine drug prescription doctor object sick'
    'syringe':
      'unicode': '1f489'
      'shortname': ':syringe:'
      'aliases': ''
      'keywords': 'syringe blood drugs health hospital medicine needle doctor object shot sick tool'
    'thermometer':
      'unicode': '1f321'
      'shortname': ':thermometer:'
      'aliases': ''
      'keywords': 'thermometer temperature nature weather'
    'label':
      'unicode': '1f3f7'
      'shortname': ':label:'
      'aliases': ''
      'keywords': 'label tag object'
    'bookmark':
      'unicode': '1f516'
      'shortname': ':bookmark:'
      'aliases': ''
      'keywords': 'bookmark favorite mark object'
    'toilet':
      'unicode': '1f6bd'
      'shortname': ':toilet:'
      'aliases': ''
      'keywords': 'toilet restroom wc bathroom throne porcelain waste flush plumbing object place travel'
    'shower':
      'unicode': '1f6bf'
      'shortname': ':shower:'
      'aliases': ''
      'keywords': 'shower bath clean wash bathroom soap water shampoo lather object place travel'
    'bathtub':
      'unicode': '1f6c1'
      'shortname': ':bathtub:'
      'aliases': ''
      'keywords': 'bathtub clean shower bath tub basin wash bubble soak bathroom soap water shampoo lather object place travel'
    'key':
      'unicode': '1f511'
      'shortname': ':key:'
      'aliases': ''
      'keywords': 'key door lock password object'
    'key2':
      'unicode': '1f5dd'
      'shortname': ':key2:'
      'aliases': ':old_key:'
      'keywords': 'old key door lock password skeleton clue object'
    'couch':
      'unicode': '1f6cb'
      'shortname': ':couch:'
      'aliases': ':couch_and_lamp:'
      'keywords': 'couch and lamp lounge sectional sofa loveseat leather microfiber sit relax hotel object'
    'sleeping_accommodation':
      'unicode': '1f6cc'
      'shortname': ':sleeping_accommodation:'
      'aliases': ''
      'keywords': 'sleeping accommodation hotel motel rest object sleep'
    'bed':
      'unicode': '1f6cf'
      'shortname': ':bed:'
      'aliases': ''
      'keywords': 'bed sleep sex queen full twin king mattress hotel object'
    'door':
      'unicode': '1f6aa'
      'shortname': ':door:'
      'aliases': ''
      'keywords': 'door entry exit house doorway entrance enter exit entry object travel'
    'bellhop':
      'unicode': '1f6ce'
      'shortname': ':bellhop:'
      'aliases': ':bellhop_bell:'
      'keywords': 'bellhop bell hotel porter ding object'
    'frame_photo':
      'unicode': '1f5bc'
      'shortname': ':frame_photo:'
      'aliases': ':frame_with_picture:'
      'keywords': 'frame with picture photo art museum object office painting'
    'map':
      'unicode': '1f5fa'
      'shortname': ':map:'
      'aliases': ':world_map:'
      'keywords': 'world map atlas earth cartography place'
    'beach_umbrella':
      'unicode': '26f1'
      'shortname': ':beach_umbrella:'
      'aliases': ':umbrella_on_ground:'
      'keywords': 'umbrella on ground nature rain sun travel weather'
    'moyai':
      'unicode': '1f5ff'
      'shortname': ':moyai:'
      'aliases': ''
      'keywords': 'moyai island stone face place statue travel'
    'shopping_bags':
      'unicode': '1f6cd'
      'shortname': ':shopping_bags:'
      'aliases': ''
      'keywords': 'shopping bags purchase mall buy store shop bag hotel object'
    'balloon':
      'unicode': '1f388'
      'shortname': ':balloon:'
      'aliases': ''
      'keywords': 'balloon celebration party birthday helium gas children float activity entertainment object'
    'flags':
      'unicode': '1f38f'
      'shortname': ':flags:'
      'aliases': ''
      'keywords': 'carp streamer banner fish japanese koinobori children kids boys celebration happiness holiday flags activity entertainment flag object'
    'ribbon':
      'unicode': '1f380'
      'shortname': ':ribbon:'
      'aliases': ''
      'keywords': 'ribbon bowtie decoration pink lace wrap decorate celebration emotion object person'
    'gift':
      'unicode': '1f381'
      'shortname': ':gift:'
      'aliases': ''
      'keywords': 'wrapped present birthday christmas xmas gift package wedding box celebration entertainment object'
    'confetti_ball':
      'unicode': '1f38a'
      'shortname': ':confetti_ball:'
      'aliases': ''
      'keywords': 'confetti ball festival party congratulations celebrate win birthday new years wedding activity celebration entertainment object'
    'tada':
      'unicode': '1f389'
      'shortname': ':tada:'
      'aliases': ''
      'keywords': 'party popper tada celebration victory announcement climax congratulations activity entertainment object'
    'dolls':
      'unicode': '1f38e'
      'shortname': ':dolls:'
      'aliases': ''
      'keywords': 'japanese dolls kimono toy japan day girls emperor empress pray blessing imperial family royal activity celebration doll entertainment festival object'
    'wind_chime':
      'unicode': '1f390'
      'shortname': ':wind_chime:'
      'aliases': ''
      'keywords': 'wind chime ding nature bell fūrin instrument music spirits soothing protective spiritual sound activity celebration entertainment object'
    'crossed_flags':
      'unicode': '1f38c'
      'shortname': ':crossed_flags:'
      'aliases': ''
      'keywords': 'crossed flags japan activity celebration cross flag japanese object'
    'izakaya_lantern':
      'unicode': '1f3ee'
      'shortname': ':izakaya_lantern:'
      'aliases': ''
      'keywords': 'izakaya lantern light stay drink alcohol bar sake restaurant japanese place red'
    'envelope':
      'unicode': '2709'
      'shortname': ':envelope:'
      'aliases': ''
      'keywords': 'envelope communication letter mail postal e-mail email object office'
    'envelope_with_arrow':
      'unicode': '1f4e9'
      'shortname': ':envelope_with_arrow:'
      'aliases': ''
      'keywords': 'envelope with downwards arrow above email communication down e-mail letter mail object office outgoing sent'
    'incoming_envelope':
      'unicode': '1f4e8'
      'shortname': ':incoming_envelope:'
      'aliases': ''
      'keywords': 'incoming envelope email inbox communication e-mail letter mail object office receive'
    'e-mail':
      'unicode': '1f4e7'
      'shortname': ':e-mail:'
      'aliases': ':email:'
      'keywords': 'e-mail symbol communication inbox email letter mail object office'
    'love_letter':
      'unicode': '1f48c'
      'shortname': ':love_letter:'
      'aliases': ''
      'keywords': 'love letter affection email envelope like valentines kiss heart emotion mail person romance'
    'postbox':
      'unicode': '1f4ee'
      'shortname': ':postbox:'
      'aliases': ''
      'keywords': 'postbox email envelope letter communication mail mailbox object office'
    'mailbox_closed':
      'unicode': '1f4ea'
      'shortname': ':mailbox_closed:'
      'aliases': ''
      'keywords': 'closed mailbox with lowered flag communication email inbox mail object office postbox'
    'mailbox':
      'unicode': '1f4eb'
      'shortname': ':mailbox:'
      'aliases': ''
      'keywords': 'closed mailbox with raised flag communication email inbox mail object office postbox'
    'mailbox_with_mail':
      'unicode': '1f4ec'
      'shortname': ':mailbox_with_mail:'
      'aliases': ''
      'keywords': 'open mailbox with raised flag communication email inbox mail object office postbox'
    'mailbox_with_no_mail':
      'unicode': '1f4ed'
      'shortname': ':mailbox_with_no_mail:'
      'aliases': ''
      'keywords': 'open mailbox with lowered flag email inbox communication mail object office postbox'
    'package':
      'unicode': '1f4e6'
      'shortname': ':package:'
      'aliases': ''
      'keywords': 'package gift mail box communication object office parcel'
    'postal_horn':
      'unicode': '1f4ef'
      'shortname': ':postal_horn:'
      'aliases': ''
      'keywords': 'postal horn instrument music communication entertainment object post sound'
    'inbox_tray':
      'unicode': '1f4e5'
      'shortname': ':inbox_tray:'
      'aliases': ''
      'keywords': 'inbox tray documents email box communication letter mail object office receive'
    'outbox_tray':
      'unicode': '1f4e4'
      'shortname': ':outbox_tray:'
      'aliases': ''
      'keywords': 'outbox tray documents email box communication letter mail object office sent'
    'scroll':
      'unicode': '1f4dc'
      'shortname': ':scroll:'
      'aliases': ''
      'keywords': 'scroll documents roll parchment history papyrus ancient object office paper'
    'page_with_curl':
      'unicode': '1f4c3'
      'shortname': ':page_with_curl:'
      'aliases': ''
      'keywords': 'page with curl document object office'
    'bookmark_tabs':
      'unicode': '1f4d1'
      'shortname': ':bookmark_tabs:'
      'aliases': ''
      'keywords': 'bookmark tabs favorite mark marker object office'
    'bar_chart':
      'unicode': '1f4ca'
      'shortname': ':bar_chart:'
      'aliases': ''
      'keywords': 'bar chart graph presentation stats object office'
    'chart_with_upwards_trend':
      'unicode': '1f4c8'
      'shortname': ':chart_with_upwards_trend:'
      'aliases': ''
      'keywords': 'chart with upwards trend graph business growth object office upward'
    'chart_with_downwards_trend':
      'unicode': '1f4c9'
      'shortname': ':chart_with_downwards_trend:'
      'aliases': ''
      'keywords': 'chart with downwards trend graph business down object office'
    'page_facing_up':
      'unicode': '1f4c4'
      'shortname': ':page_facing_up:'
      'aliases': ''
      'keywords': 'page facing up document object office'
    'date':
      'unicode': '1f4c5'
      'shortname': ':date:'
      'aliases': ''
      'keywords': 'calendar schedule date day object office'
    'calendar':
      'unicode': '1f4c6'
      'shortname': ':calendar:'
      'aliases': ''
      'keywords': 'tear-off calendar schedule date day object office'
    'calendar_spiral':
      'unicode': '1f5d3'
      'shortname': ':calendar_spiral:'
      'aliases': ':spiral_calendar_pad:'
      'keywords': 'spiral calendar pad schedule date day object office'
    'card_index':
      'unicode': '1f4c7'
      'shortname': ':card_index:'
      'aliases': ''
      'keywords': 'card index business stationery rolodex object office'
    'card_box':
      'unicode': '1f5c3'
      'shortname': ':card_box:'
      'aliases': ':card_file_box:'
      'keywords': 'card file box index organization object office'
    'ballot_box':
      'unicode': '1f5f3'
      'shortname': ':ballot_box:'
      'aliases': ':ballot_box_with_ballot:'
      'keywords': 'ballot box with ballot vote object'
    'file_cabinet':
      'unicode': '1f5c4'
      'shortname': ':file_cabinet:'
      'aliases': ''
      'keywords': 'file cabinet folders office documents storage object'
    'clipboard':
      'unicode': '1f4cb'
      'shortname': ':clipboard:'
      'aliases': ''
      'keywords': 'clipboard documents stationery object office'
    'notepad_spiral':
      'unicode': '1f5d2'
      'shortname': ':notepad_spiral:'
      'aliases': ':spiral_note_pad:'
      'keywords': 'spiral note pad stationery object office'
    'file_folder':
      'unicode': '1f4c1'
      'shortname': ':file_folder:'
      'aliases': ''
      'keywords': 'file folder documents object office'
    'open_file_folder':
      'unicode': '1f4c2'
      'shortname': ':open_file_folder:'
      'aliases': ''
      'keywords': 'open file folder documents load object office'
    'dividers':
      'unicode': '1f5c2'
      'shortname': ':dividers:'
      'aliases': ':card_index_dividers:'
      'keywords': 'card index dividers stationery rolodex object office'
    'newspaper2':
      'unicode': '1f5de'
      'shortname': ':newspaper2:'
      'aliases': ':rolled_up_newspaper:'
      'keywords': 'rolled-up newspaper headline press news object paper rolled'
    'newspaper':
      'unicode': '1f4f0'
      'shortname': ':newspaper:'
      'aliases': ''
      'keywords': 'newspaper headline press communication news object paper'
    'notebook':
      'unicode': '1f4d3'
      'shortname': ':notebook:'
      'aliases': ''
      'keywords': 'notebook notes paper record stationery school object office'
    'closed_book':
      'unicode': '1f4d5'
      'shortname': ':closed_book:'
      'aliases': ''
      'keywords': 'closed book library read novel story education object office'
    'green_book':
      'unicode': '1f4d7'
      'shortname': ':green_book:'
      'aliases': ''
      'keywords': 'green book library read novel story education object office'
    'blue_book':
      'unicode': '1f4d8'
      'shortname': ':blue_book:'
      'aliases': ''
      'keywords': 'blue book library read novel story education object office'
    'orange_book':
      'unicode': '1f4d9'
      'shortname': ':orange_book:'
      'aliases': ''
      'keywords': 'orange book library read novel story education object office'
    'notebook_with_decorative_cover':
      'unicode': '1f4d4'
      'shortname': ':notebook_with_decorative_cover:'
      'aliases': ''
      'keywords': 'notebook with decorative cover classroom notes paper school stationery book decorated education object office'
    'ledger':
      'unicode': '1f4d2'
      'shortname': ':ledger:'
      'aliases': ''
      'keywords': 'ledger notes business bookkeeping accounting finances notebook object office'
    'books':
      'unicode': '1f4da'
      'shortname': ':books:'
      'aliases': ''
      'keywords': 'books library literature novel story collection series book education object office'
    'book':
      'unicode': '1f4d6'
      'shortname': ':book:'
      'aliases': ''
      'keywords': 'open book library literature novel reading story education object office'
    'link':
      'unicode': '1f517'
      'shortname': ':link:'
      'aliases': ''
      'keywords': 'link symbol rings url object'
    'paperclip':
      'unicode': '1f4ce'
      'shortname': ':paperclip:'
      'aliases': ''
      'keywords': 'paperclip documents stationery object office'
    'paperclips':
      'unicode': '1f587'
      'shortname': ':paperclips:'
      'aliases': ':linked_paperclips:'
      'keywords': 'linked paperclips documents stationery communication link object office paperclip'
    'scissors':
      'unicode': '2702'
      'shortname': ':scissors:'
      'aliases': ''
      'keywords': 'black scissors cut stationery object office tool'
    'triangular_ruler':
      'unicode': '1f4d0'
      'shortname': ':triangular_ruler:'
      'aliases': ''
      'keywords': 'triangular ruler architect math sketch stationery object office set triangle'
    'straight_ruler':
      'unicode': '1f4cf'
      'shortname': ':straight_ruler:'
      'aliases': ''
      'keywords': 'straight ruler stationery object office straight edge'
    'pushpin':
      'unicode': '1f4cc'
      'shortname': ':pushpin:'
      'aliases': ''
      'keywords': 'pushpin stationery object office pin'
    'round_pushpin':
      'unicode': '1f4cd'
      'shortname': ':round_pushpin:'
      'aliases': ''
      'keywords': 'round pushpin stationery object office pin place'
    'triangular_flag_on_post':
      'unicode': '1f6a9'
      'shortname': ':triangular_flag_on_post:'
      'aliases': ''
      'keywords': 'triangular flag on post triangle golf flagpole object place travel'
    'flag_white':
      'unicode': '1f3f3'
      'shortname': ':flag_white:'
      'aliases': ':waving_white_flag:'
      'keywords': 'waving white flag symbol signal object'
    'flag_black':
      'unicode': '1f3f4'
      'shortname': ':flag_black:'
      'aliases': ':waving_black_flag:'
      'keywords': 'waving black flag symbol signal object'
    'closed_lock_with_key':
      'unicode': '1f510'
      'shortname': ':closed_lock_with_key:'
      'aliases': ''
      'keywords': 'closed lock with key privacy security object secure'
    'lock':
      'unicode': '1f512'
      'shortname': ':lock:'
      'aliases': ''
      'keywords': 'lock password security closed object'
    'unlock':
      'unicode': '1f513'
      'shortname': ':unlock:'
      'aliases': ''
      'keywords': 'open lock privacy security unlock object'
    'lock_with_ink_pen':
      'unicode': '1f50f'
      'shortname': ':lock_with_ink_pen:'
      'aliases': ''
      'keywords': 'lock with ink pen secret security nib object privacy'
    'pen_ballpoint':
      'unicode': '1f58a'
      'shortname': ':pen_ballpoint:'
      'aliases': ':lower_left_ballpoint_pen:'
      'keywords': 'lower left ballpoint pen write bic ink communication object office'
    'pen_fountain':
      'unicode': '1f58b'
      'shortname': ':pen_fountain:'
      'aliases': ':lower_left_fountain_pen:'
      'keywords': 'lower left fountain pen write calligraphy ink communication object office'
    'black_nib':
      'unicode': '2712'
      'shortname': ':black_nib:'
      'aliases': ''
      'keywords': 'black nib pen stationery object office'
    'pencil':
      'unicode': '1f4dd'
      'shortname': ':pencil:'
      'aliases': ''
      'keywords': 'memo documents paper station write pencil communication object office'
    'pencil2':
      'unicode': '270f'
      'shortname': ':pencil2:'
      'aliases': ''
      'keywords': 'pencil paper stationery write object office'
    'crayon':
      'unicode': '1f58d'
      'shortname': ':crayon:'
      'aliases': ':lower_left_crayon:'
      'keywords': 'lower left crayon write draw color wax communication object office'
    'paintbrush':
      'unicode': '1f58c'
      'shortname': ':paintbrush:'
      'aliases': ':lower_left_paintbrush:'
      'keywords': 'lower left paintbrush brush art painting communication object office'
    'mag':
      'unicode': '1f50d'
      'shortname': ':mag:'
      'aliases': ''
      'keywords': 'left-pointing magnifying glass search zoom detective investigator details object tool'
    'mag_right':
      'unicode': '1f50e'
      'shortname': ':mag_right:'
      'aliases': ''
      'keywords': 'right-pointing magnifying glass search zoom detective investigator details object tool'
    'heart':
      'unicode': '2764'
      'shortname': ':heart:'
      'aliases': ''
      'keywords': 'heavy black heart like love red pink passion romance intense desire death evil cold valentines emotion person'
    'yellow_heart':
      'unicode': '1f49b'
      'shortname': ':yellow_heart:'
      'aliases': ''
      'keywords': 'yellow heart affection like love valentines gold friendship happy happiness trust compassionate respectful honest caring selfless emotion person'
    'green_heart':
      'unicode': '1f49a'
      'shortname': ':green_heart:'
      'aliases': ''
      'keywords': 'green heart affection like love valentines nature rebirth reborn jealous clingy envious possessive emotion person'
    'blue_heart':
      'unicode': '1f499'
      'shortname': ':blue_heart:'
      'aliases': ''
      'keywords': 'blue heart affection like love valentines stability truth loyalty trust emotion person'
    'purple_heart':
      'unicode': '1f49c'
      'shortname': ':purple_heart:'
      'aliases': ''
      'keywords': 'purple heart affection like love valentines violet love sensitive understanding compassionate compassion duty honor royalty veteran sacrifice emotion person'
    'broken_heart':
      'unicode': '1f494'
      'shortname': ':broken_heart:'
      'aliases': ''
      'keywords': 'broken heart sad sorry breakup split break emotion person'
    'heart_exclamation':
      'unicode': '2763'
      'shortname': ':heart_exclamation:'
      'aliases': ':heavy_heart_exclamation_mark_ornament:'
      'keywords': 'heavy heart exclamation mark ornament emotion punctuation symbol'
    'two_hearts':
      'unicode': '1f495'
      'shortname': ':two_hearts:'
      'aliases': ''
      'keywords': 'two hearts affection like love valentines emotion heart person'
    'revolving_hearts':
      'unicode': '1f49e'
      'shortname': ':revolving_hearts:'
      'aliases': ''
      'keywords': 'revolving hearts affection like love valentines lovers emotion heart person'
    'heartbeat':
      'unicode': '1f493'
      'shortname': ':heartbeat:'
      'aliases': ''
      'keywords': 'beating heart affection like love valentines emotion heartbeat person pulsating'
    'heartpulse':
      'unicode': '1f497'
      'shortname': ':heartpulse:'
      'aliases': ''
      'keywords': 'growing heart affection like love valentines emotion excited heartpulse nervous person'
    'sparkling_heart':
      'unicode': '1f496'
      'shortname': ':sparkling_heart:'
      'aliases': ''
      'keywords': 'sparkling heart affection like love valentines emotion excited person sparkle'
    'cupid':
      'unicode': '1f498'
      'shortname': ':cupid:'
      'aliases': ''
      'keywords': 'heart with arrow affection like love valentines cupid emotion person romance'
    'gift_heart':
      'unicode': '1f49d'
      'shortname': ':gift_heart:'
      'aliases': ''
      'keywords': 'heart with ribbon like love valentines emotion object person valentine'
    'heart_decoration':
      'unicode': '1f49f'
      'shortname': ':heart_decoration:'
      'aliases': ''
      'keywords': 'heart decoration like love purple-square emotion person symbol'
    'peace':
      'unicode': '262e'
      'shortname': ':peace:'
      'aliases': ':peace_symbol:'
      'keywords': 'peace symbol sign'
    'cross':
      'unicode': '271d'
      'shortname': ':cross:'
      'aliases': ':latin_cross:'
      'keywords': 'latin cross religion symbol christian'
    'star_and_crescent':
      'unicode': '262a'
      'shortname': ':star_and_crescent:'
      'aliases': ''
      'keywords': 'star and crescent islam muslim religion symbol'
    'om_symbol':
      'unicode': '1f549'
      'shortname': ':om_symbol:'
      'aliases': ''
      'keywords': 'om symbol hinduism sound spiritual icon dharmic buddhism jainism meditate hindu religion'
    'wheel_of_dharma':
      'unicode': '2638'
      'shortname': ':wheel_of_dharma:'
      'aliases': ''
      'keywords': 'wheel of dharma buddhist religion symbol'
    'star_of_david':
      'unicode': '2721'
      'shortname': ':star_of_david:'
      'aliases': ''
      'keywords': 'star of david jew jewish religion symbol'
    'six_pointed_star':
      'unicode': '1f52f'
      'shortname': ':six_pointed_star:'
      'aliases': ''
      'keywords': 'six pointed star with middle dot purple-square fortune object symbol'
    'menorah':
      'unicode': '1f54e'
      'shortname': ':menorah:'
      'aliases': ''
      'keywords': 'menorah with nine branches'
    'yin_yang':
      'unicode': '262f'
      'shortname': ':yin_yang:'
      'aliases': ''
      'keywords': 'yin yang religion sign symbol tao taoist'
    'orthodox_cross':
      'unicode': '2626'
      'shortname': ':orthodox_cross:'
      'aliases': ''
      'keywords': 'orthodox cross christian religion symbol'
    'place_of_worship':
      'unicode': '1f6d0'
      'shortname': ':place_of_worship:'
      'aliases': ':worship_symbol:'
      'keywords': 'place of worship'
    'ophiuchus':
      'unicode': '26ce'
      'shortname': ':ophiuchus:'
      'aliases': ''
      'keywords': 'ophiuchus serpent snake astrology greek constellation stars zodiac purple-square sign horoscope bearer symbol'
    'aries':
      'unicode': '2648'
      'shortname': ':aries:'
      'aliases': ''
      'keywords': 'aries ram astrology greek constellation stars purple-square sign zodiac horoscope symbol time'
    'taurus':
      'unicode': '2649'
      'shortname': ':taurus:'
      'aliases': ''
      'keywords': 'taurus purple-square sign bull astrology greek constellation stars zodiac horoscope ox symbol time'
    'gemini':
      'unicode': '264a'
      'shortname': ':gemini:'
      'aliases': ''
      'keywords': 'gemini twins astrology greek constellation stars sign zodiac horoscope symbol time'
    'cancer':
      'unicode': '264b'
      'shortname': ':cancer:'
      'aliases': ''
      'keywords': 'cancer crab astrology greek constellation stars sign zodiac horoscope symbol time'
    'leo':
      'unicode': '264c'
      'shortname': ':leo:'
      'aliases': ''
      'keywords': 'leo lion astrology greek constellation stars purple-square sign zodiac horoscope symbol time'
    'virgo':
      'unicode': '264d'
      'shortname': ':virgo:'
      'aliases': ''
      'keywords': 'virgo maiden astrology greek constellation stars sign zodiac horoscope symbol time virgin'
    'libra':
      'unicode': '264e'
      'shortname': ':libra:'
      'aliases': ''
      'keywords': 'libra scales astrology greek constellation stars purple-square sign zodiac horoscope balance justice symbol time'
    'scorpius':
      'unicode': '264f'
      'shortname': ':scorpius:'
      'aliases': ''
      'keywords': 'scorpius scorpion scorpio astrology greek constellation stars sign zodiac horoscope symbol time'
    'sagittarius':
      'unicode': '2650'
      'shortname': ':sagittarius:'
      'aliases': ''
      'keywords': 'sagittarius centaur archer astrology greek constellation stars zodiac sign horoscope symbol time'
    'capricorn':
      'unicode': '2651'
      'shortname': ':capricorn:'
      'aliases': ''
      'keywords': 'capricorn sea-goat goat-horned astrology greek constellation stars zodiac sign horoscope goat symbol time'
    'aquarius':
      'unicode': '2652'
      'shortname': ':aquarius:'
      'aliases': ''
      'keywords': 'aquarius water bearer astrology greek constellation stars sign purple-square zodiac horoscope symbol time'
    'pisces':
      'unicode': '2653'
      'shortname': ':pisces:'
      'aliases': ''
      'keywords': 'pisces fish astrology greek constellation stars sign purple-square zodiac horoscope symbol time'
    'id':
      'unicode': '1f194'
      'shortname': ':id:'
      'aliases': ''
      'keywords': 'squared id purple-square identification identity symbol word'
    'atom':
      'unicode': '269b'
      'shortname': ':atom:'
      'aliases': ':atom_symbol:'
      'keywords': 'atom symbol atheist'
    'u7a7a':
      'unicode': '1f233'
      'shortname': ':u7a7a:'
      'aliases': ''
      'keywords': 'squared cjk unified ideograph-7a7a chinese empty japanese kanji symbol word'
    'u5272':
      'unicode': '1f239'
      'shortname': ':u5272:'
      'aliases': ''
      'keywords': 'squared cjk unified ideograph-5272 chinese cut divide kanji pink bargain sale japanese symbol word'
    'radioactive':
      'unicode': '2622'
      'shortname': ':radioactive:'
      'aliases': ':radioactive_sign:'
      'keywords': 'radioactive sign symbol'
    'biohazard':
      'unicode': '2623'
      'shortname': ':biohazard:'
      'aliases': ':biohazard_sign:'
      'keywords': 'biohazard sign symbol'
    'mobile_phone_off':
      'unicode': '1f4f4'
      'shortname': ':mobile_phone_off:'
      'aliases': ''
      'keywords': 'mobile phone off mute cell communication object symbol telephone'
    'vibration_mode':
      'unicode': '1f4f3'
      'shortname': ':vibration_mode:'
      'aliases': ''
      'keywords': 'vibration mode orange-square phone mobile cell communication object symbol telephone'
    'u6709':
      'unicode': '1f236'
      'shortname': ':u6709:'
      'aliases': ''
      'keywords': 'squared cjk unified ideograph-6709 chinese own possess kanji orange-square japanese symbol word'
    'u7121':
      'unicode': '1f21a'
      'shortname': ':u7121:'
      'aliases': ''
      'keywords': 'squared cjk unified ideograph-7121 chinese japanese kanji none orange-square lack symbol word'
    'u7533':
      'unicode': '1f238'
      'shortname': ':u7533:'
      'aliases': ''
      'keywords': 'squared cjk unified ideograph-7533 chinese japanese kanji request monkey symbol word'
    'u55b6':
      'unicode': '1f23a'
      'shortname': ':u55b6:'
      'aliases': ''
      'keywords': 'squared cjk unified ideograph-55b6 japanese open work chinese symbol word'
    'u6708':
      'unicode': '1f237'
      'shortname': ':u6708:'
      'aliases': ''
      'keywords': 'squared cjk unified ideograph-6708 chinese japanese kanji moon orange-square month symbol word'
    'eight_pointed_black_star':
      'unicode': '2734'
      'shortname': ':eight_pointed_black_star:'
      'aliases': ''
      'keywords': 'eight pointed black star orange-square symbol sign'
    'vs':
      'unicode': '1f19a'
      'shortname': ':vs:'
      'aliases': ''
      'keywords': 'squared vs orange-square words versus symbol word'
    'accept':
      'unicode': '1f251'
      'shortname': ':accept:'
      'aliases': ''
      'keywords': 'circled ideograph accept agree chinese good kanji ok yes symbol word'
    'white_flower':
      'unicode': '1f4ae'
      'shortname': ':white_flower:'
      'aliases': ''
      'keywords': 'white flower japanese teacher school grade score brilliance intelligence homework student assignment praise object symbol'
    'ideograph_advantage':
      'unicode': '1f250'
      'shortname': ':ideograph_advantage:'
      'aliases': ''
      'keywords': 'circled ideograph advantage chinese get kanji bargain japanese symbol word'
    'secret':
      'unicode': '3299'
      'shortname': ':secret:'
      'aliases': ''
      'keywords': 'circled ideograph secret privacy chinese symbol word'
    'congratulations':
      'unicode': '3297'
      'shortname': ':congratulations:'
      'aliases': ''
      'keywords': 'circled ideograph congratulation chinese japanese kanji congratulations symbol word'
    'u5408':
      'unicode': '1f234'
      'shortname': ':u5408:'
      'aliases': ''
      'keywords': 'squared cjk unified ideograph-5408 chinese japanese join unite agreement kanji symbol word'
    'u6e80':
      'unicode': '1f235'
      'shortname': ':u6e80:'
      'aliases': ''
      'keywords': 'squared cjk unified ideograph-6e80 chinese full japanese kanji red-square symbol word'
    'u7981':
      'unicode': '1f232'
      'shortname': ':u7981:'
      'aliases': ''
      'keywords': 'squared cjk unified ideograph-7981 chinese japanese kanji limit restricted prohibit restrict forbid symbol word'
    'a':
      'unicode': '1f170'
      'shortname': ':a:'
      'aliases': ''
      'keywords': 'negative squared latin capital letter a alphabet letter red-square blood type symbol word'
    'b':
      'unicode': '1f171'
      'shortname': ':b:'
      'aliases': ''
      'keywords': 'negative squared latin capital letter b alphabet letter red-square blood type symbol word'
    'ab':
      'unicode': '1f18e'
      'shortname': ':ab:'
      'aliases': ''
      'keywords': 'negative squared ab alphabet red-square blood type symbol word'
    'cl':
      'unicode': '1f191'
      'shortname': ':cl:'
      'aliases': ''
      'keywords': 'squared cl alphabet red-square words cl clear symbol word'
    'o2':
      'unicode': '1f17e'
      'shortname': ':o2:'
      'aliases': ''
      'keywords': 'negative squared latin capital letter o alphabet red-square o2 blood type symbol word'
    'sos':
      'unicode': '1f198'
      'shortname': ':sos:'
      'aliases': ''
      'keywords': 'squared sos emergency help red-square distress symbol word'
    'no_entry':
      'unicode': '26d4'
      'shortname': ':no_entry:'
      'aliases': ''
      'keywords': 'no entry bad denied limit privacy security stop forbidden not prohibited symbol traffic travel'
    'name_badge':
      'unicode': '1f4db'
      'shortname': ':name_badge:'
      'aliases': ''
      'keywords': 'name badge object office'
    'no_entry_sign':
      'unicode': '1f6ab'
      'shortname': ':no_entry_sign:'
      'aliases': ''
      'keywords': 'no entry sign denied disallow forbid limit stop prohibited forbidden not symbol travel'
    'x':
      'unicode': '274c'
      'shortname': ':x:'
      'aliases': ''
      'keywords': 'cross mark delete no remove cancel x multiplication multiply sign symbol'
    'o':
      'unicode': '2b55'
      'shortname': ':o:'
      'aliases': ''
      'keywords': 'heavy large circle round o symbol travel'
    'anger':
      'unicode': '1f4a2'
      'shortname': ':anger:'
      'aliases': ''
      'keywords': 'anger symbol angry mad comic emotion person'
    'hotsprings':
      'unicode': '2668'
      'shortname': ':hotsprings:'
      'aliases': ''
      'keywords': 'hot springs bath relax warm hotsprings place steaming'
    'no_pedestrians':
      'unicode': '1f6b7'
      'shortname': ':no_pedestrians:'
      'aliases': ''
      'keywords': 'no pedestrians crossing rules walking walk stroll stride forbidden not pedestrian place prohibited sign symbol travel'
    'do_not_litter':
      'unicode': '1f6af'
      'shortname': ':do_not_litter:'
      'aliases': ''
      'keywords': 'do not litter symbol bin garbage trash waste no forbidden prohibited sign travel'
    'no_bicycles':
      'unicode': '1f6b3'
      'shortname': ':no_bicycles:'
      'aliases': ''
      'keywords': 'no bicycles cyclist prohibited bike pedal bicycle forbidden not place sign sport symbol travel vehicle'
    'non-potable_water':
      'unicode': '1f6b1'
      'shortname': ':non-potable_water:'
      'aliases': ''
      'keywords': 'non-potable water symbol drink faucet tap undrinkable dirty gross aqua h20 forbidden no not potable prohibited sign travel'
    'underage':
      'unicode': '1f51e'
      'shortname': ':underage:'
      'aliases': ''
      'keywords': 'no one under eighteen symbol 18 drink night pub age restriction forbidden not prohibited underage word'
    'no_mobile_phones':
      'unicode': '1f4f5'
      'shortname': ':no_mobile_phones:'
      'aliases': ''
      'keywords': 'no mobile phones iphone mute cell communication forbidden not object phone prohibited symbol telephone'
    'exclamation':
      'unicode': '2757'
      'shortname': ':exclamation:'
      'aliases': ''
      'keywords': 'heavy exclamation mark symbol surprise punctuation word'
    'grey_exclamation':
      'unicode': '2755'
      'shortname': ':grey_exclamation:'
      'aliases': ''
      'keywords': 'white exclamation mark ornament surprise outlined punctuation symbol word'
    'question':
      'unicode': '2753'
      'shortname': ':question:'
      'aliases': ''
      'keywords': 'black question mark ornament confused doubt punctuation symbol word'
    'grey_question':
      'unicode': '2754'
      'shortname': ':grey_question:'
      'aliases': ''
      'keywords': 'white question mark ornament confused doubt outlined punctuation symbol word'
    'bangbang':
      'unicode': '203c'
      'shortname': ':bangbang:'
      'aliases': ''
      'keywords': 'double exclamation mark surprise bangbang punctuation symbol word'
    'interrobang':
      'unicode': '2049'
      'shortname': ':interrobang:'
      'aliases': ''
      'keywords': 'exclamation question mark punctuation surprise wat interrobang symbol word'
    '100':
      'unicode': '1f4af'
      'shortname': ':100:'
      'aliases': ''
      'keywords': 'hundred points symbol numbers score percent a plus perfect school quiz score test exam 100 full office'
    'low_brightness':
      'unicode': '1f505'
      'shortname': ':low_brightness:'
      'aliases': ''
      'keywords': 'low brightness symbol summer sun dim sign'
    'high_brightness':
      'unicode': '1f506'
      'shortname': ':high_brightness:'
      'aliases': ''
      'keywords': 'high brightness symbol light summer sun bright sign'
    'trident':
      'unicode': '1f531'
      'shortname': ':trident:'
      'aliases': ''
      'keywords': 'trident emblem spear weapon poseidon neptune anchor object ship symbol tool'
    'fleur-de-lis':
      'unicode': '269c'
      'shortname': ':fleur-de-lis:'
      'aliases': ''
      'keywords': 'fleur-de-lis symbol'
    'part_alternation_mark':
      'unicode': '303d'
      'shortname': ':part_alternation_mark:'
      'aliases': ''
      'keywords': 'part alternation mark graph sing song vocal music karaoke cue letter m japanese sign symbol'
    'warning':
      'unicode': '26a0'
      'shortname': ':warning:'
      'aliases': ''
      'keywords': 'warning sign exclamation wip place symbol travel'
    'children_crossing':
      'unicode': '1f6b8'
      'shortname': ':children_crossing:'
      'aliases': ''
      'keywords': 'children crossing school kids caution street crosswalk slow sign child pedestrian place symbol traffic travel'
    'beginner':
      'unicode': '1f530'
      'shortname': ':beginner:'
      'aliases': ''
      'keywords': 'japanese symbol for beginner badge shield chevron green leaf object tool yellow'
    'recycle':
      'unicode': '267b'
      'shortname': ':recycle:'
      'aliases': ''
      'keywords': 'black universal recycling symbol arrow environment garbage trash recycle sign'
    'u6307':
      'unicode': '1f22f'
      'shortname': ':u6307:'
      'aliases': ''
      'keywords': 'squared cjk unified ideograph-6307 chinese green-square kanji point japanese symbol word'
    'chart':
      'unicode': '1f4b9'
      'shortname': ':chart:'
      'aliases': ''
      'keywords': 'chart with upwards trend and yen sign graph green-square bank currency growth market money object office rise symbol upward'
    'sparkle':
      'unicode': '2747'
      'shortname': ':sparkle:'
      'aliases': ''
      'keywords': 'sparkle green-square stars sign symbol'
    'eight_spoked_asterisk':
      'unicode': '2733'
      'shortname': ':eight_spoked_asterisk:'
      'aliases': ''
      'keywords': 'eight spoked asterisk green-square sparkle star sign symbol'
    'negative_squared_cross_mark':
      'unicode': '274e'
      'shortname': ':negative_squared_cross_mark:'
      'aliases': ''
      'keywords': 'negative squared cross mark deny green-square no x sign square symbol'
    'white_check_mark':
      'unicode': '2705'
      'shortname': ':white_check_mark:'
      'aliases': ''
      'keywords': 'white heavy check mark agree green-square ok sign symbol'
    'diamond_shape_with_a_dot_inside':
      'unicode': '1f4a0'
      'shortname': ':diamond_shape_with_a_dot_inside:'
      'aliases': ''
      'keywords': 'diamond shape with a dot inside cute cuteness kawaii japanese glyph adorable comic geometric sign symbol'
    'cyclone':
      'unicode': '1f300'
      'shortname': ':cyclone:'
      'aliases': ''
      'keywords': 'cyclone blue cloud swirl weather hurricane typhoon storm ocean dizzy nature twister'
    'loop':
      'unicode': '27bf'
      'shortname': ':loop:'
      'aliases': ''
      'keywords': 'double curly loop blue-square curl sign symbol'
    'globe_with_meridians':
      'unicode': '1f310'
      'shortname': ':globe_with_meridians:'
      'aliases': ''
      'keywords': 'globe with meridians earth international world space planet nature place'
    'm':
      'unicode': '24c2'
      'shortname': ':m:'
      'aliases': ''
      'keywords': 'circled latin capital letter m alphabet blue-circle circle place symbol word'
    'atm':
      'unicode': '1f3e7'
      'shortname': ':atm:'
      'aliases': ''
      'keywords': 'automated teller machine atm cash withdrawal money deposit financial bank adam payday blue-square payment place sign symbol'
    'sa':
      'unicode': '1f202'
      'shortname': ':sa:'
      'aliases': ''
      'keywords': 'squared katakana sa blue-square japanese symbol word'
    'passport_control':
      'unicode': '1f6c2'
      'shortname': ':passport_control:'
      'aliases': ''
      'keywords': 'passport control blue-square customs official travel foreign identification check authority government border place sign symbol'
    'customs':
      'unicode': '1f6c3'
      'shortname': ':customs:'
      'aliases': ''
      'keywords': 'customs blue-square official border passport travel foreign goods check authority government place sign symbol'
    'baggage_claim':
      'unicode': '1f6c4'
      'shortname': ':baggage_claim:'
      'aliases': ''
      'keywords': 'baggage claim airport blue-square transport bag luggage travel suitcase place sign symbol'
    'left_luggage':
      'unicode': '1f6c5'
      'shortname': ':left_luggage:'
      'aliases': ''
      'keywords': 'left luggage blue-square travel bag baggage suitcase left luggage locker place sign symbol'
    'wheelchair':
      'unicode': '267f'
      'shortname': ':wheelchair:'
      'aliases': ''
      'keywords': 'wheelchair symbol blue-square disabled handicapped access sign travel'
    'no_smoking':
      'unicode': '1f6ad'
      'shortname': ':no_smoking:'
      'aliases': ''
      'keywords': 'no smoking symbol cigarette smoke cancer lungs inhale tar nicotine forbidden not prohibited sign travel'
    'wc':
      'unicode': '1f6be'
      'shortname': ':wc:'
      'aliases': ''
      'keywords': 'water closet blue-square restroom toilet bathroom throne porcelain waste flush plumbing wc lavatory place sign symbol travel'
    'parking':
      'unicode': '1f17f'
      'shortname': ':parking:'
      'aliases': ''
      'keywords': 'negative squared latin capital letter p alphabet blue-square cars letter parking place sign symbol word'
    'potable_water':
      'unicode': '1f6b0'
      'shortname': ':potable_water:'
      'aliases': ''
      'keywords': 'potable water symbol blue-square faucet liquid drinkable pure clear clean aqua h20 drink sign travel'
    'mens':
      'unicode': '1f6b9'
      'shortname': ':mens:'
      'aliases': ''
      'keywords': 'mens symbol restroom toilet wc men bathroom sign boy male avatar lavatory man travel'
    'womens':
      'unicode': '1f6ba'
      'shortname': ':womens:'
      'aliases': ''
      'keywords': 'womens symbol purple-square woman bathroom restroom sign girl female avatar lavatory travel wc'
    'baby_symbol':
      'unicode': '1f6bc'
      'shortname': ':baby_symbol:'
      'aliases': ''
      'keywords': 'baby symbol child orange-square crawl newborn human diaper small babe changing sign travel'
    'restroom':
      'unicode': '1f6bb'
      'shortname': ':restroom:'
      'aliases': ''
      'keywords': 'restroom blue-square woman man unisex bathroom sign toilet lavatory symbol travel wc'
    'put_litter_in_its_place':
      'unicode': '1f6ae'
      'shortname': ':put_litter_in_its_place:'
      'aliases': ''
      'keywords': 'put litter in its place symbol blue-square waste trash garbage receptacle can litterbox travel'
    'cinema':
      'unicode': '1f3a6'
      'shortname': ':cinema:'
      'aliases': ''
      'keywords': 'cinema blue-square film movie record theater motion picture activity camera entertainment object symbol'
    'signal_strength':
      'unicode': '1f4f6'
      'shortname': ':signal_strength:'
      'aliases': ''
      'keywords': 'antenna with bars blue-square cell bar communication mobile object phone signal symbol telephone'
    'koko':
      'unicode': '1f201'
      'shortname': ':koko:'
      'aliases': ''
      'keywords': 'squared katakana koko blue-square destination here japanese symbol word'
    'ng':
      'unicode': '1f196'
      'shortname': ':ng:'
      'aliases': ''
      'keywords': 'squared ng blue-square no good symbol word'
    'ok':
      'unicode': '1f197'
      'shortname': ':ok:'
      'aliases': ''
      'keywords': 'squared ok agree blue-square good yes symbol word'
    'up':
      'unicode': '1f199'
      'shortname': ':up:'
      'aliases': ''
      'keywords': 'squared up with exclamation mark blue-square symbol word'
    'cool':
      'unicode': '1f192'
      'shortname': ':cool:'
      'aliases': ''
      'keywords': 'squared cool blue-square words symbol word'
    'new':
      'unicode': '1f195'
      'shortname': ':new:'
      'aliases': ''
      'keywords': 'squared new blue-square symbol word'
    'free':
      'unicode': '1f193'
      'shortname': ':free:'
      'aliases': ''
      'keywords': 'squared free blue-square words symbol word'
    'zero':
      'unicode': '0030-20e3'
      'shortname': ':zero:'
      'aliases': ''
      'keywords': 'keycap digit zero blue-square numbers 0 symbol word'
    'one':
      'unicode': '0031-20e3'
      'shortname': ':one:'
      'aliases': ''
      'keywords': 'keycap digit one 1 blue-square numbers symbol word'
    'two':
      'unicode': '0032-20e3'
      'shortname': ':two:'
      'aliases': ''
      'keywords': 'keycap digit two 2 blue-square numbers prime symbol word'
    'three':
      'unicode': '0033-20e3'
      'shortname': ':three:'
      'aliases': ''
      'keywords': 'keycap digit three 3 blue-square numbers prime symbol word'
    'four':
      'unicode': '0034-20e3'
      'shortname': ':four:'
      'aliases': ''
      'keywords': 'keycap digit four 4 blue-square numbers symbol word'
    'five':
      'unicode': '0035-20e3'
      'shortname': ':five:'
      'aliases': ''
      'keywords': 'keycap digit five blue-square numbers prime 5 symbol word'
    'six':
      'unicode': '0036-20e3'
      'shortname': ':six:'
      'aliases': ''
      'keywords': 'keycap digit six 6 blue-square numbers symbol word'
    'seven':
      'unicode': '0037-20e3'
      'shortname': ':seven:'
      'aliases': ''
      'keywords': 'keycap digit seven 7 blue-square numbers prime symbol word'
    'eight':
      'unicode': '0038-20e3'
      'shortname': ':eight:'
      'aliases': ''
      'keywords': 'keycap digit eight 8 blue-square numbers symbol word'
    'nine':
      'unicode': '0039-20e3'
      'shortname': ':nine:'
      'aliases': ''
      'keywords': 'keycap digit nine 9 blue-square numbers symbol word'
    'ten':
      'unicode': '1f51f'
      'shortname': ':ten:'
      'aliases': ''
      'keywords': 'keycap ten 10 blue-square numbers symbol word'
    '1234':
      'unicode': '1f522'
      'shortname': ':1234:'
      'aliases': ''
      'keywords': 'input symbol for numbers blue-square 1234 word'
    'arrow_forward':
      'unicode': '25b6'
      'shortname': ':arrow_forward:'
      'aliases': ''
      'keywords': 'black right-pointing triangle arrow blue-square forward play right sound symbol'
    'pause_button':
      'unicode': '23f8'
      'shortname': ':pause_button:'
      'aliases': ':double_vertical_bar:'
      'keywords': 'double vertical bar pause sound symbol'
    'play_pause':
      'unicode': '23ef'
      'shortname': ':play_pause:'
      'aliases': ''
      'keywords': 'black right-pointing double triangle with double vertical bar arrow pause play right sound symbol'
    'stop_button':
      'unicode': '23f9'
      'shortname': ':stop_button:'
      'aliases': ''
      'keywords': 'black square for stop sound symbol'
    'record_button':
      'unicode': '23fa'
      'shortname': ':record_button:'
      'aliases': ''
      'keywords': 'black circle for record sound symbol'
    'track_next':
      'unicode': '23ed'
      'shortname': ':track_next:'
      'aliases': ':next_track:'
      'keywords': 'black right-pointing double triangle with vertical bar arrow next scene next track sound symbol'
    'track_previous':
      'unicode': '23ee'
      'shortname': ':track_previous:'
      'aliases': ':previous_track:'
      'keywords': 'black left-pointing double triangle with vertical bar arrow previous scene previous track sound symbol'
    'fast_forward':
      'unicode': '23e9'
      'shortname': ':fast_forward:'
      'aliases': ''
      'keywords': 'black right-pointing double triangle blue-square fast forward arrow sound symbol'
    'rewind':
      'unicode': '23ea'
      'shortname': ':rewind:'
      'aliases': ''
      'keywords': 'black left-pointing double triangle blue-square play rewind arrow sound symbol'
    'twisted_rightwards_arrows':
      'unicode': '1f500'
      'shortname': ':twisted_rightwards_arrows:'
      'aliases': ''
      'keywords': 'twisted rightwards arrows blue-square arrow crossed symbol'
    'repeat':
      'unicode': '1f501'
      'shortname': ':repeat:'
      'aliases': ''
      'keywords': 'clockwise rightwards and leftwards open circle arrows loop record repeat arrow symbol'
    'repeat_one':
      'unicode': '1f502'
      'shortname': ':repeat_one:'
      'aliases': ''
      'keywords': 'clockwise rightwards and leftwards open circle arrows with circled one overlay blue-square loop repeat once arrow symbol'
    'arrow_backward':
      'unicode': '25c0'
      'shortname': ':arrow_backward:'
      'aliases': ''
      'keywords': 'black left-pointing triangle arrow blue-square backward left reverse sound symbol'
    'arrow_up_small':
      'unicode': '1f53c'
      'shortname': ':arrow_up_small:'
      'aliases': ''
      'keywords': 'up-pointing small red triangle blue-square arrow button symbol'
    'arrow_down_small':
      'unicode': '1f53d'
      'shortname': ':arrow_down_small:'
      'aliases': ''
      'keywords': 'down-pointing small red triangle arrow blue-square button down symbol'
    'arrow_double_up':
      'unicode': '23eb'
      'shortname': ':arrow_double_up:'
      'aliases': ''
      'keywords': 'black up-pointing double triangle arrow blue-square sound symbol'
    'arrow_double_down':
      'unicode': '23ec'
      'shortname': ':arrow_double_down:'
      'aliases': ''
      'keywords': 'black down-pointing double triangle arrow blue-square down sound symbol'
    'arrow_right':
      'unicode': '27a1'
      'shortname': ':arrow_right:'
      'aliases': ''
      'keywords': 'black rightwards arrow blue-square next forward right cardinal direction east symbol'
    'arrow_left':
      'unicode': '2b05'
      'shortname': ':arrow_left:'
      'aliases': ''
      'keywords': 'leftwards black arrow blue-square previous back left cardinal direction symbol west'
    'arrow_up':
      'unicode': '2b06'
      'shortname': ':arrow_up:'
      'aliases': ''
      'keywords': 'upwards black arrow blue-square up cardinal direction north symbol'
    'arrow_down':
      'unicode': '2b07'
      'shortname': ':arrow_down:'
      'aliases': ''
      'keywords': 'downwards black arrow blue-square down cardinal direction south symbol'
    'arrow_upper_right':
      'unicode': '2197'
      'shortname': ':arrow_upper_right:'
      'aliases': ''
      'keywords': 'north east arrow blue-square upper right direction intercardinal northeast symbol'
    'arrow_lower_right':
      'unicode': '2198'
      'shortname': ':arrow_lower_right:'
      'aliases': ''
      'keywords': 'south east arrow blue-square lower right direction intercardinal southeast symbol'
    'arrow_lower_left':
      'unicode': '2199'
      'shortname': ':arrow_lower_left:'
      'aliases': ''
      'keywords': 'south west arrow blue-square lower left direction intercardinal southwest symbol'
    'arrow_upper_left':
      'unicode': '2196'
      'shortname': ':arrow_upper_left:'
      'aliases': ''
      'keywords': 'north west arrow blue-square upper left direction intercardinal northwest symbol'
    'arrow_up_down':
      'unicode': '2195'
      'shortname': ':arrow_up_down:'
      'aliases': ''
      'keywords': 'up down arrow blue-square symbol'
    'left_right_arrow':
      'unicode': '2194'
      'shortname': ':left_right_arrow:'
      'aliases': ''
      'keywords': 'left right arrow blue-square symbol'
    'arrows_counterclockwise':
      'unicode': '1f504'
      'shortname': ':arrows_counterclockwise:'
      'aliases': ''
      'keywords': 'anticlockwise downwards and upwards open circle arrows blue-square sync counterclockwise arrow symbol withershins'
    'arrow_right_hook':
      'unicode': '21aa'
      'shortname': ':arrow_right_hook:'
      'aliases': ''
      'keywords': 'rightwards arrow with hook arrow blue-square turn symbol'
    'leftwards_arrow_with_hook':
      'unicode': '21a9'
      'shortname': ':leftwards_arrow_with_hook:'
      'aliases': ''
      'keywords': 'leftwards arrow with hook arrow blue-square turn symbol'
    'arrow_heading_up':
      'unicode': '2934'
      'shortname': ':arrow_heading_up:'
      'aliases': ''
      'keywords': 'arrow pointing rightwards then curving upwards arrow blue-square up symbol'
    'arrow_heading_down':
      'unicode': '2935'
      'shortname': ':arrow_heading_down:'
      'aliases': ''
      'keywords': 'arrow pointing rightwards then curving downwards arrow blue-square down symbol'
    'hash':
      'unicode': '0023-20e3'
      'shortname': ':hash:'
      'aliases': ''
      'keywords': 'keycap number sign symbol hash pound word'
    'asterisk':
      'unicode': '002a-20e3'
      'shortname': ':asterisk:'
      'aliases': ':keycap_asterisk:'
      'keywords': 'keycap asterisk * star symbol'
    'information_source':
      'unicode': '2139'
      'shortname': ':information_source:'
      'aliases': ''
      'keywords': 'information source alphabet blue-square letter i symbol word'
    'abc':
      'unicode': '1f524'
      'shortname': ':abc:'
      'aliases': ''
      'keywords': 'input symbol for latin letters alphabet blue-square abc word'
    'abcd':
      'unicode': '1f521'
      'shortname': ':abcd:'
      'aliases': ''
      'keywords': 'input symbol for latin small letters alphabet blue-square abcd lowercase word'
    'capital_abcd':
      'unicode': '1f520'
      'shortname': ':capital_abcd:'
      'aliases': ''
      'keywords': 'input symbol for latin capital letters alphabet blue-square uppercase word'
    'symbols':
      'unicode': '1f523'
      'shortname': ':symbols:'
      'aliases': ''
      'keywords': 'input symbol for symbols blue-square word'
    'musical_note':
      'unicode': '1f3b5'
      'shortname': ':musical_note:'
      'aliases': ''
      'keywords': 'musical note score music sound tone activity entertainment object'
    'notes':
      'unicode': '1f3b6'
      'shortname': ':notes:'
      'aliases': ''
      'keywords': 'multiple musical notes music score sound melody tone activity entertainment note object'
    'wavy_dash':
      'unicode': '3030'
      'shortname': ':wavy_dash:'
      'aliases': ''
      'keywords': 'wavy dash draw line punctuation sound symbol'
    'curly_loop':
      'unicode': '27b0'
      'shortname': ':curly_loop:'
      'aliases': ''
      'keywords': 'curly loop scribble curl sign symbol'
    'heavy_check_mark':
      'unicode': '2714'
      'shortname': ':heavy_check_mark:'
      'aliases': ''
      'keywords': 'heavy check mark nike ok go sign symbol'
    'arrows_clockwise':
      'unicode': '1f503'
      'shortname': ':arrows_clockwise:'
      'aliases': ''
      'keywords': 'clockwise downwards and upwards open circle arrows sync arrow reload symbol'
    'heavy_plus_sign':
      'unicode': '2795'
      'shortname': ':heavy_plus_sign:'
      'aliases': ''
      'keywords': 'heavy plus sign calculation math add addition symbol'
    'heavy_minus_sign':
      'unicode': '2796'
      'shortname': ':heavy_minus_sign:'
      'aliases': ''
      'keywords': 'heavy minus sign calculation math sub subtract symbol'
    'heavy_division_sign':
      'unicode': '2797'
      'shortname': ':heavy_division_sign:'
      'aliases': ''
      'keywords': 'heavy division sign calculation divide math symbol'
    'heavy_multiplication_x':
      'unicode': '2716'
      'shortname': ':heavy_multiplication_x:'
      'aliases': ''
      'keywords': 'heavy multiplication x calculation math multiply times cancel sign symbol'
    'heavy_dollar_sign':
      'unicode': '1f4b2'
      'shortname': ':heavy_dollar_sign:'
      'aliases': ''
      'keywords': 'heavy dollar sign currency money payment cash sale purchase value object office symbol'
    'currency_exchange':
      'unicode': '1f4b1'
      'shortname': ':currency_exchange:'
      'aliases': ''
      'keywords': 'currency exchange dollar money travel bank object office symbol'
    'copyright':
      'unicode': '00a9'
      'shortname': ':copyright:'
      'aliases': ''
      'keywords': 'copyright sign ip license symbol word'
    'registered':
      'unicode': '00ae'
      'shortname': ':registered:'
      'aliases': ''
      'keywords': 'registered sign alphabet circle symbol word'
    'tm':
      'unicode': '2122'
      'shortname': ':tm:'
      'aliases': ''
      'keywords': 'trade mark sign brand trademark symbol tm word'
    'end':
      'unicode': '1f51a'
      'shortname': ':end:'
      'aliases': ''
      'keywords': 'end with leftwards arrow above words symbol'
    'back':
      'unicode': '1f519'
      'shortname': ':back:'
      'aliases': ''
      'keywords': 'back with leftwards arrow above words symbol'
    'on':
      'unicode': '1f51b'
      'shortname': ':on:'
      'aliases': ''
      'keywords': 'on with exclamation mark with left right arrow abo words symbol'
    'top':
      'unicode': '1f51d'
      'shortname': ':top:'
      'aliases': ''
      'keywords': 'top with upwards arrow above words symbol up'
    'soon':
      'unicode': '1f51c'
      'shortname': ':soon:'
      'aliases': ''
      'keywords': 'soon with rightwards arrow above words symbol'
    'ballot_box_with_check':
      'unicode': '2611'
      'shortname': ':ballot_box_with_check:'
      'aliases': ''
      'keywords': 'ballot box with check agree ok sign symbol'
    'radio_button':
      'unicode': '1f518'
      'shortname': ':radio_button:'
      'aliases': ''
      'keywords': 'radio button input geometric sign symbol'
    'white_circle':
      'unicode': '26aa'
      'shortname': ':white_circle:'
      'aliases': ''
      'keywords': 'medium white circle shape geometric sign symbol'
    'black_circle':
      'unicode': '26ab'
      'shortname': ':black_circle:'
      'aliases': ''
      'keywords': 'medium black circle shape geometric sign symbol'
    'red_circle':
      'unicode': '1f534'
      'shortname': ':red_circle:'
      'aliases': ''
      'keywords': 'large red circle shape geometric sign symbol'
    'large_blue_circle':
      'unicode': '1f535'
      'shortname': ':large_blue_circle:'
      'aliases': ''
      'keywords': 'large blue circle shape geometric sign symbol'
    'small_orange_diamond':
      'unicode': '1f538'
      'shortname': ':small_orange_diamond:'
      'aliases': ''
      'keywords': 'small orange diamond shape geometric sign symbol'
    'small_blue_diamond':
      'unicode': '1f539'
      'shortname': ':small_blue_diamond:'
      'aliases': ''
      'keywords': 'small blue diamond shape geometric sign symbol'
    'large_orange_diamond':
      'unicode': '1f536'
      'shortname': ':large_orange_diamond:'
      'aliases': ''
      'keywords': 'large orange diamond shape geometric sign symbol'
    'large_blue_diamond':
      'unicode': '1f537'
      'shortname': ':large_blue_diamond:'
      'aliases': ''
      'keywords': 'large blue diamond shape geometric sign symbol'
    'small_red_triangle':
      'unicode': '1f53a'
      'shortname': ':small_red_triangle:'
      'aliases': ''
      'keywords': 'up-pointing red triangle shape geometric sign symbol'
    'black_small_square':
      'unicode': '25aa'
      'shortname': ':black_small_square:'
      'aliases': ''
      'keywords': 'black small square shape geometric sign symbol'
    'white_small_square':
      'unicode': '25ab'
      'shortname': ':white_small_square:'
      'aliases': ''
      'keywords': 'white small square shape geometric sign symbol'
    'black_large_square':
      'unicode': '2b1b'
      'shortname': ':black_large_square:'
      'aliases': ''
      'keywords': 'black large square shape geometric sign symbol'
    'white_large_square':
      'unicode': '2b1c'
      'shortname': ':white_large_square:'
      'aliases': ''
      'keywords': 'white large square shape geometric sign symbol'
    'small_red_triangle_down':
      'unicode': '1f53b'
      'shortname': ':small_red_triangle_down:'
      'aliases': ''
      'keywords': 'down-pointing red triangle shape down geometric sign symbol'
    'black_medium_square':
      'unicode': '25fc'
      'shortname': ':black_medium_square:'
      'aliases': ''
      'keywords': 'black medium square shape geometric sign symbol'
    'white_medium_square':
      'unicode': '25fb'
      'shortname': ':white_medium_square:'
      'aliases': ''
      'keywords': 'white medium square shape geometric sign symbol'
    'black_medium_small_square':
      'unicode': '25fe'
      'shortname': ':black_medium_small_square:'
      'aliases': ''
      'keywords': 'black medium small square shape geometric sign symbol'
    'white_medium_small_square':
      'unicode': '25fd'
      'shortname': ':white_medium_small_square:'
      'aliases': ''
      'keywords': 'white medium small square shape geometric sign symbol'
    'black_square_button':
      'unicode': '1f532'
      'shortname': ':black_square_button:'
      'aliases': ''
      'keywords': 'black square button frame geometric sign symbol'
    'white_square_button':
      'unicode': '1f533'
      'shortname': ':white_square_button:'
      'aliases': ''
      'keywords': 'white square button shape geometric outlined sign symbol'
    'speaker':
      'unicode': '1f508'
      'shortname': ':speaker:'
      'aliases': ''
      'keywords': 'speaker sound listen hear noise volume object'
    'sound':
      'unicode': '1f509'
      'shortname': ':sound:'
      'aliases': ''
      'keywords': 'speaker with one sound wave low volume object'
    'loud_sound':
      'unicode': '1f50a'
      'shortname': ':loud_sound:'
      'aliases': ''
      'keywords': 'speaker with three sound waves loud high volume 3 entertainment object'
    'mute':
      'unicode': '1f507'
      'shortname': ':mute:'
      'aliases': ''
      'keywords': 'speaker with cancellation stroke sound volume mute object quiet silent'
    'mega':
      'unicode': '1f4e3'
      'shortname': ':mega:'
      'aliases': ''
      'keywords': 'cheering megaphone sound speaker volume communication object'
    'loudspeaker':
      'unicode': '1f4e2'
      'shortname': ':loudspeaker:'
      'aliases': ''
      'keywords': 'public address loudspeaker sound volume communication loud object public address'
    'bell':
      'unicode': '1f514'
      'shortname': ':bell:'
      'aliases': ''
      'keywords': 'bell chime christmas notification sound xmas ring object'
    'no_bell':
      'unicode': '1f515'
      'shortname': ':no_bell:'
      'aliases': ''
      'keywords': 'bell with cancellation stroke mute sound volume no forbidden not object prohibited quiet silent'
    'black_joker':
      'unicode': '1f0cf'
      'shortname': ':black_joker:'
      'aliases': ''
      'keywords': 'playing card black joker cards game poker entertainment object'
    'mahjong':
      'unicode': '1f004'
      'shortname': ':mahjong:'
      'aliases': ''
      'keywords': 'mahjong tile red dragon chinese game kanji object'
    'spades':
      'unicode': '2660'
      'shortname': ':spades:'
      'aliases': ''
      'keywords': 'black spade suit cards poker card game symbol'
    'clubs':
      'unicode': '2663'
      'shortname': ':clubs:'
      'aliases': ''
      'keywords': 'black club suit cards poker card clubs game symbol'
    'hearts':
      'unicode': '2665'
      'shortname': ':hearts:'
      'aliases': ''
      'keywords': 'black heart suit cards poker card emotion game hearts symbol'
    'diamonds':
      'unicode': '2666'
      'shortname': ':diamonds:'
      'aliases': ''
      'keywords': 'black diamond suit cards poker card diamonds game symbol'
    'flower_playing_cards':
      'unicode': '1f3b4'
      'shortname': ':flower_playing_cards:'
      'aliases': ''
      'keywords': 'flower playing cards game august moon special activity card entertainment japanese object'
    'thought_balloon':
      'unicode': '1f4ad'
      'shortname': ':thought_balloon:'
      'aliases': ''
      'keywords': 'thought balloon bubble cloud comic think day dream wonder emotion object person'
    'anger_right':
      'unicode': '1f5ef'
      'shortname': ':anger_right:'
      'aliases': ':right_anger_bubble:'
      'keywords': 'right anger bubble speech balloon talk mood conversation communication comic angry emotion mad symbol'
    'speech_balloon':
      'unicode': '1f4ac'
      'shortname': ':speech_balloon:'
      'aliases': ''
      'keywords': 'speech balloon bubble words talk conversation communication comic dialogue dialog emotion object person'
    'clock1':
      'unicode': '1f550'
      'shortname': ':clock1:'
      'aliases': ''
      'keywords': 'clock face one oclock time 00 1 1:00 o\'clock symbol'
    'clock2':
      'unicode': '1f551'
      'shortname': ':clock2:'
      'aliases': ''
      'keywords': 'clock face two oclock time 00 2 2:00 o\'clock symbol'
    'clock3':
      'unicode': '1f552'
      'shortname': ':clock3:'
      'aliases': ''
      'keywords': 'clock face three oclock time 00 3 3:00 o\'clock symbol'
    'clock4':
      'unicode': '1f553'
      'shortname': ':clock4:'
      'aliases': ''
      'keywords': 'clock face four oclock time 00 4 4:00 o\'clock symbol'
    'clock5':
      'unicode': '1f554'
      'shortname': ':clock5:'
      'aliases': ''
      'keywords': 'clock face five oclock time 00 5 5:00 o\'clock symbol'
    'clock6':
      'unicode': '1f555'
      'shortname': ':clock6:'
      'aliases': ''
      'keywords': 'clock face six oclock time 00 6 6:00 o\'clock symbol'
    'clock7':
      'unicode': '1f556'
      'shortname': ':clock7:'
      'aliases': ''
      'keywords': 'clock face seven oclock time 00 7 7:00 o\'clock symbol'
    'clock8':
      'unicode': '1f557'
      'shortname': ':clock8:'
      'aliases': ''
      'keywords': 'clock face eight oclock time 00 8 8:00 o\'clock symbol'
    'clock9':
      'unicode': '1f558'
      'shortname': ':clock9:'
      'aliases': ''
      'keywords': 'clock face nine oclock time 00 9 9:00 o\'clock symbol'
    'clock10':
      'unicode': '1f559'
      'shortname': ':clock10:'
      'aliases': ''
      'keywords': 'clock face ten oclock time 00 10 10:00 o\'clock symbol'
    'clock11':
      'unicode': '1f55a'
      'shortname': ':clock11:'
      'aliases': ''
      'keywords': 'clock face eleven oclock time 00 11 11:00 o\'clock symbol'
    'clock12':
      'unicode': '1f55b'
      'shortname': ':clock12:'
      'aliases': ''
      'keywords': 'clock face twelve oclock time 00 12 12:00 o\'clock symbol'
    'clock130':
      'unicode': '1f55c'
      'shortname': ':clock130:'
      'aliases': ''
      'keywords': 'clock face one-thirty time 1 1:30 30 one symbol thirty'
    'clock230':
      'unicode': '1f55d'
      'shortname': ':clock230:'
      'aliases': ''
      'keywords': 'clock face two-thirty time 2 2:30 30 symbol thirty two'
    'clock330':
      'unicode': '1f55e'
      'shortname': ':clock330:'
      'aliases': ''
      'keywords': 'clock face three-thirty time 3 3:30 30 symbol thirty three'
    'clock430':
      'unicode': '1f55f'
      'shortname': ':clock430:'
      'aliases': ''
      'keywords': 'clock face four-thirty time 30 4 4:30 four symbol thirty'
    'clock530':
      'unicode': '1f560'
      'shortname': ':clock530:'
      'aliases': ''
      'keywords': 'clock face five-thirty time 30 5 5:30 five symbol thirty'
    'clock630':
      'unicode': '1f561'
      'shortname': ':clock630:'
      'aliases': ''
      'keywords': 'clock face six-thirty time 30 6 6:30 six symbol thirty'
    'clock730':
      'unicode': '1f562'
      'shortname': ':clock730:'
      'aliases': ''
      'keywords': 'clock face seven-thirty time 30 7 7:30 seven symbol thirty'
    'clock830':
      'unicode': '1f563'
      'shortname': ':clock830:'
      'aliases': ''
      'keywords': 'clock face eight-thirty time 30 8 8:30 eight symbol thirty'
    'clock930':
      'unicode': '1f564'
      'shortname': ':clock930:'
      'aliases': ''
      'keywords': 'clock face nine-thirty time 30 9 9:30 nine symbol thirty'
    'clock1030':
      'unicode': '1f565'
      'shortname': ':clock1030:'
      'aliases': ''
      'keywords': 'clock face ten-thirty time 10 10:30 30 symbol ten thirty'
    'clock1130':
      'unicode': '1f566'
      'shortname': ':clock1130:'
      'aliases': ''
      'keywords': 'clock face eleven-thirty time 11 11:30 30 eleven symbol thirty'
    'clock1230':
      'unicode': '1f567'
      'shortname': ':clock1230:'
      'aliases': ''
      'keywords': 'clock face twelve-thirty time 12 12:30 30 symbol thirty twelve'
    'eye_in_speech_bubble':
      'unicode': '1f441-1f5e8'
      'shortname': ':eye_in_speech_bubble:'
      'aliases': ''
      'keywords': 'eye in speech bubble'
    'flag_ac':
      'unicode': '1f1e6-1f1e8'
      'shortname': ':flag_ac:'
      'aliases': ':ac:'
      'keywords': 'ascension country nation ac flag island other'
    'flag_af':
      'unicode': '1f1e6-1f1eb'
      'shortname': ':flag_af:'
      'aliases': ':af:'
      'keywords': 'afghanistan country nation afghanestan af flag other'
    'flag_al':
      'unicode': '1f1e6-1f1f1'
      'shortname': ':flag_al:'
      'aliases': ':al:'
      'keywords': 'albania country nation shqiperia al flag other'
    'flag_dz':
      'unicode': '1f1e9-1f1ff'
      'shortname': ':flag_dz:'
      'aliases': ':dz:'
      'keywords': 'algeria country nation al jaza\'ir al jazair dz flag other'
    'flag_ad':
      'unicode': '1f1e6-1f1e9'
      'shortname': ':flag_ad:'
      'aliases': ':ad:'
      'keywords': 'andorra country nation ad flag other'
    'flag_ao':
      'unicode': '1f1e6-1f1f4'
      'shortname': ':flag_ao:'
      'aliases': ':ao:'
      'keywords': 'angola country nation ao flag other'
    'flag_ai':
      'unicode': '1f1e6-1f1ee'
      'shortname': ':flag_ai:'
      'aliases': ':ai:'
      'keywords': 'anguilla country nation ai flag other'
    'flag_ag':
      'unicode': '1f1e6-1f1ec'
      'shortname': ':flag_ag:'
      'aliases': ':ag:'
      'keywords': 'antigua and barbuda country nation ag flag other'
    'flag_ar':
      'unicode': '1f1e6-1f1f7'
      'shortname': ':flag_ar:'
      'aliases': ':ar:'
      'keywords': 'argentina country nation ar flag other'
    'flag_am':
      'unicode': '1f1e6-1f1f2'
      'shortname': ':flag_am:'
      'aliases': ':am:'
      'keywords': 'armenia country nation hayastan am flag other'
    'flag_aw':
      'unicode': '1f1e6-1f1fc'
      'shortname': ':flag_aw:'
      'aliases': ':aw:'
      'keywords': 'aruba country nation aw flag other'
    'flag_au':
      'unicode': '1f1e6-1f1fa'
      'shortname': ':flag_au:'
      'aliases': ':au:'
      'keywords': 'australia country nation au flag other'
    'flag_at':
      'unicode': '1f1e6-1f1f9'
      'shortname': ':flag_at:'
      'aliases': ':at:'
      'keywords': 'austria country nation österreich osterreich at flag other'
    'flag_az':
      'unicode': '1f1e6-1f1ff'
      'shortname': ':flag_az:'
      'aliases': ':az:'
      'keywords': 'azerbaijan country nation azarbaycan az flag other'
    'flag_bs':
      'unicode': '1f1e7-1f1f8'
      'shortname': ':flag_bs:'
      'aliases': ':bs:'
      'keywords': 'the bahamas country nation bs flag other'
    'flag_bh':
      'unicode': '1f1e7-1f1ed'
      'shortname': ':flag_bh:'
      'aliases': ':bh:'
      'keywords': 'bahrain country nation al bahrayn bh flag other'
    'flag_bd':
      'unicode': '1f1e7-1f1e9'
      'shortname': ':flag_bd:'
      'aliases': ':bd:'
      'keywords': 'bangladesh country nation bd flag other'
    'flag_bb':
      'unicode': '1f1e7-1f1e7'
      'shortname': ':flag_bb:'
      'aliases': ':bb:'
      'keywords': 'barbados country nation bb flag other'
    'flag_by':
      'unicode': '1f1e7-1f1fe'
      'shortname': ':flag_by:'
      'aliases': ':by:'
      'keywords': 'belarus country nation byelarus by flag other'
    'flag_be':
      'unicode': '1f1e7-1f1ea'
      'shortname': ':flag_be:'
      'aliases': ':be:'
      'keywords': 'belgium country nation belgique belgie be flag other'
    'flag_bz':
      'unicode': '1f1e7-1f1ff'
      'shortname': ':flag_bz:'
      'aliases': ':bz:'
      'keywords': 'belize country nation bz flag other'
    'flag_bj':
      'unicode': '1f1e7-1f1ef'
      'shortname': ':flag_bj:'
      'aliases': ':bj:'
      'keywords': 'benin country nation bj flag other'
    'flag_bm':
      'unicode': '1f1e7-1f1f2'
      'shortname': ':flag_bm:'
      'aliases': ':bm:'
      'keywords': 'bermuda country nation bm flag other'
    'flag_bt':
      'unicode': '1f1e7-1f1f9'
      'shortname': ':flag_bt:'
      'aliases': ':bt:'
      'keywords': 'bhutan country nation bt flag other'
    'flag_bo':
      'unicode': '1f1e7-1f1f4'
      'shortname': ':flag_bo:'
      'aliases': ':bo:'
      'keywords': 'bolivia country nation bo flag other'
    'flag_ba':
      'unicode': '1f1e7-1f1e6'
      'shortname': ':flag_ba:'
      'aliases': ':ba:'
      'keywords': 'bosnia and herzegovina country nation bosna i hercegovina ba flag other'
    'flag_bw':
      'unicode': '1f1e7-1f1fc'
      'shortname': ':flag_bw:'
      'aliases': ':bw:'
      'keywords': 'botswana country nation bw flag other'
    'flag_br':
      'unicode': '1f1e7-1f1f7'
      'shortname': ':flag_br:'
      'aliases': ':br:'
      'keywords': 'brazil country nation brasil br flag other'
    'flag_bn':
      'unicode': '1f1e7-1f1f3'
      'shortname': ':flag_bn:'
      'aliases': ':bn:'
      'keywords': 'brunei country nation bn darussalam flag other'
    'flag_bg':
      'unicode': '1f1e7-1f1ec'
      'shortname': ':flag_bg:'
      'aliases': ':bg:'
      'keywords': 'bulgaria country nation bg flag other'
    'flag_bf':
      'unicode': '1f1e7-1f1eb'
      'shortname': ':flag_bf:'
      'aliases': ':bf:'
      'keywords': 'burkina faso country nation bf burkina faso flag other'
    'flag_bi':
      'unicode': '1f1e7-1f1ee'
      'shortname': ':flag_bi:'
      'aliases': ':bi:'
      'keywords': 'burundi country nation bi flag other'
    'flag_cv':
      'unicode': '1f1e8-1f1fb'
      'shortname': ':flag_cv:'
      'aliases': ':cv:'
      'keywords': 'cape verde country nation cabo verde cv cabo flag other'
    'flag_kh':
      'unicode': '1f1f0-1f1ed'
      'shortname': ':flag_kh:'
      'aliases': ':kh:'
      'keywords': 'cambodia country nation kampuchea kh flag other'
    'flag_cm':
      'unicode': '1f1e8-1f1f2'
      'shortname': ':flag_cm:'
      'aliases': ':cm:'
      'keywords': 'cameroon country nation cm flag other'
    'flag_ca':
      'unicode': '1f1e8-1f1e6'
      'shortname': ':flag_ca:'
      'aliases': ':ca:'
      'keywords': 'canada country nation ca flag other'
    'flag_ky':
      'unicode': '1f1f0-1f1fe'
      'shortname': ':flag_ky:'
      'aliases': ':ky:'
      'keywords': 'cayman islands country nation ky flag island other'
    'flag_cf':
      'unicode': '1f1e8-1f1eb'
      'shortname': ':flag_cf:'
      'aliases': ':cf:'
      'keywords': 'central african republic country nation cf central african republic flag other'
    'flag_td':
      'unicode': '1f1f9-1f1e9'
      'shortname': ':flag_td:'
      'aliases': ':td:'
      'keywords': 'chad country nation tchad td flag other'
    'flag_cl':
      'unicode': '1f1e8-1f1f1'
      'shortname': ':flag_cl:'
      'aliases': ':chile:'
      'keywords': 'chile country nation cl flag other'
    'flag_cn':
      'unicode': '1f1e8-1f1f3'
      'shortname': ':flag_cn:'
      'aliases': ':cn:'
      'keywords': 'china chinese prc zhong guo country nation cn flag other'
    'flag_co':
      'unicode': '1f1e8-1f1f4'
      'shortname': ':flag_co:'
      'aliases': ':co:'
      'keywords': 'colombia country nation co flag other'
    'flag_km':
      'unicode': '1f1f0-1f1f2'
      'shortname': ':flag_km:'
      'aliases': ':km:'
      'keywords': 'the comoros country nation km flag other'
    'flag_cg':
      'unicode': '1f1e8-1f1ec'
      'shortname': ':flag_cg:'
      'aliases': ':cg:'
      'keywords': 'the republic of the congo country nation cg brazzaville congo republic congo-brazzaville flag other republic of the congo'
    'flag_cd':
      'unicode': '1f1e8-1f1e9'
      'shortname': ':flag_cd:'
      'aliases': ':congo:'
      'keywords': 'the democratic republic of the congo country nation république démocratique du congo republique democratique du congo cd congo-kinshasa democratic republic of congo drc flag kinshasa other'
    'flag_cr':
      'unicode': '1f1e8-1f1f7'
      'shortname': ':flag_cr:'
      'aliases': ':cr:'
      'keywords': 'costa rica country nation cr costa rica flag other'
    'flag_hr':
      'unicode': '1f1ed-1f1f7'
      'shortname': ':flag_hr:'
      'aliases': ':hr:'
      'keywords': 'croatia country nation hrvatska hr flag other'
    'flag_cu':
      'unicode': '1f1e8-1f1fa'
      'shortname': ':flag_cu:'
      'aliases': ':cu:'
      'keywords': 'cuba country nation cu flag other'
    'flag_cy':
      'unicode': '1f1e8-1f1fe'
      'shortname': ':flag_cy:'
      'aliases': ':cy:'
      'keywords': 'cyprus country nation kibris kypros cy flag other'
    'flag_cz':
      'unicode': '1f1e8-1f1ff'
      'shortname': ':flag_cz:'
      'aliases': ':cz:'
      'keywords': 'the czech republic country nation ceska republika cz czech republic flag other'
    'flag_dk':
      'unicode': '1f1e9-1f1f0'
      'shortname': ':flag_dk:'
      'aliases': ':dk:'
      'keywords': 'denmark country nation danmark dk flag other'
    'flag_dj':
      'unicode': '1f1e9-1f1ef'
      'shortname': ':flag_dj:'
      'aliases': ':dj:'
      'keywords': 'djibouti country nation dj flag other'
    'flag_dm':
      'unicode': '1f1e9-1f1f2'
      'shortname': ':flag_dm:'
      'aliases': ':dm:'
      'keywords': 'dominica country nation dm flag other'
    'flag_do':
      'unicode': '1f1e9-1f1f4'
      'shortname': ':flag_do:'
      'aliases': ':do:'
      'keywords': 'the dominican republic country nation do dominican republic flag other'
    'flag_ec':
      'unicode': '1f1ea-1f1e8'
      'shortname': ':flag_ec:'
      'aliases': ':ec:'
      'keywords': 'ecuador country nation ec flag other'
    'flag_eg':
      'unicode': '1f1ea-1f1ec'
      'shortname': ':flag_eg:'
      'aliases': ':eg:'
      'keywords': 'egypt country nation misr eg flag other'
    'flag_sv':
      'unicode': '1f1f8-1f1fb'
      'shortname': ':flag_sv:'
      'aliases': ':sv:'
      'keywords': 'el salvador country nation sv el salvador flag other'
    'flag_gq':
      'unicode': '1f1ec-1f1f6'
      'shortname': ':flag_gq:'
      'aliases': ':gq:'
      'keywords': 'equatorial guinea country nation guinea ecuatorial gq equatorial guinea flag other'
    'flag_er':
      'unicode': '1f1ea-1f1f7'
      'shortname': ':flag_er:'
      'aliases': ':er:'
      'keywords': 'eritrea country nation hagere ertra er flag other'
    'flag_ee':
      'unicode': '1f1ea-1f1ea'
      'shortname': ':flag_ee:'
      'aliases': ':ee:'
      'keywords': 'estonia country nation eesti vabariik ee flag other'
    'flag_et':
      'unicode': '1f1ea-1f1f9'
      'shortname': ':flag_et:'
      'aliases': ':et:'
      'keywords': 'ethiopia country nation ityop\'iya ityopiya et flag other'
    'flag_fk':
      'unicode': '1f1eb-1f1f0'
      'shortname': ':flag_fk:'
      'aliases': ':fk:'
      'keywords': 'falkland islands country nation islas malvinas fk falklands flag island islas malvinas other'
    'flag_fo':
      'unicode': '1f1eb-1f1f4'
      'shortname': ':flag_fo:'
      'aliases': ':fo:'
      'keywords': 'faroe islands country nation foroyar fo flag island other'
    'flag_fj':
      'unicode': '1f1eb-1f1ef'
      'shortname': ':flag_fj:'
      'aliases': ':fj:'
      'keywords': 'fiji country nation fj flag other'
    'flag_fi':
      'unicode': '1f1eb-1f1ee'
      'shortname': ':flag_fi:'
      'aliases': ':fi:'
      'keywords': 'finland country nation suomen tasavalta fi flag other'
    'flag_fr':
      'unicode': '1f1eb-1f1f7'
      'shortname': ':flag_fr:'
      'aliases': ':fr:'
      'keywords': 'france french nation country fr flag other'
    'flag_pf':
      'unicode': '1f1f5-1f1eb'
      'shortname': ':flag_pf:'
      'aliases': ':pf:'
      'keywords': 'french polynesia country nation polynésie française polynesie francaise pf flag other'
    'flag_ga':
      'unicode': '1f1ec-1f1e6'
      'shortname': ':flag_ga:'
      'aliases': ':ga:'
      'keywords': 'gabon country nation ga flag other'
    'flag_gm':
      'unicode': '1f1ec-1f1f2'
      'shortname': ':flag_gm:'
      'aliases': ':gm:'
      'keywords': 'the gambia country nation gm flag other'
    'flag_ge':
      'unicode': '1f1ec-1f1ea'
      'shortname': ':flag_ge:'
      'aliases': ':ge:'
      'keywords': 'georgia country nation sak\'art\'velo sakartvelo ge flag other'
    'flag_de':
      'unicode': '1f1e9-1f1ea'
      'shortname': ':flag_de:'
      'aliases': ':de:'
      'keywords': 'germany german nation deutschland country de flag other'
    'flag_gh':
      'unicode': '1f1ec-1f1ed'
      'shortname': ':flag_gh:'
      'aliases': ':gh:'
      'keywords': 'ghana country nation gh flag other'
    'flag_gi':
      'unicode': '1f1ec-1f1ee'
      'shortname': ':flag_gi:'
      'aliases': ':gi:'
      'keywords': 'gibraltar country nation gi flag other'
    'flag_gr':
      'unicode': '1f1ec-1f1f7'
      'shortname': ':flag_gr:'
      'aliases': ':gr:'
      'keywords': 'greece country nation ellas ellada gr flag other'
    'flag_gl':
      'unicode': '1f1ec-1f1f1'
      'shortname': ':flag_gl:'
      'aliases': ':gl:'
      'keywords': 'greenland country nation kalaallit nunaat gl flag other'
    'flag_gd':
      'unicode': '1f1ec-1f1e9'
      'shortname': ':flag_gd:'
      'aliases': ':gd:'
      'keywords': 'grenada country nation gd flag other'
    'flag_gu':
      'unicode': '1f1ec-1f1fa'
      'shortname': ':flag_gu:'
      'aliases': ':gu:'
      'keywords': 'guam country nation gu flag other'
    'flag_gt':
      'unicode': '1f1ec-1f1f9'
      'shortname': ':flag_gt:'
      'aliases': ':gt:'
      'keywords': 'guatemala country nation gt flag other'
    'flag_gn':
      'unicode': '1f1ec-1f1f3'
      'shortname': ':flag_gn:'
      'aliases': ':gn:'
      'keywords': 'guinea country nation guinee gn flag other'
    'flag_gw':
      'unicode': '1f1ec-1f1fc'
      'shortname': ':flag_gw:'
      'aliases': ':gw:'
      'keywords': 'guinea-bissau country nation guine-bissau guine bissau gw bissau flag guinea other'
    'flag_gy':
      'unicode': '1f1ec-1f1fe'
      'shortname': ':flag_gy:'
      'aliases': ':gy:'
      'keywords': 'guyana country nation gy flag other'
    'flag_ht':
      'unicode': '1f1ed-1f1f9'
      'shortname': ':flag_ht:'
      'aliases': ':ht:'
      'keywords': 'haiti country nation ht flag other'
    'flag_hn':
      'unicode': '1f1ed-1f1f3'
      'shortname': ':flag_hn:'
      'aliases': ':hn:'
      'keywords': 'honduras country nation hn flag other'
    'flag_hk':
      'unicode': '1f1ed-1f1f0'
      'shortname': ':flag_hk:'
      'aliases': ':hk:'
      'keywords': 'hong kong country nation xianggang hk china flag hong kong other'
    'flag_hu':
      'unicode': '1f1ed-1f1fa'
      'shortname': ':flag_hu:'
      'aliases': ':hu:'
      'keywords': 'hungary country nation magyarorszag hu flag other'
    'flag_is':
      'unicode': '1f1ee-1f1f8'
      'shortname': ':flag_is:'
      'aliases': ':is:'
      'keywords': 'iceland country nation lyoveldio island is flag other'
    'flag_in':
      'unicode': '1f1ee-1f1f3'
      'shortname': ':flag_in:'
      'aliases': ':in:'
      'keywords': 'india country nation bharat in flag other'
    'flag_id':
      'unicode': '1f1ee-1f1e9'
      'shortname': ':flag_id:'
      'aliases': ':indonesia:'
      'keywords': 'indonesia country nation id flag other'
    'flag_ir':
      'unicode': '1f1ee-1f1f7'
      'shortname': ':flag_ir:'
      'aliases': ':ir:'
      'keywords': 'iran country nation ir flag other'
    'flag_iq':
      'unicode': '1f1ee-1f1f6'
      'shortname': ':flag_iq:'
      'aliases': ':iq:'
      'keywords': 'iraq country nation iq flag other'
    'flag_ie':
      'unicode': '1f1ee-1f1ea'
      'shortname': ':flag_ie:'
      'aliases': ':ie:'
      'keywords': 'ireland country nation éire eire ie flag other'
    'flag_il':
      'unicode': '1f1ee-1f1f1'
      'shortname': ':flag_il:'
      'aliases': ':il:'
      'keywords': 'israel country nation yisra\'el yisrael il flag other'
    'flag_it':
      'unicode': '1f1ee-1f1f9'
      'shortname': ':flag_it:'
      'aliases': ':it:'
      'keywords': 'italy italia country nation it flag other'
    'flag_ci':
      'unicode': '1f1e8-1f1ee'
      'shortname': ':flag_ci:'
      'aliases': ':ci:'
      'keywords': 'côte d’ivoire country nation ci cote ivoire côte ivoire flag ivory coast other'
    'flag_jm':
      'unicode': '1f1ef-1f1f2'
      'shortname': ':flag_jm:'
      'aliases': ':jm:'
      'keywords': 'jamaica country nation jm flag other'
    'flag_jp':
      'unicode': '1f1ef-1f1f5'
      'shortname': ':flag_jp:'
      'aliases': ':jp:'
      'keywords': 'japan nation nippon country jp flag other'
    'flag_je':
      'unicode': '1f1ef-1f1ea'
      'shortname': ':flag_je:'
      'aliases': ':je:'
      'keywords': 'jersey country nation je flag other'
    'flag_jo':
      'unicode': '1f1ef-1f1f4'
      'shortname': ':flag_jo:'
      'aliases': ':jo:'
      'keywords': 'jordan country nation al urdun jo flag other'
    'flag_kz':
      'unicode': '1f1f0-1f1ff'
      'shortname': ':flag_kz:'
      'aliases': ':kz:'
      'keywords': 'kazakhstan country nation qazaqstan kz flag other'
    'flag_ke':
      'unicode': '1f1f0-1f1ea'
      'shortname': ':flag_ke:'
      'aliases': ':ke:'
      'keywords': 'kenya country nation ke flag other'
    'flag_ki':
      'unicode': '1f1f0-1f1ee'
      'shortname': ':flag_ki:'
      'aliases': ':ki:'
      'keywords': 'kiribati country nation kiribati kiribas ki flag other'
    'flag_xk':
      'unicode': '1f1fd-1f1f0'
      'shortname': ':flag_xk:'
      'aliases': ':xk:'
      'keywords': 'kosovo country nation xk flag other'
    'flag_kw':
      'unicode': '1f1f0-1f1fc'
      'shortname': ':flag_kw:'
      'aliases': ':kw:'
      'keywords': 'kuwait country nation al kuwayt kw flag other'
    'flag_kg':
      'unicode': '1f1f0-1f1ec'
      'shortname': ':flag_kg:'
      'aliases': ':kg:'
      'keywords': 'kyrgyzstan country nation kyrgyz respublikasy kg flag other'
    'flag_la':
      'unicode': '1f1f1-1f1e6'
      'shortname': ':flag_la:'
      'aliases': ':la:'
      'keywords': 'laos country nation la flag other'
    'flag_lv':
      'unicode': '1f1f1-1f1fb'
      'shortname': ':flag_lv:'
      'aliases': ':lv:'
      'keywords': 'latvia country nation latvija lv flag other'
    'flag_lb':
      'unicode': '1f1f1-1f1e7'
      'shortname': ':flag_lb:'
      'aliases': ':lb:'
      'keywords': 'lebanon country nation lubnan lb flag other'
    'flag_ls':
      'unicode': '1f1f1-1f1f8'
      'shortname': ':flag_ls:'
      'aliases': ':ls:'
      'keywords': 'lesotho country nation ls flag other'
    'flag_lr':
      'unicode': '1f1f1-1f1f7'
      'shortname': ':flag_lr:'
      'aliases': ':lr:'
      'keywords': 'liberia country nation lr flag other'
    'flag_ly':
      'unicode': '1f1f1-1f1fe'
      'shortname': ':flag_ly:'
      'aliases': ':ly:'
      'keywords': 'libya country nation libiyah ly flag other'
    'flag_li':
      'unicode': '1f1f1-1f1ee'
      'shortname': ':flag_li:'
      'aliases': ':li:'
      'keywords': 'liechtenstein country nation li flag other'
    'flag_lt':
      'unicode': '1f1f1-1f1f9'
      'shortname': ':flag_lt:'
      'aliases': ':lt:'
      'keywords': 'lithuania country nation lietuva lt flag other'
    'flag_lu':
      'unicode': '1f1f1-1f1fa'
      'shortname': ':flag_lu:'
      'aliases': ':lu:'
      'keywords': 'luxembourg country nation luxembourg letzebuerg lu flag other'
    'flag_mo':
      'unicode': '1f1f2-1f1f4'
      'shortname': ':flag_mo:'
      'aliases': ':mo:'
      'keywords': 'macau country nation aomen mo china flag macao other'
    'flag_mk':
      'unicode': '1f1f2-1f1f0'
      'shortname': ':flag_mk:'
      'aliases': ':mk:'
      'keywords': 'macedonia country nation mk flag other'
    'flag_mg':
      'unicode': '1f1f2-1f1ec'
      'shortname': ':flag_mg:'
      'aliases': ':mg:'
      'keywords': 'madagascar country nation mg flag other'
    'flag_mw':
      'unicode': '1f1f2-1f1fc'
      'shortname': ':flag_mw:'
      'aliases': ':mw:'
      'keywords': 'malawi country nation mw flag other'
    'flag_my':
      'unicode': '1f1f2-1f1fe'
      'shortname': ':flag_my:'
      'aliases': ':my:'
      'keywords': 'malaysia country nation my flag other'
    'flag_mv':
      'unicode': '1f1f2-1f1fb'
      'shortname': ':flag_mv:'
      'aliases': ':mv:'
      'keywords': 'maldives country nation dhivehi raajje mv flag other'
    'flag_ml':
      'unicode': '1f1f2-1f1f1'
      'shortname': ':flag_ml:'
      'aliases': ':ml:'
      'keywords': 'mali country nation ml flag other'
    'flag_mt':
      'unicode': '1f1f2-1f1f9'
      'shortname': ':flag_mt:'
      'aliases': ':mt:'
      'keywords': 'malta country nation mt flag other'
    'flag_mh':
      'unicode': '1f1f2-1f1ed'
      'shortname': ':flag_mh:'
      'aliases': ':mh:'
      'keywords': 'the marshall islands country nation mh flag island other'
    'flag_mr':
      'unicode': '1f1f2-1f1f7'
      'shortname': ':flag_mr:'
      'aliases': ':mr:'
      'keywords': 'mauritania country nation muritaniyah mr flag other'
    'flag_mu':
      'unicode': '1f1f2-1f1fa'
      'shortname': ':flag_mu:'
      'aliases': ':mu:'
      'keywords': 'mauritius country nation mu flag other'
    'flag_mx':
      'unicode': '1f1f2-1f1fd'
      'shortname': ':flag_mx:'
      'aliases': ':mx:'
      'keywords': 'mexico country nation mx flag other'
    'flag_fm':
      'unicode': '1f1eb-1f1f2'
      'shortname': ':flag_fm:'
      'aliases': ':fm:'
      'keywords': 'micronesia country nation fm flag other'
    'flag_md':
      'unicode': '1f1f2-1f1e9'
      'shortname': ':flag_md:'
      'aliases': ':md:'
      'keywords': 'moldova country nation md flag other'
    'flag_mc':
      'unicode': '1f1f2-1f1e8'
      'shortname': ':flag_mc:'
      'aliases': ':mc:'
      'keywords': 'monaco country nation mc flag other'
    'flag_mn':
      'unicode': '1f1f2-1f1f3'
      'shortname': ':flag_mn:'
      'aliases': ':mn:'
      'keywords': 'mongolia country nation mongol uls mn flag other'
    'flag_me':
      'unicode': '1f1f2-1f1ea'
      'shortname': ':flag_me:'
      'aliases': ':me:'
      'keywords': 'montenegro country nation crna gora me flag other'
    'flag_ms':
      'unicode': '1f1f2-1f1f8'
      'shortname': ':flag_ms:'
      'aliases': ':ms:'
      'keywords': 'montserrat country nation ms flag other'
    'flag_ma':
      'unicode': '1f1f2-1f1e6'
      'shortname': ':flag_ma:'
      'aliases': ':ma:'
      'keywords': 'morocco country nation al maghrib ma flag other'
    'flag_mz':
      'unicode': '1f1f2-1f1ff'
      'shortname': ':flag_mz:'
      'aliases': ':mz:'
      'keywords': 'mozambique country nation mocambique mz flag other'
    'flag_mm':
      'unicode': '1f1f2-1f1f2'
      'shortname': ':flag_mm:'
      'aliases': ':mm:'
      'keywords': 'myanmar country nation myanma naingngandaw mm burma flag other'
    'flag_na':
      'unicode': '1f1f3-1f1e6'
      'shortname': ':flag_na:'
      'aliases': ':na:'
      'keywords': 'namibia country nation na flag other'
    'flag_nr':
      'unicode': '1f1f3-1f1f7'
      'shortname': ':flag_nr:'
      'aliases': ':nr:'
      'keywords': 'nauru country nation nr flag other'
    'flag_np':
      'unicode': '1f1f3-1f1f5'
      'shortname': ':flag_np:'
      'aliases': ':np:'
      'keywords': 'nepal country nation np flag other'
    'flag_nl':
      'unicode': '1f1f3-1f1f1'
      'shortname': ':flag_nl:'
      'aliases': ':nl:'
      'keywords': 'the netherlands country nation nederland holland nl flag other'
    'flag_nc':
      'unicode': '1f1f3-1f1e8'
      'shortname': ':flag_nc:'
      'aliases': ':nc:'
      'keywords': 'new caledonia country nation nouvelle calédonie caledonie nc flag new caledonia other'
    'flag_nz':
      'unicode': '1f1f3-1f1ff'
      'shortname': ':flag_nz:'
      'aliases': ':nz:'
      'keywords': 'new zealand country nation aotearoa nz flag new zealand other'
    'flag_ni':
      'unicode': '1f1f3-1f1ee'
      'shortname': ':flag_ni:'
      'aliases': ':ni:'
      'keywords': 'nicaragua country nation ni flag other'
    'flag_ne':
      'unicode': '1f1f3-1f1ea'
      'shortname': ':flag_ne:'
      'aliases': ':ne:'
      'keywords': 'niger country nation ne flag other'
    'flag_ng':
      'unicode': '1f1f3-1f1ec'
      'shortname': ':flag_ng:'
      'aliases': ':nigeria:'
      'keywords': 'nigeria country nation ng flag other'
    'flag_nu':
      'unicode': '1f1f3-1f1fa'
      'shortname': ':flag_nu:'
      'aliases': ':nu:'
      'keywords': 'niue country nation nu flag other'
    'flag_kp':
      'unicode': '1f1f0-1f1f5'
      'shortname': ':flag_kp:'
      'aliases': ':kp:'
      'keywords': 'north korea country nation kp flag north korea other'
    'flag_no':
      'unicode': '1f1f3-1f1f4'
      'shortname': ':flag_no:'
      'aliases': ':no:'
      'keywords': 'norway country nation norge no flag other'
    'flag_om':
      'unicode': '1f1f4-1f1f2'
      'shortname': ':flag_om:'
      'aliases': ':om:'
      'keywords': 'oman country nation saltanat uman om flag other'
    'flag_pk':
      'unicode': '1f1f5-1f1f0'
      'shortname': ':flag_pk:'
      'aliases': ':pk:'
      'keywords': 'pakistan country nation pk flag other'
    'flag_pw':
      'unicode': '1f1f5-1f1fc'
      'shortname': ':flag_pw:'
      'aliases': ':pw:'
      'keywords': 'palau country nation belau pw flag other'
    'flag_ps':
      'unicode': '1f1f5-1f1f8'
      'shortname': ':flag_ps:'
      'aliases': ':ps:'
      'keywords': 'palestinian authority country nation ps flag other palestine'
    'flag_pa':
      'unicode': '1f1f5-1f1e6'
      'shortname': ':flag_pa:'
      'aliases': ':pa:'
      'keywords': 'panama country nation pa flag other'
    'flag_pg':
      'unicode': '1f1f5-1f1ec'
      'shortname': ':flag_pg:'
      'aliases': ':pg:'
      'keywords': 'papua new guinea country nation papua niu gini pg flag other papua new guinea'
    'flag_py':
      'unicode': '1f1f5-1f1fe'
      'shortname': ':flag_py:'
      'aliases': ':py:'
      'keywords': 'paraguay country nation py flag other'
    'flag_pe':
      'unicode': '1f1f5-1f1ea'
      'shortname': ':flag_pe:'
      'aliases': ':pe:'
      'keywords': 'peru country nation pe flag other'
    'flag_ph':
      'unicode': '1f1f5-1f1ed'
      'shortname': ':flag_ph:'
      'aliases': ':ph:'
      'keywords': 'the philippines country nation pilipinas ph flag other'
    'flag_pl':
      'unicode': '1f1f5-1f1f1'
      'shortname': ':flag_pl:'
      'aliases': ':pl:'
      'keywords': 'poland country nation polska pl flag other'
    'flag_pt':
      'unicode': '1f1f5-1f1f9'
      'shortname': ':flag_pt:'
      'aliases': ':pt:'
      'keywords': 'portugal country nation pt flag other'
    'flag_pr':
      'unicode': '1f1f5-1f1f7'
      'shortname': ':flag_pr:'
      'aliases': ':pr:'
      'keywords': 'puerto rico country nation pr flag other puerto rico'
    'flag_qa':
      'unicode': '1f1f6-1f1e6'
      'shortname': ':flag_qa:'
      'aliases': ':qa:'
      'keywords': 'qatar country nation dawlat qatar qa flag other'
    'flag_ro':
      'unicode': '1f1f7-1f1f4'
      'shortname': ':flag_ro:'
      'aliases': ':ro:'
      'keywords': 'romania country nation ro flag other'
    'flag_ru':
      'unicode': '1f1f7-1f1fa'
      'shortname': ':flag_ru:'
      'aliases': ':ru:'
      'keywords': 'russia nation russian country ru flag other'
    'flag_rw':
      'unicode': '1f1f7-1f1fc'
      'shortname': ':flag_rw:'
      'aliases': ':rw:'
      'keywords': 'rwanda country nation rw flag other'
    'flag_sh':
      'unicode': '1f1f8-1f1ed'
      'shortname': ':flag_sh:'
      'aliases': ':sh:'
      'keywords': 'saint helena country nation sh flag other'
    'flag_kn':
      'unicode': '1f1f0-1f1f3'
      'shortname': ':flag_kn:'
      'aliases': ':kn:'
      'keywords': 'saint kitts and nevis country nation kn flag other'
    'flag_lc':
      'unicode': '1f1f1-1f1e8'
      'shortname': ':flag_lc:'
      'aliases': ':lc:'
      'keywords': 'saint lucia country nation lc flag other'
    'flag_vc':
      'unicode': '1f1fb-1f1e8'
      'shortname': ':flag_vc:'
      'aliases': ':vc:'
      'keywords': 'saint vincent and the grenadines country nation vc flag other'
    'flag_ws':
      'unicode': '1f1fc-1f1f8'
      'shortname': ':flag_ws:'
      'aliases': ':ws:'
      'keywords': 'samoa country nation american samoa ws flag other'
    'flag_sm':
      'unicode': '1f1f8-1f1f2'
      'shortname': ':flag_sm:'
      'aliases': ':sm:'
      'keywords': 'san marino country nation sm flag other san marino'
    'flag_st':
      'unicode': '1f1f8-1f1f9'
      'shortname': ':flag_st:'
      'aliases': ':st:'
      'keywords': 'são tomé and príncipe country nation st flag other príncipe sao tome'
    'flag_sa':
      'unicode': '1f1f8-1f1e6'
      'shortname': ':flag_sa:'
      'aliases': ':saudiarabia: :saudi:'
      'keywords': 'saudi arabia country nation al arabiyah as suudiyah sa flag other saudi arabia'
    'flag_sn':
      'unicode': '1f1f8-1f1f3'
      'shortname': ':flag_sn:'
      'aliases': ':sn:'
      'keywords': 'senegal country nation sn flag other'
    'flag_rs':
      'unicode': '1f1f7-1f1f8'
      'shortname': ':flag_rs:'
      'aliases': ':rs:'
      'keywords': 'serbia country nation srbija rs flag other'
    'flag_sc':
      'unicode': '1f1f8-1f1e8'
      'shortname': ':flag_sc:'
      'aliases': ':sc:'
      'keywords': 'the seychelles country nation seychelles sc flag other'
    'flag_sl':
      'unicode': '1f1f8-1f1f1'
      'shortname': ':flag_sl:'
      'aliases': ':sl:'
      'keywords': 'sierra leone country nation sl flag other sierra leone'
    'flag_sg':
      'unicode': '1f1f8-1f1ec'
      'shortname': ':flag_sg:'
      'aliases': ':sg:'
      'keywords': 'singapore country nation sg flag other'
    'flag_sk':
      'unicode': '1f1f8-1f1f0'
      'shortname': ':flag_sk:'
      'aliases': ':sk:'
      'keywords': 'slovakia country nation sk flag other'
    'flag_si':
      'unicode': '1f1f8-1f1ee'
      'shortname': ':flag_si:'
      'aliases': ':si:'
      'keywords': 'slovenia country nation slovenija si flag other'
    'flag_sb':
      'unicode': '1f1f8-1f1e7'
      'shortname': ':flag_sb:'
      'aliases': ':sb:'
      'keywords': 'the solomon islands country nation sb flag island other'
    'flag_so':
      'unicode': '1f1f8-1f1f4'
      'shortname': ':flag_so:'
      'aliases': ':so:'
      'keywords': 'somalia country nation so flag other'
    'flag_za':
      'unicode': '1f1ff-1f1e6'
      'shortname': ':flag_za:'
      'aliases': ':za:'
      'keywords': 'south africa country nation flag other south africa'
    'flag_kr':
      'unicode': '1f1f0-1f1f7'
      'shortname': ':flag_kr:'
      'aliases': ':kr:'
      'keywords': 'korea nation country south korea kr flag other south'
    'flag_es':
      'unicode': '1f1ea-1f1f8'
      'shortname': ':flag_es:'
      'aliases': ':es:'
      'keywords': 'spain nation españa country espana es flag other'
    'flag_lk':
      'unicode': '1f1f1-1f1f0'
      'shortname': ':flag_lk:'
      'aliases': ':lk:'
      'keywords': 'sri lanka country nation lk flag other sri lanka'
    'flag_sd':
      'unicode': '1f1f8-1f1e9'
      'shortname': ':flag_sd:'
      'aliases': ':sd:'
      'keywords': 'sudan country nation as-sudan sd flag other'
    'flag_sr':
      'unicode': '1f1f8-1f1f7'
      'shortname': ':flag_sr:'
      'aliases': ':sr:'
      'keywords': 'suriname country nation sr flag other'
    'flag_sz':
      'unicode': '1f1f8-1f1ff'
      'shortname': ':flag_sz:'
      'aliases': ':sz:'
      'keywords': 'swaziland country nation sz flag other'
    'flag_se':
      'unicode': '1f1f8-1f1ea'
      'shortname': ':flag_se:'
      'aliases': ':se:'
      'keywords': 'sweden country nation sverige se flag other'
    'flag_ch':
      'unicode': '1f1e8-1f1ed'
      'shortname': ':flag_ch:'
      'aliases': ':ch:'
      'keywords': 'switzerland country nation swiss flag other'
    'flag_sy':
      'unicode': '1f1f8-1f1fe'
      'shortname': ':flag_sy:'
      'aliases': ':sy:'
      'keywords': 'syria country nation sy flag other'
    'flag_tw':
      'unicode': '1f1f9-1f1fc'
      'shortname': ':flag_tw:'
      'aliases': ':tw:'
      'keywords': 'the republic of china country nation taiwan tw flag other'
    'flag_tj':
      'unicode': '1f1f9-1f1ef'
      'shortname': ':flag_tj:'
      'aliases': ':tj:'
      'keywords': 'tajikistan country nation jumhurii tojikiston tj flag other'
    'flag_tz':
      'unicode': '1f1f9-1f1ff'
      'shortname': ':flag_tz:'
      'aliases': ':tz:'
      'keywords': 'tanzania country nation tz flag other'
    'flag_th':
      'unicode': '1f1f9-1f1ed'
      'shortname': ':flag_th:'
      'aliases': ':th:'
      'keywords': 'thailand country nation prathet thai th flag other'
    'flag_tl':
      'unicode': '1f1f9-1f1f1'
      'shortname': ':flag_tl:'
      'aliases': ':tl:'
      'keywords': 'timor-leste country nation tl east timor flag other timor-leste'
    'flag_tg':
      'unicode': '1f1f9-1f1ec'
      'shortname': ':flag_tg:'
      'aliases': ':tg:'
      'keywords': 'togo country nation republique togolaise tg flag other'
    'flag_to':
      'unicode': '1f1f9-1f1f4'
      'shortname': ':flag_to:'
      'aliases': ':to:'
      'keywords': 'tonga country nation to flag other'
    'flag_tt':
      'unicode': '1f1f9-1f1f9'
      'shortname': ':flag_tt:'
      'aliases': ':tt:'
      'keywords': 'trinidad and tobago country nation tt flag other'
    'flag_tn':
      'unicode': '1f1f9-1f1f3'
      'shortname': ':flag_tn:'
      'aliases': ':tn:'
      'keywords': 'tunisia country nation tunis tn flag other'
    'flag_tr':
      'unicode': '1f1f9-1f1f7'
      'shortname': ':flag_tr:'
      'aliases': ':tr:'
      'keywords': 'turkey country nation turkiye flag other'
    'flag_tm':
      'unicode': '1f1f9-1f1f2'
      'shortname': ':flag_tm:'
      'aliases': ':turkmenistan:'
      'keywords': 'turkmenistan country nation tm flag other'
    'flag_tv':
      'unicode': '1f1f9-1f1fb'
      'shortname': ':flag_tv:'
      'aliases': ':tuvalu:'
      'keywords': 'tuvalu country nation tv flag other'
    'flag_ug':
      'unicode': '1f1fa-1f1ec'
      'shortname': ':flag_ug:'
      'aliases': ':ug:'
      'keywords': 'uganda country nation ug flag other'
    'flag_ua':
      'unicode': '1f1fa-1f1e6'
      'shortname': ':flag_ua:'
      'aliases': ':ua:'
      'keywords': 'ukraine country nation ukrayina ua flag other'
    'flag_ae':
      'unicode': '1f1e6-1f1ea'
      'shortname': ':flag_ae:'
      'aliases': ':ae:'
      'keywords': 'the united arab emirates country nation ae flag other uae'
    'flag_gb':
      'unicode': '1f1ec-1f1e7'
      'shortname': ':flag_gb:'
      'aliases': ':gb:'
      'keywords': 'great britain UK gb britsh nation united kingdom england country british cornwall flag great britain ireland northern ireland other scotland uk union jack united wales'
    'flag_us':
      'unicode': '1f1fa-1f1f8'
      'shortname': ':flag_us:'
      'aliases': ':us:'
      'keywords': 'united states american country nation usa united states of america america old glory us flag other stars and stripes united states'
    'flag_vi':
      'unicode': '1f1fb-1f1ee'
      'shortname': ':flag_vi:'
      'aliases': ':vi:'
      'keywords': 'u.s. virgin islands country nation vi america american flag island other united united states us usa'
    'flag_uy':
      'unicode': '1f1fa-1f1fe'
      'shortname': ':flag_uy:'
      'aliases': ':uy:'
      'keywords': 'uruguay country nation uy flag other'
    'flag_uz':
      'unicode': '1f1fa-1f1ff'
      'shortname': ':flag_uz:'
      'aliases': ':uz:'
      'keywords': 'uzbekistan country nation uzbekiston respublikasi uz flag other'
    'flag_vu':
      'unicode': '1f1fb-1f1fa'
      'shortname': ':flag_vu:'
      'aliases': ':vu:'
      'keywords': 'vanuatu country nation vu flag other'
    'flag_va':
      'unicode': '1f1fb-1f1e6'
      'shortname': ':flag_va:'
      'aliases': ':va:'
      'keywords': 'the vatican city country nation va flag other'
    'flag_ve':
      'unicode': '1f1fb-1f1ea'
      'shortname': ':flag_ve:'
      'aliases': ':ve:'
      'keywords': 'venezuela country nation ve flag other'
    'flag_vn':
      'unicode': '1f1fb-1f1f3'
      'shortname': ':flag_vn:'
      'aliases': ':vn:'
      'keywords': 'vietnam country nation viet nam vn flag other'
    'flag_wf':
      'unicode': '1f1fc-1f1eb'
      'shortname': ':flag_wf:'
      'aliases': ':wf:'
      'keywords': 'wallis and futuna country nation wf flag other'
    'flag_eh':
      'unicode': '1f1ea-1f1ed'
      'shortname': ':flag_eh:'
      'aliases': ':eh:'
      'keywords': 'western sahara country nation sahra gharbiyah eh flag other west western sahara'
    'flag_ye':
      'unicode': '1f1fe-1f1ea'
      'shortname': ':flag_ye:'
      'aliases': ':ye:'
      'keywords': 'yemen country nation al yaman ye flag other'
    'flag_zm':
      'unicode': '1f1ff-1f1f2'
      'shortname': ':flag_zm:'
      'aliases': ':zm:'
      'keywords': 'zambia country nation zm flag other'
    'flag_zw':
      'unicode': '1f1ff-1f1fc'
      'shortname': ':flag_zw:'
      'aliases': ':zw:'
      'keywords': 'zimbabwe country nation zw flag other'
    'flag_re':
      'unicode': '1f1f7-1f1ea'
      'shortname': ':flag_re:'
      'aliases': ':re:'
      'keywords': 'réunion'
    'flag_ax':
      'unicode': '1f1e6-1f1fd'
      'shortname': ':flag_ax:'
      'aliases': ':ax:'
      'keywords': 'åland islands'
    'flag_ta':
      'unicode': '1f1f9-1f1e6'
      'shortname': ':flag_ta:'
      'aliases': ':ta:'
      'keywords': 'tristan da cunha'
    'flag_io':
      'unicode': '1f1ee-1f1f4'
      'shortname': ':flag_io:'
      'aliases': ':io:'
      'keywords': 'british indian ocean territory'
    'flag_bq':
      'unicode': '1f1e7-1f1f6'
      'shortname': ':flag_bq:'
      'aliases': ':bq:'
      'keywords': 'caribbean netherlands'
    'flag_cx':
      'unicode': '1f1e8-1f1fd'
      'shortname': ':flag_cx:'
      'aliases': ':cx:'
      'keywords': 'christmas island'
    'flag_cc':
      'unicode': '1f1e8-1f1e8'
      'shortname': ':flag_cc:'
      'aliases': ':cc:'
      'keywords': 'cocos (keeling) islands'
    'flag_gg':
      'unicode': '1f1ec-1f1ec'
      'shortname': ':flag_gg:'
      'aliases': ':gg:'
      'keywords': 'guernsey'
    'flag_im':
      'unicode': '1f1ee-1f1f2'
      'shortname': ':flag_im:'
      'aliases': ':im:'
      'keywords': 'isle of man'
    'flag_yt':
      'unicode': '1f1fe-1f1f9'
      'shortname': ':flag_yt:'
      'aliases': ':yt:'
      'keywords': 'mayotte'
    'flag_nf':
      'unicode': '1f1f3-1f1eb'
      'shortname': ':flag_nf:'
      'aliases': ':nf:'
      'keywords': 'norfolk island'
    'flag_pn':
      'unicode': '1f1f5-1f1f3'
      'shortname': ':flag_pn:'
      'aliases': ':pn:'
      'keywords': 'pitcairn'
    'flag_bl':
      'unicode': '1f1e7-1f1f1'
      'shortname': ':flag_bl:'
      'aliases': ':bl:'
      'keywords': 'saint barthélemy'
    'flag_pm':
      'unicode': '1f1f5-1f1f2'
      'shortname': ':flag_pm:'
      'aliases': ':pm:'
      'keywords': 'saint pierre and miquelon'
    'flag_gs':
      'unicode': '1f1ec-1f1f8'
      'shortname': ':flag_gs:'
      'aliases': ':gs:'
      'keywords': 'south georgia'
    'flag_tk':
      'unicode': '1f1f9-1f1f0'
      'shortname': ':flag_tk:'
      'aliases': ':tk:'
      'keywords': 'tokelau'
    'flag_bv':
      'unicode': '1f1e7-1f1fb'
      'shortname': ':flag_bv:'
      'aliases': ':bv:'
      'keywords': 'bouvet island'
    'flag_hm':
      'unicode': '1f1ed-1f1f2'
      'shortname': ':flag_hm:'
      'aliases': ':hm:'
      'keywords': 'heard island and mcdonald islands'
    'flag_sj':
      'unicode': '1f1f8-1f1ef'
      'shortname': ':flag_sj:'
      'aliases': ':sj:'
      'keywords': 'svalbard and jan mayen'
    'flag_um':
      'unicode': '1f1fa-1f1f2'
      'shortname': ':flag_um:'
      'aliases': ':um:'
      'keywords': 'united states minor outlying islands'
    'flag_ic':
      'unicode': '1f1ee-1f1e8'
      'shortname': ':flag_ic:'
      'aliases': ':ic:'
      'keywords': 'canary islands'
    'flag_ea':
      'unicode': '1f1ea-1f1e6'
      'shortname': ':flag_ea:'
      'aliases': ':ea:'
      'keywords': 'ceuta, melilla'
    'flag_cp':
      'unicode': '1f1e8-1f1f5'
      'shortname': ':flag_cp:'
      'aliases': ':cp:'
      'keywords': 'clipperton island'
    'flag_dg':
      'unicode': '1f1e9-1f1ec'
      'shortname': ':flag_dg:'
      'aliases': ':dg:'
      'keywords': 'diego garcia'
    'flag_as':
      'unicode': '1f1e6-1f1f8'
      'shortname': ':flag_as:'
      'aliases': ':as:'
      'keywords': 'american samoa'
    'flag_aq':
      'unicode': '1f1e6-1f1f6'
      'shortname': ':flag_aq:'
      'aliases': ':aq:'
      'keywords': 'antarctica'
    'flag_vg':
      'unicode': '1f1fb-1f1ec'
      'shortname': ':flag_vg:'
      'aliases': ':vg:'
      'keywords': 'british virgin islands'
    'flag_ck':
      'unicode': '1f1e8-1f1f0'
      'shortname': ':flag_ck:'
      'aliases': ':ck:'
      'keywords': 'cook islands'
    'flag_cw':
      'unicode': '1f1e8-1f1fc'
      'shortname': ':flag_cw:'
      'aliases': ':cw:'
      'keywords': 'curaçao'
    'flag_eu':
      'unicode': '1f1ea-1f1fa'
      'shortname': ':flag_eu:'
      'aliases': ':eu:'
      'keywords': 'european union'
    'flag_gf':
      'unicode': '1f1ec-1f1eb'
      'shortname': ':flag_gf:'
      'aliases': ':gf:'
      'keywords': 'french guiana'
    'flag_tf':
      'unicode': '1f1f9-1f1eb'
      'shortname': ':flag_tf:'
      'aliases': ':tf:'
      'keywords': 'french southern territories'
    'flag_gp':
      'unicode': '1f1ec-1f1f5'
      'shortname': ':flag_gp:'
      'aliases': ':gp:'
      'keywords': 'guadeloupe'
    'flag_mq':
      'unicode': '1f1f2-1f1f6'
      'shortname': ':flag_mq:'
      'aliases': ':mq:'
      'keywords': 'martinique'
    'flag_mp':
      'unicode': '1f1f2-1f1f5'
      'shortname': ':flag_mp:'
      'aliases': ':mp:'
      'keywords': 'northern mariana islands'
    'flag_sx':
      'unicode': '1f1f8-1f1fd'
      'shortname': ':flag_sx:'
      'aliases': ':sx:'
      'keywords': 'sint maarten'
    'flag_ss':
      'unicode': '1f1f8-1f1f8'
      'shortname': ':flag_ss:'
      'aliases': ':ss:'
      'keywords': 'south sudan'
    'flag_tc':
      'unicode': '1f1f9-1f1e8'
      'shortname': ':flag_tc:'
      'aliases': ':tc:'
      'keywords': 'turks and caicos islands'
    'flag_mf':
      'unicode': '1f1f2-1f1eb'
      'shortname': ':flag_mf:'
      'aliases': ':mf:'
      'keywords': 'saint martin'
    'raised_hands_tone1':
      'unicode': '1f64c-1f3fb'
      'shortname': ':raised_hands_tone1:'
      'aliases': ''
      'keywords': 'person raising both hands in celebration tone 1 gesture hooray winning woot yay banzai raised'
    'raised_hands_tone2':
      'unicode': '1f64c-1f3fc'
      'shortname': ':raised_hands_tone2:'
      'aliases': ''
      'keywords': 'person raising both hands in celebration tone 2 gesture hooray winning woot yay banzai raised'
    'raised_hands_tone3':
      'unicode': '1f64c-1f3fd'
      'shortname': ':raised_hands_tone3:'
      'aliases': ''
      'keywords': 'person raising both hands in celebration tone 3 gesture hooray winning woot yay banzai raised'
    'raised_hands_tone4':
      'unicode': '1f64c-1f3fe'
      'shortname': ':raised_hands_tone4:'
      'aliases': ''
      'keywords': 'person raising both hands in celebration tone 4 gesture hooray winning woot yay banzai raised'
    'raised_hands_tone5':
      'unicode': '1f64c-1f3ff'
      'shortname': ':raised_hands_tone5:'
      'aliases': ''
      'keywords': 'person raising both hands in celebration tone 5 gesture hooray winning woot yay banzai raised'
    'clap_tone1':
      'unicode': '1f44f-1f3fb'
      'shortname': ':clap_tone1:'
      'aliases': ''
      'keywords': 'clapping hands sign tone 1 applause congrats praise clap appreciation approval sound encouragement enthusiasm'
    'clap_tone2':
      'unicode': '1f44f-1f3fc'
      'shortname': ':clap_tone2:'
      'aliases': ''
      'keywords': 'clapping hands sign tone 2 applause congrats praise clap appreciation approval sound encouragement enthusiasm'
    'clap_tone3':
      'unicode': '1f44f-1f3fd'
      'shortname': ':clap_tone3:'
      'aliases': ''
      'keywords': 'clapping hands sign tone 3 applause congrats praise clap appreciation approval sound encouragement enthusiasm'
    'clap_tone4':
      'unicode': '1f44f-1f3fe'
      'shortname': ':clap_tone4:'
      'aliases': ''
      'keywords': 'clapping hands sign tone 4 applause congrats praise clap appreciation approval sound encouragement enthusiasm'
    'clap_tone5':
      'unicode': '1f44f-1f3ff'
      'shortname': ':clap_tone5:'
      'aliases': ''
      'keywords': 'clapping hands sign tone 5 applause congrats praise clap appreciation approval sound encouragement enthusiasm'
    'wave_tone1':
      'unicode': '1f44b-1f3fb'
      'shortname': ':wave_tone1:'
      'aliases': ''
      'keywords': 'waving hand sign tone 1 farewell gesture goodbye solong hi wave'
    'wave_tone2':
      'unicode': '1f44b-1f3fc'
      'shortname': ':wave_tone2:'
      'aliases': ''
      'keywords': 'waving hand sign tone 2 farewell gesture goodbye solong hi wave'
    'wave_tone3':
      'unicode': '1f44b-1f3fd'
      'shortname': ':wave_tone3:'
      'aliases': ''
      'keywords': 'waving hand sign tone 3 farewell gesture goodbye solong hi wave'
    'wave_tone4':
      'unicode': '1f44b-1f3fe'
      'shortname': ':wave_tone4:'
      'aliases': ''
      'keywords': 'waving hand sign tone 4 farewell gesture goodbye solong hi wave'
    'wave_tone5':
      'unicode': '1f44b-1f3ff'
      'shortname': ':wave_tone5:'
      'aliases': ''
      'keywords': 'waving hand sign tone 5 farewell gesture goodbye solong hi wave'
    'thumbsup_tone1':
      'unicode': '1f44d-1f3fb'
      'shortname': ':thumbsup_tone1:'
      'aliases': ':+1_tone1:'
      'keywords': 'thumbs up sign tone 1 cool hand like yes +1'
    'thumbsup_tone2':
      'unicode': '1f44d-1f3fc'
      'shortname': ':thumbsup_tone2:'
      'aliases': ':+1_tone2:'
      'keywords': 'thumbs up sign tone 2 cool hand like yes +1'
    'thumbsup_tone3':
      'unicode': '1f44d-1f3fd'
      'shortname': ':thumbsup_tone3:'
      'aliases': ':+1_tone3:'
      'keywords': 'thumbs up sign tone 3 cool hand like yes +1'
    'thumbsup_tone4':
      'unicode': '1f44d-1f3fe'
      'shortname': ':thumbsup_tone4:'
      'aliases': ':+1_tone4:'
      'keywords': 'thumbs up sign tone 4 cool hand like yes +1'
    'thumbsup_tone5':
      'unicode': '1f44d-1f3ff'
      'shortname': ':thumbsup_tone5:'
      'aliases': ':+1_tone5:'
      'keywords': 'thumbs up sign tone 5 cool hand like yes +1'
    'thumbsdown_tone1':
      'unicode': '1f44e-1f3fb'
      'shortname': ':thumbsdown_tone1:'
      'aliases': ':-1_tone1:'
      'keywords': 'thumbs down sign tone 1 hand no -1'
    'thumbsdown_tone2':
      'unicode': '1f44e-1f3fc'
      'shortname': ':thumbsdown_tone2:'
      'aliases': ':-1_tone2:'
      'keywords': 'thumbs down sign tone 2 hand no -1'
    'thumbsdown_tone3':
      'unicode': '1f44e-1f3fd'
      'shortname': ':thumbsdown_tone3:'
      'aliases': ':-1_tone3:'
      'keywords': 'thumbs down sign tone 3 hand no -1'
    'thumbsdown_tone4':
      'unicode': '1f44e-1f3fe'
      'shortname': ':thumbsdown_tone4:'
      'aliases': ':-1_tone4:'
      'keywords': 'thumbs down sign tone 4 hand no -1'
    'thumbsdown_tone5':
      'unicode': '1f44e-1f3ff'
      'shortname': ':thumbsdown_tone5:'
      'aliases': ':-1_tone5:'
      'keywords': 'thumbs down sign tone 5 hand no -1'
    'punch_tone1':
      'unicode': '1f44a-1f3fb'
      'shortname': ':punch_tone1:'
      'aliases': ''
      'keywords': 'fisted hand sign tone 1 fist punch'
    'punch_tone2':
      'unicode': '1f44a-1f3fc'
      'shortname': ':punch_tone2:'
      'aliases': ''
      'keywords': 'fisted hand sign tone 2 fist punch'
    'punch_tone3':
      'unicode': '1f44a-1f3fd'
      'shortname': ':punch_tone3:'
      'aliases': ''
      'keywords': 'fisted hand sign tone 3 fist punch'
    'punch_tone4':
      'unicode': '1f44a-1f3fe'
      'shortname': ':punch_tone4:'
      'aliases': ''
      'keywords': 'fisted hand sign tone 4 fist punch'
    'punch_tone5':
      'unicode': '1f44a-1f3ff'
      'shortname': ':punch_tone5:'
      'aliases': ''
      'keywords': 'fisted hand sign tone 5 fist punch'
    'fist_tone1':
      'unicode': '270a-1f3fb'
      'shortname': ':fist_tone1:'
      'aliases': ''
      'keywords': 'raised fist tone 1 fingers grasp hand'
    'fist_tone2':
      'unicode': '270a-1f3fc'
      'shortname': ':fist_tone2:'
      'aliases': ''
      'keywords': 'raised fist tone 2 fingers grasp hand'
    'fist_tone3':
      'unicode': '270a-1f3fd'
      'shortname': ':fist_tone3:'
      'aliases': ''
      'keywords': 'raised fist tone 3 fingers grasp hand'
    'fist_tone4':
      'unicode': '270a-1f3fe'
      'shortname': ':fist_tone4:'
      'aliases': ''
      'keywords': 'raised fist tone 4 fingers grasp hand'
    'fist_tone5':
      'unicode': '270a-1f3ff'
      'shortname': ':fist_tone5:'
      'aliases': ''
      'keywords': 'raised fist tone 5 fingers grasp hand'
    'v_tone1':
      'unicode': '270c-1f3fb'
      'shortname': ':v_tone1:'
      'aliases': ''
      'keywords': 'victory hand tone 1 fingers ohyeah peace two v'
    'v_tone2':
      'unicode': '270c-1f3fc'
      'shortname': ':v_tone2:'
      'aliases': ''
      'keywords': 'victory hand tone 2 fingers ohyeah peace two v'
    'v_tone3':
      'unicode': '270c-1f3fd'
      'shortname': ':v_tone3:'
      'aliases': ''
      'keywords': 'victory hand tone 3 fingers ohyeah peace two v'
    'v_tone4':
      'unicode': '270c-1f3fe'
      'shortname': ':v_tone4:'
      'aliases': ''
      'keywords': 'victory hand tone 4 fingers ohyeah peace two v'
    'v_tone5':
      'unicode': '270c-1f3ff'
      'shortname': ':v_tone5:'
      'aliases': ''
      'keywords': 'victory hand tone 5 fingers ohyeah peace two v'
    'ok_hand_tone1':
      'unicode': '1f44c-1f3fb'
      'shortname': ':ok_hand_tone1:'
      'aliases': ''
      'keywords': 'ok hand sign tone 1 fingers limbs perfect okay smoke smoking marijuana joint pot 420'
    'ok_hand_tone2':
      'unicode': '1f44c-1f3fc'
      'shortname': ':ok_hand_tone2:'
      'aliases': ''
      'keywords': 'ok hand sign tone 2 fingers limbs perfect okay smoke smoking marijuana joint pot 420'
    'ok_hand_tone3':
      'unicode': '1f44c-1f3fd'
      'shortname': ':ok_hand_tone3:'
      'aliases': ''
      'keywords': 'ok hand sign tone 3 fingers limbs perfect okay smoke smoking marijuana joint pot 420'
    'ok_hand_tone4':
      'unicode': '1f44c-1f3fe'
      'shortname': ':ok_hand_tone4:'
      'aliases': ''
      'keywords': 'ok hand sign tone 4 fingers limbs perfect okay smoke smoking marijuana joint pot 420'
    'ok_hand_tone5':
      'unicode': '1f44c-1f3ff'
      'shortname': ':ok_hand_tone5:'
      'aliases': ''
      'keywords': 'ok hand sign tone 5 fingers limbs perfect okay smoke smoking marijuana joint pot 420'
    'raised_hand_tone1':
      'unicode': '270b-1f3fb'
      'shortname': ':raised_hand_tone1:'
      'aliases': ''
      'keywords': 'raised hand tone 1 female girl woman'
    'raised_hand_tone2':
      'unicode': '270b-1f3fc'
      'shortname': ':raised_hand_tone2:'
      'aliases': ''
      'keywords': 'raised hand tone 2 female girl woman'
    'raised_hand_tone3':
      'unicode': '270b-1f3fd'
      'shortname': ':raised_hand_tone3:'
      'aliases': ''
      'keywords': 'raised hand tone 3 female girl woman'
    'raised_hand_tone4':
      'unicode': '270b-1f3fe'
      'shortname': ':raised_hand_tone4:'
      'aliases': ''
      'keywords': 'raised hand tone 4 female girl woman'
    'raised_hand_tone5':
      'unicode': '270b-1f3ff'
      'shortname': ':raised_hand_tone5:'
      'aliases': ''
      'keywords': 'raised hand tone 5 female girl woman'
    'open_hands_tone1':
      'unicode': '1f450-1f3fb'
      'shortname': ':open_hands_tone1:'
      'aliases': ''
      'keywords': 'open hands sign tone 1 butterfly fingers'
    'open_hands_tone2':
      'unicode': '1f450-1f3fc'
      'shortname': ':open_hands_tone2:'
      'aliases': ''
      'keywords': 'open hands sign tone 2 butterfly fingers'
    'open_hands_tone3':
      'unicode': '1f450-1f3fd'
      'shortname': ':open_hands_tone3:'
      'aliases': ''
      'keywords': 'open hands sign tone 3 butterfly fingers'
    'open_hands_tone4':
      'unicode': '1f450-1f3fe'
      'shortname': ':open_hands_tone4:'
      'aliases': ''
      'keywords': 'open hands sign tone 4 butterfly fingers'
    'open_hands_tone5':
      'unicode': '1f450-1f3ff'
      'shortname': ':open_hands_tone5:'
      'aliases': ''
      'keywords': 'open hands sign tone 5 butterfly fingers'
    'muscle_tone1':
      'unicode': '1f4aa-1f3fb'
      'shortname': ':muscle_tone1:'
      'aliases': ''
      'keywords': 'flexed biceps tone 1 arm flex hand strong muscle bicep'
    'muscle_tone2':
      'unicode': '1f4aa-1f3fc'
      'shortname': ':muscle_tone2:'
      'aliases': ''
      'keywords': 'flexed biceps tone 2 arm flex hand strong muscle bicep'
    'muscle_tone3':
      'unicode': '1f4aa-1f3fd'
      'shortname': ':muscle_tone3:'
      'aliases': ''
      'keywords': 'flexed biceps tone 3 arm flex hand strong muscle bicep'
    'muscle_tone4':
      'unicode': '1f4aa-1f3fe'
      'shortname': ':muscle_tone4:'
      'aliases': ''
      'keywords': 'flexed biceps tone 4 arm flex hand strong muscle bicep'
    'muscle_tone5':
      'unicode': '1f4aa-1f3ff'
      'shortname': ':muscle_tone5:'
      'aliases': ''
      'keywords': 'flexed biceps tone 5 arm flex hand strong muscle bicep'
    'pray_tone1':
      'unicode': '1f64f-1f3fb'
      'shortname': ':pray_tone1:'
      'aliases': ''
      'keywords': 'person with folded hands tone 1 highfive hope namaste please wish pray high five sorrow regret sorry'
    'pray_tone2':
      'unicode': '1f64f-1f3fc'
      'shortname': ':pray_tone2:'
      'aliases': ''
      'keywords': 'person with folded hands tone 2 highfive hope namaste please wish pray high five sorrow regret sorry'
    'pray_tone3':
      'unicode': '1f64f-1f3fd'
      'shortname': ':pray_tone3:'
      'aliases': ''
      'keywords': 'person with folded hands tone 3 highfive hope namaste please wish pray high five sorrow regret sorry'
    'pray_tone4':
      'unicode': '1f64f-1f3fe'
      'shortname': ':pray_tone4:'
      'aliases': ''
      'keywords': 'person with folded hands tone 4 highfive hope namaste please wish pray high five sorrow regret sorry'
    'pray_tone5':
      'unicode': '1f64f-1f3ff'
      'shortname': ':pray_tone5:'
      'aliases': ''
      'keywords': 'person with folded hands tone 5 highfive hope namaste please wish pray high five sorrow regret sorry'
    'point_up_tone1':
      'unicode': '261d-1f3fb'
      'shortname': ':point_up_tone1:'
      'aliases': ''
      'keywords': 'white up pointing index tone 1 direction finger hand one'
    'point_up_tone2':
      'unicode': '261d-1f3fc'
      'shortname': ':point_up_tone2:'
      'aliases': ''
      'keywords': 'white up pointing index tone 2 direction finger hand one'
    'point_up_tone3':
      'unicode': '261d-1f3fd'
      'shortname': ':point_up_tone3:'
      'aliases': ''
      'keywords': 'white up pointing index tone 3 direction finger hand one'
    'point_up_tone4':
      'unicode': '261d-1f3fe'
      'shortname': ':point_up_tone4:'
      'aliases': ''
      'keywords': 'white up pointing index tone 4 direction finger hand one'
    'point_up_tone5':
      'unicode': '261d-1f3ff'
      'shortname': ':point_up_tone5:'
      'aliases': ''
      'keywords': 'white up pointing index tone 5 direction finger hand one'
    'point_up_2_tone1':
      'unicode': '1f446-1f3fb'
      'shortname': ':point_up_2_tone1:'
      'aliases': ''
      'keywords': 'white up pointing backhand index tone 1 direction finger hand one'
    'point_up_2_tone2':
      'unicode': '1f446-1f3fc'
      'shortname': ':point_up_2_tone2:'
      'aliases': ''
      'keywords': 'white up pointing backhand index tone 2 direction finger hand one'
    'point_up_2_tone3':
      'unicode': '1f446-1f3fd'
      'shortname': ':point_up_2_tone3:'
      'aliases': ''
      'keywords': 'white up pointing backhand index tone 3 direction finger hand one'
    'point_up_2_tone4':
      'unicode': '1f446-1f3fe'
      'shortname': ':point_up_2_tone4:'
      'aliases': ''
      'keywords': 'white up pointing backhand index tone 4 direction finger hand one'
    'point_up_2_tone5':
      'unicode': '1f446-1f3ff'
      'shortname': ':point_up_2_tone5:'
      'aliases': ''
      'keywords': 'white up pointing backhand index tone 5 direction finger hand one'
    'point_down_tone1':
      'unicode': '1f447-1f3fb'
      'shortname': ':point_down_tone1:'
      'aliases': ''
      'keywords': 'white down pointing backhand index tone 1 direction finger hand'
    'point_down_tone2':
      'unicode': '1f447-1f3fc'
      'shortname': ':point_down_tone2:'
      'aliases': ''
      'keywords': 'white down pointing backhand index tone 2 direction finger hand'
    'point_down_tone3':
      'unicode': '1f447-1f3fd'
      'shortname': ':point_down_tone3:'
      'aliases': ''
      'keywords': 'white down pointing backhand index tone 3 direction finger hand'
    'point_down_tone4':
      'unicode': '1f447-1f3fe'
      'shortname': ':point_down_tone4:'
      'aliases': ''
      'keywords': 'white down pointing backhand index tone 4 direction finger hand'
    'point_down_tone5':
      'unicode': '1f447-1f3ff'
      'shortname': ':point_down_tone5:'
      'aliases': ''
      'keywords': 'white down pointing backhand index tone 5 direction finger hand'
    'point_left_tone1':
      'unicode': '1f448-1f3fb'
      'shortname': ':point_left_tone1:'
      'aliases': ''
      'keywords': 'white left pointing backhand index tone 1 direction finger hand'
    'point_left_tone2':
      'unicode': '1f448-1f3fc'
      'shortname': ':point_left_tone2:'
      'aliases': ''
      'keywords': 'white left pointing backhand index tone 2 direction finger hand'
    'point_left_tone3':
      'unicode': '1f448-1f3fd'
      'shortname': ':point_left_tone3:'
      'aliases': ''
      'keywords': 'white left pointing backhand index tone 3 direction finger hand'
    'point_left_tone4':
      'unicode': '1f448-1f3fe'
      'shortname': ':point_left_tone4:'
      'aliases': ''
      'keywords': 'white left pointing backhand index tone 4 direction finger hand'
    'point_left_tone5':
      'unicode': '1f448-1f3ff'
      'shortname': ':point_left_tone5:'
      'aliases': ''
      'keywords': 'white left pointing backhand index tone 5 direction finger hand'
    'point_right_tone1':
      'unicode': '1f449-1f3fb'
      'shortname': ':point_right_tone1:'
      'aliases': ''
      'keywords': 'white right pointing backhand index tone 1 direction finger hand'
    'point_right_tone2':
      'unicode': '1f449-1f3fc'
      'shortname': ':point_right_tone2:'
      'aliases': ''
      'keywords': 'white right pointing backhand index tone 2 direction finger hand'
    'point_right_tone3':
      'unicode': '1f449-1f3fd'
      'shortname': ':point_right_tone3:'
      'aliases': ''
      'keywords': 'white right pointing backhand index tone 3 direction finger hand'
    'point_right_tone4':
      'unicode': '1f449-1f3fe'
      'shortname': ':point_right_tone4:'
      'aliases': ''
      'keywords': 'white right pointing backhand index tone 4 direction finger hand'
    'point_right_tone5':
      'unicode': '1f449-1f3ff'
      'shortname': ':point_right_tone5:'
      'aliases': ''
      'keywords': 'white right pointing backhand index tone 5 direction finger hand'
    'middle_finger_tone1':
      'unicode': '1f595-1f3fb'
      'shortname': ':middle_finger_tone1:'
      'aliases': ':reversed_hand_with_middle_finger_extended_tone1:'
      'keywords': 'reversed hand with middle finger extended tone 1 fu'
    'middle_finger_tone2':
      'unicode': '1f595-1f3fc'
      'shortname': ':middle_finger_tone2:'
      'aliases': ':reversed_hand_with_middle_finger_extended_tone2:'
      'keywords': 'reversed hand with middle finger extended tone 2 fu'
    'middle_finger_tone3':
      'unicode': '1f595-1f3fd'
      'shortname': ':middle_finger_tone3:'
      'aliases': ':reversed_hand_with_middle_finger_extended_tone3:'
      'keywords': 'reversed hand with middle finger extended tone 3 fu'
    'middle_finger_tone4':
      'unicode': '1f595-1f3fe'
      'shortname': ':middle_finger_tone4:'
      'aliases': ':reversed_hand_with_middle_finger_extended_tone4:'
      'keywords': 'reversed hand with middle finger extended tone 4 fu'
    'middle_finger_tone5':
      'unicode': '1f595-1f3ff'
      'shortname': ':middle_finger_tone5:'
      'aliases': ':reversed_hand_with_middle_finger_extended_tone5:'
      'keywords': 'reversed hand with middle finger extended tone 5 fu'
    'hand_splayed_tone1':
      'unicode': '1f590-1f3fb'
      'shortname': ':hand_splayed_tone1:'
      'aliases': ':raised_hand_with_fingers_splayed_tone1:'
      'keywords': 'raised hand with fingers splayed tone 1 hi five stop halt'
    'hand_splayed_tone2':
      'unicode': '1f590-1f3fc'
      'shortname': ':hand_splayed_tone2:'
      'aliases': ':raised_hand_with_fingers_splayed_tone2:'
      'keywords': 'raised hand with fingers splayed tone 2 hi five stop halt'
    'hand_splayed_tone3':
      'unicode': '1f590-1f3fd'
      'shortname': ':hand_splayed_tone3:'
      'aliases': ':raised_hand_with_fingers_splayed_tone3:'
      'keywords': 'raised hand with fingers splayed tone 3 hi five stop halt'
    'hand_splayed_tone4':
      'unicode': '1f590-1f3fe'
      'shortname': ':hand_splayed_tone4:'
      'aliases': ':raised_hand_with_fingers_splayed_tone4:'
      'keywords': 'raised hand with fingers splayed tone 4 hi five stop halt'
    'hand_splayed_tone5':
      'unicode': '1f590-1f3ff'
      'shortname': ':hand_splayed_tone5:'
      'aliases': ':raised_hand_with_fingers_splayed_tone5:'
      'keywords': 'raised hand with fingers splayed tone 5 hi five stop halt'
    'metal_tone1':
      'unicode': '1f918-1f3fb'
      'shortname': ':metal_tone1:'
      'aliases': ':sign_of_the_horns_tone1:'
      'keywords': 'sign of the horns tone 1 band concert fingers rocknroll'
    'metal_tone2':
      'unicode': '1f918-1f3fc'
      'shortname': ':metal_tone2:'
      'aliases': ':sign_of_the_horns_tone2:'
      'keywords': 'sign of the horns tone 2 band concert fingers rocknroll'
    'metal_tone3':
      'unicode': '1f918-1f3fd'
      'shortname': ':metal_tone3:'
      'aliases': ':sign_of_the_horns_tone3:'
      'keywords': 'sign of the horns tone 3 band concert fingers rocknroll'
    'metal_tone4':
      'unicode': '1f918-1f3fe'
      'shortname': ':metal_tone4:'
      'aliases': ':sign_of_the_horns_tone4:'
      'keywords': 'sign of the horns tone 4 band concert fingers rocknroll'
    'metal_tone5':
      'unicode': '1f918-1f3ff'
      'shortname': ':metal_tone5:'
      'aliases': ':sign_of_the_horns_tone5:'
      'keywords': 'sign of the horns tone 5 band concert fingers rocknroll'
    'vulcan_tone1':
      'unicode': '1f596-1f3fb'
      'shortname': ':vulcan_tone1:'
      'aliases': ':raised_hand_with_part_between_middle_and_ring_fingers_tone1:'
      'keywords': 'raised hand with part between middle and ring fingers tone 1 vulcan spock leonard nimoy star trek live long'
    'vulcan_tone2':
      'unicode': '1f596-1f3fc'
      'shortname': ':vulcan_tone2:'
      'aliases': ':raised_hand_with_part_between_middle_and_ring_fingers_tone2:'
      'keywords': 'raised hand with part between middle and ring fingers tone 2 vulcan spock leonard nimoy star trek live long'
    'vulcan_tone3':
      'unicode': '1f596-1f3fd'
      'shortname': ':vulcan_tone3:'
      'aliases': ':raised_hand_with_part_between_middle_and_ring_fingers_tone3:'
      'keywords': 'raised hand with part between middle and ring fingers tone 3 vulcan spock leonard nimoy star trek live long'
    'vulcan_tone4':
      'unicode': '1f596-1f3fe'
      'shortname': ':vulcan_tone4:'
      'aliases': ':raised_hand_with_part_between_middle_and_ring_fingers_tone4:'
      'keywords': 'raised hand with part between middle and ring fingers tone 4 vulcan spock leonard nimoy star trek live long'
    'vulcan_tone5':
      'unicode': '1f596-1f3ff'
      'shortname': ':vulcan_tone5:'
      'aliases': ':raised_hand_with_part_between_middle_and_ring_fingers_tone5:'
      'keywords': 'raised hand with part between middle and ring fingers tone 5 vulcan spock leonard nimoy star trek live long'
    'writing_hand_tone1':
      'unicode': '270d-1f3fb'
      'shortname': ':writing_hand_tone1:'
      'aliases': ''
      'keywords': 'writing hand tone 1 write sign signature draw'
    'writing_hand_tone2':
      'unicode': '270d-1f3fc'
      'shortname': ':writing_hand_tone2:'
      'aliases': ''
      'keywords': 'writing hand tone 2 write sign signature draw'
    'writing_hand_tone3':
      'unicode': '270d-1f3fd'
      'shortname': ':writing_hand_tone3:'
      'aliases': ''
      'keywords': 'writing hand tone 3 write sign signature draw'
    'writing_hand_tone4':
      'unicode': '270d-1f3fe'
      'shortname': ':writing_hand_tone4:'
      'aliases': ''
      'keywords': 'writing hand tone 4 write sign signature draw'
    'writing_hand_tone5':
      'unicode': '270d-1f3ff'
      'shortname': ':writing_hand_tone5:'
      'aliases': ''
      'keywords': 'writing hand tone 5 write sign signature draw'
    'nail_care_tone1':
      'unicode': '1f485-1f3fb'
      'shortname': ':nail_care_tone1:'
      'aliases': ''
      'keywords': 'nail polish tone 1 beauty manicure'
    'nail_care_tone2':
      'unicode': '1f485-1f3fc'
      'shortname': ':nail_care_tone2:'
      'aliases': ''
      'keywords': 'nail polish tone 2 beauty manicure'
    'nail_care_tone3':
      'unicode': '1f485-1f3fd'
      'shortname': ':nail_care_tone3:'
      'aliases': ''
      'keywords': 'nail polish tone 3 beauty manicure'
    'nail_care_tone4':
      'unicode': '1f485-1f3fe'
      'shortname': ':nail_care_tone4:'
      'aliases': ''
      'keywords': 'nail polish tone 4 beauty manicure'
    'nail_care_tone5':
      'unicode': '1f485-1f3ff'
      'shortname': ':nail_care_tone5:'
      'aliases': ''
      'keywords': 'nail polish tone 5 beauty manicure'
    'ear_tone1':
      'unicode': '1f442-1f3fb'
      'shortname': ':ear_tone1:'
      'aliases': ''
      'keywords': 'ear tone 1 hear listen sound'
    'ear_tone2':
      'unicode': '1f442-1f3fc'
      'shortname': ':ear_tone2:'
      'aliases': ''
      'keywords': 'ear tone 2 hear listen sound'
    'ear_tone3':
      'unicode': '1f442-1f3fd'
      'shortname': ':ear_tone3:'
      'aliases': ''
      'keywords': 'ear tone 3 hear listen sound'
    'ear_tone4':
      'unicode': '1f442-1f3fe'
      'shortname': ':ear_tone4:'
      'aliases': ''
      'keywords': 'ear tone 4 hear listen sound'
    'ear_tone5':
      'unicode': '1f442-1f3ff'
      'shortname': ':ear_tone5:'
      'aliases': ''
      'keywords': 'ear tone 5 hear listen sound'
    'nose_tone1':
      'unicode': '1f443-1f3fb'
      'shortname': ':nose_tone1:'
      'aliases': ''
      'keywords': 'nose tone 1 smell sniff'
    'nose_tone2':
      'unicode': '1f443-1f3fc'
      'shortname': ':nose_tone2:'
      'aliases': ''
      'keywords': 'nose tone 2 smell sniff'
    'nose_tone3':
      'unicode': '1f443-1f3fd'
      'shortname': ':nose_tone3:'
      'aliases': ''
      'keywords': 'nose tone 3 smell sniff'
    'nose_tone4':
      'unicode': '1f443-1f3fe'
      'shortname': ':nose_tone4:'
      'aliases': ''
      'keywords': 'nose tone 4 smell sniff'
    'nose_tone5':
      'unicode': '1f443-1f3ff'
      'shortname': ':nose_tone5:'
      'aliases': ''
      'keywords': 'nose tone 5 smell sniff'
    'baby_tone1':
      'unicode': '1f476-1f3fb'
      'shortname': ':baby_tone1:'
      'aliases': ''
      'keywords': 'baby tone 1 child infant toddler'
    'baby_tone2':
      'unicode': '1f476-1f3fc'
      'shortname': ':baby_tone2:'
      'aliases': ''
      'keywords': 'baby tone 2 child infant toddler'
    'baby_tone3':
      'unicode': '1f476-1f3fd'
      'shortname': ':baby_tone3:'
      'aliases': ''
      'keywords': 'baby tone 3 child infant toddler'
    'baby_tone4':
      'unicode': '1f476-1f3fe'
      'shortname': ':baby_tone4:'
      'aliases': ''
      'keywords': 'baby tone 4 child infant toddler'
    'baby_tone5':
      'unicode': '1f476-1f3ff'
      'shortname': ':baby_tone5:'
      'aliases': ''
      'keywords': 'baby tone 5 child infant toddler'
    'boy_tone1':
      'unicode': '1f466-1f3fb'
      'shortname': ':boy_tone1:'
      'aliases': ''
      'keywords': 'boy tone 1 male kid child'
    'boy_tone2':
      'unicode': '1f466-1f3fc'
      'shortname': ':boy_tone2:'
      'aliases': ''
      'keywords': 'boy tone 2 male kid child'
    'boy_tone3':
      'unicode': '1f466-1f3fd'
      'shortname': ':boy_tone3:'
      'aliases': ''
      'keywords': 'boy tone 3 male kid child'
    'boy_tone4':
      'unicode': '1f466-1f3fe'
      'shortname': ':boy_tone4:'
      'aliases': ''
      'keywords': 'boy tone 4 male kid child'
    'boy_tone5':
      'unicode': '1f466-1f3ff'
      'shortname': ':boy_tone5:'
      'aliases': ''
      'keywords': 'boy tone 5 male kid child'
    'girl_tone1':
      'unicode': '1f467-1f3fb'
      'shortname': ':girl_tone1:'
      'aliases': ''
      'keywords': 'girl tone 1 female kid child'
    'girl_tone2':
      'unicode': '1f467-1f3fc'
      'shortname': ':girl_tone2:'
      'aliases': ''
      'keywords': 'girl tone 2 female kid child'
    'girl_tone3':
      'unicode': '1f467-1f3fd'
      'shortname': ':girl_tone3:'
      'aliases': ''
      'keywords': 'girl tone 3 female kid child'
    'girl_tone4':
      'unicode': '1f467-1f3fe'
      'shortname': ':girl_tone4:'
      'aliases': ''
      'keywords': 'girl tone 4 female kid child'
    'girl_tone5':
      'unicode': '1f467-1f3ff'
      'shortname': ':girl_tone5:'
      'aliases': ''
      'keywords': 'girl tone 5 female kid child'
    'man_tone1':
      'unicode': '1f468-1f3fb'
      'shortname': ':man_tone1:'
      'aliases': ''
      'keywords': 'man tone 1 classy dad father guy mustache'
    'man_tone2':
      'unicode': '1f468-1f3fc'
      'shortname': ':man_tone2:'
      'aliases': ''
      'keywords': 'man tone 2 classy dad father guy mustache'
    'man_tone3':
      'unicode': '1f468-1f3fd'
      'shortname': ':man_tone3:'
      'aliases': ''
      'keywords': 'man tone 3 classy dad father guy mustache'
    'man_tone4':
      'unicode': '1f468-1f3fe'
      'shortname': ':man_tone4:'
      'aliases': ''
      'keywords': 'man tone 4 classy dad father guy mustache'
    'man_tone5':
      'unicode': '1f468-1f3ff'
      'shortname': ':man_tone5:'
      'aliases': ''
      'keywords': 'man tone 5 classy dad father guy mustache'
    'woman_tone1':
      'unicode': '1f469-1f3fb'
      'shortname': ':woman_tone1:'
      'aliases': ''
      'keywords': 'woman tone 1 female girl lady'
    'woman_tone2':
      'unicode': '1f469-1f3fc'
      'shortname': ':woman_tone2:'
      'aliases': ''
      'keywords': 'woman tone 2 female girl lady'
    'woman_tone3':
      'unicode': '1f469-1f3fd'
      'shortname': ':woman_tone3:'
      'aliases': ''
      'keywords': 'woman tone 3 female girl lady'
    'woman_tone4':
      'unicode': '1f469-1f3fe'
      'shortname': ':woman_tone4:'
      'aliases': ''
      'keywords': 'woman tone 4 female girl lady'
    'woman_tone5':
      'unicode': '1f469-1f3ff'
      'shortname': ':woman_tone5:'
      'aliases': ''
      'keywords': 'woman tone 5 female girl lady'
    'person_with_blond_hair_tone1':
      'unicode': '1f471-1f3fb'
      'shortname': ':person_with_blond_hair_tone1:'
      'aliases': ''
      'keywords': 'person with blond hair tone 1 male man blonde young western westerner occidental'
    'person_with_blond_hair_tone2':
      'unicode': '1f471-1f3fc'
      'shortname': ':person_with_blond_hair_tone2:'
      'aliases': ''
      'keywords': 'person with blond hair tone 2 male man blonde young western westerner occidental'
    'person_with_blond_hair_tone3':
      'unicode': '1f471-1f3fd'
      'shortname': ':person_with_blond_hair_tone3:'
      'aliases': ''
      'keywords': 'person with blond hair tone 3 male man blonde young western westerner occidental'
    'person_with_blond_hair_tone4':
      'unicode': '1f471-1f3fe'
      'shortname': ':person_with_blond_hair_tone4:'
      'aliases': ''
      'keywords': 'person with blond hair tone 4 male man blonde young western westerner occidental'
    'person_with_blond_hair_tone5':
      'unicode': '1f471-1f3ff'
      'shortname': ':person_with_blond_hair_tone5:'
      'aliases': ''
      'keywords': 'person with blond hair tone 5 male man blonde young western westerner occidental'
    'older_man_tone1':
      'unicode': '1f474-1f3fb'
      'shortname': ':older_man_tone1:'
      'aliases': ''
      'keywords': 'older man tone 1 male men grandpa grandfather'
    'older_man_tone2':
      'unicode': '1f474-1f3fc'
      'shortname': ':older_man_tone2:'
      'aliases': ''
      'keywords': 'older man tone 2 male men grandpa grandfather'
    'older_man_tone3':
      'unicode': '1f474-1f3fd'
      'shortname': ':older_man_tone3:'
      'aliases': ''
      'keywords': 'older man tone 3 male men grandpa grandfather'
    'older_man_tone4':
      'unicode': '1f474-1f3fe'
      'shortname': ':older_man_tone4:'
      'aliases': ''
      'keywords': 'older man tone 4 male men grandpa grandfather'
    'older_man_tone5':
      'unicode': '1f474-1f3ff'
      'shortname': ':older_man_tone5:'
      'aliases': ''
      'keywords': 'older man tone 5 male men grandpa grandfather'
    'older_woman_tone1':
      'unicode': '1f475-1f3fb'
      'shortname': ':older_woman_tone1:'
      'aliases': ':grandma_tone1:'
      'keywords': 'older woman tone 1 female women lady grandma grandmother'
    'older_woman_tone2':
      'unicode': '1f475-1f3fc'
      'shortname': ':older_woman_tone2:'
      'aliases': ':grandma_tone2:'
      'keywords': 'older woman tone 2 female women lady grandma grandmother'
    'older_woman_tone3':
      'unicode': '1f475-1f3fd'
      'shortname': ':older_woman_tone3:'
      'aliases': ':grandma_tone3:'
      'keywords': 'older woman tone 3 female women lady grandma grandmother'
    'older_woman_tone4':
      'unicode': '1f475-1f3fe'
      'shortname': ':older_woman_tone4:'
      'aliases': ':grandma_tone4:'
      'keywords': 'older woman tone 4 female women lady grandma grandmother'
    'older_woman_tone5':
      'unicode': '1f475-1f3ff'
      'shortname': ':older_woman_tone5:'
      'aliases': ':grandma_tone5:'
      'keywords': 'older woman tone 5 female women lady grandma grandmother'
    'man_with_gua_pi_mao_tone1':
      'unicode': '1f472-1f3fb'
      'shortname': ':man_with_gua_pi_mao_tone1:'
      'aliases': ''
      'keywords': 'man with gua pi mao tone 1 boy male skullcap chinese asian qing'
    'man_with_gua_pi_mao_tone2':
      'unicode': '1f472-1f3fc'
      'shortname': ':man_with_gua_pi_mao_tone2:'
      'aliases': ''
      'keywords': 'man with gua pi mao tone 2 boy male skullcap chinese asian qing'
    'man_with_gua_pi_mao_tone3':
      'unicode': '1f472-1f3fd'
      'shortname': ':man_with_gua_pi_mao_tone3:'
      'aliases': ''
      'keywords': 'man with gua pi mao tone 3 boy male skullcap chinese asian qing'
    'man_with_gua_pi_mao_tone4':
      'unicode': '1f472-1f3fe'
      'shortname': ':man_with_gua_pi_mao_tone4:'
      'aliases': ''
      'keywords': 'man with gua pi mao tone 4 boy male skullcap chinese asian qing'
    'man_with_gua_pi_mao_tone5':
      'unicode': '1f472-1f3ff'
      'shortname': ':man_with_gua_pi_mao_tone5:'
      'aliases': ''
      'keywords': 'man with gua pi mao tone 5 boy male skullcap chinese asian qing'
    'man_with_turban_tone1':
      'unicode': '1f473-1f3fb'
      'shortname': ':man_with_turban_tone1:'
      'aliases': ''
      'keywords': 'man with turban tone 1 male headdress headwear pagri india indian mummy wisdom peace'
    'man_with_turban_tone2':
      'unicode': '1f473-1f3fc'
      'shortname': ':man_with_turban_tone2:'
      'aliases': ''
      'keywords': 'man with turban tone 2 male headdress headwear pagri india indian mummy wisdom peace'
    'man_with_turban_tone3':
      'unicode': '1f473-1f3fd'
      'shortname': ':man_with_turban_tone3:'
      'aliases': ''
      'keywords': 'man with turban tone 3 male headdress headwear pagri india indian mummy wisdom peace'
    'man_with_turban_tone4':
      'unicode': '1f473-1f3fe'
      'shortname': ':man_with_turban_tone4:'
      'aliases': ''
      'keywords': 'man with turban tone 4 male headdress headwear pagri india indian mummy wisdom peace'
    'man_with_turban_tone5':
      'unicode': '1f473-1f3ff'
      'shortname': ':man_with_turban_tone5:'
      'aliases': ''
      'keywords': 'man with turban tone 5 male headdress headwear pagri india indian mummy wisdom peace'
    'cop_tone1':
      'unicode': '1f46e-1f3fb'
      'shortname': ':cop_tone1:'
      'aliases': ''
      'keywords': 'police officer tone 1 arrest enforcement law man cop'
    'cop_tone2':
      'unicode': '1f46e-1f3fc'
      'shortname': ':cop_tone2:'
      'aliases': ''
      'keywords': 'police officer tone 2 arrest enforcement law man cop'
    'cop_tone3':
      'unicode': '1f46e-1f3fd'
      'shortname': ':cop_tone3:'
      'aliases': ''
      'keywords': 'police officer tone 3 arrest enforcement law man cop'
    'cop_tone4':
      'unicode': '1f46e-1f3fe'
      'shortname': ':cop_tone4:'
      'aliases': ''
      'keywords': 'police officer tone 4 arrest enforcement law man cop'
    'cop_tone5':
      'unicode': '1f46e-1f3ff'
      'shortname': ':cop_tone5:'
      'aliases': ''
      'keywords': 'police officer tone 5 arrest enforcement law man cop'
    'construction_worker_tone1':
      'unicode': '1f477-1f3fb'
      'shortname': ':construction_worker_tone1:'
      'aliases': ''
      'keywords': 'construction worker tone 1 human male man wip'
    'construction_worker_tone2':
      'unicode': '1f477-1f3fc'
      'shortname': ':construction_worker_tone2:'
      'aliases': ''
      'keywords': 'construction worker tone 2 human male man wip'
    'construction_worker_tone3':
      'unicode': '1f477-1f3fd'
      'shortname': ':construction_worker_tone3:'
      'aliases': ''
      'keywords': 'construction worker tone 3 human male man wip'
    'construction_worker_tone4':
      'unicode': '1f477-1f3fe'
      'shortname': ':construction_worker_tone4:'
      'aliases': ''
      'keywords': 'construction worker tone 4 human male man wip'
    'construction_worker_tone5':
      'unicode': '1f477-1f3ff'
      'shortname': ':construction_worker_tone5:'
      'aliases': ''
      'keywords': 'construction worker tone 5 human male man wip'
    'guardsman_tone1':
      'unicode': '1f482-1f3fb'
      'shortname': ':guardsman_tone1:'
      'aliases': ''
      'keywords': 'guardsman tone 1 british gb male man uk guard bearskin hat british queen ceremonial military'
    'guardsman_tone2':
      'unicode': '1f482-1f3fc'
      'shortname': ':guardsman_tone2:'
      'aliases': ''
      'keywords': 'guardsman tone 2 british gb male man uk guard bearskin hat british queen ceremonial military'
    'guardsman_tone3':
      'unicode': '1f482-1f3fd'
      'shortname': ':guardsman_tone3:'
      'aliases': ''
      'keywords': 'guardsman tone 3 british gb male man uk guard bearskin hat british queen ceremonial military'
    'guardsman_tone4':
      'unicode': '1f482-1f3fe'
      'shortname': ':guardsman_tone4:'
      'aliases': ''
      'keywords': 'guardsman tone 4 british gb male man uk guard bearskin hat british queen ceremonial military'
    'guardsman_tone5':
      'unicode': '1f482-1f3ff'
      'shortname': ':guardsman_tone5:'
      'aliases': ''
      'keywords': 'guardsman tone 5 british gb male man uk guard bearskin hat british queen ceremonial military'
    'santa_tone1':
      'unicode': '1f385-1f3fb'
      'shortname': ':santa_tone1:'
      'aliases': ''
      'keywords': 'father christmas tone 1 festival male man xmas santa saint nick jolly ho ho ho north pole presents gifts naughty nice sleigh holiday'
    'santa_tone2':
      'unicode': '1f385-1f3fc'
      'shortname': ':santa_tone2:'
      'aliases': ''
      'keywords': 'father christmas tone 2 festival male man xmas santa saint nick jolly ho ho ho north pole presents gifts naughty nice sleigh holiday'
    'santa_tone3':
      'unicode': '1f385-1f3fd'
      'shortname': ':santa_tone3:'
      'aliases': ''
      'keywords': 'father christmas tone 3 festival male man xmas santa saint nick jolly ho ho ho north pole presents gifts naughty nice sleigh holiday'
    'santa_tone4':
      'unicode': '1f385-1f3fe'
      'shortname': ':santa_tone4:'
      'aliases': ''
      'keywords': 'father christmas tone 4 festival male man xmas santa saint nick jolly ho ho ho north pole presents gifts naughty nice sleigh holiday'
    'santa_tone5':
      'unicode': '1f385-1f3ff'
      'shortname': ':santa_tone5:'
      'aliases': ''
      'keywords': 'father christmas tone 5 festival male man xmas santa saint nick jolly ho ho ho north pole presents gifts naughty nice sleigh holiday'
    'angel_tone1':
      'unicode': '1f47c-1f3fb'
      'shortname': ':angel_tone1:'
      'aliases': ''
      'keywords': 'baby angel tone 1 halo cupid heaven wings jesus'
    'angel_tone2':
      'unicode': '1f47c-1f3fc'
      'shortname': ':angel_tone2:'
      'aliases': ''
      'keywords': 'baby angel tone 2 halo cupid heaven wings jesus'
    'angel_tone3':
      'unicode': '1f47c-1f3fd'
      'shortname': ':angel_tone3:'
      'aliases': ''
      'keywords': 'baby angel tone 3 halo cupid heaven wings jesus'
    'angel_tone4':
      'unicode': '1f47c-1f3fe'
      'shortname': ':angel_tone4:'
      'aliases': ''
      'keywords': 'baby angel tone 4 halo cupid heaven wings jesus'
    'angel_tone5':
      'unicode': '1f47c-1f3ff'
      'shortname': ':angel_tone5:'
      'aliases': ''
      'keywords': 'baby angel tone 5 halo cupid heaven wings jesus'
    'princess_tone1':
      'unicode': '1f478-1f3fb'
      'shortname': ':princess_tone1:'
      'aliases': ''
      'keywords': 'princess tone 1 blond crown female girl woman royal royalty king queen daughter disney high-maintenance'
    'princess_tone2':
      'unicode': '1f478-1f3fc'
      'shortname': ':princess_tone2:'
      'aliases': ''
      'keywords': 'princess tone 2 blond crown female girl woman royal royalty king queen daughter disney high-maintenance'
    'princess_tone3':
      'unicode': '1f478-1f3fd'
      'shortname': ':princess_tone3:'
      'aliases': ''
      'keywords': 'princess tone 3 blond crown female girl woman royal royalty king queen daughter disney high-maintenance'
    'princess_tone4':
      'unicode': '1f478-1f3fe'
      'shortname': ':princess_tone4:'
      'aliases': ''
      'keywords': 'princess tone 4 blond crown female girl woman royal royalty king queen daughter disney high-maintenance'
    'princess_tone5':
      'unicode': '1f478-1f3ff'
      'shortname': ':princess_tone5:'
      'aliases': ''
      'keywords': 'princess tone 5 blond crown female girl woman royal royalty king queen daughter disney high-maintenance'
    'bride_with_veil_tone1':
      'unicode': '1f470-1f3fb'
      'shortname': ':bride_with_veil_tone1:'
      'aliases': ''
      'keywords': 'bride with veil tone 1 couple marriage wedding wedding planning gown dress engagement white'
    'bride_with_veil_tone2':
      'unicode': '1f470-1f3fc'
      'shortname': ':bride_with_veil_tone2:'
      'aliases': ''
      'keywords': 'bride with veil tone 2 couple marriage wedding wedding planning gown dress engagement white'
    'bride_with_veil_tone3':
      'unicode': '1f470-1f3fd'
      'shortname': ':bride_with_veil_tone3:'
      'aliases': ''
      'keywords': 'bride with veil tone 3 couple marriage wedding wedding planning gown dress engagement white'
    'bride_with_veil_tone4':
      'unicode': '1f470-1f3fe'
      'shortname': ':bride_with_veil_tone4:'
      'aliases': ''
      'keywords': 'bride with veil tone 4 couple marriage wedding wedding planning gown dress engagement white'
    'bride_with_veil_tone5':
      'unicode': '1f470-1f3ff'
      'shortname': ':bride_with_veil_tone5:'
      'aliases': ''
      'keywords': 'bride with veil tone 5 couple marriage wedding wedding planning gown dress engagement white'
    'walking_tone1':
      'unicode': '1f6b6-1f3fb'
      'shortname': ':walking_tone1:'
      'aliases': ''
      'keywords': 'pedestrian tone 1 man walk stroll stride hiking hike'
    'walking_tone2':
      'unicode': '1f6b6-1f3fc'
      'shortname': ':walking_tone2:'
      'aliases': ''
      'keywords': 'pedestrian tone 2 man walk stroll stride hiking hike'
    'walking_tone3':
      'unicode': '1f6b6-1f3fd'
      'shortname': ':walking_tone3:'
      'aliases': ''
      'keywords': 'pedestrian tone 3 man walk stroll stride hiking hike'
    'walking_tone4':
      'unicode': '1f6b6-1f3fe'
      'shortname': ':walking_tone4:'
      'aliases': ''
      'keywords': 'pedestrian tone 4 man walk stroll stride hiking hike'
    'walking_tone5':
      'unicode': '1f6b6-1f3ff'
      'shortname': ':walking_tone5:'
      'aliases': ''
      'keywords': 'pedestrian tone 5 man walk stroll stride hiking hike'
    'runner_tone1':
      'unicode': '1f3c3-1f3fb'
      'shortname': ':runner_tone1:'
      'aliases': ''
      'keywords': 'runner tone 1 exercise man run jog sprint race dash marathon'
    'runner_tone2':
      'unicode': '1f3c3-1f3fc'
      'shortname': ':runner_tone2:'
      'aliases': ''
      'keywords': 'runner tone 2 exercise man run jog sprint race dash marathon'
    'runner_tone3':
      'unicode': '1f3c3-1f3fd'
      'shortname': ':runner_tone3:'
      'aliases': ''
      'keywords': 'runner tone 3 exercise man run jog sprint race dash marathon'
    'runner_tone4':
      'unicode': '1f3c3-1f3fe'
      'shortname': ':runner_tone4:'
      'aliases': ''
      'keywords': 'runner tone 4 exercise man run jog sprint race dash marathon'
    'runner_tone5':
      'unicode': '1f3c3-1f3ff'
      'shortname': ':runner_tone5:'
      'aliases': ''
      'keywords': 'runner tone 5 exercise man run jog sprint race dash marathon'
    'dancer_tone1':
      'unicode': '1f483-1f3fb'
      'shortname': ':dancer_tone1:'
      'aliases': ''
      'keywords': 'dancer tone 1 female fun girl woman dress fancy boogy party celebrate ballet tango cha cha music'
    'dancer_tone2':
      'unicode': '1f483-1f3fc'
      'shortname': ':dancer_tone2:'
      'aliases': ''
      'keywords': 'dancer tone 2 female fun girl woman dress fancy boogy party celebrate ballet tango cha cha music'
    'dancer_tone3':
      'unicode': '1f483-1f3fd'
      'shortname': ':dancer_tone3:'
      'aliases': ''
      'keywords': 'dancer tone 3 female fun girl woman dress fancy boogy party celebrate ballet tango cha cha music'
    'dancer_tone4':
      'unicode': '1f483-1f3fe'
      'shortname': ':dancer_tone4:'
      'aliases': ''
      'keywords': 'dancer tone 4 female fun girl woman dress fancy boogy party celebrate ballet tango cha cha music'
    'dancer_tone5':
      'unicode': '1f483-1f3ff'
      'shortname': ':dancer_tone5:'
      'aliases': ''
      'keywords': 'dancer tone 5 female fun girl woman dress fancy boogy party celebrate ballet tango cha cha music'
    'bow_tone1':
      'unicode': '1f647-1f3fb'
      'shortname': ':bow_tone1:'
      'aliases': ''
      'keywords': 'person bowing deeply tone 1 boy male man sorry bow respect bend'
    'bow_tone2':
      'unicode': '1f647-1f3fc'
      'shortname': ':bow_tone2:'
      'aliases': ''
      'keywords': 'person bowing deeply tone 2 boy male man sorry bow respect bend'
    'bow_tone3':
      'unicode': '1f647-1f3fd'
      'shortname': ':bow_tone3:'
      'aliases': ''
      'keywords': 'person bowing deeply tone 3 boy male man sorry bow respect bend'
    'bow_tone4':
      'unicode': '1f647-1f3fe'
      'shortname': ':bow_tone4:'
      'aliases': ''
      'keywords': 'person bowing deeply tone 4 boy male man sorry bow respect bend'
    'bow_tone5':
      'unicode': '1f647-1f3ff'
      'shortname': ':bow_tone5:'
      'aliases': ''
      'keywords': 'person bowing deeply tone 5 boy male man sorry bow respect bend'
    'information_desk_person_tone1':
      'unicode': '1f481-1f3fb'
      'shortname': ':information_desk_person_tone1:'
      'aliases': ''
      'keywords': 'information desk person tone 1 female girl human woman help question answer sassy unimpressed attitude snarky'
    'information_desk_person_tone2':
      'unicode': '1f481-1f3fc'
      'shortname': ':information_desk_person_tone2:'
      'aliases': ''
      'keywords': 'information desk person tone 2 female girl human woman help question answer sassy unimpressed attitude snarky'
    'information_desk_person_tone3':
      'unicode': '1f481-1f3fd'
      'shortname': ':information_desk_person_tone3:'
      'aliases': ''
      'keywords': 'information desk person tone 3 female girl human woman help question answer sassy unimpressed attitude snarky'
    'information_desk_person_tone4':
      'unicode': '1f481-1f3fe'
      'shortname': ':information_desk_person_tone4:'
      'aliases': ''
      'keywords': 'information desk person tone 4 female girl human woman help question answer sassy unimpressed attitude snarky'
    'information_desk_person_tone5':
      'unicode': '1f481-1f3ff'
      'shortname': ':information_desk_person_tone5:'
      'aliases': ''
      'keywords': 'information desk person tone 5 female girl human woman help question answer sassy unimpressed attitude snarky'
    'no_good_tone1':
      'unicode': '1f645-1f3fb'
      'shortname': ':no_good_tone1:'
      'aliases': ''
      'keywords': 'face with no good gesture tone 1 female girl woman stop nope don\'t not forbidden hand person prohibited'
    'no_good_tone2':
      'unicode': '1f645-1f3fc'
      'shortname': ':no_good_tone2:'
      'aliases': ''
      'keywords': 'face with no good gesture tone 2 female girl woman stop nope don\'t not forbidden hand person prohibited'
    'no_good_tone3':
      'unicode': '1f645-1f3fd'
      'shortname': ':no_good_tone3:'
      'aliases': ''
      'keywords': 'face with no good gesture tone 3 female girl woman stop nope don\'t not forbidden hand person prohibited'
    'no_good_tone4':
      'unicode': '1f645-1f3fe'
      'shortname': ':no_good_tone4:'
      'aliases': ''
      'keywords': 'face with no good gesture tone 4 female girl woman stop nope don\'t not forbidden hand person prohibited'
    'no_good_tone5':
      'unicode': '1f645-1f3ff'
      'shortname': ':no_good_tone5:'
      'aliases': ''
      'keywords': 'face with no good gesture tone 5 female girl woman stop nope don\'t not forbidden hand person prohibited'
    'ok_woman_tone1':
      'unicode': '1f646-1f3fb'
      'shortname': ':ok_woman_tone1:'
      'aliases': ''
      'keywords': 'face with ok gesture tone1 female girl human pink women yes okay accept'
    'ok_woman_tone2':
      'unicode': '1f646-1f3fc'
      'shortname': ':ok_woman_tone2:'
      'aliases': ''
      'keywords': 'face with ok gesture tone2 female girl human pink women yes okay accept'
    'ok_woman_tone3':
      'unicode': '1f646-1f3fd'
      'shortname': ':ok_woman_tone3:'
      'aliases': ''
      'keywords': 'face with ok gesture tone3 female girl human pink women yes okay accept'
    'ok_woman_tone4':
      'unicode': '1f646-1f3fe'
      'shortname': ':ok_woman_tone4:'
      'aliases': ''
      'keywords': 'face with ok gesture tone4 female girl human pink women yes okay accept'
    'ok_woman_tone5':
      'unicode': '1f646-1f3ff'
      'shortname': ':ok_woman_tone5:'
      'aliases': ''
      'keywords': 'face with ok gesture tone5 female girl human pink women yes okay accept'
    'raising_hand_tone1':
      'unicode': '1f64b-1f3fb'
      'shortname': ':raising_hand_tone1:'
      'aliases': ''
      'keywords': 'happy person raising one hand tone1 female girl woman raise notice attention answer'
    'raising_hand_tone2':
      'unicode': '1f64b-1f3fc'
      'shortname': ':raising_hand_tone2:'
      'aliases': ''
      'keywords': 'happy person raising one hand tone2 female girl woman raise notice attention answer'
    'raising_hand_tone3':
      'unicode': '1f64b-1f3fd'
      'shortname': ':raising_hand_tone3:'
      'aliases': ''
      'keywords': 'happy person raising one hand tone3 female girl woman raise notice attention answer'
    'raising_hand_tone4':
      'unicode': '1f64b-1f3fe'
      'shortname': ':raising_hand_tone4:'
      'aliases': ''
      'keywords': 'happy person raising one hand tone4 female girl woman raise notice attention answer'
    'raising_hand_tone5':
      'unicode': '1f64b-1f3ff'
      'shortname': ':raising_hand_tone5:'
      'aliases': ''
      'keywords': 'happy person raising one hand tone5 female girl woman raise notice attention answer'
    'person_with_pouting_face_tone1':
      'unicode': '1f64e-1f3fb'
      'shortname': ':person_with_pouting_face_tone1:'
      'aliases': ''
      'keywords': 'person with pouting face tone1 female girl woman pout sexy cute annoyed'
    'person_with_pouting_face_tone2':
      'unicode': '1f64e-1f3fc'
      'shortname': ':person_with_pouting_face_tone2:'
      'aliases': ''
      'keywords': 'person with pouting face tone2 female girl woman pout sexy cute annoyed'
    'person_with_pouting_face_tone3':
      'unicode': '1f64e-1f3fd'
      'shortname': ':person_with_pouting_face_tone3:'
      'aliases': ''
      'keywords': 'person with pouting face tone3 female girl woman pout sexy cute annoyed'
    'person_with_pouting_face_tone4':
      'unicode': '1f64e-1f3fe'
      'shortname': ':person_with_pouting_face_tone4:'
      'aliases': ''
      'keywords': 'person with pouting face tone4 female girl woman pout sexy cute annoyed'
    'person_with_pouting_face_tone5':
      'unicode': '1f64e-1f3ff'
      'shortname': ':person_with_pouting_face_tone5:'
      'aliases': ''
      'keywords': 'person with pouting face tone5 female girl woman pout sexy cute annoyed'
    'person_frowning_tone1':
      'unicode': '1f64d-1f3fb'
      'shortname': ':person_frowning_tone1:'
      'aliases': ''
      'keywords': 'person frowning tone 1 female girl woman dejected rejected sad frown'
    'person_frowning_tone2':
      'unicode': '1f64d-1f3fc'
      'shortname': ':person_frowning_tone2:'
      'aliases': ''
      'keywords': 'person frowning tone 2 female girl woman dejected rejected sad frown'
    'person_frowning_tone3':
      'unicode': '1f64d-1f3fd'
      'shortname': ':person_frowning_tone3:'
      'aliases': ''
      'keywords': 'person frowning tone 3 female girl woman dejected rejected sad frown'
    'person_frowning_tone4':
      'unicode': '1f64d-1f3fe'
      'shortname': ':person_frowning_tone4:'
      'aliases': ''
      'keywords': 'person frowning tone 4 female girl woman dejected rejected sad frown'
    'person_frowning_tone5':
      'unicode': '1f64d-1f3ff'
      'shortname': ':person_frowning_tone5:'
      'aliases': ''
      'keywords': 'person frowning tone 5 female girl woman dejected rejected sad frown'
    'haircut_tone1':
      'unicode': '1f487-1f3fb'
      'shortname': ':haircut_tone1:'
      'aliases': ''
      'keywords': 'haircut tone 1 female girl woman'
    'haircut_tone2':
      'unicode': '1f487-1f3fc'
      'shortname': ':haircut_tone2:'
      'aliases': ''
      'keywords': 'haircut tone 2 female girl woman'
    'haircut_tone3':
      'unicode': '1f487-1f3fd'
      'shortname': ':haircut_tone3:'
      'aliases': ''
      'keywords': 'haircut tone 3 female girl woman'
    'haircut_tone4':
      'unicode': '1f487-1f3fe'
      'shortname': ':haircut_tone4:'
      'aliases': ''
      'keywords': 'haircut tone 4 female girl woman'
    'haircut_tone5':
      'unicode': '1f487-1f3ff'
      'shortname': ':haircut_tone5:'
      'aliases': ''
      'keywords': 'haircut tone 5 female girl woman'
    'massage_tone1':
      'unicode': '1f486-1f3fb'
      'shortname': ':massage_tone1:'
      'aliases': ''
      'keywords': 'face massage tone 1 female girl woman'
    'massage_tone2':
      'unicode': '1f486-1f3fc'
      'shortname': ':massage_tone2:'
      'aliases': ''
      'keywords': 'face massage tone 2 female girl woman'
    'massage_tone3':
      'unicode': '1f486-1f3fd'
      'shortname': ':massage_tone3:'
      'aliases': ''
      'keywords': 'face massage tone 3 female girl woman'
    'massage_tone4':
      'unicode': '1f486-1f3fe'
      'shortname': ':massage_tone4:'
      'aliases': ''
      'keywords': 'face massage tone 4 female girl woman'
    'massage_tone5':
      'unicode': '1f486-1f3ff'
      'shortname': ':massage_tone5:'
      'aliases': ''
      'keywords': 'face massage tone 5 female girl woman'
    'rowboat_tone1':
      'unicode': '1f6a3-1f3fb'
      'shortname': ':rowboat_tone1:'
      'aliases': ''
      'keywords': 'rowboat tone 1 hobby ship water boat row oar paddle'
    'rowboat_tone2':
      'unicode': '1f6a3-1f3fc'
      'shortname': ':rowboat_tone2:'
      'aliases': ''
      'keywords': 'rowboat tone 2 hobby ship water boat row oar paddle'
    'rowboat_tone3':
      'unicode': '1f6a3-1f3fd'
      'shortname': ':rowboat_tone3:'
      'aliases': ''
      'keywords': 'rowboat tone 3 hobby ship water boat row oar paddle'
    'rowboat_tone4':
      'unicode': '1f6a3-1f3fe'
      'shortname': ':rowboat_tone4:'
      'aliases': ''
      'keywords': 'rowboat tone 4 hobby ship water boat row oar paddle'
    'rowboat_tone5':
      'unicode': '1f6a3-1f3ff'
      'shortname': ':rowboat_tone5:'
      'aliases': ''
      'keywords': 'rowboat tone 5 hobby ship water boat row oar paddle'
    'swimmer_tone1':
      'unicode': '1f3ca-1f3fb'
      'shortname': ':swimmer_tone1:'
      'aliases': ''
      'keywords': 'swimmer tone 1 sport swim water pool laps freestyle butterfly breaststroke backstroke'
    'swimmer_tone2':
      'unicode': '1f3ca-1f3fc'
      'shortname': ':swimmer_tone2:'
      'aliases': ''
      'keywords': 'swimmer tone 2 sport swim water pool laps freestyle butterfly breaststroke backstroke'
    'swimmer_tone3':
      'unicode': '1f3ca-1f3fd'
      'shortname': ':swimmer_tone3:'
      'aliases': ''
      'keywords': 'swimmer tone 3 sport swim water pool laps freestyle butterfly breaststroke backstroke'
    'swimmer_tone4':
      'unicode': '1f3ca-1f3fe'
      'shortname': ':swimmer_tone4:'
      'aliases': ''
      'keywords': 'swimmer tone 4 sport swim water pool laps freestyle butterfly breaststroke backstroke'
    'swimmer_tone5':
      'unicode': '1f3ca-1f3ff'
      'shortname': ':swimmer_tone5:'
      'aliases': ''
      'keywords': 'swimmer tone 5 sport swim water pool laps freestyle butterfly breaststroke backstroke'
    'surfer_tone1':
      'unicode': '1f3c4-1f3fb'
      'shortname': ':surfer_tone1:'
      'aliases': ''
      'keywords': 'surfer tone 1 ocean sea sport surf wave ocean ride swell'
    'surfer_tone2':
      'unicode': '1f3c4-1f3fc'
      'shortname': ':surfer_tone2:'
      'aliases': ''
      'keywords': 'surfer tone 2 ocean sea sport surf wave ocean ride swell'
    'surfer_tone3':
      'unicode': '1f3c4-1f3fd'
      'shortname': ':surfer_tone3:'
      'aliases': ''
      'keywords': 'surfer tone 3 ocean sea sport surf wave ocean ride swell'
    'surfer_tone4':
      'unicode': '1f3c4-1f3fe'
      'shortname': ':surfer_tone4:'
      'aliases': ''
      'keywords': 'surfer tone 4 ocean sea sport surf wave ocean ride swell'
    'surfer_tone5':
      'unicode': '1f3c4-1f3ff'
      'shortname': ':surfer_tone5:'
      'aliases': ''
      'keywords': 'surfer tone 5 ocean sea sport surf wave ocean ride swell'
    'bath_tone1':
      'unicode': '1f6c0-1f3fb'
      'shortname': ':bath_tone1:'
      'aliases': ''
      'keywords': 'bath tone 1 shower tub basin wash bubble soak bathroom soap water clean shampoo lather'
    'bath_tone2':
      'unicode': '1f6c0-1f3fc'
      'shortname': ':bath_tone2:'
      'aliases': ''
      'keywords': 'bath tone 2 shower tub basin wash bubble soak bathroom soap water clean shampoo lather'
    'bath_tone3':
      'unicode': '1f6c0-1f3fd'
      'shortname': ':bath_tone3:'
      'aliases': ''
      'keywords': 'bath tone 3 shower tub basin wash bubble soak bathroom soap water clean shampoo lather'
    'bath_tone4':
      'unicode': '1f6c0-1f3fe'
      'shortname': ':bath_tone4:'
      'aliases': ''
      'keywords': 'bath tone 4 shower tub basin wash bubble soak bathroom soap water clean shampoo lather'
    'bath_tone5':
      'unicode': '1f6c0-1f3ff'
      'shortname': ':bath_tone5:'
      'aliases': ''
      'keywords': 'bath tone 5 shower tub basin wash bubble soak bathroom soap water clean shampoo lather'
    'basketball_player_tone1':
      'unicode': '26f9-1f3fb'
      'shortname': ':basketball_player_tone1:'
      'aliases': ':person_with_ball_tone1:'
      'keywords': 'person with ball tone 1'
    'basketball_player_tone2':
      'unicode': '26f9-1f3fc'
      'shortname': ':basketball_player_tone2:'
      'aliases': ':person_with_ball_tone2:'
      'keywords': 'person with ball tone 2'
    'basketball_player_tone3':
      'unicode': '26f9-1f3fd'
      'shortname': ':basketball_player_tone3:'
      'aliases': ':person_with_ball_tone3:'
      'keywords': 'person with ball tone 3'
    'basketball_player_tone4':
      'unicode': '26f9-1f3fe'
      'shortname': ':basketball_player_tone4:'
      'aliases': ':person_with_ball_tone4:'
      'keywords': 'person with ball tone 4'
    'basketball_player_tone5':
      'unicode': '26f9-1f3ff'
      'shortname': ':basketball_player_tone5:'
      'aliases': ':person_with_ball_tone5:'
      'keywords': 'person with ball tone 5'
    'lifter_tone1':
      'unicode': '1f3cb-1f3fb'
      'shortname': ':lifter_tone1:'
      'aliases': ':weight_lifter_tone1:'
      'keywords': 'weight lifter tone 1 bench press squats deadlift'
    'lifter_tone2':
      'unicode': '1f3cb-1f3fc'
      'shortname': ':lifter_tone2:'
      'aliases': ':weight_lifter_tone2:'
      'keywords': 'weight lifter tone 2 bench press squats deadlift'
    'lifter_tone3':
      'unicode': '1f3cb-1f3fd'
      'shortname': ':lifter_tone3:'
      'aliases': ':weight_lifter_tone3:'
      'keywords': 'weight lifter tone 3 bench press squats deadlift'
    'lifter_tone4':
      'unicode': '1f3cb-1f3fe'
      'shortname': ':lifter_tone4:'
      'aliases': ':weight_lifter_tone4:'
      'keywords': 'weight lifter tone 4 bench press squats deadlift'
    'lifter_tone5':
      'unicode': '1f3cb-1f3ff'
      'shortname': ':lifter_tone5:'
      'aliases': ':weight_lifter_tone5:'
      'keywords': 'weight lifter tone 5 bench press squats deadlift'
    'bicyclist_tone1':
      'unicode': '1f6b4-1f3fb'
      'shortname': ':bicyclist_tone1:'
      'aliases': ''
      'keywords': 'bicyclist tone 1 bike exercise hipster sport road pedal bicycle transportation'
    'bicyclist_tone2':
      'unicode': '1f6b4-1f3fc'
      'shortname': ':bicyclist_tone2:'
      'aliases': ''
      'keywords': 'bicyclist tone 2 bike exercise hipster sport road pedal bicycle transportation'
    'bicyclist_tone3':
      'unicode': '1f6b4-1f3fd'
      'shortname': ':bicyclist_tone3:'
      'aliases': ''
      'keywords': 'bicyclist tone 3 bike exercise hipster sport road pedal bicycle transportation'
    'bicyclist_tone4':
      'unicode': '1f6b4-1f3fe'
      'shortname': ':bicyclist_tone4:'
      'aliases': ''
      'keywords': 'bicyclist tone 4 bike exercise hipster sport road pedal bicycle transportation'
    'bicyclist_tone5':
      'unicode': '1f6b4-1f3ff'
      'shortname': ':bicyclist_tone5:'
      'aliases': ''
      'keywords': 'bicyclist tone 5 bike exercise hipster sport road pedal bicycle transportation'
    'mountain_bicyclist_tone1':
      'unicode': '1f6b5-1f3fb'
      'shortname': ':mountain_bicyclist_tone1:'
      'aliases': ''
      'keywords': 'mountain bicyclist tone 1 sport transportation bike pedal bicycle transportation'
    'mountain_bicyclist_tone2':
      'unicode': '1f6b5-1f3fc'
      'shortname': ':mountain_bicyclist_tone2:'
      'aliases': ''
      'keywords': 'mountain bicyclist tone 2 sport transportation bike pedal bicycle transportation'
    'mountain_bicyclist_tone3':
      'unicode': '1f6b5-1f3fd'
      'shortname': ':mountain_bicyclist_tone3:'
      'aliases': ''
      'keywords': 'mountain bicyclist tone 3 sport transportation bike pedal bicycle transportation'
    'mountain_bicyclist_tone4':
      'unicode': '1f6b5-1f3fe'
      'shortname': ':mountain_bicyclist_tone4:'
      'aliases': ''
      'keywords': 'mountain bicyclist tone 4 sport transportation bike pedal bicycle transportation'
    'mountain_bicyclist_tone5':
      'unicode': '1f6b5-1f3ff'
      'shortname': ':mountain_bicyclist_tone5:'
      'aliases': ''
      'keywords': 'mountain bicyclist tone 5 sport transportation bike pedal bicycle transportation'
    'horse_racing_tone1':
      'unicode': '1f3c7-1f3fb'
      'shortname': ':horse_racing_tone1:'
      'aliases': ''
      'keywords': 'horse racing tone 1 animal betting competition race jockey triple crown'
    'horse_racing_tone2':
      'unicode': '1f3c7-1f3fc'
      'shortname': ':horse_racing_tone2:'
      'aliases': ''
      'keywords': 'horse racing tone 2 animal betting competition race jockey triple crown'
    'horse_racing_tone3':
      'unicode': '1f3c7-1f3fd'
      'shortname': ':horse_racing_tone3:'
      'aliases': ''
      'keywords': 'horse racing tone 3 animal betting competition race jockey triple crown'
    'horse_racing_tone4':
      'unicode': '1f3c7-1f3fe'
      'shortname': ':horse_racing_tone4:'
      'aliases': ''
      'keywords': 'horse racing tone 4 animal betting competition race jockey triple crown'
    'horse_racing_tone5':
      'unicode': '1f3c7-1f3ff'
      'shortname': ':horse_racing_tone5:'
      'aliases': ''
      'keywords': 'horse racing tone 5 animal betting competition race jockey triple crown'
    'spy_tone1':
      'unicode': '1f575-1f3fb'
      'shortname': ':spy_tone1:'
      'aliases': ':sleuth_or_spy_tone1:'
      'keywords': 'sleuth or spy tone 1 pi undercover investigator person'
    'spy_tone2':
      'unicode': '1f575-1f3fc'
      'shortname': ':spy_tone2:'
      'aliases': ':sleuth_or_spy_tone2:'
      'keywords': 'sleuth or spy tone 2 pi undercover investigator person'
    'spy_tone3':
      'unicode': '1f575-1f3fd'
      'shortname': ':spy_tone3:'
      'aliases': ':sleuth_or_spy_tone3:'
      'keywords': 'sleuth or spy tone 3 pi undercover investigator person'
    'spy_tone4':
      'unicode': '1f575-1f3fe'
      'shortname': ':spy_tone4:'
      'aliases': ':sleuth_or_spy_tone4:'
      'keywords': 'sleuth or spy tone 4 pi undercover investigator person'
    'spy_tone5':
      'unicode': '1f575-1f3ff'
      'shortname': ':spy_tone5:'
      'aliases': ':sleuth_or_spy_tone5:'
      'keywords': 'sleuth or spy tone 5 pi undercover investigator person'
    'tone1':
      'unicode': '1f3fb'
      'shortname': ':tone1:'
      'aliases': ''
      'keywords': 'emoji modifier Fitzpatrick type-1-2'
    'tone2':
      'unicode': '1f3fc'
      'shortname': ':tone2:'
      'aliases': ''
      'keywords': 'emoji modifier Fitzpatrick type-3'
    'tone3':
      'unicode': '1f3fd'
      'shortname': ':tone3:'
      'aliases': ''
      'keywords': 'emoji modifier Fitzpatrick type-4'
    'tone4':
      'unicode': '1f3fe'
      'shortname': ':tone4:'
      'aliases': ''
      'keywords': 'emoji modifier Fitzpatrick type-5'
    'tone5':
      'unicode': '1f3ff'
      'shortname': ':tone5:'
      'aliases': ''
      'keywords': 'emoji modifier Fitzpatrick type-6'

  Template.instance().$('textarea').textcomplete [ {
    match: /\B:([\-+\w]*)$/
    search: (term, callback) ->
      results = []
      results2 = []
      results3 = []
      $.each emojiStrategy, (shortname, data) ->
        if shortname.indexOf(term) > -1
          results.push shortname
        else
          if data.aliases != null and data.aliases.indexOf(term) > -1
            results2.push shortname
          else if data.keywords != null and data.keywords.indexOf(term) > -1
            results3.push shortname
        return
      if term.length >= 3
        results.sort (a, b) ->
          a.length > b.length
        results2.sort (a, b) ->
          a.length > b.length
        results3.sort()
      newResults = results.concat(results2).concat(results3)
      callback newResults
      return
    template: (shortname) ->
      '<img class="emojione" src="//cdn.jsdelivr.net/emojione/assets/png/' + emojiStrategy[shortname].unicode + '.png"> :' + shortname + ':'
    replace: (shortname) ->
      ':' + shortname + ': '
    index: 1
    maxCount: 10
  } ], footer: '<a href="http://www.emoji.codes" target="_blank">Browse All<span class="arrow">»</span></a>'

  Template.instance().$('textarea').focus()
