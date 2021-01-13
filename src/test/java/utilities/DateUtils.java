package utilities;

import java.text.SimpleDateFormat;
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.time.ZoneId;
import java.time.format.DateTimeFormatter;
import java.util.Calendar;
import java.util.Date;
import java.util.TimeZone;

import static java.time.ZoneId.systemDefault;
import static java.time.format.DateTimeFormatter.ofPattern;
import static java.util.Calendar.MILLISECOND;
import static java.util.Calendar.getInstance;
import static java.util.Date.from;

public class DateUtils {

    private DateUtils() {
        throw new IllegalStateException("Utility class");
    }

    private static final String DATE_FORMAT_YYYY_MM_DD = "yyyy-MM-dd";

    private static final String ISO8601_DATETIME_FORMAT = "yyyy-MM-dd'T'HH:mm:ss.SSSZ";
    public static final DateTimeFormatter ISO8601_DATETIME_FORMATTER = ofPattern(
            ISO8601_DATETIME_FORMAT);

    private static Calendar calendar = getInstance();

    public static String formatDate(Date date, String format) {

        SimpleDateFormat simpleDateFormat = new SimpleDateFormat(format);
        return simpleDateFormat.format(date);
    }

    public static String formatDateyyyyMMdd(Date date) {

        SimpleDateFormat simpleDateFormat = new SimpleDateFormat(DATE_FORMAT_YYYY_MM_DD);
        return simpleDateFormat.format(date);
    }

    public static LocalDate convertToLocalDateViaInstant(Date dateToConvert) {

        return dateToConvert.toInstant().atZone(ZoneId.systemDefault()).toLocalDate();
    }

    // month is not zero based
    public static Date createDate(
            int year, int month, int date, int hourOfDay, int minute, int second) {
        calendar.set(year, month - 1, date, hourOfDay, minute, second);
        calendar.set(MILLISECOND, 0);
        calendar.setTimeZone(TimeZone.getTimeZone("GMT"));
        return calendar.getTime();
    }

    public static Date convertLocalDateTimeToDate(LocalDateTime localDateTime){
        return from(localDateTime.atZone(systemDefault()).toInstant());
    }

    public static String formatDateISO8601(Date date) {
        SimpleDateFormat simpleDateFormat = new SimpleDateFormat(ISO8601_DATETIME_FORMAT);
        return simpleDateFormat.format(date);
    }
}
