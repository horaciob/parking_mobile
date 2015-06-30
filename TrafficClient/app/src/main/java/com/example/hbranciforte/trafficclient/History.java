package com.example.hbranciforte.trafficclient;

import android.content.Context;
import android.content.Intent;
import android.support.v7.app.ActionBarActivity;
import android.os.Bundle;
import android.telephony.TelephonyManager;
import android.util.Log;
import android.view.Menu;
import android.view.MenuItem;
import android.widget.ArrayAdapter;
import android.widget.ListView;

import org.apache.http.HttpEntity;
import org.apache.http.HttpResponse;
import org.apache.http.client.HttpClient;
import org.apache.http.client.methods.HttpGet;
import org.apache.http.client.methods.HttpPost;
import org.apache.http.entity.StringEntity;
import org.apache.http.impl.client.BasicResponseHandler;
import org.apache.http.impl.client.DefaultHttpClient;
import org.apache.http.util.EntityUtils;
import org.json.JSONArray;
import org.json.JSONObject;

import java.util.List;


public class History extends ActionBarActivity {
    JSONArray data=null;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_history);
        DefaultHttpClient httpclient = new DefaultHttpClient();
        TelephonyManager telephonyManager = (TelephonyManager)getSystemService(Context.TELEPHONY_SERVICE);
        String token = telephonyManager.getDeviceId().toString();
        //HttpPost httppostreq = new HttpPost("http://10.0.2.2:3000/parkings??notification_token=".concat(token));
        ListView listView = (ListView)findViewById(R.id.historyable);

        try {
            HttpClient client = new DefaultHttpClient();
            String getURL = "http://45.55.79.197/parkings?notification_token=".concat(token);
            //String getURL = "http://10.0.2.2:3000/parkings?notification_token=".concat(token);
            HttpGet get = new HttpGet(getURL);
            HttpResponse responseGet = client.execute(get);
            HttpEntity resEntityGet = responseGet.getEntity();
            if (resEntityGet != null) {
                String response = EntityUtils.toString(resEntityGet);
                data=new JSONArray(response);

                String[] values = new String[data.length()];
                for(int i = 0; i < this.data.length(); i++){
                    JSONObject parking=new JSONObject(data.get(i).toString());
                    JSONObject zone = new JSONObject(parking.getString("zone"));
                    JSONObject car = new JSONObject(parking.getString("car"));
                    String temp = "Patente: ".concat(car.getString("license_plate")).concat("\n");
                    temp=temp.concat("Zona: ").concat(zone.getString("name")).concat("-").concat(Integer.toString(zone.getInt("number")).concat("\n"));
                    temp=temp.concat("Estado: ").concat(parking.getString("status")).concat("\n");
                    values[i]=temp.concat("Valido hasta: ").concat(parking.getString("formated_expires_at"));

                }
                ArrayAdapter<String> adapter = new ArrayAdapter<String>(this,
                        android.R.layout.simple_list_item_1, android.R.id.text1, values);
                listView.setAdapter(adapter);
            }
        } catch (Exception e) {
            Log.e("Error Parsing:",e.getMessage());
        }

    }

    @Override
    public boolean onCreateOptionsMenu(Menu menu) {
        // Inflate the menu; this adds items to the action bar if it is present.
        getMenuInflater().inflate(R.menu.menu_history, menu);
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
}
