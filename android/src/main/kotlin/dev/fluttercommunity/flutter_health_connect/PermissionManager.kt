package dev.fluttercommunity.flutter_health_connect

import android.app.Activity
import android.content.Intent
import androidx.health.connect.client.HealthConnectClient
import androidx.health.connect.client.PermissionController
import dev.fluttercommunity.flutter_health_connect.converters.RecordTypeMapper
import io.flutter.plugin.common.PluginRegistry
import kotlinx.coroutines.Dispatchers
import kotlinx.coroutines.withContext

internal class PermissionManager(
    private val clientProvider: () -> HealthConnectClient,
) : PluginRegistry.ActivityResultListener {
    private var activity: Activity? = null
    private var pendingResult: ((Result<Set<String>>) -> Unit)? = null

    private val contract = PermissionController.createRequestPermissionResultContract()

    fun attachActivity(activity: Activity) {
        this.activity = activity
    }

    fun detachActivity() {
        activity = null
        pendingResult?.invoke(Result.failure(IllegalStateException("Activity detached")))
        pendingResult = null
    }

    suspend fun getGrantedPermissions(): Set<String> =
        withContext(Dispatchers.IO) {
            clientProvider().permissionController.getGrantedPermissions()
        }

    suspend fun checkPermissions(requested: List<Map<String, Any?>>): List<Map<String, String>> {
        val granted = getGrantedPermissions()
        return requested.mapNotNull { item ->
            val type = item["recordType"] as String
            val access = item["access"] as String
            val permission = RecordTypeMapper.permissionString(type, access)
            if (granted.contains(permission)) {
                mapOf("recordType" to type, "access" to access)
            } else {
                null
            }
        }
    }

    fun requestPermissions(
        requested: List<Map<String, Any?>>,
        callback: (Result<Boolean>) -> Unit,
    ) {
        val activity = this.activity
        if (activity == null) {
            callback(Result.failure(IllegalStateException("No Activity available for permission request")))
            return
        }
        if (pendingResult != null) {
            callback(Result.failure(IllegalStateException("Another permission request is in progress")))
            return
        }

        val permissionStrings =
            requested
                .map {
                    RecordTypeMapper.permissionString(
                        it["recordType"] as String,
                        it["access"] as String,
                    )
                }.toSet()

        pendingResult = { result ->
            result
                .onSuccess { granted ->
                    callback(Result.success(granted.containsAll(permissionStrings)))
                }.onFailure { error ->
                    callback(Result.failure(error))
                }
        }

        val intent = contract.createIntent(activity, permissionStrings)
        activity.startActivityForResult(intent, REQUEST_CODE)
    }

    suspend fun getGrantedPermissionMaps(): List<Map<String, String>> {
        val granted = getGrantedPermissions()
        return granted.mapNotNull { RecordTypeMapper.permissionMap(it) }
    }

    override fun onActivityResult(
        requestCode: Int,
        resultCode: Int,
        data: Intent?,
    ): Boolean {
        if (requestCode != REQUEST_CODE) return false
        val callback = pendingResult ?: return false
        pendingResult = null
        val granted = contract.parseResult(resultCode, data)
        callback(Result.success(granted))
        return true
    }

    companion object {
        private const val REQUEST_CODE = 99147
    }
}
