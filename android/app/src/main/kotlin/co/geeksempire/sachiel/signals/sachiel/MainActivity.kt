package co.geeksempire.sachiel.signals.sachiel

import android.view.WindowManager.LayoutParams
import co.geeksempire.sachiel.signals.sachiel.BuildConfig
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine

class MainActivity: FlutterActivity() {

    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        if (!BuildConfig.DEBUG) {
            window.addFlags(LayoutParams.FLAG_SECURE)
        }
        super.configureFlutterEngine(flutterEngine)
    }

}
