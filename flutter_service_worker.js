'use strict';
const MANIFEST = 'flutter-app-manifest';
const TEMP = 'flutter-temp-cache';
const CACHE_NAME = 'flutter-app-cache';

const RESOURCES = {"version.json": "162e9b941dc563410c59985ff3aeb403",
"index.html": "ee15172a44b4b4aee89d7e396fa89ddd",
"/": "ee15172a44b4b4aee89d7e396fa89ddd",
"main.dart.js": "e141c319bcb84ed1f9446e2e26b645e0",
"flutter.js": "c71a09214cb6f5f8996a531350400a9a",
"favicon.png": "f1aaf623e2ebec450043ee23c7c14a2f",
"icons/Icon-192.png": "ac9a721a12bbc803b44f645561ecb1e1",
"icons/Icon-maskable-192.png": "c457ef57daa1d16f64b27b786ec2ea3c",
"icons/Icon-maskable-512.png": "301a7604d45b3e739efc881eb04896ea",
"icons/Icon-512.png": "96e752610906ba2a93c65f8abe1645f1",
"manifest.json": "a30a674057c2cb4df8c5a0add21bb035",
"assets/AssetManifest.json": "6fdb6fba38b308d5d3dbd4df8a7a2540",
"assets/NOTICES": "ed20370992c3fb7c4ae478c078ffd1d2",
"assets/FontManifest.json": "892544a5a48b4e34d5a74dd210c18809",
"assets/AssetManifest.bin.json": "bee64b86664dc2695907540ea81cb760",
"assets/packages/nes_ui/assets/checkered_pattern.png": "7f3e9d7ae73d37c7329ee95d1d54f531",
"assets/packages/nes_ui/google_fonts/OFL.txt": "5096248a0ad125929b038a264f57b570",
"assets/packages/nes_ui/google_fonts/PressStart2P-Regular.ttf": "f98cd910425bf727bd54ce767a9b6884",
"assets/packages/cupertino_icons/assets/CupertinoIcons.ttf": "89ed8f4e49bcdfc0b5bfc9b24591e347",
"assets/packages/youtube_player_iframe/assets/player.html": "ea69af402f26127fa4991b611d4f2596",
"assets/packages/google_wallet/assets/tr_wallet_button_primary.svg": "d384b3554e04e7e992d07c5e43d39dc4",
"assets/packages/google_wallet/assets/ky_wallet_button_condensed.svg": "a4c963a8c278588302308c9adead05ad",
"assets/packages/google_wallet/assets/ca_wallet_button_primary.svg": "4b5de96fd0f9b295a9a79be8a8d0eae0",
"assets/packages/google_wallet/assets/sl_wallet_button_condensed.svg": "9115210492785029107c6a2270ea6b81",
"assets/packages/google_wallet/assets/kk_wallet_button_condensed.svg": "21a39f7ee3011aa092e50336e7666aea",
"assets/packages/google_wallet/assets/en_IN_wallet_button_primary.svg": "684e4081529340802d4d4942dc25d109",
"assets/packages/google_wallet/assets/cz_wallet_button_primary.svg": "c7f8036327379bedddd0955644e2f252",
"assets/packages/google_wallet/assets/zh_HK_wallet_button_condensed.svg": "5f806947f0c597698e358295dc063173",
"assets/packages/google_wallet/assets/ro_wallet_button_condensed.svg": "ad0791d56b6c874cbb82ff8c56bb15e9",
"assets/packages/google_wallet/assets/nl_wallet_button_primary.svg": "272a8c010e4fe8ddcbed3171d1f091b7",
"assets/packages/google_wallet/assets/en_US_wallet_button_condensed.svg": "b7de62572ebbd02edb55b97fea662cda",
"assets/packages/google_wallet/assets/es_US_wallet_button_primary.svg": "408c67d702c409241b287933c716f5f9",
"assets/packages/google_wallet/assets/no_wallet_button_condensed.svg": "0220c67b932537d17ba33e420abc0aea",
"assets/packages/google_wallet/assets/hu_wallet_button_primary.svg": "52fe894a003f7327edba8170663ce21a",
"assets/packages/google_wallet/assets/lt_wallet_button_condensed.svg": "3f1ac0e6e13db1cf268dcd2f496c0039",
"assets/packages/google_wallet/assets/pt_wallet_button_condensed.svg": "f352fa6b49d513011e86cff7cbcbabaf",
"assets/packages/google_wallet/assets/en_IN_wallet_button_condensed.svg": "f6388525ba6256bcddd814672d4389e5",
"assets/packages/google_wallet/assets/id_wallet_button_primary.svg": "ce5884c701d800ec94ef78d308db6e64",
"assets/packages/google_wallet/assets/hr_wallet_button_primary.svg": "1ca3f09db38e1c2cc15f690d762d9180",
"assets/packages/google_wallet/assets/ka_wallet_button_condensed.svg": "e50f3f95ec1969e6b0ea749f93561bc3",
"assets/packages/google_wallet/assets/uz_wallet_button_condensed.svg": "827febbc21a67ec1504b20d7cb68cb0f",
"assets/packages/google_wallet/assets/lv_wallet_button_primary.svg": "201e043ec36c0b812149eaa82563b47b",
"assets/packages/google_wallet/assets/hy_wallet_button_condensed.svg": "aed6e8e675a57fb66de5c87f2b1c4698",
"assets/packages/google_wallet/assets/es_ES_wallet_button_primary.svg": "79b4becce2a1cdfef82f154fe9a9af1c",
"assets/packages/google_wallet/assets/uk_wallet_button_primary.svg": "863ea50d285999147c57cbb86350ede0",
"assets/packages/google_wallet/assets/jp_wallet_button_condensed.svg": "03896b8a5dad9a42adb1bb6a7b428bd4",
"assets/packages/google_wallet/assets/ky_wallet_button_primary.svg": "fbe55d976815113cd4954100a826504c",
"assets/packages/google_wallet/assets/pl_wallet_button_condensed.svg": "61a3e3b97f4595f09a6ab97b7ed486bf",
"assets/packages/google_wallet/assets/sr_wallet_button_primary.svg": "0998bd940c28a80ba68e9c5919cdd6b2",
"assets/packages/google_wallet/assets/sq_wallet_button_condensed.svg": "9564675bca05aefe7862d599824cea6f",
"assets/packages/google_wallet/assets/az_wallet_button_condensed.svg": "3b4344df734bfe74a39de5fdce795367",
"assets/packages/google_wallet/assets/bg_wallet_button_condensed.svg": "cc28fc61d74c670c93639f27ecad2ea9",
"assets/packages/google_wallet/assets/it_wallet_button_condensed.svg": "e411485b5fb9adfbd0d258ef2efe39bf",
"assets/packages/google_wallet/assets/vi_wallet_button_condensed.svg": "06b512e3f3f7aed1bf0525b54b77f53e",
"assets/packages/google_wallet/assets/ca_wallet_button_condensed.svg": "9b3e9a6746696c9989d7eb2d3ed7580d",
"assets/packages/google_wallet/assets/en_GB_wallet_button_primary.svg": "5e394579efa0e4d2462a3fa7c4a30324",
"assets/packages/google_wallet/assets/tr_wallet_button_condensed.svg": "f53e5ac42034452ff2199c06feb2974d",
"assets/packages/google_wallet/assets/hr_wallet_button_condensed.svg": "2fcae7c3192a9669df73cb297f215542",
"assets/packages/google_wallet/assets/sl_wallet_button_primary.svg": "46d510bf1bf8017a12b828991f664c55",
"assets/packages/google_wallet/assets/pt_wallet_button_primary.svg": "d1ee37067180bfe3d83e5cb190dfc44f",
"assets/packages/google_wallet/assets/he_wallet_button_condensed.svg": "997ad26fb4d19aa8026ce51b7bf89884",
"assets/packages/google_wallet/assets/es_US_wallet_button_condensed.svg": "eca6d036063e600bbd4652fba5001917",
"assets/packages/google_wallet/assets/es_419_wallet_button_condensed.svg": "0cf21c6738ddff5ef4dff455f6a3350d",
"assets/packages/google_wallet/assets/en_CA_wallet_button_primary.svg": "c7db284caf9fb7fadfe365e5e94584dd",
"assets/packages/google_wallet/assets/my_wallet_button_primary.svg": "b9c2a17d024811424f704b94a5221ba9",
"assets/packages/google_wallet/assets/ru_wallet_button_primary.svg": "c92edf4a0c610ef993e88c54a92bb9b4",
"assets/packages/google_wallet/assets/mk_wallet_button_condensed.svg": "a5be0df87def78e495dd37e784f924e0",
"assets/packages/google_wallet/assets/my_wallet_button_condensed.svg": "8630411b06e05adfc7e4ef285c55200f",
"assets/packages/google_wallet/assets/sk_wallet_button_primary.svg": "9ebd9f4e90b7460edc2dabb62efe4a3c",
"assets/packages/google_wallet/assets/uz_wallet_button_primary.svg": "0fa3101925d940650aae990da99c013f",
"assets/packages/google_wallet/assets/fr_FR_wallet_button_primary.svg": "77e7479cbed3ac241182c4e603e47b79",
"assets/packages/google_wallet/assets/dk_wallet_button_primary.svg": "3f2440412e8583b501d527a8835d4675",
"assets/packages/google_wallet/assets/lt_wallet_button_primary.svg": "02728a3a766806a440286016b8b0d977",
"assets/packages/google_wallet/assets/zh_TW_wallet_button_condensed.svg": "69473bdf975d69a2a45a75484293899a",
"assets/packages/google_wallet/assets/br_wallet_button_primary.svg": "69034d0e4fbe96daa055f59f14b94397",
"assets/packages/google_wallet/assets/en_SG_wallet_button_primary.svg": "644d79276dddb41bab47f1f2864b62ae",
"assets/packages/google_wallet/assets/by_wallet_button_condensed.svg": "a7662ba7cafbe23dcd4f84d61d50071d",
"assets/packages/google_wallet/assets/sq_wallet_button_primary.svg": "4f749b928b9e15c76add3ee9a32a986e",
"assets/packages/google_wallet/assets/es_ES_wallet_button_condensed.svg": "8f4092b9aeabeac6ba56b2b94c6b71ff",
"assets/packages/google_wallet/assets/fl_wallet_button_primary.svg": "29121627c027f93a3065c7770b8de007",
"assets/packages/google_wallet/assets/mk_wallet_button_primary.svg": "d54b7d105274653feea7d815bde1cdef",
"assets/packages/google_wallet/assets/et_wallet_button_primary.svg": "9b9851d9fa1d9c5d1ae43647647ad832",
"assets/packages/google_wallet/assets/bs_wallet_button_primary.svg": "7f26dc32009c3bdcdd0223922c7dab94",
"assets/packages/google_wallet/assets/it_wallet_button_primary.svg": "7d37a300ec48815e7e728f727fe6dde7",
"assets/packages/google_wallet/assets/fr_CA_wallet_button_primary.svg": "0e6aad49ab8b6083566a128ee5a26bd2",
"assets/packages/google_wallet/assets/fl_wallet_button_condensed.svg": "9d73c15223a8943abdf01f141ce5b6d4",
"assets/packages/google_wallet/assets/en_AU_wallet_button_primary.svg": "2612eb82e79f677c975757d97ec2de52",
"assets/packages/google_wallet/assets/gr_wallet_button_primary.svg": "9e8c6cde53bc9a2dfb8173e9af6b3304",
"assets/packages/google_wallet/assets/ro_wallet_button_primary.svg": "1491d7729e6c85fdc9c3a0a1b20e33f1",
"assets/packages/google_wallet/assets/de_wallet_button_condensed.svg": "b168e7933f4041b4eeb6916d30410039",
"assets/packages/google_wallet/assets/en_SG_wallet_button_condensed.svg": "e17bc06ff808e9e4017702ac3d28c01e",
"assets/packages/google_wallet/assets/ru_wallet_button_condensed.svg": "16138e745d66a58a7cb8cf845b10f29d",
"assets/packages/google_wallet/assets/hy_wallet_button_primary.svg": "23d9a60fcd91cbc4b8bc606255ba4f59",
"assets/packages/google_wallet/assets/ka_wallet_button_primary.svg": "fdf3c6f39bb30450fb408a13016e1575",
"assets/packages/google_wallet/assets/cz_wallet_button_condensed.svg": "82fe8e3cdffa5356e0380543f4683b2c",
"assets/packages/google_wallet/assets/et_wallet_button_condensed.svg": "62b05af6deaa442b0a92772e5082f7d0",
"assets/packages/google_wallet/assets/en_AU_wallet_button_condensed.svg": "f2ed7ab9b5e408cfecea7f932cd1e829",
"assets/packages/google_wallet/assets/gr_wallet_button_condensed.svg": "6519be79b0460e47ad3bac4e5c76274e",
"assets/packages/google_wallet/assets/bg_wallet_button_primary.svg": "de51e6a6a1a79f553362c81fcb115bf8",
"assets/packages/google_wallet/assets/se_wallet_button_primary.svg": "b7cbf672a7c76fa2b866db8c61872675",
"assets/packages/google_wallet/assets/bs_wallet_button_condensed.svg": "f85ee9046ae15cc141d006d431e4753c",
"assets/packages/google_wallet/assets/en_CA_wallet_button_condensed.svg": "ed7347971f3f38da63fa3a353fa1d1bf",
"assets/packages/google_wallet/assets/no_wallet_button_primary.svg": "ef1b1060bc300377b1a170c55435c797",
"assets/packages/google_wallet/assets/fp_wallet_button_primary.svg": "56f86f9710333ad0581f3a7d8ed3c657",
"assets/packages/google_wallet/assets/jp_wallet_button_primary.svg": "3652b471a5eba0699a4a39321270b4a1",
"assets/packages/google_wallet/assets/zh_TW_wallet_button_primary.svg": "2978c5543b4c976988e0d0b32251a210",
"assets/packages/google_wallet/assets/en_ZA_wallet_button_primary.svg": "5690da15159fda07619e638de45ea33d",
"assets/packages/google_wallet/assets/is_wallet_button_primary.svg": "cb3c716d27dc78c571bdbc9d160d671a",
"assets/packages/google_wallet/assets/he_wallet_button_primary.svg": "a6c9669b61eb02bcb3d24b9801986f54",
"assets/packages/google_wallet/assets/lv_wallet_button_condensed.svg": "5e54397529c340c5a431abdefb823f24",
"assets/packages/google_wallet/assets/zh_HK_wallet_button_primary.svg": "d76005c4492437c367ac349668fb6899",
"assets/packages/google_wallet/assets/sk_wallet_button_condensed.svg": "0d0b3bdce79456adc84f2031c584e53d",
"assets/packages/google_wallet/assets/de_wallet_button_primary.svg": "c4f083b8749b29cdb4fc0c897a4b5bac",
"assets/packages/google_wallet/assets/es_419_wallet_button_primary.svg": "51c635c02b989718d25a946fd6221530",
"assets/packages/google_wallet/assets/fr_FR_wallet_button_condensed.svg": "2b123f266da7715af1957203cb0d3b84",
"assets/packages/google_wallet/assets/sr_wallet_button_condensed.svg": "0621d013c3cb36393e2f5a10cb9ca695",
"assets/packages/google_wallet/assets/th_wallet_button_condensed.svg": "54235a7d84eb3872470ab14822be8bb2",
"assets/packages/google_wallet/assets/fr_CA_wallet_button_condensed.svg": "d9761af1d0998d0303c9079b37f99d62",
"assets/packages/google_wallet/assets/ar_wallet_button_condensed.svg": "a4f4977e753024e30c90f8bf207a360f",
"assets/packages/google_wallet/assets/by_wallet_button_primary.svg": "deb42ee451e45251299dd61187fe7705",
"assets/packages/google_wallet/assets/uk_wallet_button_condensed.svg": "a0e680dfdd829d8b264f3a57096a34cb",
"assets/packages/google_wallet/assets/ar_wallet_button_primary.svg": "260159159e270d1415a1efa00c8a6a76",
"assets/packages/google_wallet/assets/se_wallet_button_condensed.svg": "50a1f038bb8f299f697f41d55403f0a6",
"assets/packages/google_wallet/assets/az_wallet_button_primary.svg": "90f2e2d3c4de0f883c99b4085b8fc866",
"assets/packages/google_wallet/assets/kk_wallet_button_primary.svg": "a3d875aeed8ab306f7469460453273af",
"assets/packages/google_wallet/assets/vi_wallet_button_primary.svg": "9672cf033497f6730d7c3c374222718b",
"assets/packages/google_wallet/assets/nl_wallet_button_condensed.svg": "861f9e2bd43b92dbd6def9a07aa48631",
"assets/packages/google_wallet/assets/dk_wallet_button_condensed.svg": "6ee6ab67841ba870f31ec300d12f734e",
"assets/packages/google_wallet/assets/en_GB_wallet_button_condensed.svg": "d6395ad1b9b061acef26417a04477adf",
"assets/packages/google_wallet/assets/id_wallet_button_condensed.svg": "590b3141d2d9adfd1c32bbc8426d96e3",
"assets/packages/google_wallet/assets/th_wallet_button_primary.svg": "d8e936ddb250181ef216fadd70470b66",
"assets/packages/google_wallet/assets/fp_wallet_button_condensed.svg": "3e42d792fa586f7e9ac014d2a27992b5",
"assets/packages/google_wallet/assets/is_wallet_button_condensed.svg": "255356758290070c55593aaf05c22f0f",
"assets/packages/google_wallet/assets/en_ZA_wallet_button_condensed.svg": "8b01291cd9e8bc9050d3cf4fa4a4dd60",
"assets/packages/google_wallet/assets/br_wallet_button_condensed.svg": "2fd345513b4e4d9b46f11e8c9c915c4e",
"assets/packages/google_wallet/assets/en_US_wallet_button_primary.svg": "942f89835971592cbf7d716aed8a00f5",
"assets/packages/google_wallet/assets/pl_wallet_button_primary.svg": "0687e88f92f98b8363d0148c2b5b63d0",
"assets/packages/google_wallet/assets/hu_wallet_button_condensed.svg": "f218c201a311f880b476984129fbfcd3",
"assets/shaders/ink_sparkle.frag": "ecc85a2e95f5e9f53123dcaf8cb9b6ce",
"assets/AssetManifest.bin": "f8f0a19d745d95e37347d28385217c48",
"assets/fonts/MaterialIcons-Regular.otf": "78f3f6dc555b59ed17eddec6309a0ef4",
"assets/assets/music/free_run.mp3": "c700cf7861e33436a916cdf7e5da4e5b",
"assets/assets/music/CREDITS.TXT": "664b159f17146e56808c4e23d7603f6e",
"assets/assets/music/bit_forrest.mp3": "f330991a5bd6973c5d1167619319abd0",
"assets/assets/music/tropical_fantasy.mp3": "44bdafbd3982d2ba451f225294f56dff",
"assets/assets/animate/turtle_move.riv": "2eedea70cc845a53b7565368bcef6c7a",
"assets/assets/images/poly.webp": "6296466f65fc546eb753d8a8f627b676",
"assets/assets/images/trophy.png": "3b2e7b6ce1bf7d3e211e03b5abff5658",
"assets/assets/images/land.png": "acd4dd56304e06ecf5e47224a4c0295a",
"assets/assets/images/container.png": "cf47db7deaadf4f26e7a399e6e9a12de",
"assets/assets/images/bottle_empty.png": "740c1bd8eea8b29baf1b7bbe27d9814f",
"assets/assets/images/octo_goggles.png": "f244f29ed36dae395386c5fe1d9800d7",
"assets/assets/images/nemo.jpeg": "d176e5db2b201658e1918240eb174216",
"assets/assets/images/ally.png": "2ef73d0d827272947b4a526f82af4bec",
"assets/assets/images/drop_splash.png": "68fc9f1fd6515b996ab653eeee3f861c",
"assets/assets/images/banner.png": "32f20ea98f8534fb377696aed94f11ea",
"assets/assets/images/bubble.png": "14fdb0101a54cc91443d72b0a9d401de",
"assets/assets/images/plastic_ins.png": "47e59afae740bf362362e7e8b666c08f",
"assets/assets/images/pepsi.png": "7ee993fa05426ed3b65c4a6c1a2dcbf7",
"assets/assets/images/plastic_in_stomach.png": "e014b14df541527d5d1cf723bd8d92aa",
"assets/assets/images/pixel_heart.png": "4278ee8c46d0f8642a7ae45ab2ca2679",
"assets/assets/images/under_ocean.png": "934ffbc6155230b97c53d56d138dbd6d",
"assets/assets/images/google_wallet.svg": "f6388525ba6256bcddd814672d4389e5",
"assets/assets/images/octo.png": "44686e7104e6d3cafe38dc83261bfe48",
"assets/assets/images/oh_fish.png": "cdec33040db63658019a6d683ff52b26",
"assets/assets/images/cloud.png": "baba88ad7d5601fc069f6f6e8659a042",
"assets/assets/images/helly.png": "8a7a426fddf42fa996265a6257e6a619",
"assets/assets/images/garbage_truck.gif": "b324651ef2fa4f3631ce1c2fdbfc51a3",
"assets/assets/images/bg1.jpg": "a34410434963b1ece092f55f3b80d5ce",
"assets/assets/images/background_1.png": "dbdcc3d8d5fa897fb777861a679dd696",
"assets/assets/images/bg2.jpg": "92a230dba07c211cae5a5eb5b1ef091e",
"assets/assets/images/jelly.png": "256d6bd45157212029ab6de77f2b2010",
"assets/assets/images/red_star.png": "4af97ceeae91f441be8bc86bb8a662b6",
"assets/assets/images/star.png": "6669673936fcc53e2c66520c0e65fbc3",
"assets/assets/images/cd.png": "154c8742c13bdc9afb31ef41c2146399",
"assets/assets/images/starfish_animate.png": "be7368a7a7aac282dd65e75dfce08629",
"assets/assets/images/moving.jpeg": "79f7576f1d6681e2d88bbfbaee8e4efd",
"assets/assets/images/entangled.png": "4810b2879bd9ced89d4129a2c9bb221f",
"assets/assets/images/cleanup.gif": "abb5bde3fe923f14c892aaf86666f476",
"assets/assets/images/ocean.png": "137ed35a627f9e5121ffd33a123a0e2c",
"assets/assets/images/corals.png": "8239eb09ba94f36690f1fc849fb01bf1",
"assets/assets/images/scroll.png": "4b7b9b76b4b580292cd4244e7ff1386b",
"assets/assets/images/sad_fish.png": "b369dbaaf59833c0e5e3c46997a78e3a",
"assets/assets/images/corals_new.png": "7488a6305b9a1e7f9bb93ed0509e9590",
"assets/assets/images/bubble_2.jpg": "19bb434fb9f44a37390dc8e132db172c",
"assets/assets/images/fish.png": "4182057ba7d7c5d9bba84accf810e849",
"assets/assets/sfx/double_jump1.mp3": "58633df43115de841cf9235fccd64133",
"assets/assets/sfx/jump1.mp3": "247686373bffc27c3962702465614ea8",
"assets/assets/sfx/click3.mp3": "23f7ef1589277fc59d0b297db8d0297f",
"assets/assets/sfx/hit2.mp3": "19e99975f122b67cb5e17bb5e04818da",
"assets/assets/sfx/README.md": "c2318c37838f1811dd8a00d1bd6220a8",
"assets/assets/sfx/score1.mp3": "f51ae86826ee34f92514fb8e4b027edc",
"assets/assets/sfx/click2.mp3": "e7c23ca3c1bd7c9c3285c9e60f27504c",
"assets/assets/sfx/damage1.mp3": "e73bde6e93a3754205a6960f994acf91",
"assets/assets/sfx/hit1.mp3": "52f15e8def2750b4220796d7dd749e18",
"assets/assets/sfx/score2.mp3": "f9494ae1fe1a9b78563b386acca66c2c",
"assets/assets/sfx/click1.mp3": "10dfe538c54ddca1d967034637a37cbb",
"assets/assets/sfx/damage2.mp3": "3ae6d56c2fdff524875df5c956f62012",
"assets/assets/sfx/click4.mp3": "fc48c687051776935ee27782a6ee5648",
"assets/assets/audio/game_over.mp3": "00670d0d5afb1c55be8bbbd3e36dc0bc",
"assets/assets/audio/bg.mp3": "d14845c5fa896d67a352abe523aca197",
"assets/assets/audio/fruit_cut.mp3": "3be79cdbaeb203215f63bcc481dce62b",
"assets/assets/icons/pause-play-button.png": "e522c0bdb0f10f408702b1e18c98b93a",
"assets/assets/fonts/Press_Start_2P/PressStart2P-Regular.ttf": "f98cd910425bf727bd54ce767a9b6884",
"assets/assets/fonts/victorian_secret.otf": "26531210a35f07361d538b7f5f7fa462",
"canvaskit/skwasm.js": "445e9e400085faead4493be2224d95aa",
"canvaskit/skwasm.js.symbols": "741d50ffba71f89345996b0aa8426af8",
"canvaskit/canvaskit.js.symbols": "38cba9233b92472a36ff011dc21c2c9f",
"canvaskit/skwasm.wasm": "e42815763c5d05bba43f9d0337fa7d84",
"canvaskit/chromium/canvaskit.js.symbols": "4525682ef039faeb11f24f37436dca06",
"canvaskit/chromium/canvaskit.js": "43787ac5098c648979c27c13c6f804c3",
"canvaskit/chromium/canvaskit.wasm": "f5934e694f12929ed56a671617acd254",
"canvaskit/canvaskit.js": "c86fbd9e7b17accae76e5ad116583dc4",
"canvaskit/canvaskit.wasm": "3d2a2d663e8c5111ac61a46367f751ac",
"canvaskit/skwasm.worker.js": "bfb704a6c714a75da9ef320991e88b03"};
// The application shell files that are downloaded before a service worker can
// start.
const CORE = ["main.dart.js",
"index.html",
"assets/AssetManifest.bin.json",
"assets/FontManifest.json"];

