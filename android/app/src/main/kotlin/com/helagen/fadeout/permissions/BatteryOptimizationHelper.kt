package com.helagen.fadeout.permissions

import android.content.Context
import android.os.PowerManager

class BatteryOptimizationHelper(private val context: Context) {
    fun isIgnoringBatteryOptimizations(): Boolean {
        val powerManager = context.getSystemService(PowerManager::class.java) ?: return false
        return powerManager.isIgnoringBatteryOptimizations(context.packageName)
    }
}
