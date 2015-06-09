package com.authorwjf.http_get;

import android.app.Activity;
import android.content.Context;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.BaseAdapter;
import android.widget.GridView;
import android.widget.LinearLayout;
import android.widget.ListAdapter;
import android.widget.TextView;

public class myGridAdapter extends BaseAdapter {

    private Context context;
    private String[] mobileValues;

    public myGridAdapter(Main mainActivity, String[] arrayEmpty) {
        this.context = mainActivity;
        this.mobileValues = arrayEmpty;
    }

    public View getView(int position, View convertView, ViewGroup parent) {

        LayoutInflater inflater = (LayoutInflater) context
                .getSystemService(Context.LAYOUT_INFLATER_SERVICE);

        LinearLayout gridView;

        if (convertView == null) {

            // get layout from text_item.xml
            gridView = (LinearLayout)inflater.inflate(R.layout.main, null);

            int screenHeight = ((Activity) context).getWindowManager()
                    .getDefaultDisplay().getHeight();

            gridView.setLayoutParams(new GridView.LayoutParams(GridView.LayoutParams.MATCH_PARENT, screenHeight/9));


            //gridView.setMinimumHeight(screenHeight/9);
            // set value into textview
            TextView textView = (TextView) gridView
                    .findViewById(R.id.grid_item_label);

        } else {
            gridView = (LinearLayout) convertView;
        }

        return gridView;
    }

    @Override
    public int getCount() {
        // TODO Auto-generated method stub
        return mobileValues.length;
    }

    @Override
    public Object getItem(int position) {
        // TODO Auto-generated method stub
        return null;
    }

    @Override
    public long getItemId(int position) {
        // TODO Auto-generated method stub
        return 0;
    }
}

