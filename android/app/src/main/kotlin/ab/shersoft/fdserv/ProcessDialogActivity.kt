package ab.shersoft.fdserv

import android.Manifest
import android.content.Intent
import android.content.pm.PackageManager
import android.net.Uri
import android.os.Build
import android.os.Bundle
import android.view.View
import android.widget.TextView
import androidx.core.app.ActivityCompat
import androidx.core.content.ContextCompat
import androidx.fragment.app.FragmentActivity
import androidx.fragment.app.FragmentManager
import androidx.fragment.app.FragmentTransaction
import io.flutter.embedding.android.FlutterActivity

class ProcessDialogActivity : FlutterActivity() {
    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContentView(R.layout.my_dialog)
        var text: String? = null

        val action = intent.action
        val type = intent.type
        val extras = intent.extras
        if (Intent.ACTION_PROCESS_TEXT.equals(action) && type != null) {
            if ("text/plain".equals(type)) {
                var s = handletext(extras);
                findViewById<TextView>(R.id.txt_dialog).text = s
            }
        }
    }

    fun listenProcessTextIntent(isAppRunning: Boolean) {
        openApp()

//        activity.finish()
    }

    fun openApp() {
        saveProcessIntentText()

    }

//    private fun getIntentToOpenMainActivity(): Intent? {
////        val packageName: String = context.getPackageName()
////        return this.getPackageManager().getLaunchIntentForPackage(packageName)
////            ?.setAction(Intent.ACTION_RUN)?.addFlags(Intent.FLAG_ACTIVITY_NEW_TASK)
////            ?.addFlags(Intent.FLAG_ACTIVITY_CLEAR_TASK)
//    }

    fun saveProcessIntentText() {
        var text: String? = null

        val action = intent.action
        val type = intent.type
        val extras = intent.extras
        if (Intent.ACTION_PROCESS_TEXT.equals(action) && type != null) {
            if ("text/plain".equals(type)) {
                var s = handletext(extras);

//                val dialog = MyDialogFragment()
//                dialog.show(FragmentActivity().supportFragmentManager , "MyDialogFragment")

                val dialogFragment =
                    MyDialogFragment()
                val fragmentManager: FragmentManager = FragmentActivity().supportFragmentManager
                val fragmentTransaction: FragmentTransaction = fragmentManager.beginTransaction()
                fragmentTransaction.add(dialogFragment, "my_dialog")
                fragmentTransaction.commitAllowingStateLoss()


                dialogFragment.show(fragmentManager, "my_dialog")

//                if (s != "") Dialnumber(s)
            }
        }


    }


    private fun Dialnumber(mob: String) {
        val dial = "tel:${mob}"
        val permission = Manifest.permission.CALL_PHONE
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

    fun callme(view: View) {
        val num: String = findViewById<TextView>(R.id.txt_dialog).text.toString()

        Dialnumber(num)
    }

    fun exitMe(view: View) {
        finish()
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