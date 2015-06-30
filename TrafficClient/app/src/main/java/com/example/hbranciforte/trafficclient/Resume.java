package com.example.hbranciforte.trafficclient;

import android.content.Intent;
import android.os.StrictMode;
import android.support.v7.app.ActionBarActivity;
import android.os.Bundle;
import android.util.Log;
import android.view.Menu;
import android.view.MenuItem;
import android.view.View;
import android.widget.EditText;
import android.widget.TextView;

import org.json.JSONException;
import org.json.JSONObject;
import org.w3c.dom.Text;


public class Resume extends ActionBarActivity {
    String response;
    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        String value="";
        setContentView(R.layout.activity_resume);

        if (android.os.Build.VERSION.SDK_INT > 9) {
            StrictMode.ThreadPolicy policy = new StrictMode.ThreadPolicy.Builder().permitAll().build();
            StrictMode.setThreadPolicy(policy);
        }

        Bundle extras = getIntent().getExtras();
        if (extras != null) {
            response = extras.getString("response");
        }
        try {
            JSONObject parseResponse = new JSONObject(extras.getString("response"));
            if(parseResponse.getString("status").equals("allowed")) {
                value = "Hora de expiración del permiso:\n".concat(parseResponse.getString("formated_expires_at").toString());
                TextView text = (TextView) findViewById(R.id.txtResumen);
                text.setText("Aceptado!!");
            }
            else{
                TextView text = (TextView) findViewById(R.id.txtResumen);
                text.setText(parseResponse.getString("status").toString());
            }


        } catch (JSONException e) {
            value = new String("error");
            Log.e("PARSING JSON:",e.getMessage());
        }


        TextView txtData = (TextView)findViewById(R.id.txtData);
        txtData.setText(value);
        //txtData.setText(value.toString());

    }

    @Override
    public boolean onCreateOptionsMenu(Menu menu) {
        // Inflate the menu; this adds items to the action bar if it is present.
        getMenuInflater().inflate(R.menu.menu_resume, menu);
        return true;
    }

    @Override
    public boolean onOptionsItemSelected(MenuItem item) {
        // Handle action bar item clicks here. The action bar will
        // automatically handle clicks on the Home/Up button, so long
        // as you specify a parent activity in AndroidManifest.xml.
        int id = item.getItemId();

        //noinspection SimplifiableIfStatement
        if (id == R.id.action_settings) {
            return true;
        }

        return super.onOptionsItemSelected(item);
    }

    public void goHome(View view) {
        Intent intent = new Intent(this, MainActivity.class);
        intent.setFlags(Intent.FLAG_ACTIVITY_CLEAR_TOP);
        startActivity(intent);
    }
}
