package com.example.flutter_project2

import android.os.Bundle
import android.widget.Toast
import io.flutter.embedding.android.FlutterActivity

class MainActivity : FlutterActivity(){
    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        Toast.makeText(this, "Hello from Android Native!", Toast.LENGTH_SHORT).show()
    }
}
