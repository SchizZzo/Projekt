; ModuleID = 'marshal_methods.x86_64.ll'
source_filename = "marshal_methods.x86_64.ll"
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-android21"

%struct.MarshalMethodName = type {
	i64, ; uint64_t id
	ptr ; char* name
}

%struct.MarshalMethodsManagedClass = type {
	i32, ; uint32_t token
	ptr ; MonoClass klass
}

@assembly_image_cache = dso_local local_unnamed_addr global [334 x ptr] zeroinitializer, align 16

; Each entry maps hash of an assembly name to an index into the `assembly_image_cache` array
@assembly_image_cache_hashes = dso_local local_unnamed_addr constant [1002 x i64] [
	i64 u0x001e58127c546039, ; 0: lib_System.Globalization.dll.so => 41
	i64 u0x0024d0f62dee05bd, ; 1: Xamarin.KotlinX.Coroutines.Core.dll => 295
	i64 u0x0071cf2d27b7d61e, ; 2: lib_Xamarin.AndroidX.SwipeRefreshLayout.dll.so => 273
	i64 u0x01109b0e4d99e61f, ; 3: System.ComponentModel.Annotations.dll => 13
	i64 u0x02123411c4e01926, ; 4: lib_Xamarin.AndroidX.Navigation.Runtime.dll.so => 263
	i64 u0x022f31be406de945, ; 5: Microsoft.Extensions.Options.ConfigurationExtensions => 197
	i64 u0x0284512fad379f7e, ; 6: System.Runtime.Handles => 102
	i64 u0x02abedc11addc1ed, ; 7: lib_Mono.Android.Runtime.dll.so => 166
	i64 u0x02f55bf70672f5c8, ; 8: lib_System.IO.FileSystem.DriveInfo.dll.so => 47
	i64 u0x032267b2a94db371, ; 9: lib_Xamarin.AndroidX.AppCompat.dll.so => 219
	i64 u0x03621c804933a890, ; 10: System.Buffers => 7
	i64 u0x0399610510a38a38, ; 11: lib_System.Private.DataContractSerialization.dll.so => 83
	i64 u0x043032f1d071fae0, ; 12: ru/Microsoft.Maui.Controls.resources => 323
	i64 u0x044440a55165631e, ; 13: lib-cs-Microsoft.Maui.Controls.resources.dll.so => 301
	i64 u0x046eb1581a80c6b0, ; 14: vi/Microsoft.Maui.Controls.resources => 329
	i64 u0x047408741db2431a, ; 15: Xamarin.AndroidX.DynamicAnimation => 239
	i64 u0x0517ef04e06e9f76, ; 16: System.Net.Primitives => 68
	i64 u0x0565d18c6da3de38, ; 17: Xamarin.AndroidX.RecyclerView => 266
	i64 u0x0581db89237110e9, ; 18: lib_System.Collections.dll.so => 12
	i64 u0x05989cb940b225a9, ; 19: Microsoft.Maui.dll => 202
	i64 u0x05a1c25e78e22d87, ; 20: lib_System.Runtime.CompilerServices.Unsafe.dll.so => 99
	i64 u0x06076b5d2b581f08, ; 21: zh-HK/Microsoft.Maui.Controls.resources => 330
	i64 u0x06388ffe9f6c161a, ; 22: System.Xml.Linq.dll => 151
	i64 u0x06600c4c124cb358, ; 23: System.Configuration.dll => 19
	i64 u0x067f95c5ddab55b3, ; 24: lib_Xamarin.AndroidX.Fragment.Ktx.dll.so => 244
	i64 u0x0680a433c781bb3d, ; 25: Xamarin.AndroidX.Collection.Jvm => 226
	i64 u0x0690533f9fc14683, ; 26: lib_Microsoft.AspNetCore.Components.dll.so => 172
	i64 u0x069fff96ec92a91d, ; 27: System.Xml.XPath.dll => 156
	i64 u0x070b0847e18dab68, ; 28: Xamarin.AndroidX.Emoji2.ViewsHelper.dll => 241
	i64 u0x0739448d84d3b016, ; 29: lib_Xamarin.AndroidX.VectorDrawable.dll.so => 276
	i64 u0x07469f2eecce9e85, ; 30: mscorlib.dll => 162
	i64 u0x07c57877c7ba78ad, ; 31: ru/Microsoft.Maui.Controls.resources.dll => 323
	i64 u0x07dcdc7460a0c5e4, ; 32: System.Collections.NonGeneric => 10
	i64 u0x08122e52765333c8, ; 33: lib_Microsoft.Extensions.Logging.Debug.dll.so => 195
	i64 u0x088610fc2509f69e, ; 34: lib_Xamarin.AndroidX.VectorDrawable.Animated.dll.so => 277
	i64 u0x08a7c865576bbde7, ; 35: System.Reflection.Primitives => 93
	i64 u0x08c9d051a4a817e5, ; 36: Xamarin.AndroidX.CustomView.PoolingContainer.dll => 237
	i64 u0x08f3c9788ee2153c, ; 37: Xamarin.AndroidX.DrawerLayout => 238
	i64 u0x09138715c92dba90, ; 38: lib_System.ComponentModel.Annotations.dll.so => 13
	i64 u0x0919c28b89381a0b, ; 39: lib_Microsoft.Extensions.Options.dll.so => 196
	i64 u0x092266563089ae3e, ; 40: lib_System.Collections.NonGeneric.dll.so => 10
	i64 u0x09d144a7e214d457, ; 41: System.Security.Cryptography => 124
	i64 u0x09e2b9f743db21a8, ; 42: lib_System.Reflection.Metadata.dll.so => 92
	i64 u0x0abb3e2b271edc45, ; 43: System.Threading.Channels.dll => 135
	i64 u0x0b06b1feab070143, ; 44: System.Formats.Tar => 38
	i64 u0x0b3b632c3bbee20c, ; 45: sk/Microsoft.Maui.Controls.resources => 324
	i64 u0x0b6aff547b84fbe9, ; 46: Xamarin.KotlinX.Serialization.Core.Jvm => 298
	i64 u0x0be2e1f8ce4064ed, ; 47: Xamarin.AndroidX.ViewPager => 279
	i64 u0x0c3ca6cc978e2aae, ; 48: pt-BR/Microsoft.Maui.Controls.resources => 320
	i64 u0x0c59ad9fbbd43abe, ; 49: Mono.Android => 167
	i64 u0x0c65741e86371ee3, ; 50: lib_Xamarin.Android.Glide.GifDecoder.dll.so => 213
	i64 u0x0c74af560004e816, ; 51: Microsoft.Win32.Registry.dll => 5
	i64 u0x0c7790f60165fc06, ; 52: lib_Microsoft.Maui.Essentials.dll.so => 203
	i64 u0x0c83c82812e96127, ; 53: lib_System.Net.Mail.dll.so => 64
	i64 u0x0cce4bce83380b7f, ; 54: Xamarin.AndroidX.Security.SecurityCrypto => 270
	i64 u0x0d13cd7cce4284e4, ; 55: System.Security.SecureString => 127
	i64 u0x0d63f4f73521c24f, ; 56: lib_Xamarin.AndroidX.SavedState.SavedState.Ktx.dll.so => 269
	i64 u0x0e04e702012f8463, ; 57: Xamarin.AndroidX.Emoji2 => 240
	i64 u0x0e14e73a54dda68e, ; 58: lib_System.Net.NameResolution.dll.so => 65
	i64 u0x0f37dd7a62ae99af, ; 59: lib_Xamarin.AndroidX.Collection.Ktx.dll.so => 227
	i64 u0x0f5e7abaa7cf470a, ; 60: System.Net.HttpListener => 63
	i64 u0x1001f97bbe242e64, ; 61: System.IO.UnmanagedMemoryStream => 55
	i64 u0x102a31b45304b1da, ; 62: Xamarin.AndroidX.CustomView => 236
	i64 u0x1065c4cb554c3d75, ; 63: System.IO.IsolatedStorage.dll => 51
	i64 u0x10f6cfcbcf801616, ; 64: System.IO.Compression.Brotli => 42
	i64 u0x114443cdcf2091f1, ; 65: System.Security.Cryptography.Primitives => 122
	i64 u0x11a603952763e1d4, ; 66: System.Net.Mail => 64
	i64 u0x11a70d0e1009fb11, ; 67: System.Net.WebSockets.dll => 78
	i64 u0x11f26371eee0d3c1, ; 68: lib_Xamarin.AndroidX.Lifecycle.Runtime.Ktx.dll.so => 254
	i64 u0x12128b3f59302d47, ; 69: lib_System.Xml.Serialization.dll.so => 153
	i64 u0x123639456fb056da, ; 70: System.Reflection.Emit.Lightweight.dll => 89
	i64 u0x12521e9764603eaa, ; 71: lib_System.Resources.Reader.dll.so => 96
	i64 u0x125b7f94acb989db, ; 72: Xamarin.AndroidX.RecyclerView.dll => 266
	i64 u0x12d3b63863d4ab0b, ; 73: lib_System.Threading.Overlapped.dll.so => 136
	i64 u0x134eab1061c395ee, ; 74: System.Transactions => 146
	i64 u0x138567fa954faa55, ; 75: Xamarin.AndroidX.Browser => 223
	i64 u0x13a01de0cbc3f06c, ; 76: lib-fr-Microsoft.Maui.Controls.resources.dll.so => 307
	i64 u0x13beedefb0e28a45, ; 77: lib_System.Xml.XmlDocument.dll.so => 157
	i64 u0x13f1e5e209e91af4, ; 78: lib_Java.Interop.dll.so => 164
	i64 u0x13f1e880c25d96d1, ; 79: he/Microsoft.Maui.Controls.resources => 308
	i64 u0x143d8ea60a6a4011, ; 80: Microsoft.Extensions.DependencyInjection.Abstractions => 184
	i64 u0x1497051b917530bd, ; 81: lib_System.Net.WebSockets.dll.so => 78
	i64 u0x14d612a531c79c05, ; 82: Xamarin.JSpecify.dll => 290
	i64 u0x14e68447938213b7, ; 83: Xamarin.AndroidX.Collection.Ktx.dll => 227
	i64 u0x152a448bd1e745a7, ; 84: Microsoft.Win32.Primitives => 4
	i64 u0x1557de0138c445f4, ; 85: lib_Microsoft.Win32.Registry.dll.so => 5
	i64 u0x15bdc156ed462f2f, ; 86: lib_System.IO.FileSystem.dll.so => 50
	i64 u0x15e300c2c1668655, ; 87: System.Resources.Writer.dll => 98
	i64 u0x16bf2a22df043a09, ; 88: System.IO.Pipes.dll => 54
	i64 u0x16ea2b318ad2d830, ; 89: System.Security.Cryptography.Algorithms => 117
	i64 u0x16eeae54c7ebcc08, ; 90: System.Reflection.dll => 95
	i64 u0x17125c9a85b4929f, ; 91: lib_netstandard.dll.so => 163
	i64 u0x1716866f7416792e, ; 92: lib_System.Security.AccessControl.dll.so => 115
	i64 u0x174f71c46216e44a, ; 93: Xamarin.KotlinX.Coroutines.Core => 295
	i64 u0x1752c12f1e1fc00c, ; 94: System.Core => 21
	i64 u0x17b56e25558a5d36, ; 95: lib-hu-Microsoft.Maui.Controls.resources.dll.so => 311
	i64 u0x17f9358913beb16a, ; 96: System.Text.Encodings.Web => 208
	i64 u0x1809fb23f29ba44a, ; 97: lib_System.Reflection.TypeExtensions.dll.so => 94
	i64 u0x18402a709e357f3b, ; 98: lib_Xamarin.KotlinX.Serialization.Core.Jvm.dll.so => 298
	i64 u0x18a9befae51bb361, ; 99: System.Net.WebClient => 74
	i64 u0x18f0ce884e87d89a, ; 100: nb/Microsoft.Maui.Controls.resources.dll => 317
	i64 u0x19777fba3c41b398, ; 101: Xamarin.AndroidX.Startup.StartupRuntime.dll => 272
	i64 u0x19a4c090f14ebb66, ; 102: System.Security.Claims => 116
	i64 u0x1a91866a319e9259, ; 103: lib_System.Collections.Concurrent.dll.so => 8
	i64 u0x1aac34d1917ba5d3, ; 104: lib_System.dll.so => 160
	i64 u0x1aad60783ffa3e5b, ; 105: lib-th-Microsoft.Maui.Controls.resources.dll.so => 326
	i64 u0x1ac92909aaff0652, ; 106: JokerApp.dll => 0
	i64 u0x1aea8f1c3b282172, ; 107: lib_System.Net.Ping.dll.so => 67
	i64 u0x1b4b7a1d0d265fa2, ; 108: Xamarin.Android.Glide.DiskLruCache => 212
	i64 u0x1b8700ce6e547c0b, ; 109: lib_Microsoft.AspNetCore.Components.Forms.dll.so => 173
	i64 u0x1bbdb16cfa73e785, ; 110: Xamarin.AndroidX.Lifecycle.Runtime.Ktx.Android => 255
	i64 u0x1bc766e07b2b4241, ; 111: Xamarin.AndroidX.ResourceInspection.Annotation.dll => 267
	i64 u0x1c292b1598348d77, ; 112: Microsoft.Extensions.Diagnostics.dll => 185
	i64 u0x1c5217a9e4973753, ; 113: lib_Microsoft.Extensions.FileProviders.Physical.dll.so => 190
	i64 u0x1c753b5ff15bce1b, ; 114: Mono.Android.Runtime.dll => 166
	i64 u0x1cd47467799d8250, ; 115: System.Threading.Tasks.dll => 140
	i64 u0x1d23eafdc6dc346c, ; 116: System.Globalization.Calendars.dll => 39
	i64 u0x1da4110562816681, ; 117: Xamarin.AndroidX.Security.SecurityCrypto.dll => 270
	i64 u0x1db6820994506bf5, ; 118: System.IO.FileSystem.AccessControl.dll => 46
	i64 u0x1dbb0c2c6a999acb, ; 119: System.Diagnostics.StackTrace => 29
	i64 u0x1e3d87657e9659bc, ; 120: Xamarin.AndroidX.Navigation.UI => 264
	i64 u0x1e71143913d56c10, ; 121: lib-ko-Microsoft.Maui.Controls.resources.dll.so => 315
	i64 u0x1e7c31185e2fb266, ; 122: lib_System.Threading.Tasks.Parallel.dll.so => 139
	i64 u0x1ed8fcce5e9b50a0, ; 123: Microsoft.Extensions.Options.dll => 196
	i64 u0x1f055d15d807e1b2, ; 124: System.Xml.XmlSerializer => 158
	i64 u0x1f1ed22c1085f044, ; 125: lib_System.Diagnostics.FileVersionInfo.dll.so => 27
	i64 u0x1f61df9c5b94d2c1, ; 126: lib_System.Numerics.dll.so => 81
	i64 u0x1f750bb5421397de, ; 127: lib_Xamarin.AndroidX.Tracing.Tracing.dll.so => 274
	i64 u0x20237ea48006d7a8, ; 128: lib_System.Net.WebClient.dll.so => 74
	i64 u0x209375905fcc1bad, ; 129: lib_System.IO.Compression.Brotli.dll.so => 42
	i64 u0x20fab3cf2dfbc8df, ; 130: lib_System.Diagnostics.Process.dll.so => 28
	i64 u0x2110167c128cba15, ; 131: System.Globalization => 41
	i64 u0x21419508838f7547, ; 132: System.Runtime.CompilerServices.VisualC => 100
	i64 u0x2174319c0d835bc9, ; 133: System.Runtime => 114
	i64 u0x2198e5bc8b7153fa, ; 134: Xamarin.AndroidX.Annotation.Experimental.dll => 217
	i64 u0x219ea1b751a4dee4, ; 135: lib_System.IO.Compression.ZipFile.dll.so => 44
	i64 u0x21cc7e445dcd5469, ; 136: System.Reflection.Emit.ILGeneration => 88
	i64 u0x220fd4f2e7c48170, ; 137: th/Microsoft.Maui.Controls.resources => 326
	i64 u0x224538d85ed15a82, ; 138: System.IO.Pipes => 54
	i64 u0x22908438c6bed1af, ; 139: lib_System.Threading.Timer.dll.so => 143
	i64 u0x237be844f1f812c7, ; 140: System.Threading.Thread.dll => 141
	i64 u0x23852b3bdc9f7096, ; 141: System.Resources.ResourceManager => 97
	i64 u0x23986dd7e5d4fc01, ; 142: System.IO.FileSystem.Primitives.dll => 48
	i64 u0x2407aef2bbe8fadf, ; 143: System.Console => 20
	i64 u0x240abe014b27e7d3, ; 144: Xamarin.AndroidX.Core.dll => 232
	i64 u0x247619fe4413f8bf, ; 145: System.Runtime.Serialization.Primitives.dll => 111
	i64 u0x24de8d301281575e, ; 146: Xamarin.Android.Glide => 210
	i64 u0x252073cc3caa62c2, ; 147: fr/Microsoft.Maui.Controls.resources.dll => 307
	i64 u0x256b8d41255f01b1, ; 148: Xamarin.Google.Crypto.Tink.Android => 285
	i64 u0x2662c629b96b0b30, ; 149: lib_Xamarin.Kotlin.StdLib.dll.so => 291
	i64 u0x268c1439f13bcc29, ; 150: lib_Microsoft.Extensions.Primitives.dll.so => 198
	i64 u0x26a670e154a9c54b, ; 151: System.Reflection.Extensions.dll => 91
	i64 u0x26d077d9678fe34f, ; 152: System.IO.dll => 56
	i64 u0x273f3515de5faf0d, ; 153: id/Microsoft.Maui.Controls.resources.dll => 312
	i64 u0x2742545f9094896d, ; 154: hr/Microsoft.Maui.Controls.resources => 310
	i64 u0x2759af78ab94d39b, ; 155: System.Net.WebSockets => 78
	i64 u0x27b2b16f3e9de038, ; 156: Xamarin.Google.Crypto.Tink.Android.dll => 285
	i64 u0x27b410442fad6cf1, ; 157: Java.Interop.dll => 164
	i64 u0x27b97e0d52c3034a, ; 158: System.Diagnostics.Debug => 26
	i64 u0x2801845a2c71fbfb, ; 159: System.Net.Primitives.dll => 68
	i64 u0x286835e259162700, ; 160: lib_Xamarin.AndroidX.ProfileInstaller.ProfileInstaller.dll.so => 265
	i64 u0x28e52865585a1ebe, ; 161: Microsoft.Extensions.Diagnostics.Abstractions.dll => 186
	i64 u0x2949f3617a02c6b2, ; 162: Xamarin.AndroidX.ExifInterface => 242
	i64 u0x2a128783efe70ba0, ; 163: uk/Microsoft.Maui.Controls.resources.dll => 328
	i64 u0x2a3b095612184159, ; 164: lib_System.Net.NetworkInformation.dll.so => 66
	i64 u0x2a6507a5ffabdf28, ; 165: System.Diagnostics.TraceSource.dll => 32
	i64 u0x2ad156c8e1354139, ; 166: fi/Microsoft.Maui.Controls.resources => 306
	i64 u0x2ad5d6b13b7a3e04, ; 167: System.ComponentModel.DataAnnotations.dll => 14
	i64 u0x2af298f63581d886, ; 168: System.Text.RegularExpressions.dll => 134
	i64 u0x2afc1c4f898552ee, ; 169: lib_System.Formats.Asn1.dll.so => 37
	i64 u0x2b148910ed40fbf9, ; 170: zh-Hant/Microsoft.Maui.Controls.resources.dll => 332
	i64 u0x2b4d4904cebfa4e9, ; 171: Microsoft.Extensions.FileSystemGlobbing => 191
	i64 u0x2b6989d78cba9a15, ; 172: Xamarin.AndroidX.Concurrent.Futures.dll => 228
	i64 u0x2c8bd14bb93a7d82, ; 173: lib-pl-Microsoft.Maui.Controls.resources.dll.so => 319
	i64 u0x2cbd9262ca785540, ; 174: lib_System.Text.Encoding.CodePages.dll.so => 131
	i64 u0x2cc9e1fed6257257, ; 175: lib_System.Reflection.Emit.Lightweight.dll.so => 89
	i64 u0x2cd723e9fe623c7c, ; 176: lib_System.Private.Xml.Linq.dll.so => 85
	i64 u0x2d169d318a968379, ; 177: System.Threading.dll => 144
	i64 u0x2d47774b7d993f59, ; 178: sv/Microsoft.Maui.Controls.resources.dll => 325
	i64 u0x2d5ffcae1ad0aaca, ; 179: System.Data.dll => 24
	i64 u0x2db915caf23548d2, ; 180: System.Text.Json.dll => 209
	i64 u0x2dcaa0bb15a4117a, ; 181: System.IO.UnmanagedMemoryStream.dll => 55
	i64 u0x2e5a40c319acb800, ; 182: System.IO.FileSystem => 50
	i64 u0x2e6f1f226821322a, ; 183: el/Microsoft.Maui.Controls.resources.dll => 304
	i64 u0x2e8ff3fae87a8245, ; 184: lib_Microsoft.JSInterop.dll.so => 199
	i64 u0x2f02f94df3200fe5, ; 185: System.Diagnostics.Process => 28
	i64 u0x2f2e98e1c89b1aff, ; 186: System.Xml.ReaderWriter => 152
	i64 u0x2f5911d9ba814e4e, ; 187: System.Diagnostics.Tracing => 33
	i64 u0x2f84070a459bc31f, ; 188: lib_System.Xml.dll.so => 159
	i64 u0x2ff49de6a71764a1, ; 189: lib_Microsoft.Extensions.Http.dll.so => 192
	i64 u0x309ee9eeec09a71e, ; 190: lib_Xamarin.AndroidX.Fragment.dll.so => 243
	i64 u0x30c6dda129408828, ; 191: System.IO.IsolatedStorage => 51
	i64 u0x310d9651ec86c411, ; 192: Microsoft.Extensions.FileProviders.Embedded => 189
	i64 u0x31195fef5d8fb552, ; 193: _Microsoft.Android.Resource.Designer.dll => 333
	i64 u0x312c8ed623cbfc8d, ; 194: Xamarin.AndroidX.Window.dll => 281
	i64 u0x31496b779ed0663d, ; 195: lib_System.Reflection.DispatchProxy.dll.so => 87
	i64 u0x315f08d19390dc36, ; 196: Xamarin.Google.ErrorProne.TypeAnnotations => 287
	i64 u0x32243413e774362a, ; 197: Xamarin.AndroidX.CardView.dll => 224
	i64 u0x3235427f8d12dae1, ; 198: lib_System.Drawing.Primitives.dll.so => 34
	i64 u0x329753a17a517811, ; 199: fr/Microsoft.Maui.Controls.resources => 307
	i64 u0x32aa989ff07a84ff, ; 200: lib_System.Xml.ReaderWriter.dll.so => 152
	i64 u0x33642d5508314e46, ; 201: Microsoft.Extensions.FileSystemGlobbing.dll => 191
	i64 u0x33829542f112d59b, ; 202: System.Collections.Immutable => 9
	i64 u0x33a31443733849fe, ; 203: lib-es-Microsoft.Maui.Controls.resources.dll.so => 305
	i64 u0x341abc357fbb4ebf, ; 204: lib_System.Net.Sockets.dll.so => 73
	i64 u0x3496c1e2dcaf5ecc, ; 205: lib_System.IO.Pipes.AccessControl.dll.so => 53
	i64 u0x34bd01fd4be06ee3, ; 206: lib_Microsoft.Extensions.FileProviders.Composite.dll.so => 188
	i64 u0x34dfd74fe2afcf37, ; 207: Microsoft.Maui => 202
	i64 u0x34e292762d9615df, ; 208: cs/Microsoft.Maui.Controls.resources.dll => 301
	i64 u0x3508234247f48404, ; 209: Microsoft.Maui.Controls => 200
	i64 u0x353590da528c9d22, ; 210: System.ComponentModel.Annotations => 13
	i64 u0x3549870798b4cd30, ; 211: lib_Xamarin.AndroidX.ViewPager2.dll.so => 280
	i64 u0x355282fc1c909694, ; 212: Microsoft.Extensions.Configuration => 178
	i64 u0x3552fc5d578f0fbf, ; 213: Xamarin.AndroidX.Arch.Core.Common => 221
	i64 u0x355c649948d55d97, ; 214: lib_System.Runtime.Intrinsics.dll.so => 106
	i64 u0x35ea9d1c6834bc8c, ; 215: Xamarin.AndroidX.Lifecycle.ViewModel.Ktx.dll => 258
	i64 u0x3628ab68db23a01a, ; 216: lib_System.Diagnostics.Tools.dll.so => 31
	i64 u0x3673b042508f5b6b, ; 217: lib_System.Runtime.Extensions.dll.so => 101
	i64 u0x36740f1a8ecdc6c4, ; 218: System.Numerics => 81
	i64 u0x36b2b50fdf589ae2, ; 219: System.Reflection.Emit.Lightweight => 89
	i64 u0x36cada77dc79928b, ; 220: System.IO.MemoryMappedFiles => 52
	i64 u0x374ef46b06791af6, ; 221: System.Reflection.Primitives.dll => 93
	i64 u0x376bf93e521a5417, ; 222: lib_Xamarin.Jetbrains.Annotations.dll.so => 289
	i64 u0x37bc29f3183003b6, ; 223: lib_System.IO.dll.so => 56
	i64 u0x380134e03b1e160a, ; 224: System.Collections.Immutable.dll => 9
	i64 u0x38049b5c59b39324, ; 225: System.Runtime.CompilerServices.Unsafe => 99
	i64 u0x385c17636bb6fe6e, ; 226: Xamarin.AndroidX.CustomView.dll => 236
	i64 u0x38869c811d74050e, ; 227: System.Net.NameResolution.dll => 65
	i64 u0x393c226616977fdb, ; 228: lib_Xamarin.AndroidX.ViewPager.dll.so => 279
	i64 u0x395e37c3334cf82a, ; 229: lib-ca-Microsoft.Maui.Controls.resources.dll.so => 300
	i64 u0x39c3107c28752af1, ; 230: lib_Microsoft.Extensions.FileProviders.Abstractions.dll.so => 187
	i64 u0x3ab5859054645f72, ; 231: System.Security.Cryptography.Primitives.dll => 122
	i64 u0x3ad75090c3fac0e9, ; 232: lib_Xamarin.AndroidX.ResourceInspection.Annotation.dll.so => 267
	i64 u0x3ae44ac43a1fbdbb, ; 233: System.Runtime.Serialization => 113
	i64 u0x3b860f9932505633, ; 234: lib_System.Text.Encoding.Extensions.dll.so => 132
	i64 u0x3be6248c2bc7dc8c, ; 235: Microsoft.JSInterop.dll => 199
	i64 u0x3c3aafb6b3a00bf6, ; 236: lib_System.Security.Cryptography.X509Certificates.dll.so => 123
	i64 u0x3c4049146b59aa90, ; 237: System.Runtime.InteropServices.JavaScript => 103
	i64 u0x3c7c495f58ac5ee9, ; 238: Xamarin.Kotlin.StdLib => 291
	i64 u0x3c7e5ed3d5db71bb, ; 239: System.Security => 128
	i64 u0x3cd9d281d402eb9b, ; 240: Xamarin.AndroidX.Browser.dll => 223
	i64 u0x3d1c50cc001a991e, ; 241: Xamarin.Google.Guava.ListenableFuture.dll => 288
	i64 u0x3d2b1913edfc08d7, ; 242: lib_System.Threading.ThreadPool.dll.so => 142
	i64 u0x3d46f0b995082740, ; 243: System.Xml.Linq => 151
	i64 u0x3d8a8f400514a790, ; 244: Xamarin.AndroidX.Fragment.Ktx.dll => 244
	i64 u0x3d9c2a242b040a50, ; 245: lib_Xamarin.AndroidX.Core.dll.so => 232
	i64 u0x3db495de2204755c, ; 246: Microsoft.Extensions.Configuration.FileExtensions => 181
	i64 u0x3dbb6b9f5ab90fa7, ; 247: lib_Xamarin.AndroidX.DynamicAnimation.dll.so => 239
	i64 u0x3e5441657549b213, ; 248: Xamarin.AndroidX.ResourceInspection.Annotation => 267
	i64 u0x3e57d4d195c53c2e, ; 249: System.Reflection.TypeExtensions => 94
	i64 u0x3e616ab4ed1f3f15, ; 250: lib_System.Data.dll.so => 24
	i64 u0x3e7f8912b96e5065, ; 251: Microsoft.AspNetCore.Components.WebView.dll => 175
	i64 u0x3f1d226e6e06db7e, ; 252: Xamarin.AndroidX.SlidingPaneLayout.dll => 271
	i64 u0x3f510adf788828dd, ; 253: System.Threading.Tasks.Extensions => 138
	i64 u0x407a10bb4bf95829, ; 254: lib_Xamarin.AndroidX.Navigation.Common.dll.so => 261
	i64 u0x40c98b6bd77346d4, ; 255: Microsoft.VisualBasic.dll => 3
	i64 u0x41833cf766d27d96, ; 256: mscorlib => 162
	i64 u0x41cab042be111c34, ; 257: lib_Xamarin.AndroidX.AppCompat.AppCompatResources.dll.so => 220
	i64 u0x423a9ecc4d905a88, ; 258: lib_System.Resources.ResourceManager.dll.so => 97
	i64 u0x423bf51ae7def810, ; 259: System.Xml.XPath => 156
	i64 u0x42462ff15ddba223, ; 260: System.Resources.Reader.dll => 96
	i64 u0x4291015ff4e5ef71, ; 261: Xamarin.AndroidX.Core.ViewTree.dll => 234
	i64 u0x42a31b86e6ccc3f0, ; 262: System.Diagnostics.Contracts => 25
	i64 u0x430e95b891249788, ; 263: lib_System.Reflection.Emit.dll.so => 90
	i64 u0x43375950ec7c1b6a, ; 264: netstandard.dll => 163
	i64 u0x434c4e1d9284cdae, ; 265: Mono.Android.dll => 167
	i64 u0x43505013578652a0, ; 266: lib_Xamarin.AndroidX.Activity.Ktx.dll.so => 215
	i64 u0x437d06c381ed575a, ; 267: lib_Microsoft.VisualBasic.dll.so => 3
	i64 u0x43950f84de7cc79a, ; 268: pl/Microsoft.Maui.Controls.resources.dll => 319
	i64 u0x43e8ca5bc927ff37, ; 269: lib_Xamarin.AndroidX.Emoji2.ViewsHelper.dll.so => 241
	i64 u0x448bd33429269b19, ; 270: Microsoft.CSharp => 1
	i64 u0x4499fa3c8e494654, ; 271: lib_System.Runtime.Serialization.Primitives.dll.so => 111
	i64 u0x4515080865a951a5, ; 272: Xamarin.Kotlin.StdLib.dll => 291
	i64 u0x4545802489b736b9, ; 273: Xamarin.AndroidX.Fragment.Ktx => 244
	i64 u0x454b4d1e66bb783c, ; 274: Xamarin.AndroidX.Lifecycle.Process => 251
	i64 u0x45c40276a42e283e, ; 275: System.Diagnostics.TraceSource => 32
	i64 u0x45d443f2a29adc37, ; 276: System.AppContext.dll => 6
	i64 u0x46a4213bc97fe5ae, ; 277: lib-ru-Microsoft.Maui.Controls.resources.dll.so => 323
	i64 u0x47358bd471172e1d, ; 278: lib_System.Xml.Linq.dll.so => 151
	i64 u0x47daf4e1afbada10, ; 279: pt/Microsoft.Maui.Controls.resources => 321
	i64 u0x480c0a47dd42dd81, ; 280: lib_System.IO.MemoryMappedFiles.dll.so => 52
	i64 u0x49e952f19a4e2022, ; 281: System.ObjectModel => 82
	i64 u0x49f9e6948a8131e4, ; 282: lib_Xamarin.AndroidX.VersionedParcelable.dll.so => 278
	i64 u0x4a5667b2462a664b, ; 283: lib_Xamarin.AndroidX.Navigation.UI.dll.so => 264
	i64 u0x4a7a18981dbd56bc, ; 284: System.IO.Compression.FileSystem.dll => 43
	i64 u0x4aa5c60350917c06, ; 285: lib_Xamarin.AndroidX.Lifecycle.LiveData.Core.Ktx.dll.so => 250
	i64 u0x4b07a0ed0ab33ff4, ; 286: System.Runtime.Extensions.dll => 101
	i64 u0x4b576d47ac054f3c, ; 287: System.IO.FileSystem.AccessControl => 46
	i64 u0x4b7b6532ded934b7, ; 288: System.Text.Json => 209
	i64 u0x4c7755cf07ad2d5f, ; 289: System.Net.Http.Json.dll => 207
	i64 u0x4cc5f15266470798, ; 290: lib_Xamarin.AndroidX.Loader.dll.so => 260
	i64 u0x4cf6f67dc77aacd2, ; 291: System.Net.NetworkInformation.dll => 66
	i64 u0x4d3183dd245425d4, ; 292: System.Net.WebSockets.Client.dll => 77
	i64 u0x4d479f968a05e504, ; 293: System.Linq.Expressions.dll => 57
	i64 u0x4d55a010ffc4faff, ; 294: System.Private.Xml => 86
	i64 u0x4d5cbe77561c5b2e, ; 295: System.Web.dll => 149
	i64 u0x4d77512dbd86ee4c, ; 296: lib_Xamarin.AndroidX.Arch.Core.Common.dll.so => 221
	i64 u0x4d7793536e79c309, ; 297: System.ServiceProcess => 130
	i64 u0x4d95fccc1f67c7ca, ; 298: System.Runtime.Loader.dll => 107
	i64 u0x4dcf44c3c9b076a2, ; 299: it/Microsoft.Maui.Controls.resources.dll => 313
	i64 u0x4dd9247f1d2c3235, ; 300: Xamarin.AndroidX.Loader.dll => 260
	i64 u0x4df510084e2a0bae, ; 301: Microsoft.JSInterop => 199
	i64 u0x4e2aeee78e2c4a87, ; 302: Xamarin.AndroidX.ProfileInstaller.ProfileInstaller => 265
	i64 u0x4e32f00cb0937401, ; 303: Mono.Android.Runtime => 166
	i64 u0x4e5eea4668ac2b18, ; 304: System.Text.Encoding.CodePages => 131
	i64 u0x4ebd0c4b82c5eefc, ; 305: lib_System.Threading.Channels.dll.so => 135
	i64 u0x4ee8eaa9c9c1151a, ; 306: System.Globalization.Calendars => 39
	i64 u0x4f21ee6ef9eb527e, ; 307: ca/Microsoft.Maui.Controls.resources => 300
	i64 u0x4fdc964ec1888e25, ; 308: lib_Microsoft.Extensions.Configuration.Binder.dll.so => 180
	i64 u0x5037f0be3c28c7a3, ; 309: lib_Microsoft.Maui.Controls.dll.so => 200
	i64 u0x50c3a29b21050d45, ; 310: System.Linq.Parallel.dll => 58
	i64 u0x5112ed116d87baf8, ; 311: CommunityToolkit.Mvvm => 169
	i64 u0x5116b21580ae6eb0, ; 312: Microsoft.Extensions.Configuration.Binder.dll => 180
	i64 u0x5131bbe80989093f, ; 313: Xamarin.AndroidX.Lifecycle.ViewModel.Android.dll => 257
	i64 u0x516324a5050a7e3c, ; 314: System.Net.WebProxy => 76
	i64 u0x516d6f0b21a303de, ; 315: lib_System.Diagnostics.Contracts.dll.so => 25
	i64 u0x51bb8a2afe774e32, ; 316: System.Drawing => 35
	i64 u0x5247c5c32a4140f0, ; 317: System.Resources.Reader => 96
	i64 u0x526bb15e3c386364, ; 318: Xamarin.AndroidX.Lifecycle.Runtime.Ktx.dll => 254
	i64 u0x526ce79eb8e90527, ; 319: lib_System.Net.Primitives.dll.so => 68
	i64 u0x52829f00b4467c38, ; 320: lib_System.Data.Common.dll.so => 22
	i64 u0x529ffe06f39ab8db, ; 321: Xamarin.AndroidX.Core => 232
	i64 u0x52ff996554dbf352, ; 322: Microsoft.Maui.Graphics => 204
	i64 u0x535f7e40e8fef8af, ; 323: lib-sk-Microsoft.Maui.Controls.resources.dll.so => 324
	i64 u0x53978aac584c666e, ; 324: lib_System.Security.Cryptography.Cng.dll.so => 118
	i64 u0x53a96d5c86c9e194, ; 325: System.Net.NetworkInformation => 66
	i64 u0x53be1038a61e8d44, ; 326: System.Runtime.InteropServices.RuntimeInformation.dll => 104
	i64 u0x53c3014b9437e684, ; 327: lib-zh-HK-Microsoft.Maui.Controls.resources.dll.so => 330
	i64 u0x5435e6f049e9bc37, ; 328: System.Security.Claims.dll => 116
	i64 u0x54795225dd1587af, ; 329: lib_System.Runtime.dll.so => 114
	i64 u0x547a34f14e5f6210, ; 330: Xamarin.AndroidX.Lifecycle.Common.dll => 246
	i64 u0x556e8b63b660ab8b, ; 331: Xamarin.AndroidX.Lifecycle.Common.Jvm.dll => 247
	i64 u0x5588627c9a108ec9, ; 332: System.Collections.Specialized => 11
	i64 u0x55a898e4f42e3fae, ; 333: Microsoft.VisualBasic.Core.dll => 2
	i64 u0x55fa0c610fe93bb1, ; 334: lib_System.Security.Cryptography.OpenSsl.dll.so => 121
	i64 u0x56442b99bc64bb47, ; 335: System.Runtime.Serialization.Xml.dll => 112
	i64 u0x56a8b26e1aeae27b, ; 336: System.Threading.Tasks.Dataflow => 137
	i64 u0x56f932d61e93c07f, ; 337: System.Globalization.Extensions => 40
	i64 u0x571c5cfbec5ae8e2, ; 338: System.Private.Uri => 84
	i64 u0x576499c9f52fea31, ; 339: Xamarin.AndroidX.Annotation => 216
	i64 u0x579a06fed6eec900, ; 340: System.Private.CoreLib.dll => 168
	i64 u0x57c542c14049b66d, ; 341: System.Diagnostics.DiagnosticSource => 205
	i64 u0x581a8bd5cfda563e, ; 342: System.Threading.Timer => 143
	i64 u0x584ac38e21d2fde1, ; 343: Microsoft.Extensions.Configuration.Binder => 180
	i64 u0x58601b2dda4a27b9, ; 344: lib-ja-Microsoft.Maui.Controls.resources.dll.so => 314
	i64 u0x58688d9af496b168, ; 345: Microsoft.Extensions.DependencyInjection.dll => 183
	i64 u0x588c167a79db6bfb, ; 346: lib_Xamarin.Google.ErrorProne.Annotations.dll.so => 286
	i64 u0x5906028ae5151104, ; 347: Xamarin.AndroidX.Activity.Ktx => 215
	i64 u0x595a356d23e8da9a, ; 348: lib_Microsoft.CSharp.dll.so => 1
	i64 u0x59f9e60b9475085f, ; 349: lib_Xamarin.AndroidX.Annotation.Experimental.dll.so => 217
	i64 u0x5a745f5101a75527, ; 350: lib_System.IO.Compression.FileSystem.dll.so => 43
	i64 u0x5a89a886ae30258d, ; 351: lib_Xamarin.AndroidX.CoordinatorLayout.dll.so => 231
	i64 u0x5a8f6699f4a1caa9, ; 352: lib_System.Threading.dll.so => 144
	i64 u0x5ae9cd33b15841bf, ; 353: System.ComponentModel => 18
	i64 u0x5b54391bdc6fcfe6, ; 354: System.Private.DataContractSerialization => 83
	i64 u0x5b5f0e240a06a2a2, ; 355: da/Microsoft.Maui.Controls.resources.dll => 302
	i64 u0x5b8109e8e14c5e3e, ; 356: System.Globalization.Extensions.dll => 40
	i64 u0x5bddd04d72a9e350, ; 357: Xamarin.AndroidX.Lifecycle.LiveData.Core.Ktx => 250
	i64 u0x5bdf16b09da116ab, ; 358: Xamarin.AndroidX.Collection => 225
	i64 u0x5c019d5266093159, ; 359: lib_Xamarin.AndroidX.Lifecycle.Runtime.Ktx.Android.dll.so => 255
	i64 u0x5c30a4a35f9cc8c4, ; 360: lib_System.Reflection.Extensions.dll.so => 91
	i64 u0x5c393624b8176517, ; 361: lib_Microsoft.Extensions.Logging.dll.so => 193
	i64 u0x5c53c29f5073b0c9, ; 362: System.Diagnostics.FileVersionInfo => 27
	i64 u0x5c87463c575c7616, ; 363: lib_System.Globalization.Extensions.dll.so => 40
	i64 u0x5d0a4a29b02d9d3c, ; 364: System.Net.WebHeaderCollection.dll => 75
	i64 u0x5d25ef991dd9a85c, ; 365: Microsoft.AspNetCore.Components.WebView.Maui.dll => 176
	i64 u0x5d40c9b15181641f, ; 366: lib_Xamarin.AndroidX.Emoji2.dll.so => 240
	i64 u0x5d6ca10d35e9485b, ; 367: lib_Xamarin.AndroidX.Concurrent.Futures.dll.so => 228
	i64 u0x5d7ec76c1c703055, ; 368: System.Threading.Tasks.Parallel => 139
	i64 u0x5db0cbbd1028510e, ; 369: lib_System.Runtime.InteropServices.dll.so => 105
	i64 u0x5db30905d3e5013b, ; 370: Xamarin.AndroidX.Collection.Jvm.dll => 226
	i64 u0x5e467bc8f09ad026, ; 371: System.Collections.Specialized.dll => 11
	i64 u0x5e5173b3208d97e7, ; 372: System.Runtime.Handles.dll => 102
	i64 u0x5ea92fdb19ec8c4c, ; 373: System.Text.Encodings.Web.dll => 208
	i64 u0x5eb8046dd40e9ac3, ; 374: System.ComponentModel.Primitives => 16
	i64 u0x5ec272d219c9aba4, ; 375: System.Security.Cryptography.Csp.dll => 119
	i64 u0x5eee1376d94c7f5e, ; 376: System.Net.HttpListener.dll => 63
	i64 u0x5f36ccf5c6a57e24, ; 377: System.Xml.ReaderWriter.dll => 152
	i64 u0x5f4294b9b63cb842, ; 378: System.Data.Common => 22
	i64 u0x5f9a2d823f664957, ; 379: lib-el-Microsoft.Maui.Controls.resources.dll.so => 304
	i64 u0x5fa6da9c3cd8142a, ; 380: lib_Xamarin.KotlinX.Serialization.Core.dll.so => 297
	i64 u0x5fac98e0b37a5b9d, ; 381: System.Runtime.CompilerServices.Unsafe.dll => 99
	i64 u0x609f4b7b63d802d4, ; 382: lib_Microsoft.Extensions.DependencyInjection.dll.so => 183
	i64 u0x60cd4e33d7e60134, ; 383: Xamarin.KotlinX.Coroutines.Core.Jvm => 296
	i64 u0x60f62d786afcf130, ; 384: System.Memory => 61
	i64 u0x61bb78c89f867353, ; 385: System.IO => 56
	i64 u0x61be8d1299194243, ; 386: Microsoft.Maui.Controls.Xaml => 201
	i64 u0x61d2cba29557038f, ; 387: de/Microsoft.Maui.Controls.resources => 303
	i64 u0x61d88f399afb2f45, ; 388: lib_System.Runtime.Loader.dll.so => 107
	i64 u0x622eef6f9e59068d, ; 389: System.Private.CoreLib => 168
	i64 u0x63d5e3aa4ef9b931, ; 390: Xamarin.KotlinX.Coroutines.Android.dll => 294
	i64 u0x63f1f6883c1e23c2, ; 391: lib_System.Collections.Immutable.dll.so => 9
	i64 u0x6400f68068c1e9f1, ; 392: Xamarin.Google.Android.Material.dll => 283
	i64 u0x640e3b14dbd325c2, ; 393: System.Security.Cryptography.Algorithms.dll => 117
	i64 u0x64587004560099b9, ; 394: System.Reflection => 95
	i64 u0x64b1529a438a3c45, ; 395: lib_System.Runtime.Handles.dll.so => 102
	i64 u0x6565fba2cd8f235b, ; 396: Xamarin.AndroidX.Lifecycle.ViewModel.Ktx => 258
	i64 u0x65ecac39144dd3cc, ; 397: Microsoft.Maui.Controls.dll => 200
	i64 u0x65ece51227bfa724, ; 398: lib_System.Runtime.Numerics.dll.so => 108
	i64 u0x661722438787b57f, ; 399: Xamarin.AndroidX.Annotation.Jvm.dll => 218
	i64 u0x6679b2337ee6b22a, ; 400: lib_System.IO.FileSystem.Primitives.dll.so => 48
	i64 u0x6692e924eade1b29, ; 401: lib_System.Console.dll.so => 20
	i64 u0x66a4e5c6a3fb0bae, ; 402: lib_Xamarin.AndroidX.Lifecycle.ViewModel.Android.dll.so => 257
	i64 u0x66d13304ce1a3efa, ; 403: Xamarin.AndroidX.CursorAdapter => 235
	i64 u0x674303f65d8fad6f, ; 404: lib_System.Net.Quic.dll.so => 69
	i64 u0x6756ca4cad62e9d6, ; 405: lib_Xamarin.AndroidX.ConstraintLayout.Core.dll.so => 230
	i64 u0x67c0802770244408, ; 406: System.Windows.dll => 150
	i64 u0x68100b69286e27cd, ; 407: lib_System.Formats.Tar.dll.so => 38
	i64 u0x68558ec653afa616, ; 408: lib-da-Microsoft.Maui.Controls.resources.dll.so => 302
	i64 u0x6857d56b8e8b4bb6, ; 409: lib_Microsoft.AspNetCore.Metadata.dll.so => 177
	i64 u0x6872ec7a2e36b1ac, ; 410: System.Drawing.Primitives.dll => 34
	i64 u0x68bb2c417aa9b61c, ; 411: Xamarin.KotlinX.AtomicFU.dll => 292
	i64 u0x68fbbbe2eb455198, ; 412: System.Formats.Asn1 => 37
	i64 u0x69063fc0ba8e6bdd, ; 413: he/Microsoft.Maui.Controls.resources.dll => 308
	i64 u0x69a3e26c76f6eec4, ; 414: Xamarin.AndroidX.Window.Extensions.Core.Core.dll => 282
	i64 u0x6a4d7577b2317255, ; 415: System.Runtime.InteropServices.dll => 105
	i64 u0x6ace3b74b15ee4a4, ; 416: nb/Microsoft.Maui.Controls.resources => 317
	i64 u0x6afcedb171067e2b, ; 417: System.Core.dll => 21
	i64 u0x6bef98e124147c24, ; 418: Xamarin.Jetbrains.Annotations => 289
	i64 u0x6ce874bff138ce2b, ; 419: Xamarin.AndroidX.Lifecycle.ViewModel.dll => 256
	i64 u0x6d12bfaa99c72b1f, ; 420: lib_Microsoft.Maui.Graphics.dll.so => 204
	i64 u0x6d70755158ca866e, ; 421: lib_System.ComponentModel.EventBasedAsync.dll.so => 15
	i64 u0x6d79993361e10ef2, ; 422: Microsoft.Extensions.Primitives => 198
	i64 u0x6d7eeca99577fc8b, ; 423: lib_System.Net.WebProxy.dll.so => 76
	i64 u0x6d8515b19946b6a2, ; 424: System.Net.WebProxy.dll => 76
	i64 u0x6d86d56b84c8eb71, ; 425: lib_Xamarin.AndroidX.CursorAdapter.dll.so => 235
	i64 u0x6d9bea6b3e895cf7, ; 426: Microsoft.Extensions.Primitives.dll => 198
	i64 u0x6e25a02c3833319a, ; 427: lib_Xamarin.AndroidX.Navigation.Fragment.dll.so => 262
	i64 u0x6e79c6bd8627412a, ; 428: Xamarin.AndroidX.SavedState.SavedState.Ktx => 269
	i64 u0x6e838d9a2a6f6c9e, ; 429: lib_System.ValueTuple.dll.so => 147
	i64 u0x6e9965ce1095e60a, ; 430: lib_System.Core.dll.so => 21
	i64 u0x6f94a4d20e602d4b, ; 431: JokerApp => 0
	i64 u0x6fd2265da78b93a4, ; 432: lib_Microsoft.Maui.dll.so => 202
	i64 u0x6fdfc7de82c33008, ; 433: cs/Microsoft.Maui.Controls.resources => 301
	i64 u0x6ffc4967cc47ba57, ; 434: System.IO.FileSystem.Watcher.dll => 49
	i64 u0x701cd46a1c25a5fe, ; 435: System.IO.FileSystem.dll => 50
	i64 u0x70e99f48c05cb921, ; 436: tr/Microsoft.Maui.Controls.resources.dll => 327
	i64 u0x70fd3deda22442d2, ; 437: lib-nb-Microsoft.Maui.Controls.resources.dll.so => 317
	i64 u0x71485e7ffdb4b958, ; 438: System.Reflection.Extensions => 91
	i64 u0x7162a2fce67a945f, ; 439: lib_Xamarin.Android.Glide.Annotations.dll.so => 211
	i64 u0x717530326f808838, ; 440: lib_Microsoft.Extensions.Diagnostics.Abstractions.dll.so => 186
	i64 u0x71a495ea3761dde8, ; 441: lib-it-Microsoft.Maui.Controls.resources.dll.so => 313
	i64 u0x71ad672adbe48f35, ; 442: System.ComponentModel.Primitives.dll => 16
	i64 u0x720f102581a4a5c8, ; 443: Xamarin.AndroidX.Core.ViewTree => 234
	i64 u0x725f5a9e82a45c81, ; 444: System.Security.Cryptography.Encoding => 120
	i64 u0x72b1fb4109e08d7b, ; 445: lib-hr-Microsoft.Maui.Controls.resources.dll.so => 310
	i64 u0x72e0300099accce1, ; 446: System.Xml.XPath.XDocument => 155
	i64 u0x730bfb248998f67a, ; 447: System.IO.Compression.ZipFile => 44
	i64 u0x732b2d67b9e5c47b, ; 448: Xamarin.Google.ErrorProne.Annotations.dll => 286
	i64 u0x734b76fdc0dc05bb, ; 449: lib_GoogleGson.dll.so => 170
	i64 u0x73a6be34e822f9d1, ; 450: lib_System.Runtime.Serialization.dll.so => 113
	i64 u0x73e4ce94e2eb6ffc, ; 451: lib_System.Memory.dll.so => 61
	i64 u0x743a1eccf080489a, ; 452: WindowsBase.dll => 161
	i64 u0x746cf89b511b4d40, ; 453: lib_Microsoft.Extensions.Diagnostics.dll.so => 185
	i64 u0x755a91767330b3d4, ; 454: lib_Microsoft.Extensions.Configuration.dll.so => 178
	i64 u0x75c326eb821b85c4, ; 455: lib_System.ComponentModel.DataAnnotations.dll.so => 14
	i64 u0x76012e7334db86e5, ; 456: lib_Xamarin.AndroidX.SavedState.dll.so => 268
	i64 u0x76ca07b878f44da0, ; 457: System.Runtime.Numerics.dll => 108
	i64 u0x7736c8a96e51a061, ; 458: lib_Xamarin.AndroidX.Annotation.Jvm.dll.so => 218
	i64 u0x778a805e625329ef, ; 459: System.Linq.Parallel => 58
	i64 u0x779290cc2b801eb7, ; 460: Xamarin.KotlinX.AtomicFU.Jvm => 293
	i64 u0x779f67ad3b8efbd5, ; 461: Microsoft.Extensions.Configuration.Json.dll => 182
	i64 u0x77f8a4acc2fdc449, ; 462: System.Security.Cryptography.Cng.dll => 118
	i64 u0x780bc73597a503a9, ; 463: lib-ms-Microsoft.Maui.Controls.resources.dll.so => 316
	i64 u0x782c5d8eb99ff201, ; 464: lib_Microsoft.VisualBasic.Core.dll.so => 2
	i64 u0x783606d1e53e7a1a, ; 465: th/Microsoft.Maui.Controls.resources.dll => 326
	i64 u0x78a45e51311409b6, ; 466: Xamarin.AndroidX.Fragment.dll => 243
	i64 u0x78ed4ab8f9d800a1, ; 467: Xamarin.AndroidX.Lifecycle.ViewModel => 256
	i64 u0x7a25bdb29108c6e7, ; 468: Microsoft.Extensions.Http => 192
	i64 u0x7a39601d6f0bb831, ; 469: lib_Xamarin.KotlinX.AtomicFU.dll.so => 292
	i64 u0x7a5207a7c82d30b4, ; 470: lib_Xamarin.JSpecify.dll.so => 290
	i64 u0x7a71889545dcdb00, ; 471: lib_Microsoft.AspNetCore.Components.WebView.dll.so => 175
	i64 u0x7a7e7eddf79c5d26, ; 472: lib_Xamarin.AndroidX.Lifecycle.ViewModel.dll.so => 256
	i64 u0x7a9a57d43b0845fa, ; 473: System.AppContext => 6
	i64 u0x7ad0f4f1e5d08183, ; 474: Xamarin.AndroidX.Collection.dll => 225
	i64 u0x7adb8da2ac89b647, ; 475: fi/Microsoft.Maui.Controls.resources.dll => 306
	i64 u0x7b13d9eaa944ade8, ; 476: Xamarin.AndroidX.DynamicAnimation.dll => 239
	i64 u0x7bef86a4335c4870, ; 477: System.ComponentModel.TypeConverter => 17
	i64 u0x7c0820144cd34d6a, ; 478: sk/Microsoft.Maui.Controls.resources.dll => 324
	i64 u0x7c2a0bd1e0f988fc, ; 479: lib-de-Microsoft.Maui.Controls.resources.dll.so => 303
	i64 u0x7c41d387501568ba, ; 480: System.Net.WebClient.dll => 74
	i64 u0x7c482cd79bd24b13, ; 481: lib_Xamarin.AndroidX.ConstraintLayout.dll.so => 229
	i64 u0x7c4867f3cb880d2f, ; 482: Microsoft.AspNetCore.Metadata => 177
	i64 u0x7cd2ec8eaf5241cd, ; 483: System.Security.dll => 128
	i64 u0x7cf9ae50dd350622, ; 484: Xamarin.Jetbrains.Annotations.dll => 289
	i64 u0x7d649b75d580bb42, ; 485: ms/Microsoft.Maui.Controls.resources.dll => 316
	i64 u0x7d8b5821548f89e7, ; 486: Microsoft.AspNetCore.Components.Forms => 173
	i64 u0x7d8ee2bdc8e3aad1, ; 487: System.Numerics.Vectors => 80
	i64 u0x7df5df8db8eaa6ac, ; 488: Microsoft.Extensions.Logging.Debug => 195
	i64 u0x7dfc3d6d9d8d7b70, ; 489: System.Collections => 12
	i64 u0x7e2e564fa2f76c65, ; 490: lib_System.Diagnostics.Tracing.dll.so => 33
	i64 u0x7e302e110e1e1346, ; 491: lib_System.Security.Claims.dll.so => 116
	i64 u0x7e4465b3f78ad8d0, ; 492: Xamarin.KotlinX.Serialization.Core.dll => 297
	i64 u0x7e571cad5915e6c3, ; 493: lib_Xamarin.AndroidX.Lifecycle.Process.dll.so => 251
	i64 u0x7e6b1ca712437d7d, ; 494: Xamarin.AndroidX.Emoji2.ViewsHelper => 241
	i64 u0x7e946809d6008ef2, ; 495: lib_System.ObjectModel.dll.so => 82
	i64 u0x7ea0272c1b4a9635, ; 496: lib_Xamarin.Android.Glide.dll.so => 210
	i64 u0x7ecc13347c8fd849, ; 497: lib_System.ComponentModel.dll.so => 18
	i64 u0x7f00ddd9b9ca5a13, ; 498: Xamarin.AndroidX.ViewPager.dll => 279
	i64 u0x7f9351cd44b1273f, ; 499: Microsoft.Extensions.Configuration.Abstractions => 179
	i64 u0x7fbd557c99b3ce6f, ; 500: lib_Xamarin.AndroidX.Lifecycle.LiveData.Core.dll.so => 249
	i64 u0x8076a9a44a2ca331, ; 501: System.Net.Quic => 69
	i64 u0x80da183a87731838, ; 502: System.Reflection.Metadata => 92
	i64 u0x8101a73bd4533440, ; 503: Microsoft.AspNetCore.Components.Web => 174
	i64 u0x812c069d5cdecc17, ; 504: System.dll => 160
	i64 u0x81381be520a60adb, ; 505: Xamarin.AndroidX.Interpolator.dll => 245
	i64 u0x81657cec2b31e8aa, ; 506: System.Net => 79
	i64 u0x81ab745f6c0f5ce6, ; 507: zh-Hant/Microsoft.Maui.Controls.resources => 332
	i64 u0x8277f2be6b5ce05f, ; 508: Xamarin.AndroidX.AppCompat => 219
	i64 u0x828f06563b30bc50, ; 509: lib_Xamarin.AndroidX.CardView.dll.so => 224
	i64 u0x82920a8d9194a019, ; 510: Xamarin.KotlinX.AtomicFU.Jvm.dll => 293
	i64 u0x82b399cb01b531c4, ; 511: lib_System.Web.dll.so => 149
	i64 u0x82df8f5532a10c59, ; 512: lib_System.Drawing.dll.so => 35
	i64 u0x82f0b6e911d13535, ; 513: lib_System.Transactions.dll.so => 146
	i64 u0x82f6403342e12049, ; 514: uk/Microsoft.Maui.Controls.resources => 328
	i64 u0x83c14ba66c8e2b8c, ; 515: zh-Hans/Microsoft.Maui.Controls.resources => 331
	i64 u0x83de69860da6cbdd, ; 516: Microsoft.Extensions.FileProviders.Composite => 188
	i64 u0x846ce984efea52c7, ; 517: System.Threading.Tasks.Parallel.dll => 139
	i64 u0x84ae73148a4557d2, ; 518: lib_System.IO.Pipes.dll.so => 54
	i64 u0x84b01102c12a9232, ; 519: System.Runtime.Serialization.Json.dll => 110
	i64 u0x850c5ba0b57ce8e7, ; 520: lib_Xamarin.AndroidX.Collection.dll.so => 225
	i64 u0x851d02edd334b044, ; 521: Xamarin.AndroidX.VectorDrawable => 276
	i64 u0x85c919db62150978, ; 522: Xamarin.AndroidX.Transition.dll => 275
	i64 u0x8662aaeb94fef37f, ; 523: lib_System.Dynamic.Runtime.dll.so => 36
	i64 u0x86a909228dc7657b, ; 524: lib-zh-Hant-Microsoft.Maui.Controls.resources.dll.so => 332
	i64 u0x86b3e00c36b84509, ; 525: Microsoft.Extensions.Configuration.dll => 178
	i64 u0x86b62cb077ec4fd7, ; 526: System.Runtime.Serialization.Xml => 112
	i64 u0x8704193f462e892e, ; 527: lib_Microsoft.Extensions.FileSystemGlobbing.dll.so => 191
	i64 u0x8706ffb12bf3f53d, ; 528: Xamarin.AndroidX.Annotation.Experimental => 217
	i64 u0x872a5b14c18d328c, ; 529: System.ComponentModel.DataAnnotations => 14
	i64 u0x872fb9615bc2dff0, ; 530: Xamarin.Android.Glide.Annotations.dll => 211
	i64 u0x87c69b87d9283884, ; 531: lib_System.Threading.Thread.dll.so => 141
	i64 u0x87f6569b25707834, ; 532: System.IO.Compression.Brotli.dll => 42
	i64 u0x8842b3a5d2d3fb36, ; 533: Microsoft.Maui.Essentials => 203
	i64 u0x88926583efe7ee86, ; 534: Xamarin.AndroidX.Activity.Ktx.dll => 215
	i64 u0x88ba6bc4f7762b03, ; 535: lib_System.Reflection.dll.so => 95
	i64 u0x88bda98e0cffb7a9, ; 536: lib_Xamarin.KotlinX.Coroutines.Core.Jvm.dll.so => 296
	i64 u0x8930322c7bd8f768, ; 537: netstandard => 163
	i64 u0x897a606c9e39c75f, ; 538: lib_System.ComponentModel.Primitives.dll.so => 16
	i64 u0x89911a22005b92b7, ; 539: System.IO.FileSystem.DriveInfo.dll => 47
	i64 u0x89c5188089ec2cd5, ; 540: lib_System.Runtime.InteropServices.RuntimeInformation.dll.so => 104
	i64 u0x8a19e3dc71b34b2c, ; 541: System.Reflection.TypeExtensions.dll => 94
	i64 u0x8ad229ea26432ee2, ; 542: Xamarin.AndroidX.Loader => 260
	i64 u0x8b4ff5d0fdd5faa1, ; 543: lib_System.Diagnostics.DiagnosticSource.dll.so => 205
	i64 u0x8b541d476eb3774c, ; 544: System.Security.Principal.Windows => 125
	i64 u0x8b8d01333a96d0b5, ; 545: System.Diagnostics.Process.dll => 28
	i64 u0x8b9ceca7acae3451, ; 546: lib-he-Microsoft.Maui.Controls.resources.dll.so => 308
	i64 u0x8c575135aa1ccef4, ; 547: Microsoft.Extensions.FileProviders.Abstractions => 187
	i64 u0x8cb8f612b633affb, ; 548: Xamarin.AndroidX.SavedState.SavedState.Ktx.dll => 269
	i64 u0x8cdfdb4ce85fb925, ; 549: lib_System.Security.Principal.Windows.dll.so => 125
	i64 u0x8cdfe7b8f4caa426, ; 550: System.IO.Compression.FileSystem => 43
	i64 u0x8d0f420977c2c1c7, ; 551: Xamarin.AndroidX.CursorAdapter.dll => 235
	i64 u0x8d52f7ea2796c531, ; 552: Xamarin.AndroidX.Emoji2.dll => 240
	i64 u0x8d7b8ab4b3310ead, ; 553: System.Threading => 144
	i64 u0x8da188285aadfe8e, ; 554: System.Collections.Concurrent => 8
	i64 u0x8ed807bfe9858dfc, ; 555: Xamarin.AndroidX.Navigation.Common => 261
	i64 u0x8ee08b8194a30f48, ; 556: lib-hi-Microsoft.Maui.Controls.resources.dll.so => 309
	i64 u0x8ef7601039857a44, ; 557: lib-ro-Microsoft.Maui.Controls.resources.dll.so => 322
	i64 u0x8f32c6f611f6ffab, ; 558: pt/Microsoft.Maui.Controls.resources.dll => 321
	i64 u0x8f44b45eb046bbd1, ; 559: System.ServiceModel.Web.dll => 129
	i64 u0x8f8829d21c8985a4, ; 560: lib-pt-BR-Microsoft.Maui.Controls.resources.dll.so => 320
	i64 u0x8fbf5b0114c6dcef, ; 561: System.Globalization.dll => 41
	i64 u0x8fcc8c2a81f3d9e7, ; 562: Xamarin.KotlinX.Serialization.Core => 297
	i64 u0x90263f8448b8f572, ; 563: lib_System.Diagnostics.TraceSource.dll.so => 32
	i64 u0x903101b46fb73a04, ; 564: _Microsoft.Android.Resource.Designer => 333
	i64 u0x90393bd4865292f3, ; 565: lib_System.IO.Compression.dll.so => 45
	i64 u0x905e2b8e7ae91ae6, ; 566: System.Threading.Tasks.Extensions.dll => 138
	i64 u0x90634f86c5ebe2b5, ; 567: Xamarin.AndroidX.Lifecycle.ViewModel.Android => 257
	i64 u0x907b636704ad79ef, ; 568: lib_Microsoft.Maui.Controls.Xaml.dll.so => 201
	i64 u0x90e9efbfd68593e0, ; 569: lib_Xamarin.AndroidX.Lifecycle.LiveData.dll.so => 248
	i64 u0x91418dc638b29e68, ; 570: lib_Xamarin.AndroidX.CustomView.dll.so => 236
	i64 u0x914647982e998267, ; 571: Microsoft.Extensions.Configuration.Json => 182
	i64 u0x9157bd523cd7ed36, ; 572: lib_System.Text.Json.dll.so => 209
	i64 u0x91a74f07b30d37e2, ; 573: System.Linq.dll => 60
	i64 u0x91cb86ea3b17111d, ; 574: System.ServiceModel.Web => 129
	i64 u0x91fa41a87223399f, ; 575: ca/Microsoft.Maui.Controls.resources.dll => 300
	i64 u0x92054e486c0c7ea7, ; 576: System.IO.FileSystem.DriveInfo => 47
	i64 u0x928614058c40c4cd, ; 577: lib_System.Xml.XPath.XDocument.dll.so => 155
	i64 u0x92b138fffca2b01e, ; 578: lib_Xamarin.AndroidX.Arch.Core.Runtime.dll.so => 222
	i64 u0x92dfc2bfc6c6a888, ; 579: Xamarin.AndroidX.Lifecycle.LiveData => 248
	i64 u0x933da2c779423d68, ; 580: Xamarin.Android.Glide.Annotations => 211
	i64 u0x9388aad9b7ae40ce, ; 581: lib_Xamarin.AndroidX.Lifecycle.Common.dll.so => 246
	i64 u0x93cfa73ab28d6e35, ; 582: ms/Microsoft.Maui.Controls.resources => 316
	i64 u0x941c00d21e5c0679, ; 583: lib_Xamarin.AndroidX.Transition.dll.so => 275
	i64 u0x944077d8ca3c6580, ; 584: System.IO.Compression.dll => 45
	i64 u0x948cffedc8ed7960, ; 585: System.Xml => 159
	i64 u0x94c8990839c4bdb1, ; 586: lib_Xamarin.AndroidX.Interpolator.dll.so => 245
	i64 u0x967fc325e09bfa8c, ; 587: es/Microsoft.Maui.Controls.resources => 305
	i64 u0x9686161486d34b81, ; 588: lib_Xamarin.AndroidX.ExifInterface.dll.so => 242
	i64 u0x9732d8dbddea3d9a, ; 589: id/Microsoft.Maui.Controls.resources => 312
	i64 u0x978be80e5210d31b, ; 590: Microsoft.Maui.Graphics.dll => 204
	i64 u0x97b8c771ea3e4220, ; 591: System.ComponentModel.dll => 18
	i64 u0x97e144c9d3c6976e, ; 592: System.Collections.Concurrent.dll => 8
	i64 u0x984184e3c70d4419, ; 593: GoogleGson => 170
	i64 u0x9843944103683dd3, ; 594: Xamarin.AndroidX.Core.Core.Ktx => 233
	i64 u0x98d720cc4597562c, ; 595: System.Security.Cryptography.OpenSsl => 121
	i64 u0x991d510397f92d9d, ; 596: System.Linq.Expressions => 57
	i64 u0x996ceeb8a3da3d67, ; 597: System.Threading.Overlapped.dll => 136
	i64 u0x999cb19e1a04ffd3, ; 598: CommunityToolkit.Mvvm.dll => 169
	i64 u0x99a00ca5270c6878, ; 599: Xamarin.AndroidX.Navigation.Runtime => 263
	i64 u0x99cdc6d1f2d3a72f, ; 600: ko/Microsoft.Maui.Controls.resources.dll => 315
	i64 u0x9a01b1da98b6ee10, ; 601: Xamarin.AndroidX.Lifecycle.Runtime.dll => 252
	i64 u0x9a5ccc274fd6e6ee, ; 602: Jsr305Binding.dll => 284
	i64 u0x9ae6940b11c02876, ; 603: lib_Xamarin.AndroidX.Window.dll.so => 281
	i64 u0x9b211a749105beac, ; 604: System.Transactions.Local => 145
	i64 u0x9b8734714671022d, ; 605: System.Threading.Tasks.Dataflow.dll => 137
	i64 u0x9bc6aea27fbf034f, ; 606: lib_Xamarin.KotlinX.Coroutines.Core.dll.so => 295
	i64 u0x9bd8cc74558ad4c7, ; 607: Xamarin.KotlinX.AtomicFU => 292
	i64 u0x9c244ac7cda32d26, ; 608: System.Security.Cryptography.X509Certificates.dll => 123
	i64 u0x9c465f280cf43733, ; 609: lib_Xamarin.KotlinX.Coroutines.Android.dll.so => 294
	i64 u0x9c8f6872beab6408, ; 610: System.Xml.XPath.XDocument.dll => 155
	i64 u0x9ce01cf91101ae23, ; 611: System.Xml.XmlDocument => 157
	i64 u0x9d128180c81d7ce6, ; 612: Xamarin.AndroidX.CustomView.PoolingContainer => 237
	i64 u0x9d5dbcf5a48583fe, ; 613: lib_Xamarin.AndroidX.Activity.dll.so => 214
	i64 u0x9d74dee1a7725f34, ; 614: Microsoft.Extensions.Configuration.Abstractions.dll => 179
	i64 u0x9e4534b6adaf6e84, ; 615: nl/Microsoft.Maui.Controls.resources => 318
	i64 u0x9e4b95dec42769f7, ; 616: System.Diagnostics.Debug.dll => 26
	i64 u0x9eaf1efdf6f7267e, ; 617: Xamarin.AndroidX.Navigation.Common.dll => 261
	i64 u0x9ef542cf1f78c506, ; 618: Xamarin.AndroidX.Lifecycle.LiveData.Core => 249
	i64 u0x9fbb2961ca18e5c2, ; 619: Microsoft.Extensions.FileProviders.Physical.dll => 190
	i64 u0xa00832eb975f56a8, ; 620: lib_System.Net.dll.so => 79
	i64 u0xa0ad78236b7b267f, ; 621: Xamarin.AndroidX.Window => 281
	i64 u0xa0d8259f4cc284ec, ; 622: lib_System.Security.Cryptography.dll.so => 124
	i64 u0xa0e17ca50c77a225, ; 623: lib_Xamarin.Google.Crypto.Tink.Android.dll.so => 285
	i64 u0xa0ff9b3e34d92f11, ; 624: lib_System.Resources.Writer.dll.so => 98
	i64 u0xa12fbfb4da97d9f3, ; 625: System.Threading.Timer.dll => 143
	i64 u0xa1440773ee9d341e, ; 626: Xamarin.Google.Android.Material => 283
	i64 u0xa1b9d7c27f47219f, ; 627: Xamarin.AndroidX.Navigation.UI.dll => 264
	i64 u0xa2572680829d2c7c, ; 628: System.IO.Pipelines.dll => 206
	i64 u0xa26597e57ee9c7f6, ; 629: System.Xml.XmlDocument.dll => 157
	i64 u0xa308401900e5bed3, ; 630: lib_mscorlib.dll.so => 162
	i64 u0xa395572e7da6c99d, ; 631: lib_System.Security.dll.so => 128
	i64 u0xa3b8104115a36bf6, ; 632: lib_Microsoft.Extensions.FileProviders.Embedded.dll.so => 189
	i64 u0xa3e683f24b43af6f, ; 633: System.Dynamic.Runtime.dll => 36
	i64 u0xa4145becdee3dc4f, ; 634: Xamarin.AndroidX.VectorDrawable.Animated => 277
	i64 u0xa46aa1eaa214539b, ; 635: ko/Microsoft.Maui.Controls.resources => 315
	i64 u0xa4a372eecb9e4df0, ; 636: Microsoft.Extensions.Diagnostics => 185
	i64 u0xa4d20d2ff0563d26, ; 637: lib_CommunityToolkit.Mvvm.dll.so => 169
	i64 u0xa4e62983cf1e3674, ; 638: Microsoft.AspNetCore.Components.Forms.dll => 173
	i64 u0xa4edc8f2ceae241a, ; 639: System.Data.Common.dll => 22
	i64 u0xa5494f40f128ce6a, ; 640: System.Runtime.Serialization.Formatters.dll => 109
	i64 u0xa54b74df83dce92b, ; 641: System.Reflection.DispatchProxy => 87
	i64 u0xa5b7152421ed6d98, ; 642: lib_System.IO.FileSystem.Watcher.dll.so => 49
	i64 u0xa5c3844f17b822db, ; 643: lib_System.Linq.Parallel.dll.so => 58
	i64 u0xa5ce5c755bde8cb8, ; 644: lib_System.Security.Cryptography.Csp.dll.so => 119
	i64 u0xa5e599d1e0524750, ; 645: System.Numerics.Vectors.dll => 80
	i64 u0xa5f1ba49b85dd355, ; 646: System.Security.Cryptography.dll => 124
	i64 u0xa61975a5a37873ea, ; 647: lib_System.Xml.XmlSerializer.dll.so => 158
	i64 u0xa6593e21584384d2, ; 648: lib_Jsr305Binding.dll.so => 284
	i64 u0xa66cbee0130865f7, ; 649: lib_WindowsBase.dll.so => 161
	i64 u0xa67dbee13e1df9ca, ; 650: Xamarin.AndroidX.SavedState.dll => 268
	i64 u0xa684b098dd27b296, ; 651: lib_Xamarin.AndroidX.Security.SecurityCrypto.dll.so => 270
	i64 u0xa68a420042bb9b1f, ; 652: Xamarin.AndroidX.DrawerLayout.dll => 238
	i64 u0xa6d26156d1cacc7c, ; 653: Xamarin.Android.Glide.dll => 210
	i64 u0xa75386b5cb9595aa, ; 654: Xamarin.AndroidX.Lifecycle.Runtime.Android => 253
	i64 u0xa763fbb98df8d9fb, ; 655: lib_Microsoft.Win32.Primitives.dll.so => 4
	i64 u0xa78ce3745383236a, ; 656: Xamarin.AndroidX.Lifecycle.Common.Jvm => 247
	i64 u0xa7c31b56b4dc7b33, ; 657: hu/Microsoft.Maui.Controls.resources => 311
	i64 u0xa7eab29ed44b4e7a, ; 658: Mono.Android.Export => 165
	i64 u0xa8195217cbf017b7, ; 659: Microsoft.VisualBasic.Core => 2
	i64 u0xa82fd211eef00a5b, ; 660: Microsoft.Extensions.FileProviders.Physical => 190
	i64 u0xa859a95830f367ff, ; 661: lib_Xamarin.AndroidX.Lifecycle.ViewModel.Ktx.dll.so => 258
	i64 u0xa8b52f21e0dbe690, ; 662: System.Runtime.Serialization.dll => 113
	i64 u0xa8ee4ed7de2efaee, ; 663: Xamarin.AndroidX.Annotation.dll => 216
	i64 u0xa95590e7c57438a4, ; 664: System.Configuration => 19
	i64 u0xaa2219c8e3449ff5, ; 665: Microsoft.Extensions.Logging.Abstractions => 194
	i64 u0xaa443ac34067eeef, ; 666: System.Private.Xml.dll => 86
	i64 u0xaa52de307ef5d1dd, ; 667: System.Net.Http => 62
	i64 u0xaa9a7b0214a5cc5c, ; 668: System.Diagnostics.StackTrace.dll => 29
	i64 u0xaaaf86367285a918, ; 669: Microsoft.Extensions.DependencyInjection.Abstractions.dll => 184
	i64 u0xaaf84bb3f052a265, ; 670: el/Microsoft.Maui.Controls.resources => 304
	i64 u0xab9af77b5b67a0b8, ; 671: Xamarin.AndroidX.ConstraintLayout.Core => 230
	i64 u0xab9c1b2687d86b0b, ; 672: lib_System.Linq.Expressions.dll.so => 57
	i64 u0xac2af3fa195a15ce, ; 673: System.Runtime.Numerics => 108
	i64 u0xac5376a2a538dc10, ; 674: Xamarin.AndroidX.Lifecycle.LiveData.Core.dll => 249
	i64 u0xac5acae88f60357e, ; 675: System.Diagnostics.Tools.dll => 31
	i64 u0xac79c7e46047ad98, ; 676: System.Security.Principal.Windows.dll => 125
	i64 u0xac98d31068e24591, ; 677: System.Xml.XDocument => 154
	i64 u0xacd46e002c3ccb97, ; 678: ro/Microsoft.Maui.Controls.resources => 322
	i64 u0xacdd9e4180d56dda, ; 679: Xamarin.AndroidX.Concurrent.Futures => 228
	i64 u0xacf42eea7ef9cd12, ; 680: System.Threading.Channels => 135
	i64 u0xad89c07347f1bad6, ; 681: nl/Microsoft.Maui.Controls.resources.dll => 318
	i64 u0xadbb53caf78a79d2, ; 682: System.Web.HttpUtility => 148
	i64 u0xadc90ab061a9e6e4, ; 683: System.ComponentModel.TypeConverter.dll => 17
	i64 u0xadca1b9030b9317e, ; 684: Xamarin.AndroidX.Collection.Ktx => 227
	i64 u0xadd8eda2edf396ad, ; 685: Xamarin.Android.Glide.GifDecoder => 213
	i64 u0xadf4cf30debbeb9a, ; 686: System.Net.ServicePoint.dll => 72
	i64 u0xadf511667bef3595, ; 687: System.Net.Security => 71
	i64 u0xae0aaa94fdcfce0f, ; 688: System.ComponentModel.EventBasedAsync.dll => 15
	i64 u0xae282bcd03739de7, ; 689: Java.Interop => 164
	i64 u0xae53579c90db1107, ; 690: System.ObjectModel.dll => 82
	i64 u0xaec7c0c7e2ed4575, ; 691: lib_Xamarin.KotlinX.AtomicFU.Jvm.dll.so => 293
	i64 u0xaf732d0b2193b8f5, ; 692: System.Security.Cryptography.OpenSsl.dll => 121
	i64 u0xafdb94dbccd9d11c, ; 693: Xamarin.AndroidX.Lifecycle.LiveData.dll => 248
	i64 u0xafe29f45095518e7, ; 694: lib_Xamarin.AndroidX.Lifecycle.ViewModelSavedState.dll.so => 259
	i64 u0xb03ae931fb25607e, ; 695: Xamarin.AndroidX.ConstraintLayout => 229
	i64 u0xb05cc42cd94c6d9d, ; 696: lib-sv-Microsoft.Maui.Controls.resources.dll.so => 325
	i64 u0xb0ac21bec8f428c5, ; 697: Xamarin.AndroidX.Lifecycle.Runtime.Ktx.Android.dll => 255
	i64 u0xb0bb43dc52ea59f9, ; 698: System.Diagnostics.Tracing.dll => 33
	i64 u0xb1ccbf6243328d1c, ; 699: Microsoft.AspNetCore.Components => 172
	i64 u0xb1dd05401aa8ee63, ; 700: System.Security.AccessControl => 115
	i64 u0xb220631954820169, ; 701: System.Text.RegularExpressions => 134
	i64 u0xb2376e1dbf8b4ed7, ; 702: System.Security.Cryptography.Csp => 119
	i64 u0xb2a1959fe95c5402, ; 703: lib_System.Runtime.InteropServices.JavaScript.dll.so => 103
	i64 u0xb2a3f67f3bf29fce, ; 704: da/Microsoft.Maui.Controls.resources => 302
	i64 u0xb3874072ee0ecf8c, ; 705: Xamarin.AndroidX.VectorDrawable.Animated.dll => 277
	i64 u0xb3f0a0fcda8d3ebc, ; 706: Xamarin.AndroidX.CardView => 224
	i64 u0xb46be1aa6d4fff93, ; 707: hi/Microsoft.Maui.Controls.resources => 309
	i64 u0xb477491be13109d8, ; 708: ar/Microsoft.Maui.Controls.resources => 299
	i64 u0xb4bd7015ecee9d86, ; 709: System.IO.Pipelines => 206
	i64 u0xb4c53d9749c5f226, ; 710: lib_System.IO.FileSystem.AccessControl.dll.so => 46
	i64 u0xb4ff710863453fda, ; 711: System.Diagnostics.FileVersionInfo.dll => 27
	i64 u0xb5c38bf497a4cfe2, ; 712: lib_System.Threading.Tasks.dll.so => 140
	i64 u0xb5c7fcdafbc67ee4, ; 713: Microsoft.Extensions.Logging.Abstractions.dll => 194
	i64 u0xb5ea31d5244c6626, ; 714: System.Threading.ThreadPool.dll => 142
	i64 u0xb7212c4683a94afe, ; 715: System.Drawing.Primitives => 34
	i64 u0xb7b7753d1f319409, ; 716: sv/Microsoft.Maui.Controls.resources => 325
	i64 u0xb81a2c6e0aee50fe, ; 717: lib_System.Private.CoreLib.dll.so => 168
	i64 u0xb872c26142d22aa9, ; 718: Microsoft.Extensions.Http.dll => 192
	i64 u0xb8b0a9b3dfbc5cb7, ; 719: Xamarin.AndroidX.Window.Extensions.Core.Core => 282
	i64 u0xb8c60af47c08d4da, ; 720: System.Net.ServicePoint => 72
	i64 u0xb8e68d20aad91196, ; 721: lib_System.Xml.XPath.dll.so => 156
	i64 u0xb9185c33a1643eed, ; 722: Microsoft.CSharp.dll => 1
	i64 u0xb9b8001adf4ed7cc, ; 723: lib_Xamarin.AndroidX.SlidingPaneLayout.dll.so => 271
	i64 u0xb9f64d3b230def68, ; 724: lib-pt-Microsoft.Maui.Controls.resources.dll.so => 321
	i64 u0xb9fc3c8a556e3691, ; 725: ja/Microsoft.Maui.Controls.resources => 314
	i64 u0xba4670aa94a2b3c6, ; 726: lib_System.Xml.XDocument.dll.so => 154
	i64 u0xba48785529705af9, ; 727: System.Collections.dll => 12
	i64 u0xba965b8c86359996, ; 728: lib_System.Windows.dll.so => 150
	i64 u0xbaf762c4825c14e9, ; 729: Microsoft.AspNetCore.Components.WebView => 175
	i64 u0xbb286883bc35db36, ; 730: System.Transactions.dll => 146
	i64 u0xbb65706fde942ce3, ; 731: System.Net.Sockets => 73
	i64 u0xbba28979413cad9e, ; 732: lib_System.Runtime.CompilerServices.VisualC.dll.so => 100
	i64 u0xbbd180354b67271a, ; 733: System.Runtime.Serialization.Formatters => 109
	i64 u0xbc260cdba33291a3, ; 734: Xamarin.AndroidX.Arch.Core.Common.dll => 221
	i64 u0xbc3c4e8dffea9d4e, ; 735: Microsoft.AspNetCore.Metadata.dll => 177
	i64 u0xbcd36316d29f27b4, ; 736: lib_Microsoft.AspNetCore.Authorization.dll.so => 171
	i64 u0xbd0e2c0d55246576, ; 737: System.Net.Http.dll => 62
	i64 u0xbd3fbd85b9e1cb29, ; 738: lib_System.Net.HttpListener.dll.so => 63
	i64 u0xbd437a2cdb333d0d, ; 739: Xamarin.AndroidX.ViewPager2 => 280
	i64 u0xbd4f572d2bd0a789, ; 740: System.IO.Compression.ZipFile.dll => 44
	i64 u0xbd5d0b88d3d647a5, ; 741: lib_Xamarin.AndroidX.Browser.dll.so => 223
	i64 u0xbd877b14d0b56392, ; 742: System.Runtime.Intrinsics.dll => 106
	i64 u0xbe65a49036345cf4, ; 743: lib_System.Buffers.dll.so => 7
	i64 u0xbee38d4a88835966, ; 744: Xamarin.AndroidX.AppCompat.AppCompatResources => 220
	i64 u0xbef9919db45b4ca7, ; 745: System.IO.Pipes.AccessControl => 53
	i64 u0xbf0fa68611139208, ; 746: lib_Xamarin.AndroidX.Annotation.dll.so => 216
	i64 u0xbfc1e1fb3095f2b3, ; 747: lib_System.Net.Http.Json.dll.so => 207
	i64 u0xc040a4ab55817f58, ; 748: ar/Microsoft.Maui.Controls.resources.dll => 299
	i64 u0xc07cadab29efeba0, ; 749: Xamarin.AndroidX.Core.Core.Ktx.dll => 233
	i64 u0xc0d928351ab5ca77, ; 750: System.Console.dll => 20
	i64 u0xc0f5a221a9383aea, ; 751: System.Runtime.Intrinsics => 106
	i64 u0xc111030af54d7191, ; 752: System.Resources.Writer => 98
	i64 u0xc12b8b3afa48329c, ; 753: lib_System.Linq.dll.so => 60
	i64 u0xc183ca0b74453aa9, ; 754: lib_System.Threading.Tasks.Dataflow.dll.so => 137
	i64 u0xc1ebdc7e6a943450, ; 755: Microsoft.AspNetCore.Authorization.dll => 171
	i64 u0xc1ff9ae3cdb6e1e6, ; 756: Xamarin.AndroidX.Activity.dll => 214
	i64 u0xc26c064effb1dea9, ; 757: System.Buffers.dll => 7
	i64 u0xc28c50f32f81cc73, ; 758: ja/Microsoft.Maui.Controls.resources.dll => 314
	i64 u0xc2902f6cf5452577, ; 759: lib_Mono.Android.Export.dll.so => 165
	i64 u0xc2a3bca55b573141, ; 760: System.IO.FileSystem.Watcher => 49
	i64 u0xc2bcfec99f69365e, ; 761: Xamarin.AndroidX.ViewPager2.dll => 280
	i64 u0xc30b52815b58ac2c, ; 762: lib_System.Runtime.Serialization.Xml.dll.so => 112
	i64 u0xc36d7d89c652f455, ; 763: System.Threading.Overlapped => 136
	i64 u0xc396b285e59e5493, ; 764: GoogleGson.dll => 170
	i64 u0xc3c86c1e5e12f03d, ; 765: WindowsBase => 161
	i64 u0xc421b61fd853169d, ; 766: lib_System.Net.WebSockets.Client.dll.so => 77
	i64 u0xc463e077917aa21d, ; 767: System.Runtime.Serialization.Json => 110
	i64 u0xc4d3858ed4d08512, ; 768: Xamarin.AndroidX.Lifecycle.ViewModelSavedState.dll => 259
	i64 u0xc50fded0ded1418c, ; 769: lib_System.ComponentModel.TypeConverter.dll.so => 17
	i64 u0xc519125d6bc8fb11, ; 770: lib_System.Net.Requests.dll.so => 70
	i64 u0xc5293b19e4dc230e, ; 771: Xamarin.AndroidX.Navigation.Fragment => 262
	i64 u0xc5325b2fcb37446f, ; 772: lib_System.Private.Xml.dll.so => 86
	i64 u0xc535cb9a21385d9b, ; 773: lib_Xamarin.Android.Glide.DiskLruCache.dll.so => 212
	i64 u0xc5a0f4b95a699af7, ; 774: lib_System.Private.Uri.dll.so => 84
	i64 u0xc5cdcd5b6277579e, ; 775: lib_System.Security.Cryptography.Algorithms.dll.so => 117
	i64 u0xc5ec286825cb0bf4, ; 776: Xamarin.AndroidX.Tracing.Tracing => 274
	i64 u0xc659b586d4c229e2, ; 777: Microsoft.Extensions.Configuration.FileExtensions.dll => 181
	i64 u0xc6706bc8aa7fe265, ; 778: Xamarin.AndroidX.Annotation.Jvm => 218
	i64 u0xc7c01e7d7c93a110, ; 779: System.Text.Encoding.Extensions.dll => 132
	i64 u0xc7ce851898a4548e, ; 780: lib_System.Web.HttpUtility.dll.so => 148
	i64 u0xc809d4089d2556b2, ; 781: System.Runtime.InteropServices.JavaScript.dll => 103
	i64 u0xc858a28d9ee5a6c5, ; 782: lib_System.Collections.Specialized.dll.so => 11
	i64 u0xc8ac7c6bf1c2ec51, ; 783: System.Reflection.DispatchProxy.dll => 87
	i64 u0xc9c62c8f354ac568, ; 784: lib_System.Diagnostics.TextWriterTraceListener.dll.so => 30
	i64 u0xca3110fea81c8916, ; 785: Microsoft.AspNetCore.Components.Web.dll => 174
	i64 u0xca3a723e7342c5b6, ; 786: lib-tr-Microsoft.Maui.Controls.resources.dll.so => 327
	i64 u0xca5801070d9fccfb, ; 787: System.Text.Encoding => 133
	i64 u0xcab3493c70141c2d, ; 788: pl/Microsoft.Maui.Controls.resources => 319
	i64 u0xcab69b9a31439815, ; 789: lib_Xamarin.Google.ErrorProne.TypeAnnotations.dll.so => 287
	i64 u0xcacfddc9f7c6de76, ; 790: ro/Microsoft.Maui.Controls.resources.dll => 322
	i64 u0xcadbc92899a777f0, ; 791: Xamarin.AndroidX.Startup.StartupRuntime => 272
	i64 u0xcba1cb79f45292b5, ; 792: Xamarin.Android.Glide.GifDecoder.dll => 213
	i64 u0xcbb5f80c7293e696, ; 793: lib_System.Globalization.Calendars.dll.so => 39
	i64 u0xcbd4fdd9cef4a294, ; 794: lib__Microsoft.Android.Resource.Designer.dll.so => 333
	i64 u0xcc15da1e07bbd994, ; 795: Xamarin.AndroidX.SlidingPaneLayout => 271
	i64 u0xcc2876b32ef2794c, ; 796: lib_System.Text.RegularExpressions.dll.so => 134
	i64 u0xcc5c3bb714c4561e, ; 797: Xamarin.KotlinX.Coroutines.Core.Jvm.dll => 296
	i64 u0xcc76886e09b88260, ; 798: Xamarin.KotlinX.Serialization.Core.Jvm.dll => 298
	i64 u0xcc9fa2923aa1c9ef, ; 799: System.Diagnostics.Contracts.dll => 25
	i64 u0xccf25c4b634ccd3a, ; 800: zh-Hans/Microsoft.Maui.Controls.resources.dll => 331
	i64 u0xcd10a42808629144, ; 801: System.Net.Requests => 70
	i64 u0xcdca1b920e9f53ba, ; 802: Xamarin.AndroidX.Interpolator => 245
	i64 u0xcdd0c48b6937b21c, ; 803: Xamarin.AndroidX.SwipeRefreshLayout => 273
	i64 u0xce36efa900c5a6e9, ; 804: lib_JokerApp.dll.so => 0
	i64 u0xcf23d8093f3ceadf, ; 805: System.Diagnostics.DiagnosticSource.dll => 205
	i64 u0xcf5ff6b6b2c4c382, ; 806: System.Net.Mail.dll => 64
	i64 u0xcf8fc898f98b0d34, ; 807: System.Private.Xml.Linq => 85
	i64 u0xd04b5f59ed596e31, ; 808: System.Reflection.Metadata.dll => 92
	i64 u0xd063299fcfc0c93f, ; 809: lib_System.Runtime.Serialization.Json.dll.so => 110
	i64 u0xd0de8a113e976700, ; 810: System.Diagnostics.TextWriterTraceListener => 30
	i64 u0xd0fc33d5ae5d4cb8, ; 811: System.Runtime.Extensions => 101
	i64 u0xd1194e1d8a8de83c, ; 812: lib_Xamarin.AndroidX.Lifecycle.Common.Jvm.dll.so => 247
	i64 u0xd12beacdfc14f696, ; 813: System.Dynamic.Runtime => 36
	i64 u0xd16fd7fb9bbcd43e, ; 814: Microsoft.Extensions.Diagnostics.Abstractions => 186
	i64 u0xd198e7ce1b6a8344, ; 815: System.Net.Quic.dll => 69
	i64 u0xd2505d8abeed6983, ; 816: lib_Microsoft.AspNetCore.Components.Web.dll.so => 174
	i64 u0xd3144156a3727ebe, ; 817: Xamarin.Google.Guava.ListenableFuture => 288
	i64 u0xd333d0af9e423810, ; 818: System.Runtime.InteropServices => 105
	i64 u0xd33a415cb4278969, ; 819: System.Security.Cryptography.Encoding.dll => 120
	i64 u0xd3426d966bb704f5, ; 820: Xamarin.AndroidX.AppCompat.AppCompatResources.dll => 220
	i64 u0xd3651b6fc3125825, ; 821: System.Private.Uri.dll => 84
	i64 u0xd373685349b1fe8b, ; 822: Microsoft.Extensions.Logging.dll => 193
	i64 u0xd3801faafafb7698, ; 823: System.Private.DataContractSerialization.dll => 83
	i64 u0xd3e4c8d6a2d5d470, ; 824: it/Microsoft.Maui.Controls.resources => 313
	i64 u0xd3edcc1f25459a50, ; 825: System.Reflection.Emit => 90
	i64 u0xd4645626dffec99d, ; 826: lib_Microsoft.Extensions.DependencyInjection.Abstractions.dll.so => 184
	i64 u0xd46b4a8758d1f3ee, ; 827: Microsoft.Extensions.FileProviders.Composite.dll => 188
	i64 u0xd4fa0abb79079ea9, ; 828: System.Security.Principal.dll => 126
	i64 u0xd5507e11a2b2839f, ; 829: Xamarin.AndroidX.Lifecycle.ViewModelSavedState => 259
	i64 u0xd5d04bef8478ea19, ; 830: Xamarin.AndroidX.Tracing.Tracing.dll => 274
	i64 u0xd60815f26a12e140, ; 831: Microsoft.Extensions.Logging.Debug.dll => 195
	i64 u0xd6694f8359737e4e, ; 832: Xamarin.AndroidX.SavedState => 268
	i64 u0xd6949e129339eae5, ; 833: lib_Xamarin.AndroidX.Core.Core.Ktx.dll.so => 233
	i64 u0xd6d21782156bc35b, ; 834: Xamarin.AndroidX.SwipeRefreshLayout.dll => 273
	i64 u0xd6de019f6af72435, ; 835: Xamarin.AndroidX.ConstraintLayout.Core.dll => 230
	i64 u0xd6f697a581fc6fe3, ; 836: Xamarin.Google.ErrorProne.TypeAnnotations.dll => 287
	i64 u0xd70956d1e6deefb9, ; 837: Jsr305Binding => 284
	i64 u0xd72329819cbbbc44, ; 838: lib_Microsoft.Extensions.Configuration.Abstractions.dll.so => 179
	i64 u0xd72c760af136e863, ; 839: System.Xml.XmlSerializer.dll => 158
	i64 u0xd753f071e44c2a03, ; 840: lib_System.Security.SecureString.dll.so => 127
	i64 u0xd7b3764ada9d341d, ; 841: lib_Microsoft.Extensions.Logging.Abstractions.dll.so => 194
	i64 u0xd7f0088bc5ad71f2, ; 842: Xamarin.AndroidX.VersionedParcelable => 278
	i64 u0xd8fb25e28ae30a12, ; 843: Xamarin.AndroidX.ProfileInstaller.ProfileInstaller.dll => 265
	i64 u0xda1dfa4c534a9251, ; 844: Microsoft.Extensions.DependencyInjection => 183
	i64 u0xdad05a11827959a3, ; 845: System.Collections.NonGeneric.dll => 10
	i64 u0xdaefdfe71aa53cf9, ; 846: System.IO.FileSystem.Primitives => 48
	i64 u0xdb5383ab5865c007, ; 847: lib-vi-Microsoft.Maui.Controls.resources.dll.so => 329
	i64 u0xdb58816721c02a59, ; 848: lib_System.Reflection.Emit.ILGeneration.dll.so => 88
	i64 u0xdbeda89f832aa805, ; 849: vi/Microsoft.Maui.Controls.resources.dll => 329
	i64 u0xdbf2a779fbc3ac31, ; 850: System.Transactions.Local.dll => 145
	i64 u0xdbf9607a441b4505, ; 851: System.Linq => 60
	i64 u0xdbfc90157a0de9b0, ; 852: lib_System.Text.Encoding.dll.so => 133
	i64 u0xdc75032002d1a212, ; 853: lib_System.Transactions.Local.dll.so => 145
	i64 u0xdca8be7403f92d4f, ; 854: lib_System.Linq.Queryable.dll.so => 59
	i64 u0xdce2c53525640bf3, ; 855: Microsoft.Extensions.Logging => 193
	i64 u0xdd2b722d78ef5f43, ; 856: System.Runtime.dll => 114
	i64 u0xdd67031857c72f96, ; 857: lib_System.Text.Encodings.Web.dll.so => 208
	i64 u0xdd70765ad6162057, ; 858: Xamarin.JSpecify => 290
	i64 u0xdd92e229ad292030, ; 859: System.Numerics.dll => 81
	i64 u0xdde30e6b77aa6f6c, ; 860: lib-zh-Hans-Microsoft.Maui.Controls.resources.dll.so => 331
	i64 u0xde110ae80fa7c2e2, ; 861: System.Xml.XDocument.dll => 154
	i64 u0xde4726fcdf63a198, ; 862: Xamarin.AndroidX.Transition => 275
	i64 u0xde572c2b2fb32f93, ; 863: lib_System.Threading.Tasks.Extensions.dll.so => 138
	i64 u0xde8769ebda7d8647, ; 864: hr/Microsoft.Maui.Controls.resources.dll => 310
	i64 u0xdee075f3477ef6be, ; 865: Xamarin.AndroidX.ExifInterface.dll => 242
	i64 u0xdf4b773de8fb1540, ; 866: System.Net.dll => 79
	i64 u0xdfa254ebb4346068, ; 867: System.Net.Ping => 67
	i64 u0xe0142572c095a480, ; 868: Xamarin.AndroidX.AppCompat.dll => 219
	i64 u0xe021eaa401792a05, ; 869: System.Text.Encoding.dll => 133
	i64 u0xe02f89350ec78051, ; 870: Xamarin.AndroidX.CoordinatorLayout.dll => 231
	i64 u0xe0496b9d65ef5474, ; 871: Xamarin.Android.Glide.DiskLruCache.dll => 212
	i64 u0xe10b760bb1462e7a, ; 872: lib_System.Security.Cryptography.Primitives.dll.so => 122
	i64 u0xe192a588d4410686, ; 873: lib_System.IO.Pipelines.dll.so => 206
	i64 u0xe1a08bd3fa539e0d, ; 874: System.Runtime.Loader => 107
	i64 u0xe1a77eb8831f7741, ; 875: System.Security.SecureString.dll => 127
	i64 u0xe1b52f9f816c70ef, ; 876: System.Private.Xml.Linq.dll => 85
	i64 u0xe1e199c8ab02e356, ; 877: System.Data.DataSetExtensions.dll => 23
	i64 u0xe1ecfdb7fff86067, ; 878: System.Net.Security.dll => 71
	i64 u0xe2252a80fe853de4, ; 879: lib_System.Security.Principal.dll.so => 126
	i64 u0xe22fa4c9c645db62, ; 880: System.Diagnostics.TextWriterTraceListener.dll => 30
	i64 u0xe2420585aeceb728, ; 881: System.Net.Requests.dll => 70
	i64 u0xe26692647e6bcb62, ; 882: Xamarin.AndroidX.Lifecycle.Runtime.Ktx => 254
	i64 u0xe29b73bc11392966, ; 883: lib-id-Microsoft.Maui.Controls.resources.dll.so => 312
	i64 u0xe2ad448dee50fbdf, ; 884: System.Xml.Serialization => 153
	i64 u0xe2d920f978f5d85c, ; 885: System.Data.DataSetExtensions => 23
	i64 u0xe2e426c7714fa0bc, ; 886: Microsoft.Win32.Primitives.dll => 4
	i64 u0xe31089e70e4e84ee, ; 887: Microsoft.AspNetCore.Components.WebView.Maui => 176
	i64 u0xe332bacb3eb4a806, ; 888: Mono.Android.Export.dll => 165
	i64 u0xe3811d68d4fe8463, ; 889: pt-BR/Microsoft.Maui.Controls.resources.dll => 320
	i64 u0xe3b7cbae5ad66c75, ; 890: lib_System.Security.Cryptography.Encoding.dll.so => 120
	i64 u0xe4292b48f3224d5b, ; 891: lib_Xamarin.AndroidX.Core.ViewTree.dll.so => 234
	i64 u0xe494f7ced4ecd10a, ; 892: hu/Microsoft.Maui.Controls.resources.dll => 311
	i64 u0xe4a9b1e40d1e8917, ; 893: lib-fi-Microsoft.Maui.Controls.resources.dll.so => 306
	i64 u0xe4f74a0b5bf9703f, ; 894: System.Runtime.Serialization.Primitives => 111
	i64 u0xe5434e8a119ceb69, ; 895: lib_Mono.Android.dll.so => 167
	i64 u0xe55703b9ce5c038a, ; 896: System.Diagnostics.Tools => 31
	i64 u0xe57013c8afc270b5, ; 897: Microsoft.VisualBasic => 3
	i64 u0xe62913cc36bc07ec, ; 898: System.Xml.dll => 159
	i64 u0xe7bea09c4900a191, ; 899: Xamarin.AndroidX.VectorDrawable.dll => 276
	i64 u0xe7e03cc18dcdeb49, ; 900: lib_System.Diagnostics.StackTrace.dll.so => 29
	i64 u0xe7e147ff99a7a380, ; 901: lib_System.Configuration.dll.so => 19
	i64 u0xe8397cf3948e7cb7, ; 902: lib_Microsoft.Extensions.Options.ConfigurationExtensions.dll.so => 197
	i64 u0xe86b0df4ba9e5db8, ; 903: lib_Xamarin.AndroidX.Lifecycle.Runtime.Android.dll.so => 253
	i64 u0xe896622fe0902957, ; 904: System.Reflection.Emit.dll => 90
	i64 u0xe89a2a9ef110899b, ; 905: System.Drawing.dll => 35
	i64 u0xe8c5f8c100b5934b, ; 906: Microsoft.Win32.Registry => 5
	i64 u0xe957c3976986ab72, ; 907: lib_Xamarin.AndroidX.Window.Extensions.Core.Core.dll.so => 282
	i64 u0xe9772100456fb4b4, ; 908: Microsoft.AspNetCore.Components.dll => 172
	i64 u0xe98163eb702ae5c5, ; 909: Xamarin.AndroidX.Arch.Core.Runtime => 222
	i64 u0xe994f23ba4c143e5, ; 910: Xamarin.KotlinX.Coroutines.Android => 294
	i64 u0xe9b9c8c0458fd92a, ; 911: System.Windows => 150
	i64 u0xe9d166d87a7f2bdb, ; 912: lib_Xamarin.AndroidX.Startup.StartupRuntime.dll.so => 272
	i64 u0xea154e342c6ac70f, ; 913: Microsoft.Extensions.FileProviders.Embedded.dll => 189
	i64 u0xea5a4efc2ad81d1b, ; 914: Xamarin.Google.ErrorProne.Annotations => 286
	i64 u0xeb2313fe9d65b785, ; 915: Xamarin.AndroidX.ConstraintLayout.dll => 229
	i64 u0xec8abb68d340aac6, ; 916: Microsoft.AspNetCore.Authorization => 171
	i64 u0xed19c616b3fcb7eb, ; 917: Xamarin.AndroidX.VersionedParcelable.dll => 278
	i64 u0xedc4817167106c23, ; 918: System.Net.Sockets.dll => 73
	i64 u0xedc632067fb20ff3, ; 919: System.Memory.dll => 61
	i64 u0xedc8e4ca71a02a8b, ; 920: Xamarin.AndroidX.Navigation.Runtime.dll => 263
	i64 u0xee81f5b3f1c4f83b, ; 921: System.Threading.ThreadPool => 142
	i64 u0xeeb7ebb80150501b, ; 922: lib_Xamarin.AndroidX.Collection.Jvm.dll.so => 226
	i64 u0xeefc635595ef57f0, ; 923: System.Security.Cryptography.Cng => 118
	i64 u0xef03b1b5a04e9709, ; 924: System.Text.Encoding.CodePages.dll => 131
	i64 u0xef602c523fe2e87a, ; 925: lib_Xamarin.Google.Guava.ListenableFuture.dll.so => 288
	i64 u0xef72742e1bcca27a, ; 926: Microsoft.Maui.Essentials.dll => 203
	i64 u0xefd1e0c4e5c9b371, ; 927: System.Resources.ResourceManager.dll => 97
	i64 u0xefe8f8d5ed3c72ea, ; 928: System.Formats.Tar.dll => 38
	i64 u0xefec0b7fdc57ec42, ; 929: Xamarin.AndroidX.Activity => 214
	i64 u0xf00c29406ea45e19, ; 930: es/Microsoft.Maui.Controls.resources.dll => 305
	i64 u0xf09e47b6ae914f6e, ; 931: System.Net.NameResolution => 65
	i64 u0xf0ac2b489fed2e35, ; 932: lib_System.Diagnostics.Debug.dll.so => 26
	i64 u0xf0bb49dadd3a1fe1, ; 933: lib_System.Net.ServicePoint.dll.so => 72
	i64 u0xf0de2537ee19c6ca, ; 934: lib_System.Net.WebHeaderCollection.dll.so => 75
	i64 u0xf1138779fa181c68, ; 935: lib_Xamarin.AndroidX.Lifecycle.Runtime.dll.so => 252
	i64 u0xf11b621fc87b983f, ; 936: Microsoft.Maui.Controls.Xaml.dll => 201
	i64 u0xf161f4f3c3b7e62c, ; 937: System.Data => 24
	i64 u0xf16eb650d5a464bc, ; 938: System.ValueTuple => 147
	i64 u0xf1c4b4005493d871, ; 939: System.Formats.Asn1.dll => 37
	i64 u0xf238bd79489d3a96, ; 940: lib-nl-Microsoft.Maui.Controls.resources.dll.so => 318
	i64 u0xf2feea356ba760af, ; 941: Xamarin.AndroidX.Arch.Core.Runtime.dll => 222
	i64 u0xf300e085f8acd238, ; 942: lib_System.ServiceProcess.dll.so => 130
	i64 u0xf34e52b26e7e059d, ; 943: System.Runtime.CompilerServices.VisualC.dll => 100
	i64 u0xf37221fda4ef8830, ; 944: lib_Xamarin.Google.Android.Material.dll.so => 283
	i64 u0xf3ad9b8fb3eefd12, ; 945: lib_System.IO.UnmanagedMemoryStream.dll.so => 55
	i64 u0xf3ddfe05336abf29, ; 946: System => 160
	i64 u0xf408654b2a135055, ; 947: System.Reflection.Emit.ILGeneration.dll => 88
	i64 u0xf4103170a1de5bd0, ; 948: System.Linq.Queryable.dll => 59
	i64 u0xf42d20c23173d77c, ; 949: lib_System.ServiceModel.Web.dll.so => 129
	i64 u0xf4c1dd70a5496a17, ; 950: System.IO.Compression => 45
	i64 u0xf4ecf4b9afc64781, ; 951: System.ServiceProcess.dll => 130
	i64 u0xf4eeeaa566e9b970, ; 952: lib_Xamarin.AndroidX.CustomView.PoolingContainer.dll.so => 237
	i64 u0xf518f63ead11fcd1, ; 953: System.Threading.Tasks => 140
	i64 u0xf5fc7602fe27b333, ; 954: System.Net.WebHeaderCollection => 75
	i64 u0xf6077741019d7428, ; 955: Xamarin.AndroidX.CoordinatorLayout => 231
	i64 u0xf6742cbf457c450b, ; 956: Xamarin.AndroidX.Lifecycle.Runtime.Android.dll => 253
	i64 u0xf6de7fa3776f8927, ; 957: lib_Microsoft.Extensions.Configuration.Json.dll.so => 182
	i64 u0xf6f893f692f8cb43, ; 958: Microsoft.Extensions.Options.ConfigurationExtensions.dll => 197
	i64 u0xf70c0a7bf8ccf5af, ; 959: System.Web => 149
	i64 u0xf77b20923f07c667, ; 960: de/Microsoft.Maui.Controls.resources.dll => 303
	i64 u0xf7e2cac4c45067b3, ; 961: lib_System.Numerics.Vectors.dll.so => 80
	i64 u0xf7e74930e0e3d214, ; 962: zh-HK/Microsoft.Maui.Controls.resources.dll => 330
	i64 u0xf84773b5c81e3cef, ; 963: lib-uk-Microsoft.Maui.Controls.resources.dll.so => 328
	i64 u0xf8aac5ea82de1348, ; 964: System.Linq.Queryable => 59
	i64 u0xf8b77539b362d3ba, ; 965: lib_System.Reflection.Primitives.dll.so => 93
	i64 u0xf8e045dc345b2ea3, ; 966: lib_Xamarin.AndroidX.RecyclerView.dll.so => 266
	i64 u0xf915dc29808193a1, ; 967: System.Web.HttpUtility.dll => 148
	i64 u0xf96c777a2a0686f4, ; 968: hi/Microsoft.Maui.Controls.resources.dll => 309
	i64 u0xf9be54c8bcf8ff3b, ; 969: System.Security.AccessControl.dll => 115
	i64 u0xf9eec5bb3a6aedc6, ; 970: Microsoft.Extensions.Options => 196
	i64 u0xfa0e82300e67f913, ; 971: lib_System.AppContext.dll.so => 6
	i64 u0xfa2fdb27e8a2c8e8, ; 972: System.ComponentModel.EventBasedAsync => 15
	i64 u0xfa3f278f288b0e84, ; 973: lib_System.Net.Security.dll.so => 71
	i64 u0xfa504dfa0f097d72, ; 974: Microsoft.Extensions.FileProviders.Abstractions.dll => 187
	i64 u0xfa5ed7226d978949, ; 975: lib-ar-Microsoft.Maui.Controls.resources.dll.so => 299
	i64 u0xfa645d91e9fc4cba, ; 976: System.Threading.Thread => 141
	i64 u0xfad4d2c770e827f9, ; 977: lib_System.IO.IsolatedStorage.dll.so => 51
	i64 u0xfb06dd2338e6f7c4, ; 978: System.Net.Ping.dll => 67
	i64 u0xfb087abe5365e3b7, ; 979: lib_System.Data.DataSetExtensions.dll.so => 23
	i64 u0xfb846e949baff5ea, ; 980: System.Xml.Serialization.dll => 153
	i64 u0xfbad3e4ce4b98145, ; 981: System.Security.Cryptography.X509Certificates => 123
	i64 u0xfbf0a31c9fc34bc4, ; 982: lib_System.Net.Http.dll.so => 62
	i64 u0xfc6b7527cc280b3f, ; 983: lib_System.Runtime.Serialization.Formatters.dll.so => 109
	i64 u0xfc719aec26adf9d9, ; 984: Xamarin.AndroidX.Navigation.Fragment.dll => 262
	i64 u0xfc82690c2fe2735c, ; 985: Xamarin.AndroidX.Lifecycle.Process.dll => 251
	i64 u0xfc93fc307d279893, ; 986: System.IO.Pipes.AccessControl.dll => 53
	i64 u0xfcd302092ada6328, ; 987: System.IO.MemoryMappedFiles.dll => 52
	i64 u0xfd22f00870e40ae0, ; 988: lib_Xamarin.AndroidX.DrawerLayout.dll.so => 238
	i64 u0xfd2e866c678cac90, ; 989: lib_Microsoft.AspNetCore.Components.WebView.Maui.dll.so => 176
	i64 u0xfd49b3c1a76e2748, ; 990: System.Runtime.InteropServices.RuntimeInformation => 104
	i64 u0xfd536c702f64dc47, ; 991: System.Text.Encoding.Extensions => 132
	i64 u0xfd583f7657b6a1cb, ; 992: Xamarin.AndroidX.Fragment => 243
	i64 u0xfd8dd91a2c26bd5d, ; 993: Xamarin.AndroidX.Lifecycle.Runtime => 252
	i64 u0xfda36abccf05cf5c, ; 994: System.Net.WebSockets.Client => 77
	i64 u0xfddbe9695626a7f5, ; 995: Xamarin.AndroidX.Lifecycle.Common => 246
	i64 u0xfe9856c3af9365ab, ; 996: lib_Microsoft.Extensions.Configuration.FileExtensions.dll.so => 181
	i64 u0xfeae9952cf03b8cb, ; 997: tr/Microsoft.Maui.Controls.resources => 327
	i64 u0xfebe1950717515f9, ; 998: Xamarin.AndroidX.Lifecycle.LiveData.Core.Ktx.dll => 250
	i64 u0xff270a55858bac8d, ; 999: System.Security.Principal => 126
	i64 u0xff9b54613e0d2cc8, ; 1000: System.Net.Http.Json => 207
	i64 u0xffdb7a971be4ec73 ; 1001: System.ValueTuple.dll => 147
], align 16

