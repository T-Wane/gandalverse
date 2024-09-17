'use strict';
const MANIFEST = 'flutter-app-manifest';
const TEMP = 'flutter-temp-cache';
const CACHE_NAME = 'flutter-app-cache';

const RESOURCES = {"assets/AssetManifest.bin": "be012700c114a15c26e86dc122841dad",
"assets/AssetManifest.bin.json": "80a1dc4d80c2795b059e360cded2d2c9",
"assets/AssetManifest.json": "1633b4ce44f4aea6fea2fc546a69c420",
"assets/assets/AssetManifest.bin": "c85bcc7489efa79fc6ad3fe57dd52e3e",
"assets/assets/AssetManifest.bin.json": "7dba2718645bee383e32a237b5dea4a5",
"assets/assets/AssetManifest.json": "eef43b9362dfb365aef650a403e2c9e5",
"assets/assets/FontManifest.json": "2a5267a8ba1e6aa47542e873e50f2700",
"assets/assets/fonts/aller/AllerDisplay_Std_Rg.ttf": "544f1e3f487729dd268b9ae192ea17c4",
"assets/assets/fonts/aller/Aller_Std_Bd.ttf": "66d9368564ca91a2a2f92d3c914d8ceb",
"assets/assets/fonts/aller/Aller_Std_It.ttf": "039f78c02b59f0fd2c2fbc974d6843c5",
"assets/assets/fonts/aller/Aller_Std_Lt.ttf": "f21cb65658725c08c7f7cc8ccb99aabd",
"assets/assets/fonts/aller/Aller_Std_Rg.ttf": "ea76b8319cceb0671810cfe2b3575365",
"assets/assets/images/accountability.png": "9fa9b35e8f883ae8fade44d2008fc7d9",
"assets/assets/images/availability.png": "82bd66a10ace0a2866e7b5eca6ed576a",
"assets/assets/images/avatar/AvatarPMU2.png": "deaef98930c477cd045128b65d1804ff",
"assets/assets/images/avatar/AvatarYaraOil.png": "bbc3539cd5530ecf30ef38322fffd2fa",
"assets/assets/images/bag_coin.png": "a9aa383be0a4a3f9d5fcd41325710d66",
"assets/assets/images/boost.png": "fb6880f549f1956e6de2792da85da3a2",
"assets/assets/images/categories_icons/badge.png": "4035354cdabd32a4a7db44192a6ff96b",
"assets/assets/images/categories_icons/bank.png": "9d30f6f3262c44751bf1af21f1dca602",
"assets/assets/images/categories_icons/consumer.png": "67de6a0df3705ea6f9a18b917f23b4e0",
"assets/assets/images/categories_icons/luck.png": "1296bf6a036b8f9b15f2c2e1a1c0bb04",
"assets/assets/images/categories_icons/luggage-cart.png": "5eb02663faeb94c5561df0b39fd279b2",
"assets/assets/images/categories_icons/photo-camera.png": "7378190240a6b17f8281a1fbf46f01a9",
"assets/assets/images/categories_icons/restaurant.png": "fb53e8600fb436e596e488f109328bb6",
"assets/assets/images/categories_icons/ring-bell.png": "db08d4d55d1862fcda9e38c5a6e3bf77",
"assets/assets/images/categories_icons/shopping-bag.png": "d2f2ef57af3a616bc1022a1790388570",
"assets/assets/images/categories_icons/ticket-box.png": "abe912b6e0bc96170d409041271f0d8d",
"assets/assets/images/categories_icons/tickets.png": "643b1cc4d9f4d17a1a2101128840f3dd",
"assets/assets/images/categories_images/afg.jpg": "7df103dbbcf5307ec06721fff51eb908",
"assets/assets/images/categories_images/musso_kunda.jpg": "d2be8b8cd287dd92ca166c04b5d81116",
"assets/assets/images/categories_images/pmu.jpg": "8c9c1a3545d8112ad1b385a358a741c4",
"assets/assets/images/categories_images/yara_oil.jpg": "c968586522ce26ec03eae92684006567",
"assets/assets/images/check.png": "1f28c98cc302f9ef327602e30e7f92c9",
"assets/assets/images/circleBtn.png": "829ccc444f688c9b115ef8edd1a56619",
"assets/assets/images/coin.png": "105d090cf62fde5fcad3eabc4ee4e8d3",
"assets/assets/images/coins.jpg": "93f528f3b07e12599263e6c9a8160d83",
"assets/assets/images/coin_dollar.png": "7a11863313280fdb3f6d421991d4bc1b",
"assets/assets/images/coin_dollar_update.png": "fef1f601492d052abb4b4adb98efe3ce",
"assets/assets/images/education.png": "555a9232b606506b019aa127e42a230b",
"assets/assets/images/facebook.png": "a24ea58fe99f79696613c1e16768da9c",
"assets/assets/images/game_gift.png": "fc364d31b8b128ac9bdc0705dffe0816",
"assets/assets/images/game_key.png": "21ff9447ae81fe2c499549b3e6a35a3c",
"assets/assets/images/game_money.png": "1d9a3d1a50250ca081499c2512957dd5",
"assets/assets/images/game_puzzle_piece.png": "5b43a9fbd06f50cf9ece5d94f5a3cf50",
"assets/assets/images/Gandal%2520Verse%2520v2.PNG": "f73addd836efb3ae4192d9aca13905be",
"assets/assets/images/GandalVersev3.PNG": "5e80030b0a41545d08466e0859865fa7",
"assets/assets/images/gift.png": "fd194b305eacd9237fff2cf2ae02126c",
"assets/assets/images/group.png": "9d74c09183860d1119ddc8449ddacdd3",
"assets/assets/images/GverseIconePNG.png": "b8321703e5d52f1c9b5151b0d1694f7c",
"assets/assets/images/GverseToken_OnboardingPage.png": "8128e5bbeed2bdd3b9de842f9fed4ea1",
"assets/assets/images/GVT.png": "f31dc5b89125c144a0c04646b7f4362b",
"assets/assets/images/GVT_lightBack.png": "f2a92bfe55904c9a8ea688f81d12a765",
"assets/assets/images/img_back1.jpg": "a0ddbcbdb200bf121b86485d6efc466a",
"assets/assets/images/img_back2.png": "8b4d8768dacfcd1d764e254a867ab475",
"assets/assets/images/levels_images/Niveau1.png": "459a2babd5ef3a050ba8552ed5d962e8",
"assets/assets/images/levels_images/Niveau2.png": "21da0e41bafaf8ce84b2552a15836d9b",
"assets/assets/images/levels_images/Niveau3.png": "b8456aea25df7d8c0a28460f2e6587aa",
"assets/assets/images/Logo-bnda-2.png": "bf57f59a7465352dfea8a6eeb0c91408",
"assets/assets/images/logo_BDM.jpg": "d6de779272af07c820de63ca68909e03",
"assets/assets/images/mission.png": "1e7c203db003068fb636c828e3caebd0",
"assets/assets/images/new/arrow.png": "3d387150f4d28ae54a35100b7072eab6",
"assets/assets/images/new/avatar.png": "f2f7e71c45dfaa00ef500cb42b502775",
"assets/assets/images/new/banner_1.png": "2e42064a796bc9f1334f904198735d43",
"assets/assets/images/new/banner_2.png": "a25d15b83ba770963dcecb2fbb790137",
"assets/assets/images/new/banner_3.png": "276ec3fa7bc2ba0bfda72673afccb995",
"assets/assets/images/new/banner_4.png": "4594856e0602938ef457b9d10641a1dc",
"assets/assets/images/new/banner_5.png": "37fe7a390f1069fe96db689036d03c20",
"assets/assets/images/new/dj.png": "86937084aed33516ecbb9158ea21e147",
"assets/assets/images/new/FontManifest.json": "2dea9f1d6548823bfa546f373bc3e405",
"assets/assets/images/new/icon_1.png": "94a789566f38dd932a0354660aab6b5b",
"assets/assets/images/new/icon_2.png": "eec76affddac7e81e4a1f4573cb11f01",
"assets/assets/images/new/icon_3.png": "ef7f77e5a1a16ff8d58830ca1dee9fc2",
"assets/assets/images/new/lable.png": "9f84f44c633a28db063a1ec27b061ad6",
"assets/assets/images/new/map.png": "c9a4d0a1d780ff21d896a85ed00bf11c",
"assets/assets/images/new/recent.png": "04b3629aa0e237d11ac4bee759b5cbe5",
"assets/assets/images/new/search.png": "bec8d72c8056f388640623e94b8b9728",
"assets/assets/images/panel.png": "668fbe57f3fff442c8c7b6a941b11563",
"assets/assets/images/parchment.png": "89f2ab5990feb29abc890e022e21fbb0",
"assets/assets/images/placeholder.svg": "9bf25ec74afd819dbfc1cbe0e5bbfc13",
"assets/assets/images/playstore.png": "c7bd0c679ec22cba1633ff12fccca216",
"assets/assets/images/pub.png": "0b0f48cfbe48c9b51d52cd1191c8f77c",
"assets/assets/images/qg_images/analysteDeCourse.jpg": "0558f44b61ea0848a4109d39c8b7920e",
"assets/assets/images/qg_images/analysteFinancier.jpg": "13a79feb42bb6a369588f0f0b9f03f78",
"assets/assets/images/qg_images/carburantEtLubrifiant.jpg": "a594a6223d4550824702c10fe7738c41",
"assets/assets/images/qg_images/chefdeProjet.jpg": "c8e743ddab5a11c0bef1d49e0ffd1836",
"assets/assets/images/qg_images/communityManager.jpg": "3f73e93d1dd8a9d7b74b5a202f6506be",
"assets/assets/images/qg_images/doYouWantBank.jpg": "70879ea75b6a141f99078a461961b59f",
"assets/assets/images/qg_images/leParieur.jpg": "144ae6f5857d639ef304cb59071d9fea",
"assets/assets/images/qg_images/responsableCommunication.jpg": "d7984d71f9c320e5151f59b0f18828d8",
"assets/assets/images/qg_images/supportClient.jpg": "082164305557fd9f422cca08f198c399",
"assets/assets/images/question.png": "d29b4e51e908aedb0be8e10384771a39",
"assets/assets/images/redistribuer.png": "88449264ffcd8b188ee165d7057ed0fd",
"assets/assets/images/right-arrow.png": "7895ebd7cbb23c610450a82b334451c8",
"assets/assets/images/rocket-ship.png": "1b0fc3a23f841e4600b880d2b653a0b5",
"assets/assets/images/scanQr.png": "ecfec508d784dfbf1f4caee992931a21",
"assets/assets/images/social_black/barcode-scanner.png": "60701002d8d5ad6b270e9bfda6358269",
"assets/assets/images/social_black/facebook.png": "4f1051b8d8c05d33fd826c7f3d7c96b4",
"assets/assets/images/social_black/telegram.png": "0788bd23d86360c661b8fa9a91d99550",
"assets/assets/images/social_black/tiktok.png": "c28071fcea9742f039d0ae44468caf22",
"assets/assets/images/social_black/twitter.png": "6352d995b0c2a0f882503daa1d99a2e7",
"assets/assets/images/social_black/youtube.png": "4aa43a7d58e9899c0d0bcbf516285e02",
"assets/assets/images/soon.png": "2a3a489e4836cde82133f466b551a05c",
"assets/assets/images/spin.png": "fee22f5ea8606e5f2970e148fdf70150",
"assets/assets/images/telegram.png": "0b010ffa480ee2e2c422c187811d4ed9",
"assets/assets/images/tiktok.png": "af0831a3b70b49c307fa20ded7de25cd",
"assets/assets/images/twitter.png": "33249779c69d217384d439be743e8da9",
"assets/assets/images/up-arrow.png": "f86dd1b12a5c06c39ab8210638dd8a58",
"assets/assets/images/Vector.png": "76de5a501a2fca51eb4bdb9d10bf9377",
"assets/assets/images/videoYoutube.png": "d8efeffd392578abeb3580d179cca779",
"assets/assets/images/whatsapp.png": "e577c4ee1c927a59300a082a1590877e",
"assets/assets/images/whatsapp2.png": "27d86ab9ba2fbee3decc4e48bcd2deaf",
"assets/assets/images/word.png": "72fc71e0d812160605b6eaf0c313c373",
"assets/assets/images/youtube.png": "ba606c447ed57e36d4a95b4920a441de",
"assets/assets/json/categorieData.json": "5cb0e1540b3b0483f31cbd2c1609422f",
"assets/assets/json/equipeData.json": "477b72899b2d6e754097f19d8128c443",
"assets/assets/json/eventsData.json": "9898205ea436fb047e7bbad200cfcfe5",
"assets/assets/json/partenaireData.json": "5e19e28ac4434ade08e2d731e50747d7",
"assets/assets/json/reward.json": "73e339fd6cb732df3778b52461a5b344",
"assets/assets/json/socialLinksData.json": "7caad065c09a55b97e63bca9a8ba6bea",
"assets/assets/NOTICES": "e5dad0895aa77c21e8a8d7680bb81958",
"assets/back_new_verse.jpg": "f7fd074e3739e2cfb77ab1b0cc5c6f58",
"assets/FontManifest.json": "2a5267a8ba1e6aa47542e873e50f2700",
"assets/fonts/MaterialIcons-Regular.otf": "b211bee5f3d7e9d8b7659774548af51c",
"assets/GverseToken_OnboardingPage.png": "820b9e0e98327dc8cc26971d46a9dfaf",
"assets/GverseToken_OnboardingPage2.png": "8128e5bbeed2bdd3b9de842f9fed4ea1",
"assets/NOTICES": "17b784384f9fd8a4b4140a426c952809",
"assets/packages/cupertino_icons/assets/CupertinoIcons.ttf": "c4dc2c0e87feea6a008bc589ed32b2fe",
"assets/packages/flutter_inappwebview/assets/t_rex_runner/t-rex.css": "5a8d0222407e388155d7d1395a75d5b9",
"assets/packages/flutter_inappwebview/assets/t_rex_runner/t-rex.html": "16911fcc170c8af1c5457940bd0bf055",
"assets/packages/line_awesome_flutter/lib/fonts/LineAwesome.ttf": "c9f7bb62655415e80068b01558fb8d4e",
"assets/shaders/ink_sparkle.frag": "ecc85a2e95f5e9f53123dcaf8cb9b6ce",
"canvaskit/canvaskit.js": "738255d00768497e86aa4ca510cce1e1",
"canvaskit/canvaskit.js.symbols": "74a84c23f5ada42fe063514c587968c6",
"canvaskit/canvaskit.wasm": "9251bb81ae8464c4df3b072f84aa969b",
"canvaskit/chromium/canvaskit.js": "901bb9e28fac643b7da75ecfd3339f3f",
"canvaskit/chromium/canvaskit.js.symbols": "ee7e331f7f5bbf5ec937737542112372",
"canvaskit/chromium/canvaskit.wasm": "399e2344480862e2dfa26f12fa5891d7",
"canvaskit/skwasm.js": "5d4f9263ec93efeb022bb14a3881d240",
"canvaskit/skwasm.js.symbols": "c3c05bd50bdf59da8626bbe446ce65a3",
"canvaskit/skwasm.wasm": "4051bfc27ba29bf420d17aa0c3a98bce",
"canvaskit/skwasm.worker.js": "bfb704a6c714a75da9ef320991e88b03",
"favicon.png": "5dcef449791fa27946b3d35ad8803796",
"flutter.js": "383e55f7f3cce5be08fcf1f3881f585c",
"flutter_bootstrap.js": "1fca8fd6bb17702d831039951293f08e",
"icons/Icon-192.png": "ac9a721a12bbc803b44f645561ecb1e1",
"icons/Icon-512.png": "96e752610906ba2a93c65f8abe1645f1",
"icons/Icon-maskable-192.png": "c457ef57daa1d16f64b27b786ec2ea3c",
"icons/Icon-maskable-512.png": "301a7604d45b3e739efc881eb04896ea",
"index.html": "d3a8da59444c6f58b97b820e14b09d1c",
"/": "d3a8da59444c6f58b97b820e14b09d1c",
"main.dart.js": "238304b0c05b95d87a539fa1eee94384",
"manifest.json": "9f6f1bf5b67cd2b30e68a99551f02cad",
"version.json": "bdbf5533cd872db8379bf13ff58db6f3"};
// The application shell files that are downloaded before a service worker can
// start.
const CORE = ["main.dart.js",
"index.html",
"flutter_bootstrap.js",
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
