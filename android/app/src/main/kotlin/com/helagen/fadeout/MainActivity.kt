package com.helagen.fadeout

import com.helagen.fadeout.channels.MediaControlMethodChannel
import com.helagen.fadeout.channels.NotificationsMethodChannel
import com.helagen.fadeout.channels.PermissionsMethodChannel
import com.helagen.fadeout.channels.TimerMethodChannel
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine

class MainActivity : FlutterActivity() {
    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)

        val messenger = flutterEngine.dartExecutor.binaryMessenger

        TimerMethodChannel(context = this, messenger = messenger).register()
        MediaControlMethodChannel(context = this, messenger = messenger).register()
        PermissionsMethodChannel(context = this, messenger = messenger).register()
        NotificationsMethodChannel(context = this, messenger = messenger).register()
    }
}
