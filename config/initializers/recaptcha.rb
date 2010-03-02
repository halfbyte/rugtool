config = YAML.load_file(File.join(Rails.root, "config", "recaptcha.yml"))
ENV['RECAPTCHA_PUBLIC_KEY']  = config[Rails.env]['public_key']
ENV['RECAPTCHA_PRIVATE_KEY'] = config[Rails.env]['private_key']