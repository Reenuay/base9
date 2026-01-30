package com.example.base9

import android.content.Intent
import android.net.Uri
import android.os.Build
import android.provider.Settings
import androidx.core.content.FileProvider
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel
import java.io.File

class MainActivity : FlutterActivity() {
    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)
        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, CHANNEL).setMethodCallHandler {
                call,
                result ->
            if (call.method == "installApk") {
                val path = call.argument<String>("path")
                if (path == null) {
                    result.error("INVALID_ARGS", "path is null", null)
                    return@setMethodCallHandler
                }
                if (openInstallIntent(path)) {
                    result.success(null)
                } else {
                    result.error("INSTALL_FAILED", "Could not open install intent", null)
                }
            } else {
                result.notImplemented()
            }
        }
    }

    private fun openInstallIntent(apkPath: String): Boolean {
        val file = File(apkPath)
        if (!file.exists()) return false
        val uri: Uri =
                FileProvider.getUriForFile(
                        this,
                        "${applicationContext.packageName}.fileprovider",
                        file,
                )
        val intent =
                Intent(Intent.ACTION_VIEW).apply {
                    setDataAndType(uri, "application/vnd.android.package-archive")
                    addFlags(Intent.FLAG_ACTIVITY_NEW_TASK)
                    addFlags(Intent.FLAG_GRANT_READ_URI_PERMISSION)
                }
        return try {
            startActivity(intent)
            true
        } catch (e: Exception) {
            if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.O &&
                            !packageManager.canRequestPackageInstalls()
            ) {
                startActivity(
                        Intent(Settings.ACTION_MANAGE_UNKNOWN_APP_SOURCES).apply {
                            data = Uri.parse("package:$packageName")
                            addFlags(Intent.FLAG_ACTIVITY_NEW_TASK)
                        }
                )
            }
            false
        }
    }

    companion object {
        private const val CHANNEL = "base9/install_apk"
    }
}