@assembly_image_cache_indices = dso_local local_unnamed_addr constant [1002 x i32] [
	i32 41, i32 295, i32 273, i32 13, i32 263, i32 197, i32 102, i32 166,
	i32 47, i32 219, i32 7, i32 83, i32 323, i32 301, i32 329, i32 239,
	i32 68, i32 266, i32 12, i32 202, i32 99, i32 330, i32 151, i32 19,
	i32 244, i32 226, i32 172, i32 156, i32 241, i32 276, i32 162, i32 323,
	i32 10, i32 195, i32 277, i32 93, i32 237, i32 238, i32 13, i32 196,
	i32 10, i32 124, i32 92, i32 135, i32 38, i32 324, i32 298, i32 279,
	i32 320, i32 167, i32 213, i32 5, i32 203, i32 64, i32 270, i32 127,
	i32 269, i32 240, i32 65, i32 227, i32 63, i32 55, i32 236, i32 51,
	i32 42, i32 122, i32 64, i32 78, i32 254, i32 153, i32 89, i32 96,
	i32 266, i32 136, i32 146, i32 223, i32 307, i32 157, i32 164, i32 308,
	i32 184, i32 78, i32 290, i32 227, i32 4, i32 5, i32 50, i32 98,
	i32 54, i32 117, i32 95, i32 163, i32 115, i32 295, i32 21, i32 311,
	i32 208, i32 94, i32 298, i32 74, i32 317, i32 272, i32 116, i32 8,
	i32 160, i32 326, i32 0, i32 67, i32 212, i32 173, i32 255, i32 267,
	i32 185, i32 190, i32 166, i32 140, i32 39, i32 270, i32 46, i32 29,
	i32 264, i32 315, i32 139, i32 196, i32 158, i32 27, i32 81, i32 274,
	i32 74, i32 42, i32 28, i32 41, i32 100, i32 114, i32 217, i32 44,
	i32 88, i32 326, i32 54, i32 143, i32 141, i32 97, i32 48, i32 20,
	i32 232, i32 111, i32 210, i32 307, i32 285, i32 291, i32 198, i32 91,
	i32 56, i32 312, i32 310, i32 78, i32 285, i32 164, i32 26, i32 68,
	i32 265, i32 186, i32 242, i32 328, i32 66, i32 32, i32 306, i32 14,
	i32 134, i32 37, i32 332, i32 191, i32 228, i32 319, i32 131, i32 89,
	i32 85, i32 144, i32 325, i32 24, i32 209, i32 55, i32 50, i32 304,
	i32 199, i32 28, i32 152, i32 33, i32 159, i32 192, i32 243, i32 51,
	i32 189, i32 333, i32 281, i32 87, i32 287, i32 224, i32 34, i32 307,
	i32 152, i32 191, i32 9, i32 305, i32 73, i32 53, i32 188, i32 202,
	i32 301, i32 200, i32 13, i32 280, i32 178, i32 221, i32 106, i32 258,
	i32 31, i32 101, i32 81, i32 89, i32 52, i32 93, i32 289, i32 56,
	i32 9, i32 99, i32 236, i32 65, i32 279, i32 300, i32 187, i32 122,
	i32 267, i32 113, i32 132, i32 199, i32 123, i32 103, i32 291, i32 128,
	i32 223, i32 288, i32 142, i32 151, i32 244, i32 232, i32 181, i32 239,
	i32 267, i32 94, i32 24, i32 175, i32 271, i32 138, i32 261, i32 3,
	i32 162, i32 220, i32 97, i32 156, i32 96, i32 234, i32 25, i32 90,
	i32 163, i32 167, i32 215, i32 3, i32 319, i32 241, i32 1, i32 111,
	i32 291, i32 244, i32 251, i32 32, i32 6, i32 323, i32 151, i32 321,
	i32 52, i32 82, i32 278, i32 264, i32 43, i32 250, i32 101, i32 46,
	i32 209, i32 207, i32 260, i32 66, i32 77, i32 57, i32 86, i32 149,
	i32 221, i32 130, i32 107, i32 313, i32 260, i32 199, i32 265, i32 166,
	i32 131, i32 135, i32 39, i32 300, i32 180, i32 200, i32 58, i32 169,
	i32 180, i32 257, i32 76, i32 25, i32 35, i32 96, i32 254, i32 68,
	i32 22, i32 232, i32 204, i32 324, i32 118, i32 66, i32 104, i32 330,
	i32 116, i32 114, i32 246, i32 247, i32 11, i32 2, i32 121, i32 112,
	i32 137, i32 40, i32 84, i32 216, i32 168, i32 205, i32 143, i32 180,
	i32 314, i32 183, i32 286, i32 215, i32 1, i32 217, i32 43, i32 231,
	i32 144, i32 18, i32 83, i32 302, i32 40, i32 250, i32 225, i32 255,
	i32 91, i32 193, i32 27, i32 40, i32 75, i32 176, i32 240, i32 228,
	i32 139, i32 105, i32 226, i32 11, i32 102, i32 208, i32 16, i32 119,
	i32 63, i32 152, i32 22, i32 304, i32 297, i32 99, i32 183, i32 296,
	i32 61, i32 56, i32 201, i32 303, i32 107, i32 168, i32 294, i32 9,
	i32 283, i32 117, i32 95, i32 102, i32 258, i32 200, i32 108, i32 218,
	i32 48, i32 20, i32 257, i32 235, i32 69, i32 230, i32 150, i32 38,
	i32 302, i32 177, i32 34, i32 292, i32 37, i32 308, i32 282, i32 105,
	i32 317, i32 21, i32 289, i32 256, i32 204, i32 15, i32 198, i32 76,
	i32 76, i32 235, i32 198, i32 262, i32 269, i32 147, i32 21, i32 0,
	i32 202, i32 301, i32 49, i32 50, i32 327, i32 317, i32 91, i32 211,
	i32 186, i32 313, i32 16, i32 234, i32 120, i32 310, i32 155, i32 44,
	i32 286, i32 170, i32 113, i32 61, i32 161, i32 185, i32 178, i32 14,
	i32 268, i32 108, i32 218, i32 58, i32 293, i32 182, i32 118, i32 316,
	i32 2, i32 326, i32 243, i32 256, i32 192, i32 292, i32 290, i32 175,
	i32 256, i32 6, i32 225, i32 306, i32 239, i32 17, i32 324, i32 303,
	i32 74, i32 229, i32 177, i32 128, i32 289, i32 316, i32 173, i32 80,
	i32 195, i32 12, i32 33, i32 116, i32 297, i32 251, i32 241, i32 82,
	i32 210, i32 18, i32 279, i32 179, i32 249, i32 69, i32 92, i32 174,
	i32 160, i32 245, i32 79, i32 332, i32 219, i32 224, i32 293, i32 149,
	i32 35, i32 146, i32 328, i32 331, i32 188, i32 139, i32 54, i32 110,
	i32 225, i32 276, i32 275, i32 36, i32 332, i32 178, i32 112, i32 191,
	i32 217, i32 14, i32 211, i32 141, i32 42, i32 203, i32 215, i32 95,
	i32 296, i32 163, i32 16, i32 47, i32 104, i32 94, i32 260, i32 205,
	i32 125, i32 28, i32 308, i32 187, i32 269, i32 125, i32 43, i32 235,
	i32 240, i32 144, i32 8, i32 261, i32 309, i32 322, i32 321, i32 129,
	i32 320, i32 41, i32 297, i32 32, i32 333, i32 45, i32 138, i32 257,
	i32 201, i32 248, i32 236, i32 182, i32 209, i32 60, i32 129, i32 300,
	i32 47, i32 155, i32 222, i32 248, i32 211, i32 246, i32 316, i32 275,
	i32 45, i32 159, i32 245, i32 305, i32 242, i32 312, i32 204, i32 18,
	i32 8, i32 170, i32 233, i32 121, i32 57, i32 136, i32 169, i32 263,
	i32 315, i32 252, i32 284, i32 281, i32 145, i32 137, i32 295, i32 292,
	i32 123, i32 294, i32 155, i32 157, i32 237, i32 214, i32 179, i32 318,
	i32 26, i32 261, i32 249, i32 190, i32 79, i32 281, i32 124, i32 285,
	i32 98, i32 143, i32 283, i32 264, i32 206, i32 157, i32 162, i32 128,
	i32 189, i32 36, i32 277, i32 315, i32 185, i32 169, i32 173, i32 22,
	i32 109, i32 87, i32 49, i32 58, i32 119, i32 80, i32 124, i32 158,
	i32 284, i32 161, i32 268, i32 270, i32 238, i32 210, i32 253, i32 4,
	i32 247, i32 311, i32 165, i32 2, i32 190, i32 258, i32 113, i32 216,
	i32 19, i32 194, i32 86, i32 62, i32 29, i32 184, i32 304, i32 230,
	i32 57, i32 108, i32 249, i32 31, i32 125, i32 154, i32 322, i32 228,
	i32 135, i32 318, i32 148, i32 17, i32 227, i32 213, i32 72, i32 71,
	i32 15, i32 164, i32 82, i32 293, i32 121, i32 248, i32 259, i32 229,
	i32 325, i32 255, i32 33, i32 172, i32 115, i32 134, i32 119, i32 103,
	i32 302, i32 277, i32 224, i32 309, i32 299, i32 206, i32 46, i32 27,
	i32 140, i32 194, i32 142, i32 34, i32 325, i32 168, i32 192, i32 282,
	i32 72, i32 156, i32 1, i32 271, i32 321, i32 314, i32 154, i32 12,
	i32 150, i32 175, i32 146, i32 73, i32 100, i32 109, i32 221, i32 177,
	i32 171, i32 62, i32 63, i32 280, i32 44, i32 223, i32 106, i32 7,
	i32 220, i32 53, i32 216, i32 207, i32 299, i32 233, i32 20, i32 106,
	i32 98, i32 60, i32 137, i32 171, i32 214, i32 7, i32 314, i32 165,
	i32 49, i32 280, i32 112, i32 136, i32 170, i32 161, i32 77, i32 110,
	i32 259, i32 17, i32 70, i32 262, i32 86, i32 212, i32 84, i32 117,
	i32 274, i32 181, i32 218, i32 132, i32 148, i32 103, i32 11, i32 87,
	i32 30, i32 174, i32 327, i32 133, i32 319, i32 287, i32 322, i32 272,
	i32 213, i32 39, i32 333, i32 271, i32 134, i32 296, i32 298, i32 25,
	i32 331, i32 70, i32 245, i32 273, i32 0, i32 205, i32 64, i32 85,
	i32 92, i32 110, i32 30, i32 101, i32 247, i32 36, i32 186, i32 69,
	i32 174, i32 288, i32 105, i32 120, i32 220, i32 84, i32 193, i32 83,
	i32 313, i32 90, i32 184, i32 188, i32 126, i32 259, i32 274, i32 195,
	i32 268, i32 233, i32 273, i32 230, i32 287, i32 284, i32 179, i32 158,
	i32 127, i32 194, i32 278, i32 265, i32 183, i32 10, i32 48, i32 329,
	i32 88, i32 329, i32 145, i32 60, i32 133, i32 145, i32 59, i32 193,
	i32 114, i32 208, i32 290, i32 81, i32 331, i32 154, i32 275, i32 138,
	i32 310, i32 242, i32 79, i32 67, i32 219, i32 133, i32 231, i32 212,
	i32 122, i32 206, i32 107, i32 127, i32 85, i32 23, i32 71, i32 126,
	i32 30, i32 70, i32 254, i32 312, i32 153, i32 23, i32 4, i32 176,
	i32 165, i32 320, i32 120, i32 234, i32 311, i32 306, i32 111, i32 167,
	i32 31, i32 3, i32 159, i32 276, i32 29, i32 19, i32 197, i32 253,
	i32 90, i32 35, i32 5, i32 282, i32 172, i32 222, i32 294, i32 150,
	i32 272, i32 189, i32 286, i32 229, i32 171, i32 278, i32 73, i32 61,
	i32 263, i32 142, i32 226, i32 118, i32 131, i32 288, i32 203, i32 97,
	i32 38, i32 214, i32 305, i32 65, i32 26, i32 72, i32 75, i32 252,
	i32 201, i32 24, i32 147, i32 37, i32 318, i32 222, i32 130, i32 100,
	i32 283, i32 55, i32 160, i32 88, i32 59, i32 129, i32 45, i32 130,
	i32 237, i32 140, i32 75, i32 231, i32 253, i32 182, i32 197, i32 149,
	i32 303, i32 80, i32 330, i32 328, i32 59, i32 93, i32 266, i32 148,
	i32 309, i32 115, i32 196, i32 6, i32 15, i32 71, i32 187, i32 299,
	i32 141, i32 51, i32 67, i32 23, i32 153, i32 123, i32 62, i32 109,
	i32 262, i32 251, i32 53, i32 52, i32 238, i32 176, i32 104, i32 132,
	i32 243, i32 252, i32 77, i32 246, i32 181, i32 327, i32 250, i32 126,
	i32 207, i32 147
], align 16

