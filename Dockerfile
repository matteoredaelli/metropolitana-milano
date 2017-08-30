FROM swipl
MAINTAINER matteo.redaelli@gmail.com

RUN useradd -c 'appuser prolog' -m -d /app -s /bin/bash appuser
RUN chown -R appuser /app
USER appuser
ENV HOME /app

EXPOSE 9876

COPY . /app
CMD ["swipl", "/app/server.pl", "--port=9876", "--interactive"]

