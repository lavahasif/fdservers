package ab.shersoft.fdserv

import android.content.Intent
import android.os.Build
import android.os.Bundle
import androidx.core.content.ContextCompat
import ab.shersoft.fdserv.MainActivity.Companion.isAppRunning
import io.flutter.embedding.android.FlutterActivity

class ProcessTextActivity : FlutterActivity() {
    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        val issAppRunning = isAppRunning
        listenProcessTextIntent(isAppRunning)
//        FlutterProcessTextPlugin().listenProcessTextIntent(issAppRunning)
    }

    fun listenProcessTextIntent(isAppRunning: Boolean) {
        openApp()
        if (!isAppRunning) {
            // Open app when its not running

        } else {
            // Fetch process text when the app is running.
        }
        activity.finish()
    }

    fun openApp() {
        saveProcessIntentText()
        val intent: Intent =
            getIntentToOpenMainActivity()!!
        ContextCompat.startActivity(
            context,
            intent,
            null
        )
    }

    private fun getIntentToOpenMainActivity(): Intent? {
        val packageName: String =
            context.getPackageName()
        return this
            .getPackageManager()
            .getLaunchIntentForPackage(packageName)
            ?.setAction(Intent.ACTION_RUN)
            ?.addFlags(Intent.FLAG_ACTIVITY_NEW_TASK)
            ?.addFlags(Intent.FLAG_ACTIVITY_CLEAR_TASK)
    }

    fun saveProcessIntentText() {
        var text: String? = null

        val action = intent.action
        val type = intent.type
        val extras = intent.extras
        if (Intent.ACTION_PROCESS_TEXT.equals(action) && type != null) {
            if ("text/plain".equals(type)) {
                var s = handletext(extras);
                MainActivity.savedProcessIntentText_ = s;
            }
        }


    }

    private fun handletext(extras: Bundle?): String {
        val sharedText = if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.M) {
            intent.getStringExtra(Intent.EXTRA_PROCESS_TEXT)

        } else {
           ""
        }
        if (sharedText != null) {
            return sharedText;
        }
        return "";
    }

//        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.M) {
    //            text =
    //                this.getIntent()
    //                    .getStringExtra(
    //                        Intent.EXTRA_PROCESS_TEXT
    //                    )
    //        } else {
    //            Log.e(
    //                "TAG",
    //                "Compatibility Issue:"
    //            )
    //            Log.i(
    //                "TAG",
    //                "Make sure device android version >= M (Marshmallow)"
    //            )
    //        }
}