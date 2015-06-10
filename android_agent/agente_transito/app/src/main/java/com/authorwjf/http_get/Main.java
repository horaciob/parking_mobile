package com.authorwjf.http_get;
import java.io.IOException;
import java.io.InputStream;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.TimeZone;

import org.apache.http.HttpEntity;
import org.apache.http.HttpResponse;
import org.apache.http.client.HttpClient;
import org.apache.http.client.methods.HttpGet;
import org.apache.http.impl.client.DefaultHttpClient;
import org.apache.http.protocol.BasicHttpContext;
import org.apache.http.protocol.HttpContext;
import android.app.Activity;
import android.os.AsyncTask;
import android.os.Bundle;
import android.text.format.DateFormat;
import android.view.View;
import android.view.View.OnClickListener;
import android.widget.ArrayAdapter;
import android.widget.Button;
import android.widget.EditText;
import android.widget.GridView;

import org.json.JSONArray;
import org.json.JSONException;
import org.json.JSONObject;

public class Main extends Activity implements OnClickListener {
    private EditText license_plate, zone_name, zone_number;
    private Button search;
    public static Activity activity;
    @Override
    public void onCreate(Bundle savedInstanceState) {
        activity = this;
        super.onCreate(savedInstanceState);
        setContentView(R.layout.main);
        findViewById(R.id.my_button).setOnClickListener(this);
    }
    @Override
    public void onClick(View arg0) {
        license_plate = (EditText) findViewById(R.id.license_plate);
        zone_name = (EditText)findViewById(R.id.zone_name);
        zone_number = (EditText)findViewById(R.id.zone_number);

        Button b = (Button)findViewById(R.id.my_button);
        b.setClickable(false);
        new LongRunningGetIO().execute();
    }
    private class LongRunningGetIO extends AsyncTask <Void, Void, String> {
        protected String getASCIIContentFromEntity(HttpEntity entity) throws IllegalStateException, IOException {
            InputStream in = entity.getContent();
            StringBuffer out = new StringBuffer();
            int n = 1;
            while (n>0) {
                byte[] b = new byte[4096];
                n =  in.read(b);
                if (n>0) out.append(new String(b, 0, n));
            }
            return out.toString();
        }
        @Override
        protected String doInBackground(Void... params) {
            HttpClient httpClient = new DefaultHttpClient();
            HttpContext localContext = new BasicHttpContext();
            String query_url,params_uri,values;
            query_url = "http://10.0.2.2:3000/parkings";
            params_uri="";

            values = zone_name.getText().toString();
            if (!values.matches("")) {
               params_uri="zone_name=".concat(values);
            }

            values = zone_number.getText().toString();
            if (!values.matches("")) {
                if (params_uri.length()>1){
                    params_uri=params_uri.concat("&");
                }
                params_uri=params_uri.concat("zone_number=".concat(values));
            }

            values = license_plate.getText().toString();
            if (!values.matches("")) {
                if (params_uri.length()>1){
                    params_uri=params_uri.concat("&");
                }
                params_uri=params_uri.concat("license_plate=".concat(values));
            }

            if (params_uri.length()>1){
                query_url= query_url.concat("?");
            }

            HttpGet httpGet = new HttpGet(query_url.concat(params_uri));
            String text = null;
            try {
                HttpResponse response = httpClient.execute(httpGet, localContext);
                HttpEntity entity = response.getEntity();
                text = getASCIIContentFromEntity(entity);
            } catch (Exception e) {
                return e.getLocalizedMessage();
            }
            return text;
        }

        protected void onPostExecute(String results) {
            EditText et = (EditText) findViewById(R.id.my_edit);
            et.setText("");
            List<String> data = new ArrayList<String>();
            GridView gridview = (GridView) findViewById(R.id.search_grid);

            JSONArray jsonarray = null;
            String val = new String("");
            try {
                jsonarray = new JSONArray("[]");
            } catch (JSONException e) {
                e.printStackTrace();
            }
            if (results!=null) {
                et.setText(results.toString());
                try {
                  jsonarray = new JSONArray(results);
                } catch (JSONException e) {

                    e.printStackTrace();
                }
                for(int i=0; i<jsonarray.length(); i++){
                    try {
                        JSONObject parking = jsonarray.getJSONObject(i);
                        JSONObject car = new JSONObject(parking.getString("car"));
                        data.add(car.getString("license_plate"));
                        data.add(parking.getString("status"));
                        data.add(parking.getString("formated_expires_at"));
                        String[] simpleArray = new String[ data.size() ];
                        String[] stringArray = data.toArray(new String[data.size()]);
                        ArrayAdapter<String> adapter = new ArrayAdapter<String>(Main.activity,
                                       android.R.layout.simple_list_item_1, stringArray);

                        gridview.setAdapter(adapter);
                    } catch (JSONException e) {
                        //et.setText(e.getMessage().toString());
                        e.printStackTrace();
                    }

                }
            }
            else{
                et.setText("No se encontró información con dichos requerimientos");
            }

            Button b = (Button)findViewById(R.id.my_button);
            b.setClickable(true);
        }
    }
}
