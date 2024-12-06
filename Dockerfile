FROM mcr.microsoft.com/playwright/python:v1.49.0-noble

USER root

RUN ln -sf /usr/share/zoneinfo/Asia/Shanghai /etc/localtime && pip config set global.index-url https://pypi.tuna.tsinghua.edu.cn/simple && \
    pip install --no-cache-dir pytest-playwright pytest-html pymsteams prometheus_client pytest-xdist && \
    playwright install
