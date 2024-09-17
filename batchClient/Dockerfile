FROM openedge:12.8.3

# USE for production to self-contain your image
RUN mkdir /app
RUN mkdir /app/temp

WORKDIR /app
COPY batchRunner.p ./batchRunner.p
COPY batchRunner.pf ./batchRunner.pf
COPY batchRunner.sh ./batchRunner.sh

RUN chmod 755 /app/batchRunner.sh

ENTRYPOINT [ "/app/batchRunner.sh" ]