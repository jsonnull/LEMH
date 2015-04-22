FROM jsonnull/lemhpress
MAINTAINER Jason Nall <jsonnull@gmail.com>

RUN apt-get update && \
    apt-get install -y git

ADD entry.sh /
# ADD conf/config.php /var/www/config.php

CMD /bin/bash /entry.sh && /usr/bin/supervisord