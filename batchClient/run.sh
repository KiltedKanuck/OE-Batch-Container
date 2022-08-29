#!/bin/bash

docker run -d --mount src="$(pwd)",target=/app,type=bind openedge:oebatch
