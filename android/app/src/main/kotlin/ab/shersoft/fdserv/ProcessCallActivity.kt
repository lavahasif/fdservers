package ab.shersoft.fdserv

import android.Manifest
import android.content.Intent
import android.content.pm.PackageManager
import android.net.Uri
import android.os.Build
import android.os.Bundle
import androidx.core.app.ActivityCompat
import androidx.core.content.ContextCompat
import ab.shersoft.fdserv.MainActivity.Companion.isAppRunning
//import com.shersoft.android_ip.constant
import io.flutter.embedding.android.FlutterActivity

class ProcessCallActivity : FlutterActivity() {
    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        val issAppRunning = isAppRunning
        listenProcessTextIntent(isAppRunning)
//        FlutterProcessTextPlugin().listenProcessTextIntent(issAppRunning)
    }

    fun listenProcessTextIntent(isAppRunning: Boolean) {
        openApp()

//        activity.finish()
    }

    fun openApp() {
        saveProcessIntentText()

    }

    private fun getIntentToOpenMainActivity(): Intent? {
        val packageName: String = context.getPackageName()
        return this.getPackageManager().getLaunchIntentForPackage(packageName)
            ?.setAction(Intent.ACTION_RUN)?.addFlags(Intent.FLAG_ACTIVITY_NEW_TASK)
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

                if (s != "") callnumber(s)
            }
        }


    }

    private fun callnumber(mob: String) {
        val permission = Manifest.permission.CALL_PHONE
        val phoneNumberRegex = "^\\(\\d{3}\\) \\d{3}-\\d{4}\$".toRegex()
        val phoneNumber = "(123) 456-7890"
        val isValid = phoneNumberRegex.matches(phoneNumber)

        if (ContextCompat.checkSelfPermission(
                this,
                permission
            ) != PackageManager.PERMISSION_GRANTED
        ) {
            ActivityCompat.requestPermissions(
                this,
                arrayOf(permission),
                constant.PERMISSION_Call_CODE
            )
        } else {
            val dial = "tel:" + mob
            val intent = Intent(Intent.ACTION_CALL, Uri.parse(dial))
            startActivity(intent)
        }
        activity.finish()

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