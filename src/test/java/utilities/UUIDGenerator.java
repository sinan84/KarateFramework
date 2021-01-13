package utilities;

import java.util.UUID;

public class UUIDGenerator {

    public static UUID generateUuid() {
        return UUID.randomUUID();
    }

    public static String generateTransactionId() {
        return generateUuid() +"-0001";
    }
    public static String generateIdempotencyKey() {
        return generateUuid() +"-0001";
    }
}