@marshal_methods_number_of_classes = dso_local local_unnamed_addr constant i32 0, align 4

@marshal_methods_class_cache = dso_local local_unnamed_addr global [0 x %struct.MarshalMethodsManagedClass] zeroinitializer, align 8

; Names of classes in which marshal methods reside
@mm_class_names = dso_local local_unnamed_addr constant [0 x ptr] zeroinitializer, align 8

@mm_method_names = dso_local local_unnamed_addr constant [1 x %struct.MarshalMethodName] [
	%struct.MarshalMethodName {
		i64 u0x0000000000000000, ; name: 
		ptr @.MarshalMethodName.0_name; char* name
	} ; 0
], align 8

; get_function_pointer (uint32_t mono_image_index, uint32_t class_index, uint32_t method_token, void*& target_ptr)
@get_function_pointer = internal dso_local unnamed_addr global ptr null, align 8

; Functions

; Function attributes: memory(write, argmem: none, inaccessiblemem: none) "min-legal-vector-width"="0" mustprogress nofree norecurse nosync "no-trapping-math"="true" nounwind "stack-protector-buffer-size"="8" uwtable willreturn
define void @xamarin_app_init(ptr nocapture noundef readnone %env, ptr noundef %fn) local_unnamed_addr #0
{
	%fnIsNull = icmp eq ptr %fn, null
	br i1 %fnIsNull, label %1, label %2

1: ; preds = %0
	%putsResult = call noundef i32 @puts(ptr @.str.0)
	call void @abort()
	unreachable 

2: ; preds = %1, %0
	store ptr %fn, ptr @get_function_pointer, align 8, !tbaa !3
	ret void
}

