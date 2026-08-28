package vn.iotstar.config;

import jakarta.persistence.EntityManager;
import jakarta.persistence.EntityManagerFactory;
import jakarta.persistence.Persistence;
import jakarta.persistence.PersistenceContext;
import java.util.HashMap;
import java.util.Map;

@PersistenceContext
public class JpaConfig {

    private static EntityManagerFactory factory;

    public static synchronized EntityManager getEntityManager() {
        if (factory == null || !factory.isOpen()) {
            Map<String, String> properties = new HashMap<>();
            copySystemProperty(properties, "app.jdbc.url", "jakarta.persistence.jdbc.url");
            copySystemProperty(properties, "app.jdbc.user", "jakarta.persistence.jdbc.user");
            copySystemProperty(properties, "app.jdbc.password", "jakarta.persistence.jdbc.password");
            factory = Persistence.createEntityManagerFactory("jpa-hibernate-mysql", properties);
        }
        return factory.createEntityManager();
    }

    private static void copySystemProperty(Map<String, String> properties, String source, String target) {
        String value = System.getProperty(source);
        if (value != null && !value.isBlank()) {
            properties.put(target, value);
        }
    }

    public static synchronized void close() {
        if (factory != null && factory.isOpen()) {
            factory.close();
        }
    }
}
