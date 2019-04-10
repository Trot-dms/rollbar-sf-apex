public with sharing class Rollbar {
    public static Rollbar instance() {
        if (Rollbar.instance == null) {
            Rollbar.instance = new Rollbar();
        }

        return Rollbar.instance;
    }

    public static Rollbar init(String accessToken, String environment) {
        Rollbar instance = Rollbar.instance();
        instance.config = new Config(accessToken, environment);
        instance.notifier = new Notifier(instance.config);
        instance.initialized = true;
        return instance;
    }

    public static HttpResponse log(String level, String message) {
        Rollbar instance = Rollbar.instance();
        if (!instance.initialized) {
            throw new RollbarNotInitializedException('Rollbar has not been initialized');
        }
        return instance.notifier.log(level, message);
    }

    private Rollbar() {
    }

    private static Rollbar instance = null;
    private Config config = null;
    private Notifier notifier = null;
    private Boolean initialized = false;
}