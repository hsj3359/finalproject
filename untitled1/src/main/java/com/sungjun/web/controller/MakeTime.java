package com.sungjun.web.controller;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.Locale;

public class MakeTime {
    public String getTime() {
        SimpleDateFormat mSimpleDateFormat = new SimpleDateFormat ( "yyyyMMddHHmmss", Locale.KOREA );
        Date currentTime= new Date();
        String mTime = mSimpleDateFormat.format ( currentTime );
        System.out.println(mTime);
        return mTime;
    }
}
