package com.example.untitled1

import android.app.ActivityManager
import android.content.Context
import android.content.Intent
import android.os.Bundle
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel
import java.io.File

class MainActivity: FlutterActivity() {


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
            }

        }

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
