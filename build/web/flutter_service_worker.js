'use strict';
const MANIFEST = 'flutter-app-manifest';
const TEMP = 'flutter-temp-cache';
const CACHE_NAME = 'flutter-app-cache';

const RESOURCES = {"flutter_bootstrap.js": "512c8272e72f955ce9b3abeb4aea32df",
"version.json": "009c9e65172e010890f7f65fde438006",
"index.html": "e2f6eee91695f56873438d685d510a95",
"/": "e2f6eee91695f56873438d685d510a95",
"main.dart.js": "429a2999e295c4e4065712268af97a2d",
"flutter.js": "24bc71911b75b5f8135c949e27a2984e",
"favicon.png": "d7b92395a6ec502e8fa77a8c45a10671",
"icons/favicon-16x16.png": "d7b92395a6ec502e8fa77a8c45a10671",
"icons/favicon.ico": "29fce6af89ea4a496397a61fffac1797",
"icons/apple-icon.png": "1cc667e26ddc791e2838eeb673463166",
"icons/apple-icon-144x144.png": "b5a48af070f5300f4d243ea46ec51070",
"icons/android-icon-192x192.png": "eef6818ccc76007bc19889123ea109ff",
"icons/apple-icon-precomposed.png": "1cc667e26ddc791e2838eeb673463166",
"icons/apple-icon-114x114.png": "f7e0b581da8ab30e9c3f72777af2cd1c",
"icons/ms-icon-310x310.png": "53e7602ba9391a60a30d540a41aa83c0",
"icons/ms-icon-144x144.png": "41287e8f327e450be735855b1495e94f",
"icons/icons8-j-key-stickers-16.png": "408617023566b59726fdc7098e1a8d6e",
"icons/apple-icon-57x57.png": "6f4016850f9f244d1194e513a5b94d95",
"icons/apple-icon-152x152.png": "1e806f71360050ac8da71d354133ad71",
"icons/icons8-j-key-stickers-32.png": "891b9524f208ba2296f3f3debc4e21fb",
"icons/ms-icon-150x150.png": "dff72e05bb35dfd56b263b0eef42f20f",
"icons/android-icon-72x72.png": "6da68852f7028aa48b8b70ba55dfefde",
"icons/android-icon-96x96.png": "c579f8f3e23abd9f5e6c1ef7f7cd9bb9",
"icons/android-icon-36x36.png": "97fddde43d95dcb0f7198df0290f0ef8",
"icons/apple-icon-180x180.png": "3322f05ad4f76dc18fa67c9ef46e2cd3",
"icons/favicon-96x96.png": "4af6da443a456293f82d0de48a2315ca",
"icons/android-icon-48x48.png": "c9fb200a24a89d792f90e8b261cd8ca3",
"icons/apple-icon-76x76.png": "415af589f62f1b8ca78773d9256f63b6",
"icons/apple-icon-60x60.png": "21c0c9df904a52563bb2a4d7404336ba",
"icons/android-icon-144x144.png": "b5a48af070f5300f4d243ea46ec51070",
"icons/apple-icon-72x72.png": "6da68852f7028aa48b8b70ba55dfefde",
"icons/apple-icon-120x120.png": "0524a5a0988e6b5d1da93524b8367897",
"icons/icons8-j-key-stickers-96.png": "5deca21cdd01d18c79005b3a24bf4b5f",
"icons/favicon-32x32.png": "5be85aa48085c43bf5563ac88413a8cb",
"icons/ms-icon-70x70.png": "a3342fe44afab33b0fd78895a2403266",
"manifest.json": "ee139c6bf19ec9d8cc29081480ad5fc4",
"assets/NOTICES": "d34d9da4ad6ecd07b87f584561328caf",
"assets/FontManifest.json": "d267ed3380a925065c2d7ca99668131f",
"assets/AssetManifest.bin.json": "a2181d05a2c35c01b42e0d77402cbe6d",
"assets/packages/iconsax_flutter/fonts/FlutterIconsax.ttf": "6ebc7bc5b74956596611c6774d8beb5b",
"assets/shaders/ink_sparkle.frag": "ecc85a2e95f5e9f53123dcaf8cb9b6ce",
"assets/shaders/stretch_effect.frag": "40d68efbbf360632f614c731219e95f0",
"assets/AssetManifest.bin": "ee3a3cfaf26c633754e538ba17bdb80f",
"assets/fonts/sfmono.otf": "f28892de5e5d3e75a4247d62be1e6cf0",
"assets/fonts/MaterialIcons-Regular.otf": "01f64ab9a9fde95907bd000d6cf65f4f",
"assets/assets/svg/github.svg": "c0e94df08ad3d521af33fa4ad69e2162",
"assets/assets/svg/appLogo.png": "b1229e2de1361466285599f237519c73",
"assets/assets/svg/tetris.svg": "aed2bed354a99caef2018d99af16b1d5",
"assets/assets/svg/instagram.svg": "0f51da178eff1d87826480d0e5db970b",
"assets/assets/svg/externalLink.svg": "1790fffa6c0b0eb87d7e90470cc80b86",
"assets/assets/svg/profilePic.png": "87257320fd70cea32f399f7a591866fe",
"assets/assets/svg/appstoreIcon.svg": "f23a5fbb1a02e918f78fdea34e767789",
"assets/assets/svg/tetrisLogo.svg": "331417e7b94c0fe0633ee1a44e8ea92e",
"assets/assets/svg/stackoverflow.svg": "ec181e798c8b9fe73dcf64d47926667a",
"assets/assets/svg/playstoreIcon.svg": "f9e4f7a6956def261f73cb66baa3bdb8",
"assets/assets/svg/linkedIn.svg": "c408ef7fbd143d9052cd195819076f90",
"assets/assets/svg/twitter.svg": "d278ea034ebbe0c01e76739232fa2a3e",
"assets/assets/svg/folder.svg": "46a545a4289ba140f5b90613ceccd879",
"assets/assets/lright.png": "43d0ae737b59d92884ad02e07356d40b",
"assets/assets/projects/project_jatt.png": "73b1d6cecf18cac9e45e395e5ae25306",
"assets/assets/projects/project_zera.png": "1796c1c4c960b051f436ed9ccb13b3c7",
"assets/assets/projects/project_bepay_client.png": "fb4e653ee3008e394deded8241bb0392",
"assets/assets/projects/project_simman.png": "889821dc74dba05c0c802ab0e3ae841e",
"assets/assets/projects/project_onscene.png": "80e47e536d97eee716e3858f01516fe1",
"assets/assets/projects/project_ppl.png": "f921c84af8247dc397b8f74d71ffad99",
"assets/assets/projects/project_bepay_business.png": "eab9b841fe4b04e9b6a29873786281b7",
"assets/assets/projects/project_lawnolu.png": "6980f5f03d4de964108b43609dfa30c2",
"assets/assets/lleft.png": "544a834902df4faa60240b87bb3cd4c4",
"assets/assets/skills/skills-web3.png": "d20a5185137568ebd65ab65d3ace43f3",
"assets/assets/skills/skills-flutter.png": "86b48379addc4f2cde1272c575f9ef54",
"assets/assets/skills/skills-social-login.png": "70a517a6ceddb03c9ea0f31df2893d11",
"assets/assets/skills/skills-revenue-cat.jpg": "1dbaac58dd88ada990abc78459f1a1f1",
"assets/assets/skills/skills-play-store.png": "bfdfc7ba741e5968056dbef220327c01",
"assets/assets/skills/skills-app-store.png": "c3e5edb88db092bcb124660f8ce903db",
"assets/assets/skills/skills-web-socket.png": "f78e537aedfbb1a7c60059f911b22f43",
"assets/assets/skills/skills-shared-prefrences.png": "fa060cb919fe98c8181be5d522c599a7",
"assets/assets/skills/skills-kyc.png": "a557563fe2312c5b8b9d1c3fd1977eb5",
"assets/assets/skills/skills-android-studio.webp": "59ff56439ebdf5ca6439d1c71c8dfaab",
"assets/assets/skills/skills-stripe.png": "9ddc517686b176ad85a06e7842741f4d",
"assets/assets/skills/skills-firebase.png": "3b65fa44a89349baede3bbc969151ae2",
"assets/assets/skills/skills-redux.png": "e3af48f56de0dc5e59a9315230fd18a2",
"assets/assets/skills/skills-push-notification.png": "5310ac7dbec4dc8d25d685676924ca59",
"assets/assets/skills/skills-google-map.png": "b7707e2df6e84a28e6f09b967715665b",
"assets/assets/na.png": "6ab30470a8c58fac0b1ae4c1af3ea49f",
"assets/assets/line.png": "50c295964ed314248e60a88a51f33eee",
"assets/assets/square.png": "32c79b2828f4043a32542bb303d5b853",
"canvaskit/skwasm.js": "8060d46e9a4901ca9991edd3a26be4f0",
"canvaskit/skwasm_heavy.js": "740d43a6b8240ef9e23eed8c48840da4",
"canvaskit/skwasm.js.symbols": "3a4aadf4e8141f284bd524976b1d6bdc",
"canvaskit/canvaskit.js.symbols": "a3c9f77715b642d0437d9c275caba91e",
"canvaskit/skwasm_heavy.js.symbols": "0755b4fb399918388d71b59ad390b055",
"canvaskit/skwasm.wasm": "7e5f3afdd3b0747a1fd4517cea239898",
"canvaskit/chromium/canvaskit.js.symbols": "e2d09f0e434bc118bf67dae526737d07",
"canvaskit/chromium/canvaskit.js": "a80c765aaa8af8645c9fb1aae53f9abf",
"canvaskit/chromium/canvaskit.wasm": "a726e3f75a84fcdf495a15817c63a35d",
"canvaskit/canvaskit.js": "8331fe38e66b3a898c4f37648aaf7ee2",
"canvaskit/canvaskit.wasm": "9b6a7830bf26959b200594729d73538e",
"canvaskit/skwasm_heavy.wasm": "b0be7910760d205ea4e011458df6ee01"};
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
