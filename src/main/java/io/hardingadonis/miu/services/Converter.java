package io.hardingadonis.miu.services;

import java.sql.*;
import java.time.*;
import java.time.format.*;

public class Converter {

    public static DateTimeFormatter DATE_TIME_FORMAT = DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss");

    public static LocalDateTime convert(Timestamp timestamp) {
        if (timestamp != null) {
            return timestamp.toLocalDateTime();
        }

        return null;
    }

    public static String convert(LocalDateTime datetime) {
        if (datetime != null) {
            return datetime.format(DATE_TIME_FORMAT);
        }

        return null;
    }
}
