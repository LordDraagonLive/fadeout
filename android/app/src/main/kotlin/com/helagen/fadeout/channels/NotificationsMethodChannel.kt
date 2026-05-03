package com.helagen.fadeout.channels

import android.content.Context
import com.helagen.fadeout.timer.TimerNotificationController
import io.flutter.plugin.common.BinaryMessenger
import io.flutter.plugin.common.MethodChannel

class NotificationsMethodChannel(
    context: Context,
    messenger: BinaryMessenger,
) {
    private val notificationController = TimerNotificationController(context)
    private val channel = MethodChannel(messenger, CHANNEL_NAME)

    fun register() {
        channel.setMethodCallHandler { call, result ->
            when (call.method) {
                "ensureTimerNotificationChannel" -> {
                    notificationController.ensureChannel()
                    result.success(null)
                }

                else -> result.notImplemented()
            }
        }
    }

    private companion object {
        const val CHANNEL_NAME = "com.helagen.fadeout/notifications"
    }
}
