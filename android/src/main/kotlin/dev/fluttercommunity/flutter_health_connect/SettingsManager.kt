package dev.fluttercommunity.flutter_health_connect

import android.app.Activity
import android.content.Intent
import android.os.Build
import androidx.health.connect.client.HealthConnectClient

internal class SettingsManager {
    fun openHealthConnectSettings(activity: Activity) {
        val intent = Intent(HealthConnectClient.ACTION_HEALTH_CONNECT_SETTINGS)
        activity.startActivity(intent)
    }

    fun openAppPermissions(activity: Activity) {
        val intent =
            if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.UPSIDE_DOWN_CAKE) {
                Intent("android.health.connect.action.MANAGE_HEALTH_PERMISSIONS")
                    .putExtra(Intent.EXTRA_PACKAGE_NAME, activity.packageName)
            } else {
                Intent(HealthConnectClient.ACTION_HEALTH_CONNECT_SETTINGS)
            }
        activity.startActivity(intent)
    }
}
