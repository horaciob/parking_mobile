package com.example.hbranciforte.trafficclient;

import android.content.Intent;
import android.os.AsyncTask;
import android.support.v7.app.ActionBarActivity;
import android.os.Bundle;
import android.util.Log;
import android.view.Menu;
import android.view.MenuItem;
import android.view.View;
import android.widget.Button;
import android.widget.TextView;

import org.apache.http.HttpResponse;
import org.apache.http.HttpStatus;
import org.apache.http.StatusLine;
import org.apache.http.client.ClientProtocolException;
import org.apache.http.client.HttpClient;
import org.apache.http.client.methods.HttpGet;
import org.apache.http.impl.client.DefaultHttpClient;
import org.json.JSONException;
import org.json.JSONObject;

import java.io.ByteArrayOutputStream;
import java.io.IOException;


public class NewParking extends ActionBarActivity {
    JSONObject json = null;
    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_new_parking);
    }

    @Override
    public boolean onCreateOptionsMenu(Menu menu) {
        // Inflate the menu; this adds items to the action bar if it is present.
        getMenuInflater().inflate(R.menu.menu_new_parking, menu);
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

    public void lunchDataSection(View view) throws IOException, InterruptedException {
        Intent intent = new Intent(this, DataTraffic.class);
        intent.putExtra( "zone_info",json.toString() );
        startActivity(intent);
    }

    public void searchZone(View view) {
        TextView zone_name = (TextView) findViewById(R.id.zone_name);
        TextView zone_number = (TextView) findViewById(R.id.zone_number);
        new RequestTask().execute("http://10.0.2.2:3000/zones/".concat(zone_name.getText().toString()).concat("-").concat(zone_number.getText().toString()));
    }

    class RequestTask extends AsyncTask<String, String, String> {

        @Override
        protected String doInBackground(String... uri) {
            HttpClient httpclient = new DefaultHttpClient();
            HttpResponse response;
            String responseString = null;
            try {
                response = httpclient.execute(new HttpGet(uri[0]));
                StatusLine statusLine = response.getStatusLine();
                if(statusLine.getStatusCode() == HttpStatus.SC_OK){
                    ByteArrayOutputStream out = new ByteArrayOutputStream();
                    response.getEntity().writeTo(out);
                    responseString = out.toString();
                    out.close();
                } else{
                    //Closes the connection.
                    response.getEntity().getContent().close();
                    throw new IOException(statusLine.getReasonPhrase());
                }
            } catch (ClientProtocolException e) {
                Log.e("ERROR", e.getMessage());
            } catch (IOException e) {
                Log.e("ERROR", e.getMessage());
            }
            return responseString;
        }

        @Override
        protected void onPostExecute(String result) {
            super.onPostExecute(result);


            try {
                json = new JSONObject(result);
            } catch (JSONException e) {
                Log.e("Data: Getting error",e.getMessage());
            }
            TextView txtResponse = (TextView) findViewById(R.id.txtResult);
            Button nextBtn = (Button) findViewById(R.id.next);
            String res= null;
            try {
                res = "Precio por ficha: ".concat(json.getString("unit_price")).concat(" Pesos\nTiempo por ficha: ").concat(json.getString("unit_time").concat(" Minutos"));
            } catch (JSONException e) {
                e.printStackTrace();
            }
            txtResponse.setText(res);
            nextBtn.setVisibility(View.VISIBLE);
        }
    }
}



