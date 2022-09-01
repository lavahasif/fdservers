package com.example.untitled1

import android.app.ActivityManager
import android.content.Context
import android.content.Intent
import android.content.pm.PackageManager
import android.content.pm.ResolveInfo
import android.net.Uri
import android.os.Build
import android.os.Bundle
import android.widget.Toast
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel
import java.io.File
import java.net.URLEncoder

class MainActivity : FlutterActivity() {


    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
//        handleIntent()
        isAppRunning = isAppRunning(this);
    }

    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)
        MethodChannel(
            flutterEngine.dartExecutor.binaryMessenger,
            "com.tnorbury.flutterSharingTutorial"
        ).setMethodCallHandler { call, result ->

            if (call.method == "getSharedDatatext") {

//                if (intent.type == "text/plain") {

                result.success(savedProcessIntentText_)
//                    savedProcessIntentText_ = null;
//                }
            } else if (call.method == "getSharedDatafile") {
                if (intent.type != "text/plain") {

//                    result.success(savedProcessIntentFile_)
//                    savedProcessIntentFile_ = null;
                }
            } else if (call.method == "getPath") {
                result.success(getPath())
            } else if (call.method == "delete") {
                deletetemp()
            } else if (call.method == "version") {
                result.success(Build.VERSION.SDK_INT)

            } else if (call.method == "opendev") {
                openDeveloper()

            } else if (call.method == "whats") {
                try {
                    var message = call.argument<String>("message")
                    val mob = call.argument<String>("mob")
                    val packages = call.argument<String>("pacakges")
//                    val i = Intent(Intent.ACTION_VIEW);
//                    i.setData(Uri.parse("whatsapp://919747200785?text=The text message goes here"))
//                    context.startActivity(i)
//                    OpenWhatspp()
                    if (message != null) {
                        if (mob != null) {
                            if (packages == "A")
                                Fromwhats(mob, message)
                            else if (packages == "W")
                                Opwhats(mob, message)
                            else if (packages == "Z")
                                Fromwhats_opweb(mob, message)
                            else if (packages == "B")
                                FromwhatsView(mob, message, "com.whatsapp.w4b")
                            else
                                FromwhatsView(mob, message, "com.whatsapp")
//                            Opwhats()
//                            openWhatsApp2(mob, message)
//                            openWhatsApp(mob, message)
                        }
                    }
                } catch (e: Exception) {
                    Toast.makeText(context, "Whatsapp not installed!", Toast.LENGTH_LONG).show();
                }
            }

        }

    }

    private fun openDeveloper() {
        startActivity(Intent(android.provider.Settings.ACTION_APPLICATION_DEVELOPMENT_SETTINGS));

    }

    public fun Fromwhats(mobile: String, msg: String) {
        val sendIntent = Intent()
        if (Build.VERSION.SDK_INT <= 28) {
            sendIntent.setAction(Intent.ACTION_VIEW);

        } else
            sendIntent.setAction(Intent.ACTION_SEND);
        val url =
            "https://wa.me/$mobile" + "?text=" + URLEncoder.encode(msg, "utf-8")
        val s = "https://api.whatsapp.com/send?phone=917012438494&text=Message to send"
        sendIntent.setData(Uri.parse(url))
//        sendIntent.putExtra(Intent.EXTRA_TEXT, "This is my text to send.");
//        sendIntent.setType("text/plain");
        startActivity(sendIntent);

    }

    fun Fromwhats_opweb(mobile: String, msg: String) {
        val sendIntent = Intent()
        sendIntent.setAction(Intent.ACTION_SEND);

        val url =
            "https://wa.me/$mobile" + "?text=" + URLEncoder.encode(msg, "utf-8")
        val s = "https://api.whatsapp.com/send?phone=917012438494&text=Message to send"
        sendIntent.setData(Uri.parse(url))
//        sendIntent.putExtra(Intent.EXTRA_TEXT, "This is my text to send.");
//        sendIntent.setType("text/plain");
        startActivity(sendIntent);

    }

    public fun FromwhatsView(mobile: String, msg: String, packages: String) {
        val sendIntent = Intent()
        sendIntent.setAction(Intent.ACTION_VIEW);
        val url =
            "https://wa.me/$mobile" + "?text=" + URLEncoder.encode(msg, "utf-8")
        val s = "https://api.whatsapp.com/send?phone=917012438494&text=Message to send"
        sendIntent.setData(Uri.parse(url))
        sendIntent.setPackage(packages)
//        sendIntent.putExtra(Intent.EXTRA_TEXT, "This is my text to send.");
//        sendIntent.setType("text/plain");
        startActivity(sendIntent);

    }

    public fun Opwhats(mobile: String, msg: String) {
        // get available share intents
        var packageToBeFiltered: String = "com.whats"
        var targets = ArrayList<Intent>();
//        var template = Intent(Intent.ACTION_SEND);
        var template = Intent(Intent.ACTION_SEND);
        template.setType("text/plain");
        var candidates: List<ResolveInfo> =
            this.getPackageManager().queryIntentActivities(template, 0);

// filter package here
        for (candidate in candidates) {
            var packageName: String = candidate.activityInfo.packageName;
            if (packageName.contains("whats")) {
                var target: Intent = Intent(android.content.Intent.ACTION_VIEW);
                val url =
                    "https://wa.me/$mobile" + "?text=" + URLEncoder.encode(msg, "utf-8")
                val s = "https://api.whatsapp.com/send?phone=917012438494&text=Message to send"
                target.setData(Uri.parse(url))
                target.setPackage(packageName);
                targets.add(target);
                val chooser = Intent.createChooser(target, "Open Whatspp").apply {


                }

                startActivity(chooser);
            }
        }
        if (!targets.isEmpty()) {

        }
    }

    private fun openWhatsApp(mobile: String, msg: String) {
        try {
            val packageManager: PackageManager = activity.packageManager
            val i = Intent(Intent.ACTION_VIEW)
//            val url =
//                "https://api.whatsapp.com/send?phone=" + mobile + "&text=" + URLEncoder.encode(
//                    msg,
//                    "UTF-8"
//                )

            val url =
                "https://wa.me/$mobile" + "?text=" + URLEncoder.encode(msg, "utf-8")

//            i.setPackage("com.whatsapp")
//            i.setComponent()
            val viewIntent = Intent(Intent.ACTION_VIEW)
            val editIntent = Intent(Intent.ACTION_SENDTO)
            val sendIntent = Intent(Intent.ACTION_SEND)

            i.setDataAndType(Uri.parse(url), "text/plain");
            i.putExtra(Intent.EXTRA_TEXT, "This is my text to send.");
//                i.setAction(Intent.ACTION_SEND);
            i.data = Uri.parse(url)
            if (i.resolveActivity(packageManager) != null) {
                val shareIntent = Intent.createChooser(i, null)
                    .apply {
                        putExtra(Intent.EXTRA_CHOOSER_TARGETS, arrayOf(viewIntent, sendIntent))
                        putExtra(Intent.EXTRA_INITIAL_INTENTS, arrayOf(viewIntent, sendIntent))
                    }
                startActivity(shareIntent)

            } else {
                Toast.makeText(
                    activity,
                    "",
                    Toast.LENGTH_SHORT
                ).show()
            }
        } catch (e: java.lang.Exception) {
            Toast.makeText(
                activity,
                "$e",
                Toast.LENGTH_SHORT
            ).show()
        }
    }

    private fun openWhatsApp2(mobile: String, msg: String) {
        try {
            val packageManager: PackageManager = activity.packageManager
            val i = Intent(Intent.ACTION_VIEW)

            val url =
                "https://wa.me/$mobile" + "?text=" + URLEncoder.encode(msg, "utf-8")
//            i.setPackage("com.whatsapp")


//            i.setComponent()


            i.setDataAndType(Uri.parse(url), "text/plain");
            i.putExtra(Intent.EXTRA_TEXT, "This is my text to send.");
//                i.setAction(Intent.ACTION_SEND);
            i.data = Uri.parse(url)
            if (i.resolveActivity(packageManager) != null) {
                val shareIntent = Intent.createChooser(i, null)
                startActivity(shareIntent)

            } else {
                Toast.makeText(
                    activity,
                    "",
                    Toast.LENGTH_SHORT
                ).show()
            }
        } catch (e: java.lang.Exception) {
            Toast.makeText(
                activity,
                "$e",
                Toast.LENGTH_SHORT
            ).show()
        }
    }

    private fun OpenWhatspp() {
        startActivity(
            Intent(
                Intent.ACTION_VIEW,
                Uri.parse(
                    "https://api.whatsapp.com/send?phone=917012438494&text=Message to send"
                )
            )
        )
    }

    private var sharedData: String = ""
    private fun handleIntent() {
        // intent is a property of this activity
        // Only process the intent if it's a send intent and it's of type 'text'
        if (intent?.action == Intent.ACTION_SEND) {
            if (intent.type == "text/plain") {
                intent.getStringExtra(Intent.EXTRA_TEXT)?.let { intentData ->
                    sharedData = intentData
                }
            }
        }
    }

    fun deletetemp() {
        val replace = externalCacheDir?.path?.replace("/cache", "/dele")
        val file = File(replace)
        file.deleteRecursively()
        file.mkdir()
    }

    fun getPath(): String {
        return externalCacheDir?.path?.replace("/cache", "/dele").toString()

    }

    companion object {
        var isAppRunning: Boolean = true;
        var savedProcessIntentText: ByteArray? = null;
        var savedProcessIntentText_: String? = null;
        var savedProcessIntentFile_: ArrayList<String>? = ArrayList<String>();

        fun isAppRunning(context: Context): Boolean {
            val packageName: String = context.getPackageName()
            val activityManager: ActivityManager =
                context.getSystemService(Context.ACTIVITY_SERVICE) as ActivityManager
            val processInfo: List<ActivityManager.RunningAppProcessInfo> =
                activityManager.getRunningAppProcesses()
            if (processInfo != null) {
                for (info in processInfo) {
                    if (info.processName.equals(packageName)) {
                        return true
                    }
                }
            }
            return false
        }
    }
}
