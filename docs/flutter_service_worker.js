'use strict';
const MANIFEST = 'flutter-app-manifest';
const TEMP = 'flutter-temp-cache';
const CACHE_NAME = 'flutter-app-cache';

const RESOURCES = {"assets/AssetManifest.bin": "63740ecbac17239d3e6f1283c70ae706",
"assets/AssetManifest.bin.json": "d7f55ed0c8796c095cbd757862409f1e",
"assets/AssetManifest.json": "6f08da437739bd7fc2e453c5527163a3",
"assets/assets/fonts/aller/AllerDisplay_Std_Rg.ttf": "544f1e3f487729dd268b9ae192ea17c4",
"assets/assets/fonts/aller/Aller_Std_Bd.ttf": "66d9368564ca91a2a2f92d3c914d8ceb",
"assets/assets/fonts/aller/Aller_Std_It.ttf": "039f78c02b59f0fd2c2fbc974d6843c5",
"assets/assets/fonts/aller/Aller_Std_Lt.ttf": "f21cb65658725c08c7f7cc8ccb99aabd",
"assets/assets/fonts/aller/Aller_Std_Rg.ttf": "ea76b8319cceb0671810cfe2b3575365",
"assets/assets/images/availability.png": "82bd66a10ace0a2866e7b5eca6ed576a",
"assets/assets/images/bag_coin.png": "a9aa383be0a4a3f9d5fcd41325710d66",
"assets/assets/images/coin.png": "975da585de1415a3bedb80bb69dc16d8",
"assets/assets/images/coins.jpg": "93f528f3b07e12599263e6c9a8160d83",
"assets/assets/images/facebook.png": "a24ea58fe99f79696613c1e16768da9c",
"assets/assets/images/game_gift.png": "fc364d31b8b128ac9bdc0705dffe0816",
"assets/assets/images/game_key.png": "21ff9447ae81fe2c499549b3e6a35a3c",
"assets/assets/images/game_money.png": "1d9a3d1a50250ca081499c2512957dd5",
"assets/assets/images/game_puzzle_piece.png": "5b43a9fbd06f50cf9ece5d94f5a3cf50",
"assets/assets/images/Gandal%2520Verse%2520v2.PNG": "f73addd836efb3ae4192d9aca13905be",
"assets/assets/images/Gandal%2520Verse%2520v3.PNG": "5e80030b0a41545d08466e0859865fa7",
"assets/assets/images/gift.png": "fd194b305eacd9237fff2cf2ae02126c",
"assets/assets/images/GverseToken_OnboardingPage.png": "820b9e0e98327dc8cc26971d46a9dfaf",
"assets/assets/images/img_back1.jpg": "a0ddbcbdb200bf121b86485d6efc466a",
"assets/assets/images/img_back2.png": "8b4d8768dacfcd1d764e254a867ab475",
"assets/assets/images/panel.png": "668fbe57f3fff442c8c7b6a941b11563",
"assets/assets/images/parchment.png": "89f2ab5990feb29abc890e022e21fbb0",
"assets/assets/images/playstore.png": "c7bd0c679ec22cba1633ff12fccca216",
"assets/assets/images/pub.png": "0b0f48cfbe48c9b51d52cd1191c8f77c",
"assets/assets/images/question.png": "d29b4e51e908aedb0be8e10384771a39",
"assets/assets/images/redistribuer.png": "88449264ffcd8b188ee165d7057ed0fd",
"assets/assets/images/scanQr.png": "ecfec508d784dfbf1f4caee992931a21",
"assets/assets/images/telegram.png": "0b010ffa480ee2e2c422c187811d4ed9",
"assets/assets/images/tiktok.png": "af0831a3b70b49c307fa20ded7de25cd",
"assets/assets/images/twitter.png": "33249779c69d217384d439be743e8da9",
"assets/assets/images/videoYoutube.png": "d8efeffd392578abeb3580d179cca779",
"assets/assets/images/whatsapp.png": "e577c4ee1c927a59300a082a1590877e",
"assets/assets/images/whatsapp2.png": "27d86ab9ba2fbee3decc4e48bcd2deaf",
"assets/assets/images/youtube.png": "ba606c447ed57e36d4a95b4920a441de",
"assets/FontManifest.json": "2a5267a8ba1e6aa47542e873e50f2700",
"assets/fonts/MaterialIcons-Regular.otf": "fbfcc060b7261dc4cbb9d45d2b1348a9",
"assets/NOTICES": "8c39e882a6a8520785a28f092e11f272",
"assets/packages/cupertino_icons/assets/CupertinoIcons.ttf": "639d91ebdbdc26d0ccce20a464cd190b",
"assets/packages/line_awesome_flutter/lib/fonts/LineAwesome.ttf": "c9f7bb62655415e80068b01558fb8d4e",
"assets/shaders/ink_sparkle.frag": "ecc85a2e95f5e9f53123dcaf8cb9b6ce",
"canvaskit/canvaskit.js": "c86fbd9e7b17accae76e5ad116583dc4",
"canvaskit/canvaskit.js.symbols": "38cba9233b92472a36ff011dc21c2c9f",
"canvaskit/canvaskit.wasm": "3d2a2d663e8c5111ac61a46367f751ac",
"canvaskit/chromium/canvaskit.js": "43787ac5098c648979c27c13c6f804c3",
"canvaskit/chromium/canvaskit.js.symbols": "4525682ef039faeb11f24f37436dca06",
"canvaskit/chromium/canvaskit.wasm": "f5934e694f12929ed56a671617acd254",
"canvaskit/skwasm.js": "445e9e400085faead4493be2224d95aa",
"canvaskit/skwasm.js.symbols": "741d50ffba71f89345996b0aa8426af8",
"canvaskit/skwasm.wasm": "e42815763c5d05bba43f9d0337fa7d84",
"canvaskit/skwasm.worker.js": "bfb704a6c714a75da9ef320991e88b03",
"favicon.png": "5dcef449791fa27946b3d35ad8803796",
"flutter.js": "c71a09214cb6f5f8996a531350400a9a",
"icons/Icon-192.png": "ac9a721a12bbc803b44f645561ecb1e1",
"icons/Icon-512.png": "96e752610906ba2a93c65f8abe1645f1",
"icons/Icon-maskable-192.png": "c457ef57daa1d16f64b27b786ec2ea3c",
"icons/Icon-maskable-512.png": "301a7604d45b3e739efc881eb04896ea",
"index.html": "58d859788d3457bb69b2fcd1519d977c",
"/": "58d859788d3457bb69b2fcd1519d977c",
"main.dart.js": "2060634ac4eb297a2342ebb8e37958f7",
"manifest.json": "9f6f1bf5b67cd2b30e68a99551f02cad",
"version.json": "bdbf5533cd872db8379bf13ff58db6f3"};
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
