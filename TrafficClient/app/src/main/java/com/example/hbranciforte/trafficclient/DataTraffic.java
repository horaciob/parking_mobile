package com.example.hbranciforte.trafficclient;

import android.content.Intent;
import android.os.AsyncTask;
import android.os.StrictMode;
import android.support.v7.app.ActionBarActivity;
import android.os.Bundle;
import android.text.Editable;
import android.text.TextWatcher;
import android.util.Log;
import android.view.Menu;
import android.view.MenuItem;
import android.view.View;
import android.widget.EditText;
import android.widget.TextView;
import android.widget.Toast;

import org.apache.http.HttpResponse;
import org.apache.http.NameValuePair;
import org.apache.http.client.ClientProtocolException;
import org.apache.http.client.HttpClient;
import org.apache.http.client.entity.UrlEncodedFormEntity;
import org.apache.http.client.methods.HttpPost;
import org.apache.http.entity.StringEntity;
import org.apache.http.impl.client.DefaultHttpClient;
import org.apache.http.message.BasicNameValuePair;
import org.json.JSONException;
import org.json.JSONObject;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;


public class DataTraffic extends ActionBarActivity {
    JSONObject zone_info=null;
    float price=(float) 0;
    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_data_traffic);
        if (android.os.Build.VERSION.SDK_INT > 9) {
            StrictMode.ThreadPolicy policy = new StrictMode.ThreadPolicy.Builder().permitAll().build();
            StrictMode.setThreadPolicy(policy);
        }
        try {
            zone_info = new JSONObject((String) getIntent().getSerializableExtra("zone_info"));
        } catch (JSONException e) {
            e.printStackTrace();
        }
        EditText ed_fichas = (EditText) findViewById(R.id.fichas);
        ed_fichas.addTextChangedListener(new TextWatcher() {
            @Override
            public void beforeTextChanged(CharSequence s, int start, int count, int after) {
            }

            @Override
            public void onTextChanged(CharSequence s, int start, int before, int count) {

            }

            @Override
            public void afterTextChanged(Editable s) {
                //float price = (float) 0.0;
                Integer time = 0;
                TextView txtvalor = (TextView) findViewById(R.id.valor);
                TextView txttiempo = (TextView) findViewById(R.id.txtTime);
                if (s.toString() != "") {
                    try {
                        price = (float) zone_info.getDouble("unit_price") * Float.valueOf(s.toString());
                        time = zone_info.getInt("unit_time") * Integer.parseInt(s.toString());
                    } catch (Exception e) {
                        Log.e("getting data:", e.getMessage());
                        txtvalor.setText("");
                        txttiempo.setText("");
                    }
                    try {
                        txtvalor.setText("$ ".concat(Float.toString(price)));
                        txttiempo.setText(time.toString().concat(" min"));
                    } catch (Exception e) {
                        Log.e("getting data:", e.getMessage());
                        txtvalor.setText("");
                        txttiempo.setText("");
                    }
                }
            }
        });
    }

    @Override
    public boolean onCreateOptionsMenu(Menu menu) {
        // Inflate the menu; this adds items to the action bar if it is present.
        getMenuInflater().inflate(R.menu.menu_data_traffic, menu);
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

    public void lunchResume(View view) throws JSONException, IOException {
        JSONObject zone = new JSONObject();
        JSONObject device = new JSONObject();
        JSONObject car = new JSONObject();
        JSONObject payment = new JSONObject();
        JSONObject parking = new JSONObject();


        device.put("notification_token","test_token");
        device.put("user_agent","test_agent");

        EditText licenseLetters = (EditText)findViewById(R.id.license_letters);
        EditText licenseNumbers = (EditText)findViewById(R.id.license_numbers);
        car.put("license_plate",licenseLetters.getText().toString().toUpperCase().concat(licenseNumbers.getText().toString()));

        EditText paymentField1 = (EditText)findViewById(R.id.payment_field1);
        EditText licenseSec = (EditText)findViewById(R.id.payment_security);
        TextView valor = (TextView) findViewById(R.id.valor);
        payment.put("type","test_method");
        payment.put("data","{\"data\",\"".concat(paymentField1.getText().toString()).concat("\",\"security\":\"").concat(licenseSec.getText().toString().concat("\",\"price\":").concat(Float.toString(price)).concat("}")));
        payment.put("price",price);
        zone.put("name",zone_info.get("name"));
        zone.put("number",zone_info.get("number"));

        EditText parkingCoins = (EditText)findViewById(R.id.fichas);
        parking.put("parking_units", Integer.valueOf(parkingCoins.getText().toString()));
        parking.put("zone", zone);
        parking.put("device",device);
        parking.put("car",car);
        parking.put("payment",payment);

        DefaultHttpClient httpclient = new DefaultHttpClient();
        HttpPost httppostreq = new HttpPost("http://10.0.2.2:3000/parkings");
        StringEntity se = new StringEntity(parking.toString());
        httppostreq.setHeader("Content-type", "application/json");
        httppostreq.setEntity(se);
        HttpResponse httpresponse = httpclient.execute(httppostreq);
        if(httpresponse.getStatusLine().getStatusCode()==200) {
            Intent intent = new Intent(this, Resume.class);
            intent.putExtra("response", httpresponse.toString());
            intent.putExtra("data", parking.toString());
            startActivity(intent);
        }


    }

}
