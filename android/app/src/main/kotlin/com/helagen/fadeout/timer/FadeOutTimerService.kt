package com.helagen.fadeout.timer

import android.app.Service
import android.content.Intent
import android.os.IBinder

class FadeOutTimerService : Service() {
    override fun onBind(intent: Intent?): IBinder? = null
}
