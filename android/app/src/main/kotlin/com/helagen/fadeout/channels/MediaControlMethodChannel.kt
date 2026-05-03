package com.helagen.fadeout.channels

import android.content.Context
import com.helagen.fadeout.media.MediaSessionController
import com.helagen.fadeout.media.VolumeFadeController
import io.flutter.plugin.common.BinaryMessenger
import io.flutter.plugin.common.MethodChannel

class MediaControlMethodChannel(
    context: Context,
    messenger: BinaryMessenger,
) {
    private val mediaSessionController = MediaSessionController(context)
    private val volumeFadeController = VolumeFadeController(context)
    private val channel = MethodChannel(messenger, CHANNEL_NAME)

    fun register() {
        channel.setMethodCallHandler { call, result ->
            when (call.method) {
                "captureCurrentVolume" -> {
                    volumeFadeController.captureCurrentVolume()
                    result.success(null)
                }

                "fadeVolume" -> {
                    val durationMillis = call.argument<Number>("durationMillis")?.toLong() ?: 0L
                    volumeFadeController.fadeVolume(durationMillis)
                    result.success(null)
                }

                "pauseCurrentMedia" -> result.success(mediaSessionController.pauseCurrentMedia())
                "stopCurrentMedia" -> result.success(mediaSessionController.stopCurrentMedia())

                "restoreVolume" -> {
                    volumeFadeController.restoreVolume()
                    result.success(null)
                }

                else -> result.notImplemented()
            }
        }
    }

    private companion object {
        const val CHANNEL_NAME = "com.helagen.fadeout/media_control"
    }
}