; Strings
@.str.0 = private unnamed_addr constant [40 x i8] c"get_function_pointer MUST be specified\0A\00", align 16

;MarshalMethodName
@.MarshalMethodName.0_name = private unnamed_addr constant [1 x i8] c"\00", align 1

; External functions

; Function attributes: noreturn "no-trapping-math"="true" nounwind "stack-protector-buffer-size"="8"
declare void @abort() local_unnamed_addr #2

; Function attributes: nofree nounwind
declare noundef i32 @puts(ptr noundef) local_unnamed_addr #1
attributes #0 = { memory(write, argmem: none, inaccessiblemem: none) "min-legal-vector-width"="0" mustprogress nofree norecurse nosync "no-trapping-math"="true" nounwind "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+crc32,+cx16,+cx8,+fxsr,+mmx,+popcnt,+sse,+sse2,+sse3,+sse4.1,+sse4.2,+ssse3,+x87" "tune-cpu"="generic" uwtable willreturn }
attributes #1 = { nofree nounwind }
attributes #2 = { noreturn "no-trapping-math"="true" nounwind "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+crc32,+cx16,+cx8,+fxsr,+mmx,+popcnt,+sse,+sse2,+sse3,+sse4.1,+sse4.2,+ssse3,+x87" "tune-cpu"="generic" }

; Metadata
!llvm.module.flags = !{!0, !1}
!0 = !{i32 1, !"wchar_size", i32 4}
!1 = !{i32 7, !"PIC Level", i32 2}
!llvm.ident = !{!2}
!2 = !{!".NET for Android remotes/origin/release/9.0.1xx @ 9abff7703206541fdb83ffa80fe2c2753ad1997b"}
!3 = !{!4, !4, i64 0}
!4 = !{!"any pointer", !5, i64 0}
!5 = !{!"omnipotent char", !6, i64 0}
!6 = !{!"Simple C++ TBAA"}
