package com.helagen.fadeout.timer

import android.app.NotificationChannel
import android.app.NotificationManager
import android.content.Context
import android.os.Build

class TimerNotificationController(private val context: Context) {
    fun ensureChannel() {
        if (Build.VERSION.SDK_INT < Build.VERSION_CODES.O) {
            return
        }

        val notificationManager = context.getSystemService(NotificationManager::class.java)
        val channel = NotificationChannel(
            TIMER_CHANNEL_ID,
            "FadeOut timer",
            NotificationManager.IMPORTANCE_LOW,
        ).apply {
            description = "Shows the running FadeOut sleep timer."
        }

        notificationManager?.createNotificationChannel(channel)
    }

    companion object {
        const val TIMER_CHANNEL_ID = "fadeout_timer"
    }
}
