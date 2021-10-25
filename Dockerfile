FROM 3.9-slim-bullseye as base

ENV PYTHONDONTWRITEBYTECODE 1
ENV PYTHONUNBUFFERED 1
ENV LANG C.UTF-8
ENV LC_ALL C.UTF-8
ENV DOCKER_CONTENT_TRUST=1
ENV VIRTUAL_ENV=/opt/venv

COPY requirements.txt .

RUN apt-get update && \
    apt-get install -y --no-install-recommends gcc \
    pip install --upgrade pip \
    pip install -r requirements.txt

    

RUN python3 -m venv /opt/venv
ENV PATH="$VIRTUAL_ENV/bin:$PATH"



FROM base as runtime

WORKDIR /app


COPY --from=builder /opt/venv /opt/venv



ENV PATH="/opt/venv/bin:$PATH"


WORKDIR /usr/src/app


RUN pip install -r requirements.txt

COPY . .


