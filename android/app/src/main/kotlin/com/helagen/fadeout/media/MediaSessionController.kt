package com.helagen.fadeout.media

import android.content.Context
import android.media.AudioManager
import android.os.SystemClock
import android.view.KeyEvent

class MediaSessionController(context: Context) {
    private val audioManager = context.getSystemService(AudioManager::class.java)

    fun pauseCurrentMedia(): String {
        return dispatchMediaKey(KeyEvent.KEYCODE_MEDIA_PAUSE, successStatus = "paused")
    }

    fun stopCurrentMedia(): String {
        return dispatchMediaKey(KeyEvent.KEYCODE_MEDIA_STOP, successStatus = "stopped")
    }

    private fun dispatchMediaKey(keyCode: Int, successStatus: String): String {
        if (audioManager == null || !audioManager.isMusicActive) {
            return "noActiveSession"
        }

        val eventTime = SystemClock.uptimeMillis()
        val downEvent = KeyEvent(eventTime, eventTime, KeyEvent.ACTION_DOWN, keyCode, 0)
        val upEvent = KeyEvent(eventTime, eventTime, KeyEvent.ACTION_UP, keyCode, 0)

        audioManager.dispatchMediaKeyEvent(downEvent)
        audioManager.dispatchMediaKeyEvent(upEvent)

        return successStatus
    }
}
