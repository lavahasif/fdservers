package ab.shersoft.fdserv

import android.content.Intent
import android.net.Uri
import android.os.Bundle
import android.os.Parcelable
import android.provider.OpenableColumns
import androidx.core.content.ContextCompat
import androidx.documentfile.provider.DocumentFile
import ab.shersoft.fdserv.MainActivity.Companion.isAppRunning
import ab.shersoft.fdserv.MainActivity.Companion.savedProcessIntentText
import io.flutter.embedding.android.FlutterActivity
import kotlinx.coroutines.CoroutineScope
import kotlinx.coroutines.Dispatchers
import kotlinx.coroutines.SupervisorJob
import kotlinx.coroutines.launch
import java.io.*

class ProcessFileActivity : FlutterActivity() {


    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        val issAppRunning = isAppRunning
        listenProcessTextIntent(isAppRunning)
        //        handleIntent()
//        // Get the intent that started this activity
//        val intent = intent
//        val data = intent.data
//
//        // Figure out what to do based on the intent type
//        if (intent.type!!.indexOf("image/") != -1) {
//            // Handle intents with image data ...
//        } else if (intent.type == "text/plain") {
//            // Handle intents with text ...
//        }
    }

    private fun handleIntent() {
        // intent is a property of this activity
        // Only process the intent if it's a send intent and it's of type 'text'
        if (intent?.action == Intent.ACTION_SEND) {
            if (intent.type == "text/plain") {
                intent.getStringExtra(Intent.EXTRA_TEXT)?.let { intentData ->
//                    sharedData = intentData
                }
            } else {
                savedProcessIntentText = null;
            }
        }
    }

    fun saveProcessIntentText() {
        var text: String? = null

        val action = intent.action
        val type = intent.type
        val extras = intent.extras
        if (Intent.ACTION_SEND.equals(action) && type != null) {
            if ("text/plain".equals(type)) {
                MainActivity.savedProcessIntentText_ = handletext(extras);
            } else {
                var s = handleSingleFile(extras)
                MainActivity.savedProcessIntentFile_?.add(s)

            }
        } else if (Intent.ACTION_SEND_MULTIPLE.equals(action) && type != null) {

            var s = handleMultipleFile(extras, intent); // Handle multiple images being sent
            MainActivity.savedProcessIntentFile_?.addAll(s)
        }


//        savedProcessIntentText =
//            this.getIntent().toString()
    }

    private fun handletext(extras: Bundle?): String {
        val sharedText = intent.getStringExtra(Intent.EXTRA_TEXT)
        if (sharedText != null) {
            return sharedText;
        }
        return "";
    }

    private fun handleSingleFile(extras: Bundle?): String {

        var name = "";
        if (extras!!.containsKey(Intent.EXTRA_STREAM)) {
            val uri = extras.getParcelable<Parcelable>(Intent.EXTRA_STREAM) as Uri?
//            getFileName(uri)
            val scheme = uri!!.scheme
            if (scheme == "content") {

                val openInputStream = contentResolver.openInputStream(uri)
                if (openInputStream != null) {
                    name = createFile(openInputStream, uri).toString()
                };
//                savedProcessIntentText = openInputStream?.readBytes();

            }
            name = uri.path.toString();
        }
        return name;
    }

    private fun getFileName(uri: Uri?) {
        if (uri != null) {

            print("===========>${DocumentFile.fromSingleUri(context, uri)?.name}")
        }
        if (uri != null) {
            contentResolver.query(uri, null, null, null, null).use { cursor ->
                val nameIndex = cursor?.getColumnIndex(OpenableColumns.DISPLAY_NAME)
                val sizeIndex = cursor?.getColumnIndex(OpenableColumns.SIZE)
                print("===========>$nameIndex")
                print("===========>$sizeIndex")
                cursor?.moveToFirst()
            }
        }


    }



    private fun handleMultipleFile(extras: Bundle?, intent: Intent): ArrayList<String> {
        var name = arrayListOf<String>();
        val imageUris: ArrayList<Uri> =
            intent.getParcelableArrayListExtra<Uri>(Intent.EXTRA_STREAM) as ArrayList<Uri>
        imageUris.forEach {


            val openInputStream = contentResolver.openInputStream(it)
            var n = ""
            openInputStream?.let { it1 -> n = createFile(it1, it) }
            name.add(n)
//            savedProcessIntentText = openInputStream?.readBytes();

        }
        return name;
    }

    val scope = CoroutineScope(Dispatchers.IO + SupervisorJob())
    fun createFile(ipstream: InputStream, uri: Uri): String {


        val last = DocumentFile.fromSingleUri(context, uri)?.name
//            URI(uri.toString()).path.replace("%20", "").split("/")
//            URI(extras["android.intent.extra.STREAM"].toString()).replace("%20", "").split("/")
//                .last()
        val replace = externalCacheDir?.path?.replace("/cache", "/dele")

        var tempFile: File = File(replace)

        if (tempFile.exists() && tempFile.isDirectory) {

            var s = "/$last"
            var tempFiles: File = File(replace + s)
            CopyFile(ipstream, tempFiles)
            return last.toString();
        } else {
            tempFile.mkdir()
            var s = "/$last"
            var tempFiles: File = File(replace + s)
            CopyFile(ipstream, tempFiles)
            return last.toString();

        }

    }

    private fun CopyFile(ipstream: InputStream, tempFile: File): Boolean {
        try {


            scope.launch {
//Copy file to new location
                val inp: InputStream = ipstream
                val out: OutputStream = FileOutputStream(tempFile)
                val buf = ByteArray(1024)
                var len: Int
                while (inp.read(buf).also { len = it } > 0) {
                    out.write(buf, 0, len)
                }
                inp.close()
                out.close()
            }
            return true;
        } catch (e: IOException) {
            e.printStackTrace()
            return false;
        }
    }

    fun listenProcessTextIntent(isAppRunning: Boolean) {
        openApp()
        if (!isAppRunning) {
            // Open app when its not running

        } else {
            // Fetch process text when the app is running.
        }
        // Activity launch Theme.NoDisplay
        activity.finish()
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
}