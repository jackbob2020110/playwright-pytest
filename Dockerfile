FROM mcr.microsoft.com/playwright/python:v1.44.0-jammy

USER root

RUN pip config set global.index-url https://pypi.tuna.tsinghua.edu.cn/simple && \
    pip install --no-cache-dir pytest-playwright pytest-html pymsteams prometheus_client pytest-xdist && \
    playwright install
