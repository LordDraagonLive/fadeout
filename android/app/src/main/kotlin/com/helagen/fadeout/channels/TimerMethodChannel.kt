package com.helagen.fadeout.channels

import android.content.Context
import android.content.Intent
import com.helagen.fadeout.timer.FadeOutTimerService
import io.flutter.plugin.common.BinaryMessenger
import io.flutter.plugin.common.MethodChannel

class TimerMethodChannel(
    private val context: Context,
    messenger: BinaryMessenger,
) {
    private val channel = MethodChannel(messenger, CHANNEL_NAME)

    fun register() {
        channel.setMethodCallHandler { call, result ->
            when (call.method) {
                "startTimer" -> {
                    context.startService(Intent(context, FadeOutTimerService::class.java))
                    result.success(null)
                }

                "pauseTimer", "resumeTimer", "cancelTimer" -> result.success(null)
                else -> result.notImplemented()
            }
        }
    }

    private companion object {
        const val CHANNEL_NAME = "com.helagen.fadeout/timer"
    }
}
