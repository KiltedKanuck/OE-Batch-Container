# OE-Batch-Container
OpenEdge Batch Container

BUILD 12.5.2
./container
docker build . -t openedge:12.5.2

BUILD oebatch
./batchClient
docker build . -t openedge:oebatch
RUN
docker run -d --mount src="$(pwd)",target=/app,type=bind openedge:oebatch