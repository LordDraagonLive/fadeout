package com.helagen.fadeout.media

import android.content.Context
import android.media.AudioManager
import android.os.Handler
import android.os.Looper
import kotlin.math.max
import kotlin.math.roundToInt

class VolumeFadeController(context: Context) {
    private val audioManager = context.getSystemService(AudioManager::class.java)
    private val handler = Handler(Looper.getMainLooper())
    private var capturedVolume: Int? = null

    fun captureCurrentVolume() {
        capturedVolume = audioManager?.getStreamVolume(AudioManager.STREAM_MUSIC)
    }

    fun fadeVolume(durationMillis: Long) {
        val manager = audioManager ?: return
        val originalVolume = capturedVolume ?: manager.getStreamVolume(AudioManager.STREAM_MUSIC)

        if (durationMillis <= 0L || originalVolume <= 0) {
            manager.setStreamVolume(AudioManager.STREAM_MUSIC, 0, 0)
            return
        }

        val steps = max(originalVolume, 1)
        val stepDelay = durationMillis / steps

        for (step in 1..steps) {
            handler.postDelayed(
                {
                    val nextVolume = (originalVolume * (1 - step / steps.toFloat())).roundToInt()
                    manager.setStreamVolume(AudioManager.STREAM_MUSIC, max(nextVolume, 0), 0)
                },
                stepDelay * step,
            )
        }
    }

    fun restoreVolume() {
        val volume = capturedVolume ?: return
        audioManager?.setStreamVolume(AudioManager.STREAM_MUSIC, volume, 0)
        capturedVolume = null
    }
}
