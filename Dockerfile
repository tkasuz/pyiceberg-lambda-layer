FROM public.ecr.aws/sam/build-python3.12:1.107.0-20240110201202

ARG AWS_ACCESS_KEY_ID
ARG AWS_SECRET_ACCESS_KEY
ARG AWS_SESSION_TOKEN
ARG AWS_DEFAULT_REGION
ARG SAM_S3_BUCKET_NAME

ENV AWS_ACCESS_KEY_ID=${AWS_ACCESS_KEY_ID}
ENV AWS_SECRET_ACCESS_KEY=${AWS_SECRET_ACCESS_KEY}
ENV AWS_SESSION_TOKEN=${AWS_SESSION_TOKEN}
ENV AWS_DEFAULT_REGION=${AWS_DEFAULT_REGION}

COPY requirements.txt template.yaml samconfig.toml ./
RUN pip install --upgrade pip \
    && pip install -r requirements.txt -t layer/python/lib/python3.12/site-packages/

RUN sam build --parameter-overrides PythonVersion=python3.12 \
    && sam deploy --no-fail-on-empty-changeset --s3-bucket ${SAM_S3_BUCKET_NAME}