// During install, the TEMP cache is populated with the application shell files.
self.addEventListener("install", (event) => {
  self.skipWaiting();
  return event.waitUntil(
    caches.open(TEMP).then((cache) => {
      return cache.addAll(
        CORE.map((value) => new Request(value, {'cache': 'reload'})));
    })
  );
});
// During activate, the cache is populated with the temp files downloaded in
// install. If this service worker is upgrading from one with a saved
// MANIFEST, then use this to retain unchanged resource files.
self.addEventListener("activate", function(event) {
  return event.waitUntil(async function() {
    try {
      var contentCache = await caches.open(CACHE_NAME);
      var tempCache = await caches.open(TEMP);
      var manifestCache = await caches.open(MANIFEST);
      var manifest = await manifestCache.match('manifest');
      // When there is no prior manifest, clear the entire cache.
      if (!manifest) {
        await caches.delete(CACHE_NAME);
        contentCache = await caches.open(CACHE_NAME);
        for (var request of await tempCache.keys()) {
          var response = await tempCache.match(request);
          await contentCache.put(request, response);
        }
        await caches.delete(TEMP);
        // Save the manifest to make future upgrades efficient.
        await manifestCache.put('manifest', new Response(JSON.stringify(RESOURCES)));
        // Claim client to enable caching on first launch
        self.clients.claim();
        return;
      }
      var oldManifest = await manifest.json();
      var origin = self.location.origin;
      for (var request of await contentCache.keys()) {
        var key = request.url.substring(origin.length + 1);
        if (key == "") {
          key = "/";
        }
        // If a resource from the old manifest is not in the new cache, or if
        // the MD5 sum has changed, delete it. Otherwise the resource is left
        // in the cache and can be reused by the new service worker.
        if (!RESOURCES[key] || RESOURCES[key] != oldManifest[key]) {
          await contentCache.delete(request);
        }
      }
      // Populate the cache with the app shell TEMP files, potentially overwriting
      // cache files preserved above.
      for (var request of await tempCache.keys()) {
        var response = await tempCache.match(request);
        await contentCache.put(request, response);
      }
      await caches.delete(TEMP);
      // Save the manifest to make future upgrades efficient.
      await manifestCache.put('manifest', new Response(JSON.stringify(RESOURCES)));
      // Claim client to enable caching on first launch
      self.clients.claim();
      return;
    } catch (err) {
      // On an unhandled exception the state of the cache cannot be guaranteed.
      console.error('Failed to upgrade service worker: ' + err);
      await caches.delete(CACHE_NAME);
      await caches.delete(TEMP);
      await caches.delete(MANIFEST);
    }
  }());
});
// The fetch handler redirects requests for RESOURCE files to the service
// worker cache.
self.addEventListener("fetch", (event) => {
  if (event.request.method !== 'GET') {
    return;
  }
  var origin = self.location.origin;
  var key = event.request.url.substring(origin.length + 1);
  // Redirect URLs to the index.html
  if (key.indexOf('?v=') != -1) {
    key = key.split('?v=')[0];
  }
  if (event.request.url == origin || event.request.url.startsWith(origin + '/#') || key == '') {
    key = '/';
  }
  // If the URL is not the RESOURCE list then return to signal that the
  // browser should take over.
  if (!RESOURCES[key]) {
    return;
  }
  // If the URL is the index.html, perform an online-first request.
  if (key == '/') {
    return onlineFirst(event);
  }
  event.respondWith(caches.open(CACHE_NAME)
    .then((cache) =>  {
      return cache.match(event.request).then((response) => {
        // Either respond with the cached resource, or perform a fetch and
        // lazily populate the cache only if the resource was successfully fetched.
        return response || fetch(event.request).then((response) => {
          if (response && Boolean(response.ok)) {
            cache.put(event.request, response.clone());
          }
          return response;
        });
      })
    })
  );
});
self.addEventListener('message', (event) => {
  // SkipWaiting can be used to immediately activate a waiting service worker.
  // This will also require a page refresh triggered by the main worker.
  if (event.data === 'skipWaiting') {
    self.skipWaiting();
    return;
  }
  if (event.data === 'downloadOffline') {
    downloadOffline();
    return;
  }
});
// Download offline will check the RESOURCES for all files not in the cache
// and populate them.
async function downloadOffline() {
  var resources = [];
  var contentCache = await caches.open(CACHE_NAME);
  var currentContent = {};
  for (var request of await contentCache.keys()) {
    var key = request.url.substring(origin.length + 1);
    if (key == "") {
      key = "/";
    }
    currentContent[key] = true;
  }
  for (var resourceKey of Object.keys(RESOURCES)) {
    if (!currentContent[resourceKey]) {
      resources.push(resourceKey);
    }
  }
  return contentCache.addAll(resources);
}
// Attempt to download the resource online before falling back to
// the offline cache.
function onlineFirst(event) {
  return event.respondWith(
    fetch(event.request).then((response) => {
      return caches.open(CACHE_NAME).then((cache) => {
        cache.put(event.request, response.clone());
        return response;
      });
    }).catch((error) => {
      return caches.open(CACHE_NAME).then((cache) => {
        return cache.match(event.request).then((response) => {
          if (response != null) {
            return response;
          }
          throw error;
        });
      });
    })
  );
}
