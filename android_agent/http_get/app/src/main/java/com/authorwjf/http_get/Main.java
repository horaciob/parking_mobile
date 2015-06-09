package com.authorwjf.http_get;
import java.io.IOException;
import java.io.InputStream;
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
import android.view.View;
import android.view.View.OnClickListener;
import android.widget.Button;
import android.widget.EditText;
public class Main extends Activity implements OnClickListener {
    private EditText license_plate, zone_name, zone_number;
    private Button search;
    @Override
    public void onCreate(Bundle savedInstanceState) {
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
               params_uri="by_name=".concat(values);
            }

            values = zone_number.getText().toString();
            if (!values.matches("")) {
                if (params_uri.length()>1){
                    params_uri=params_uri.concat("&");
                }
                params_uri=params_uri.concat("by_number=".concat(values));
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
            if (results!=null) {
                EditText et = (EditText)findViewById(R.id.my_edit);
                et.setText(results);
            }
            Button b = (Button)findViewById(R.id.my_button);
            b.setClickable(true);
        }
    }
}