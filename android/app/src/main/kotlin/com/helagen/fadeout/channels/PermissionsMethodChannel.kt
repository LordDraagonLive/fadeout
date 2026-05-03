package com.helagen.fadeout.channels

import android.content.Context
import com.helagen.fadeout.permissions.BatteryOptimizationHelper
import io.flutter.plugin.common.BinaryMessenger
import io.flutter.plugin.common.MethodChannel

class PermissionsMethodChannel(
    context: Context,
    messenger: BinaryMessenger,
) {
    private val batteryOptimizationHelper = BatteryOptimizationHelper(context)
    private val channel = MethodChannel(messenger, CHANNEL_NAME)

    fun register() {
        channel.setMethodCallHandler { call, result ->
            when (call.method) {
                "isIgnoringBatteryOptimizations" -> {
                    result.success(batteryOptimizationHelper.isIgnoringBatteryOptimizations())
                }

                else -> result.notImplemented()
            }
        }
    }

    private companion object {
        const val CHANNEL_NAME = "com.helagen.fadeout/permissions"
    }
}
