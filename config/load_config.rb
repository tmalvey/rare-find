RF_CONFIG = YAML.load_file(RF_ROOT + "/config/config.yml")
DB_CONFIG = RF_CONFIG['mongodb']
MAIL_CONFIG = RF_CONFIG['mailer']