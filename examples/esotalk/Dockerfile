FROM jsonnull/lemhpress:0.1.0
MAINTAINER Jason Nall <jsonnull@gmail.com>

RUN apt-get update && \
    apt-get install -y git

# Install esoTalk
RUN cd /var/www && \
    git clone https://github.com/esotalk/esoTalk.git --branch master ./ && \
    git reset --hard b2a1884fde967286a8c30c152e27b3fd4dfadad0 && \
    sed -i.bak 's/and function_exists("apache_get_modules") and in_array("mod_rewrite", apache_get_modules())//g' core/controllers/ETInstallController.class.php

# Install plugins
RUN cd /var/www/addons/plugins && \
    rm -r SMTP && \
    git clone https://github.com/esotalk/Views.git && \
    git clone https://github.com/esotalk/GoogleAnalytics.git && \
    git clone https://github.com/tvb/reCAPTCHA.git && \
    git clone https://github.com/jsonnull/esotalkMandrill.git

CMD /usr/bin/supervisord